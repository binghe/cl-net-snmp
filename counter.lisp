(in-package :snmp)

(defclass counter (general-type) ())
(defclass counter32 (counter) ())
(defclass counter64 (counter) ())

(defun counter (v)
  (declare (type integer v))
  (if (<= v #xffffffff)
    (counter32 v)
    (counter64 v)))
 
(defun counter32 (v)
  (declare (type (integer 0 #xffffffff) v))
  (make-instance 'counter32 :value v))

(defun counter64 (v)
  (declare (type integer v))
  (make-instance 'counter64 :value v))

(defmethod ber-encode ((value counter32))
  (multiple-value-bind (v l) (ber-encode-integer (value-of value))
    (concatenate 'vector
                 (ber-encode-type 1 0 1)
                 (ber-encode-length l)
                 v)))

(defmethod ber-encode ((value counter64))
  (multiple-value-bind (v l) (ber-encode-integer (value-of value))
    (concatenate 'vector
                 (ber-encode-type 1 0 6)
                 (ber-encode-length l)
                 v)))

(defmethod ber-decode-value ((stream stream) (type (eql :counter32)) length)
  (declare (type fixnum length) (ignore type))
  (counter32 (ber-decode-integer-value stream length)))

(defmethod ber-decode-value ((stream stream) (type (eql :counter64)) length)
  (declare (type fixnum length) (ignore type))
  (counter64 (ber-decode-integer-value stream length)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :counter32 1 0 1)
  (install-asn.1-type :counter64 1 0 6))

