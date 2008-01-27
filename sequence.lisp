(in-package :snmp)

;;; SEQUENCE (:sequence)

(defmethod plain-value ((object sequence))
  object)

;; for non-null sequence
(defmethod ber-encode ((value sequence))
  (let ((sub-encode (apply #'append
                           (map 'list #'ber-encode value))))
    (append (ber-encode-type 0 1 16)
            (ber-encode-length (length sub-encode))
            sub-encode)))

;; for non-null sequence
(defclass empty-sequence () ())

(defmethod plain-value ((object empty-sequence))
  nil)

(defmethod ber-encode ((value empty-sequence))
  (append (ber-encode-type 0 1 16)
          (ber-encode-length 0)))

(declaim (inline empty-sequence-p)
         (inline empty-sequence))

(defun empty-sequence-p (sequence)
  (typep sequence 'empty-sequence))

(defun empty-sequence () (make-instance 'empty-sequence))

(defmethod ber-decode-value ((stream stream) (type (eql :sequence)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (if (zerop length)
    ;; for null sequence
    (empty-sequence)
    ;; for non-null sequence
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
      (iter length nil))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :sequence 0 1 16))
