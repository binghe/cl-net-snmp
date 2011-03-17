;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

(defvar *mib-modules* nil)
(defvar *mib-module-dependency* (make-hash-table))

(deftype access () '(member |not-accessible|
                            |accessible-for-notify|
                            |read-only|
                            |read-write|
                            |read-create|))

(eval-when (:load-toplevel :execute)
  (macrolet ((define-self-evaluated-symbol (symbol)
               `(defvar ,symbol ',symbol)))
    (define-self-evaluated-symbol |not-accessible|)
    (define-self-evaluated-symbol |accessible-for-notify|)
    (define-self-evaluated-symbol |read-only|)
    (define-self-evaluated-symbol |read-write|)
    (define-self-evaluated-symbol |read-create|)))

(deftype status () '(member |current|
                            |deprecated|
                            |mandatory|
                            |obsolete|))

(eval-when (:load-toplevel :execute)
  (macrolet ((define-self-evaluated-symbol (symbol)
               `(defvar ,symbol ',symbol)))
    (define-self-evaluated-symbol |current|)
    (define-self-evaluated-symbol |deprecated|)
    (define-self-evaluated-symbol |mandatory|)
    (define-self-evaluated-symbol |obsolete|)))

(deftype oid-syntax () '(or symbol list))

(deftype oid-type ()
  '(member module-identity
           module-compliance
           object-identity
           object-type
           object-group
           notification-type
           notification-group
           agent-capabilities))

(deftype oid-subidentifier ()
  '(unsigned-byte 32))

(defclass base-oid (asn.1-type)
  ((parent      :type object-id
                :reader oid-parent
                :initarg :parent)))

(defclass simple-oid (base-oid)
  ((values      :type list
                :reader oid-number-list
                :initarg :values)
   (length      :type fixnum
                :reader oid-length))
  (:documentation "A simple OID implementation"))

(defmethod initialize-instance :after ((instance simple-oid)
                                       &rest initargs &key value &allow-other-keys)
  (declare (ignore initargs))
  ;; update values slot
  (when (and value (slot-boundp instance 'parent))
    (setf (slot-value instance 'values)
          (append (oid-number-list (slot-value instance 'parent))
                  (if (atom value) (list value) value))))
  ;; update length slot
  (when (slot-boundp instance 'values)
    (setf (slot-value instance 'length)
          (list-length (slot-value instance 'values)))))

(defclass object-id (simple-oid)
  ((name        :type symbol
                :reader oid-name
                :initarg :name)
   (value       :type integer
                :reader oid-value
                :initarg :value)
   (type        :type oid-type
                :reader oid-type
                :initarg :type)
   (syntax      :type oid-syntax
                :reader oid-syntax
                :initarg :syntax)
   (max-access  :type access
                :reader oid-max-access
                :initarg :max-access)
   (status      :type status
                :reader oid-status
                :initarg :status)
   (description :type string
                :reader oid-description
                :initarg :description)
   (module      :type symbol
                :reader oid-module
                :initarg :module)
   (children    :type hash-table
                :accessor oid-children
                :initform (make-hash-table)))
  (:documentation "OBJECT IDENTIFIER"))

(defmethod initialize-instance :after ((instance object-id)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (if (and (slot-boundp instance 'parent)
           (slot-boundp instance 'name)
           (slot-boundp instance 'value))
      (setf (gethash (oid-value instance)
                     (oid-children (oid-parent instance)))
            instance)))

(defun list-children (oid)
  (declare (type object-id oid))
  (let ((all-children '()))
    (maphash #'(lambda (key value)
                 (declare (ignore key))
                 (push value all-children))
             (oid-children oid))
    all-children))

(defun delete-object (oid)
  (declare (type object-id oid))
  (remhash (oid-value oid)
           (oid-children (oid-parent oid))))

(defun oid-parent-p (oid)
  (declare (type simple-oid oid))
  (slot-boundp oid 'parent))

(defgeneric oid-module-p (oid)
  (:method ((oid object-id))
   (slot-boundp oid 'module))
  (:method ((oid simple-oid))
   nil))

(defgeneric oid-syntax-p (oid)
  (:method ((oid object-id))
   (slot-boundp oid 'syntax))
  (:method ((oid simple-oid))
   nil))

(defun oid-name-string (oid)
  (declare (type object-id oid))
  (symbol-name (oid-name oid)))

(defgeneric oid-name-list (oid))

(defmethod oid-name-list ((oid object-id))
  (labels ((iter (o acc)
             (if (slot-boundp o 'parent)
                 (iter (oid-parent o)
                       (cons (if (slot-boundp o 'name)
                                 (oid-name-string o)
                               (oid-value o))
                             acc))
               acc)))
    (iter oid nil)))

(defun oid-number-sublist (oid)
  (declare (type simple-oid oid))
  (nthcdr (if (oid-parent-p oid)
              (oid-length (oid-parent oid))
            0)
          (oid-number-list oid)))

(defmethod oid-name-list ((oid simple-oid))
  (append (when (oid-parent-p oid) (oid-name-list (oid-parent oid)))
          (oid-number-sublist oid)))

(defmethod plain-value ((object simple-oid) &key default)
  (declare (ignore default))
  (oid-number-list object))

(defmethod ber-equal ((a simple-oid) (b simple-oid))
  (equal (oid-number-list a) (oid-number-list b)))

(defmethod ber-encode ((value simple-oid))
  (let ((result (make-array 1000 :element-type '(unsigned-byte 8) :adjustable t :fill-pointer t))
	(nums (oid-number-list value)))
    (declare (dynamic-extent result))
    (setf (fill-pointer result) 0)
    (labels ((w (n)
	       (vector-push-extend n result))
	     (encode-number (n &optional (p 0))
	       (declare (type (member 0 128) p) (type oid-subidentifier n))
               (multiple-value-bind (q r) (floor (the oid-subidentifier n) 128)
		 (unless (zerop q)
		   (encode-number q 128))
		 (w (logior r p)))))
      (case (oid-length value)
	(0)
	(1 (encode-number (* 40 (the oid-subidentifier (first nums)))))
	(t (encode-number (+ (* 40 (the oid-subidentifier (first nums))) (the oid-subidentifier (second nums))))
	   (loop for n in (cddr nums)
		 do (encode-number n)))))
    (ber-array-from-seqs 
     (ber-encode-type 0 0 6)
     (ber-encode-length (fill-pointer result))
     (subseq result 0 (fill-pointer result)))))

;;; BER Encode & Decode (:object-identifier)
#+ignore ;; inefficient
(defmethod ber-encode ((value simple-oid))
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
    (let ((subids (oid-number-list value)))
      (multiple-value-bind (v l)
          (case (oid-length value)
            (0 (values nil 0))
            (1 (number-get (* (first subids) 40)))
            (2 (number-get (+ (* (first subids) 40) (second subids))))
            (otherwise (apply #'iter
                              (cddr subids)
                              (multiple-value-list
                               (number-get (+ (* (first subids) 40)
                                              (second subids)))))))
        (ber-array-from-seqs
	 (ber-encode-type 0 0 6)
	 (ber-encode-length l)
	 v)))))

;;; FIXME: #(6 1 40), |iso| should be decoded to 1, not 1.0
(defmethod ber-decode-value ((s stream) (type (eql :object-identifier)) length)
  (declare (type stream s)
           (type fixnum length)
           (ignore type))
  (if (zerop length)
      (oid '(0))
    (labels ((get-number (acc len)
               (let* ((byte (read-byte s))
                      (val (logior (ash acc 7) (logand byte 127))))
                 (if (< byte 128) (values val len)
                   (get-number val (1+ len)))))
             (iter (left-length acc head-p)
               (declare (type fixnum left-length)
                        (type list acc))
               (if (zerop left-length)
                   (nreverse acc)
                 (multiple-value-bind (n l) (get-number 0 1)
                   (if head-p
                       (multiple-value-bind (q r) (floor n 40)
                         (iter (- left-length l) (cons r (cons q acc)) nil))
                     (iter (- left-length l) (cons n acc) nil))))))
      (oid (iter length nil t)))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :object-identifier 0 0 6))

;;; OID lexical compare functions, by John Fremlin from MSI
(defun number-list-cmp (a b)
  "return minus if a < b, zero if a == b, plus if a > b"
  (declare (optimize speed))
  (loop for i = a then (cdr i)
	for j = b then (cdr j)
	for x = (car i)
	for y = (car j)
	do
	(unless x (return (if y -1 0)))
	(unless y (return 1))
	(let ((s (- x y)))
	  (unless (zerop s)
	    (return s)))))

(defun oid-cmp (oid-1 oid-2)
 (number-list-cmp (oid-number-list oid-1)
                  (oid-number-list oid-2)))

(defun oid-lexical-< (oid-1 oid-2)
  (minusp (oid-cmp oid-1 oid-2)))

(defun oid-lexical-> (oid-1 oid-2)
  (plusp (oid-cmp oid-1 oid-2)))

(defun oid-lexical->= (oid-1 oid-2)
  (not (oid-lexical-< oid-1 oid-2)))

(defun oid-lexical-<= (oid-1 oid-2)
  (not (oid-lexical-> oid-1 oid-2)))

;; thanks to John Fremlin (MSI)
(defun oid-< (oid-1 oid-2)
 "test if oid-1 is oid-2's child"
 (unless (<= (oid-length oid-1) (oid-length oid-2))
   (loop for x-1 in (oid-number-list oid-1)
         for x-2 in (oid-number-list oid-2)
         always (= x-1 x-2))))

(defun oid->= (oid-1 oid-2)
  (not (oid-< oid-1 oid-2)))

(defvar |zero|
  (make-instance 'object-id
                 :name '|zero|
                 :values nil
                 :value 0))

(defvar *root-object-id* |zero|) ; for compatibility

(defvar |iso|
  (make-instance 'object-id
                 :name '|iso|
                 :value 1
                 :parent |zero|))
                 
(defvar |org| ; iso.org
  (make-instance 'object-id
                 :name '|org|
                 :value 3
                 :parent |iso|))

(defvar |dod| ; iso.org.dod
  (make-instance 'object-id
                 :name '|dod|
                 :value 6
                 :parent |org|))

;;; OID Database, key: string, value: oid or list (all oid instances with same name)
(defvar *oid-database* (make-hash-table :test 'equal))

(eval-when (:load-toplevel :execute)
  (setf (gethash "zero" *oid-database*) '|zero|
        (gethash "iso"  *oid-database*) '|iso|
        (gethash "org"  *oid-database*) '|org|
        (gethash "dod"  *oid-database*) '|dod|))

(defun register-oid (name var)
  (let ((exist (gethash name *oid-database*)))
    (setf (gethash name *oid-database*)
          (typecase exist
            (null var)
            (list (pushnew var exist))
            (otherwise (if (eq exist var)
                           exist
                         (list var exist)))))
    (symbol-value var))) ; new one comes first

(defun unregister-oid (name var)
  (let ((exist (gethash name *oid-database*)))
    (typecase exist
      (null nil)
      (list (let ((new (remove var exist)))
              (if (null new)
                  (remhash name *oid-database*)
                (setf (gethash name *oid-database*) new))))
      (otherwise
       (when (eq exist var)
         (remhash name *oid-database*))))))

(defgeneric ensure-oid (oid value))

(defmethod ensure-oid ((oid object-id) (value integer))
  (gethash value (oid-children oid) nil))

(defmethod ensure-oid ((oid symbol) (value integer))
  (ensure-oid (symbol-value oid) value))

(defmethod ensure-oid ((oid null) (value t))
  (error "Try to ensure a NIL oid"))

(defmacro defoid (name (parent value) &body options)
  `(progn
     (defvar ,name
       (or (ensure-oid ,parent ,value)
           ,(nconc `(make-instance 'object-id
                                    :name ',name
                                    :value ,value
                                    :parent ,parent
                                    :module *current-module*)
                    (reduce #'append options))))
     (eval-when (:load-toplevel :execute)
       (register-oid (symbol-name ',name) ',name))))
