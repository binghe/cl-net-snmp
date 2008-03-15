;;;; ASN.1 IPv4 Address Type

(in-package :snmp)

(defclass ipaddress (general-type) ())

(defun ipaddress (address)
  (declare (type string address))
  (make-instance 'ipaddress :value (usocket::host-to-hbo address)))

(defmethod print-object ((obj ipaddress) stream)
  (with-slots (value) obj
    (print-unreadable-object (obj stream :type t)
      (format stream "~A" (usocket:hbo-to-dotted-quad value)))))

(defmethod ber-encode ((value ipaddress))
  (let* ((addr (value-of value))
         (a (ash (logand addr #xff000000) -24))
         (b (ash (logand addr #x00ff0000) -16))
         (c (ash (logand addr #x0000ff00) -8))
         (d      (logand addr #x000000ff)))
    (concatenate 'vector
                 (ber-encode-type 1 0 0)
                 (ber-encode-length 4)
                 (list a b c d))))

(defmethod ber-decode-value ((stream stream) (type (eql :ipaddress)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (assert (= 4 length))
  (let ((a (read-byte stream))
        (b (read-byte stream))
        (c (read-byte stream))
        (d (read-byte stream)))
    (make-instance 'ipaddress :value (logior (ash a 24) (ash b 16) (ash c 8) d))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :ipaddress 1 0 0))
