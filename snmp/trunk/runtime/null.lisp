;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

(defmethod plain-value ((object (eql nil)) &key default)
  (declare (ignore object default))
  nil)

(defmethod ber-equal ((a (eql nil)) (b (eql nil)))
  (declare (ignore a b))
  t)

;;; NULL (:null)
(defmethod ber-encode ((value (eql nil)))
  (declare (ignore value))
  (concatenate 'vector
               (ber-encode-type 0 0 5)
               (ber-encode-length 0)))

(defmethod ber-decode-value ((stream stream) (type (eql :null)) length)
  "Eat bytes and return a NIL"
  (declare (type fixnum length) (ignore type))
  (dotimes (i length nil) (read-byte stream)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :null 0 0 5))
