(in-package :snmp.system)

(defpackage asn.1
  (:use :common-lisp
        #+lispworks :stream #+sbcl :sb-gray #+clisp :gray
        :zebu)
  (:export update-syntax
           ber-encode
           ber-decode
           ber-decode-value
           ber-encode-type
           ber-encode-length
           ber-decode-type
           ber-decode-length
           install-asn.1-type
           raw-data-p
           raw-data
           raw-data-of
           ;;; Symbols from ASN.1 Syntax
           Obj-Id-Component-p
           Obj-Id-Component-name
           Obj-Id-Component-value
	   Module-Body-Assignment
           Module-Body-Assignment-list
	   Value-Assignment
           Value-Assignment-name
           Value-Assignment-value
	   Module-Definition
           Module-Definition-body
	   Assignment
           Assignment-type
           Assignment-value
	   Object-Identifier-Value
           Object-Identifier-Value-value))

(in-package :asn.1)

(defparameter *version* 1)
