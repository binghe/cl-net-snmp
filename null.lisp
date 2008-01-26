(in-package :snmp)

(defmethod plain-value ((object (eql nil)))
  object)

;;; NULL (:null)
(defmethod ber-encode ((value (eql nil)))
  (declare (ignore value))
  (nconc (ber-encode-type 0 0 5)
         (ber-encode-length 0)))

(defmethod ber-decode-value ((stream stream) (type (eql :null)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (assert (zerop length))
  nil)

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :null 0 0 5))

