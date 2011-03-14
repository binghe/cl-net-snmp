;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

(defconstant +asn-universal+	0)
(defconstant +asn-application+	1)
(defconstant +asn-context+	2)
(defconstant +asn-private+	3)

(defconstant +asn-primitive+	0)
(defconstant +asn-constructor+	1)

(defconstant +asn-boolean+	#x01)
(defconstant +asn-integer+	#x02)
(defconstant +asn-bit-str+	#x03)
(defconstant +asn-octet-str+	#x04)
(defconstant +asn-null+		#x05)
(defconstant +asn-object-id+	#x06)
(defconstant +asn-sequence+	#x10)
(defconstant +asn-set+		#x11)

(defconstant +ber-encode-max-length+ #.(1+ (ceiling (log most-positive-fixnum 256))))
