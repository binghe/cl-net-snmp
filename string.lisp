(in-package :snmp)

(defmethod plain-value ((object string))
  object)

;;; OCTET STRING (:octet-string)

(defmethod ber-encode ((value string))
  (append (ber-encode-type 0 0 4)
          (ber-encode-length (length value))
          (map 'list #'char-code value)))

(defmethod ber-decode-value ((stream stream) (type (eql :octet-string)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (let ((str (make-string length)))
    (map-into str #'(lambda () (code-char (read-byte stream))))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :octet-string 0 0 4))
