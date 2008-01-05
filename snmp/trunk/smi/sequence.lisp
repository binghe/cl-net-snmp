(in-package :smi)

;;; SEQUENCE (:sequence)

(defmethod plain-value ((object sequence))
  object)

;; we define (:null) = null sequence (#x30 #x00)
(defmethod ber-encode ((value sequence))
  (if (empty-sequence-p value)
    ;; for null sequence
    (ber-encode-empty-sequence)
    ;; for non-null sequence
    (let ((sub-encode (apply #'nconc
                             (map 'list #'ber-encode value))))
      (nconc (ber-encode-type 0 1 16)
             (ber-encode-length (length sub-encode))
             sub-encode))))

(defun ber-encode-empty-sequence ()
  (nconc (ber-encode-type 0 1 16)
         (ber-encode-length 0)))

(declaim (inline empty-sequence-p))
(defun empty-sequence-p (sequence)
  (declare (type list sequence))
  (eq (car sequence) :null))

(defmethod ber-decode-value ((stream stream) (type (eql :sequence)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (if (zerop length)
    ;; for null sequence
    (list :null)
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
