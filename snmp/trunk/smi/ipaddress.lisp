(in-package :smi)

;; IP Address Type, use IOLIB's ipv4addr class

(defmethod plain-value ((address ipv4addr))
  (vector-to-dotted (name address)))

(defmethod ber-encode ((value ipv4addr))
  (declare (ignore value))
  (nconc (ber-encode-type 1 0 0)
         (ber-encode-length 4)
         (coerce (name value) 'list)))

(defmethod ber-decode-value ((stream stream) (type (eql :ipaddress)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (assert (= 4 length))
  (let ((part-1 (read-byte stream))
        (part-2 (read-byte stream))
        (part-3 (read-byte stream))
        (part-4 (read-byte stream)))
    (make-instance 'ipv4addr :name (vector part-1 part-2 part-3 part-4))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :ipaddress 1 0 0))
