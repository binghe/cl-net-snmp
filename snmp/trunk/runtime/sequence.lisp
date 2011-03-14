;;;; -*- Mode: Lisp -*-
;;;; $Id: sequence.lisp 802 2010-07-10 00:39:14Z binghe $

(in-package :asn.1)

(defclass sequence-type (asn.1-type)
  ()
  (:documentation "Root class of all sequence-based ASN.1 types"))

(defun list-all-mib-tables ()
  (mapcar #'(lambda (x)
              (oid-parent ; table
               (oid-parent ; entry
                (symbol-value (slot-definition-name ; choose one slot
                               (car (class-direct-slots x)))))))
          (list-all-mib-classes)))

(defun list-all-mib-classes ()
  (class-direct-subclasses (find-class 'sequence-type)))

(defmethod plain-value ((object sequence-type) &key default)
  (let ((slots (mapcar #'slot-definition-name
                       (class-direct-slots (class-of object)))))
    (mapcar #'(lambda (slot)
                (list (symbol-value slot)
                      (if (slot-boundp object slot) (slot-value object slot) default)))
            slots)))

(defgeneric slot-value-using-oid (instance oid)
  (:documentation "Get the slot value from sequence class instance"))

(defmethod slot-value-using-oid ((instance sequence-type) oid)
  (slot-value-using-oid instance (oid oid)))

(defmethod slot-value-using-oid ((instance sequence-type) (oid object-id))
  (let ((slot-name (oid-name oid)))
    (slot-value instance slot-name)))

(defmethod slot-value-using-oid ((instance sequence-type) (oid symbol))
  (slot-value instance oid))

(defmethod plain-value ((object sequence) &key default)
  (declare (ignore default))
  object)

(defmethod ber-equal ((a sequence) (b sequence))
  (every #'ber-equal a b))

(declaim (inline ber-array-from-list-of-seqs))
(defun ber-array-from-list-of-seqs (list)
  (declare (dynamic-extent list) (type list list) (optimize speed))
  (let ((len (reduce #'+ list :key #'length :initial-value 0)))
    (let ((array (make-array len :element-type '(unsigned-byte 8))) (i 0))
      (declare (type fixnum i))
      (loop for e in list
	    do 
	    (typecase e
	      (vector
	       (loop for c across e do
		     (setf (aref (the (simple-array (unsigned-byte 8)) array) (the fixnum i)) c)
		     (incf (the fixnum i)))
	       )
	      (list
	       (loop for c in e do
		     (setf (aref (the (simple-array (unsigned-byte 8)) array) (the fixnum i)) c)
		     (incf (the fixnum i))))))
      array)))

(declaim (inline ber-array-from-seqs))
(defun ber-array-from-seqs (&rest seqs)
  (declare (dynamic-extent seqs) (optimize speed))
  (ber-array-from-list-of-seqs seqs))

;;; used by pdu.lisp
(defun ber-encode-list (list)
  (ber-array-from-list-of-seqs (mapcar #'ber-encode list)))


;; for non-null sequence
(defmethod ber-encode ((value sequence))
  "Encode any VECTOR and non-nil LIST into ASN.1 sequence"
  (let ((sub-encode (mapcar #'ber-encode value)))
    (declare (dynamic-extent sub-encode))
    (ber-array-from-list-of-seqs
     (list*
      (ber-encode-type 0 1 16)
      (ber-encode-length (reduce #'+ sub-encode :key #'length :initial-value 0))
      sub-encode))))

(defmethod ber-decode-value ((stream stream) (type (eql :sequence)) length)
  (declare (type fixnum length) (ignore type))
  "Decode ASN.1 sequence data and return a VECTOR"
  (if (zerop length) #()
    ;; for non-null sequence
    (labels ((iter (length-left acc)
               (if (zerop length-left)
                 (nreverse acc)
                 (multiple-value-bind (sub-type sub-type-length sub-type-bytes)
                     (ber-decode-type stream)
                   (multiple-value-bind (sub-length sub-length-length sub-length-bytes)
                       (ber-decode-length stream)
                     (iter (- length-left
                              sub-type-length
                              sub-length-length
                              sub-length)
                           (cons (if sub-type (ber-decode-value stream sub-type sub-length)
                                   (ber-decode-value stream sub-type
                                                     (cons sub-length
                                                           (append sub-type-bytes
                                                                   sub-length-bytes))))
                                 acc)))))))
      (let ((temp (coerce (iter length nil) 'vector)))
        ;; (format t "sequence: ~A~%" temp)
        temp))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :sequence 0 1 16))
