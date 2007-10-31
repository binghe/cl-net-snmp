(in-package :smi)

;;; SEQUENCE (:sequence)

(defmethod plain-value ((object sequence))
  object)

(defmethod ber-encode ((value sequence))
  (let ((sub-encode (apply #'nconc
                           (map 'list #'ber-encode value))))
    (nconc (ber-encode-type 0 1 16)
           (ber-encode-length (length sub-encode))
           sub-encode)))

(defmethod ber-decode-value ((stream stream) (type (eql :sequence)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (labels ((iter (length-left acc)
             (if (zerop length-left)
                 (nreverse acc)
               (multiple-value-bind (sub-type sub-type-length)
                   (ber-decode-type stream)
                 (multiple-value-bind (sub-length sub-length-length)
                     (ber-decode-length stream)
                   (iter (- length-left
                            sub-type-length
                            sub-length-length
                            sub-length)
                         (cons (ber-decode-value stream sub-type sub-length) acc)))))))
    (iter length nil)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :sequence 0 1 16))
