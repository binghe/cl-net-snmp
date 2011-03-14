;;;; -*- Mode: Lisp; External-Format: utf-8; -*-
;;;; $Id: ipaddress.lisp 768 2009-05-08 08:50:42Z binghe $

;;;; Note: In ASN.1-5 we choosed a simpliest solution for representation of IPaddress,
;;;; and removed all dependency of USOCKET.

(in-package :asn.1)

;;;; ASN.1 definitions

(defclass ipaddress (general-type) ())

(defun ipaddress (address)
  "translate to ASN.1 ipaddress from any form"
  (make-instance 'ipaddress :value (coerce address 'list)))

(defmethod print-object ((obj ipaddress) stream)
  (let ((address (value-of obj)))
    (print-unreadable-object (obj stream :type t)
      (format stream "~A~{.~A~}" (car address) (cdr address)))))

(defmethod ber-encode ((value ipaddress))
  (let ((address (value-of value)))
    (concatenate 'vector
                 (ber-encode-type 1 0 0)
                 (ber-encode-length (length address))
                 address)))

(defmethod ber-decode-value ((stream stream) (type (eql :ipaddress)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (let ((address (loop repeat length
                       collect (read-byte stream))))
    (make-instance 'ipaddress :value address)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :ipaddress 1 0 0))
