(in-package :snmp)

(defclass counter (general-type) ())
(defclass counter32 (counter) ())
(defclass counter64 (counter) ())

(defun counter (v)
  (counter32 v))

(defun counter32 (v)
  (make-instance 'counter32 :value v))

(defun counter64 (v)
  (make-instance 'counter64 :value v))

(defmethod ber-encode ((value counter32))
  (assert (<= 0 value 4294967295))
  (multiple-value-bind (v l) (ber-encode-integer value)
    (nconc (ber-encode-type 1 0 1)
           (ber-encode-length l)
           v)))

(defmethod ber-encode ((value counter64))
  (assert (<= 0 value))
  (multiple-value-bind (v l) (ber-encode-integer value)
    (nconc (ber-encode-type 1 0 6)
           (ber-encode-length l)
           v)))

(defmethod ber-decode-value ((stream stream) (type (eql :counter32)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (make-instance 'counter32 :value (ber-decode-integer-value stream length)))

(defmethod ber-decode-value ((stream stream) (type (eql :counter64)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (make-instance 'counter64 :value (ber-decode-integer-value stream length)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :counter32 1 0 1)
  (install-asn.1-type :counter64 1 0 6))

