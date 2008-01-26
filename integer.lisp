(in-package :snmp)

(defmethod plain-value ((object integer))
  object)

(defun ber-encode-integer (value)
  (declare (type integer value))
  (labels ((iter (n acc l)
             (if (zerop n) (values acc l)
               (multiple-value-bind (q r) (floor n 256)
                 (iter q (cons r acc) (1+ l))))))
    (if (zerop value)
      (values (list 0) 1)
      (iter value nil 0))))

(defmethod ber-encode ((value integer))
  (assert (<= 0 value))
  (multiple-value-bind (v l) (ber-encode-integer value)
    (nconc (ber-encode-type 0 0 2)
           (ber-encode-length l)
           v)))

(defun ber-decode-integer-value (stream length)
  (declare (type stream stream)
           (type fixnum length))
  (labels ((iter (i acc)
             (if (= i length) acc
               (iter (1+ i) (logior (ash acc 8) (read-byte stream))))))
    (iter 0 0)))

(defmethod ber-decode-value ((stream stream) (type (eql :integer)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (ber-decode-integer-value stream length))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :integer 0 0 2))
