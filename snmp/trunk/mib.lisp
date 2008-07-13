(in-package :snmp)

(defmethod plain-value ((object (eql :end-of-mibview)))
  (declare (ignore object))
  :end-of-mibview)

(defmethod ber-equal ((a (eql :end-of-mibview)) (b (eql :end-of-mibview)))
  (declare (ignore a b))
  t)

(defmethod ber-encode ((value (eql :end-of-mibview)))
  (declare (ignore value))
  (concatenate 'vector
               (ber-encode-type 2 0 2)
               (ber-encode-length 0)))

(defmethod ber-decode-value ((stream stream) (type (eql :end-of-mibview)) length)
  (declare (type fixnum length) (ignore type))
  (dotimes (i length :end-of-mibview) (read-byte stream)))

;; (uninstall-asn.1-type 1 0 18)
(eval-when (:load-toplevel :execute)
  (install-asn.1-type :end-of-mibview 2 0 2))
