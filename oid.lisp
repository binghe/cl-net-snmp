;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Object ID Base Support ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; TODO: fix bug in (ber-test (object-id #(0), #(0 0), #(0 0 0), ...))

(in-package :snmp)

(defclass object-id ()
  ((rev-ids :initform nil :reader oid-revid :initarg :id)
   (rev-names :initform nil :reader oid-name :initarg :name)
   (length :initform 0 :type integer :reader oid-length)))

(defmethod plain-value ((object object-id))
  (reverse (oid-revid object)))

(defmethod ber-equal ((a object-id) (b object-id))
  (equal (oid-revid a) (oid-revid b)))

(defmethod oid ((oid object-id))
  (reverse (slot-value 'rev-ids oid)))

(defmethod initialize-instance :after ((instance object-id)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (rev-ids length) instance
    (setf length (list-length rev-ids))))

(defun object-id (ids)
  (declare (type sequence ids))
  (make-instance 'object-id :id (reverse (coerce ids 'list))))

(deftype oid-component () '(unsigned-byte 29))
(deftype oid-component-length () '(integer 0 4))

;;; BER Encode & Decode (:object-identifier)

(defmethod ber-encode ((value object-id))
  (labels ((number-get (n)
             (if (zerop n) (values (list 0) 1)
               (number-split n 0 nil 0)))
           (number-split (n p acc l)
             (if (zerop n) (values acc l)
               (multiple-value-bind (q r) (floor n 128)
                 (number-split q 1 (cons (logior (ash p 7) r) acc) (1+ l)))))
           (iter (oids acc len)
             (if (endp oids)
                 (values acc len)
               (multiple-value-bind (sub-oid sub-length) (number-get (car oids))
                 (iter (cdr oids) (nconc acc sub-oid) (+ len sub-length))))))
    (with-slots (rev-ids length) value
      (let ((subids (reverse rev-ids)))
        (multiple-value-bind (v l)
            (case length
              (0 (values nil 0))
              (1 (number-split (* (first subids) 40) 0 nil 0))
              (2 (number-split (+ (* (first subids) 40)
                                  (second subids)) 0 nil 0))
              (otherwise (apply #'iter
                                (cddr subids)
                                (multiple-value-list
                                 (number-split (+ (* (first subids) 40)
                                                  (second subids)) 0 nil 0)))))
          (concatenate 'vector
                       (ber-encode-type 0 0 6)
                       (ber-encode-length l)
                       v))))))

(defmethod ber-decode-value ((s stream) (type (eql :object-identifier)) length)
  (declare (type stream s)
           (type fixnum length)
           (ignore type))
  (if (zerop length)
      (make-instance 'object-id)
    (labels ((get-number (acc len)
               (let* ((byte (read-byte s))
                      (val (logior (ash acc 7) (logand byte 127))))
                 (if (< byte 128) (values val len)
                   (get-number val (1+ len)))))
             (iter (left-length acc head-p)
               (declare (type fixnum left-length)
                        (type list acc))
               (if (zerop left-length) acc
                 (multiple-value-bind (n l) (get-number 0 1)
                   (if head-p
                       (multiple-value-bind (q r) (floor n 40)
                         (iter (- left-length l) (cons r (cons q acc)) nil))
                     (iter (- left-length l) (cons n acc) nil))))))
      (make-instance 'object-id :id (iter length nil t)))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :object-identifier 0 0 6))

;;; Object ID utilitys

(defun oid-< (oid-1 oid-2)
  "test if oid-1 is oid-2's child"
  (let ((o-1 (oid-revid oid-1))
        (o-2 (oid-revid oid-2))
        (o-1-len (oid-length oid-1))
        (o-2-len (oid-length oid-2)))
    (if (<= o-1-len o-2-len) nil
      (equal o-2 (nthcdr (- o-1-len o-2-len) o-1)))))

(defun oid->= (oid-1 oid-2)
  (not (oid-< oid-1 oid-2)))

(defgeneric *->oid (x)
  (:documentation "Anything -> Object ID"))

(defmethod *->oid ((x object-id)) x)
(defmethod *->oid ((x sequence)) (object-id x))
