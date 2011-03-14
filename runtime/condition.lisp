;;;; -*- Mode: Lisp -*-
;;;; $Id: condition.lisp 555 2008-09-28 15:36:14Z binghe $
;;;; Note: parts of this file come from Simon Leinen's cl-snmp project

(in-package :asn.1)

(define-condition asn-error (error) ())

(define-condition asn-implementation-restriction (asn-error) ())

(define-condition unknown-object-id (asn-error)
  ((symbol :type symbol
           :reader unknown-object-id-symbol
           :initarg :symbol))
  (:report (lambda (c stream)
             (format stream "Unknown object id: ~A"
                     (unknown-object-id-symbol c)))))

(define-condition ber-decode-error (asn-error) ())

(define-condition ber-encode-error (asn-error) ())

(define-condition ber-implementation-restriction 
    (asn-implementation-restriction)
  ())

(define-condition ber-message-ended-prematurely
    (ber-decode-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "BER message ended prematurely"))))

(define-condition ber-indefinite-length-not-supported
    (ber-decode-error 
     asn-implementation-restriction)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Indefinite length not supported"))))

(define-condition ber-unencodable-length
    (ber-encode-error
     asn-implementation-restriction)
  ((length :initarg :length
	   :reader ber-unencodable-length-length))
  (:report (lambda (c stream)
	     (format stream "Length ~D cannot be encoded"
		     (ber-unencodable-length-length c)))))
