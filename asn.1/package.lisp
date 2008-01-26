(in-package :snmp.system)

(defpackage asn.1
  (:use :common-lisp
        #+lispworks :stream #+sbcl :sb-gray #+clisp :gray
        #+mib :zebu)
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
           #+mib Obj-Id-Component-p
           #+mib Obj-Id-Component-name
           #+mib Obj-Id-Component-value
	   #+mib Module-Body-Assignment
           #+mib Module-Body-Assignment-list
	   #+mib Value-Assignment
           #+mib Value-Assignment-name
           #+mib Value-Assignment-value
	   #+mib Module-Definition
           #+mib Module-Definition-body
	   #+mib Assignment
           #+mib Assignment-type
           #+mib Assignment-value
	   #+mib Object-Identifier-Value
           #+mib Object-Identifier-Value-value))

(in-package :asn.1)

(defparameter *version* 2)
