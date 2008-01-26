(in-package :snmp)

(defclass gauge (general-type) ())

(defun gauge (v)
  (make-instance 'gauge :value v))

(defmethod ber-encode ((value gauge))
  (multiple-value-bind (v l) (ber-encode-integer value)
    (nconc (ber-encode-type 1 0 2)
           (ber-encode-length l)
           v)))

(defmethod ber-decode-value ((stream stream) (type (eql :gauge)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (make-instance 'gauge :value (ber-decode-integer-value stream length)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :gauge 1 0 2))
