;;;; -*- Mode: Lisp -*-
;;;; $Id: string.lisp 800 2010-07-09 15:31:44Z binghe $

(in-package :asn.1)

(defclass octet-string (general-type)
  ((value :type (vector (unsigned-byte 8))))
  (:documentation "ASN.1 OCTET STRING class"))

(defmethod print-object ((object octet-string) stream)
  (print-unreadable-object (object stream :type t)
    (format stream "~A" (value-of object))))

(defgeneric octet-string (input)
  (:documentation "create octet-string instance"))

(defmethod octet-string ((input string))
  "A bug version which haven't consider encoding issues"
  (make-instance 'octet-string :value (map 'vector #'char-code input)))

(defmethod octet-string ((input sequence))
  (make-instance 'octet-string :value (coerce input
                                              '(vector (unsigned-byte 8)))))

(defmethod plain-value ((object string) &key default)
  (declare (ignore default))
  object)

(defmethod ber-equal ((a string) (b string)) (string= a b))

(defmethod ber-equal ((a octet-string) (b octet-string))
  "A slow version which just work"
  (equal (coerce (value-of a) 'list)
         (coerce (value-of b) 'list)))

;;; OCTET STRING (:octet-string)
(defmethod ber-encode ((value string))
  (concatenate 'vector
               (ber-encode-type 0 0 +asn-octet-str+)
               (ber-encode-length (length value))
               (map 'vector #'char-code value)))

(defmethod ber-encode ((value octet-string))
  (let ((data (value-of value)))
    (concatenate 'vector
                 (ber-encode-type 0 0 +asn-octet-str+)
                 (ber-encode-length (length data))
                 data)))

(defmethod ber-decode-value ((stream stream) (type (eql :octet-string)) length)
  (declare (type fixnum length) (ignore type))
  (let ((str (make-string length)))
    (map-into str #'(lambda () (code-char (read-byte stream))))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :octet-string 0 0 +asn-octet-str+))
