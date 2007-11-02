;;;; -*- Mode: Lisp -*-

(in-package :cl-user)

(defpackage snmp.system
  (:use :common-lisp :asdf)
  (:export #+lispworks make-fli-templates))

(in-package :snmp.system)

(defsystem net-snmp
  :description "Simple Network Manangement Protocol"
  :version "1.2"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:cl-fad          ; for directory and file
               :cl-ppcre        ; for oid resolve
               :ironclad        ; for v3 support
               :net-telent-date ; for time convert
               #+lispworks :lispworks-udp
               #-lispworks :iolib
               :cffi		; for FFI need...
               :zebu)           ; for mib parse
  :components (;; ASN.1
	       (:module asn.1
                :components ((:file "package")
                             (:file "syntax"    :depends-on ("package"))
                             (:file "ber"       :depends-on ("package"))))
	       ;; SMI
	       (:module smi
		:components ((:file "package")
                             (:file "null"      :depends-on ("package"))
			     (:file "integer"   :depends-on ("package"))
			     (:file "string"    :depends-on ("package"))
			     (:file "sequence"  :depends-on ("package"))
                             #+ignore (:file "ipaddress" :depends-on ("package"))
			     (:file "oid"       :depends-on ("package"))
                             (:file "timeticks" :depends-on ("package"))
                             (:file "pdu"       :depends-on ("package"))
                             (:file "bulk-pdu"  :depends-on ("pdu"))
                             (:file "message"   :depends-on ("package"))
                             (:file "opaque"    :depends-on ("integer"))
                             (:file "counter"    :depends-on ("integer"))
                             (:file "gauge"    :depends-on ("integer")))
		:depends-on (asn.1))
	       ;; MIB
               (:module mib
                :components ((:file "package")
			     (:file "tree"      :depends-on ("package"))
			     (:file "build"     :depends-on ("tree"))
                             (:file "print-oid" :depends-on ("tree"))
			     #+lispworks
			     (:file "browser"   :depends-on ("tree")))
		:depends-on (smi))
	       ;; SNMP
	       (:module snmp
		:components ((:file "package")
                             (:file "constants" :depends-on ("package"))
                             (:file "session"   :depends-on ("constants"))
                             (:file "snmp-get" :depends-on ("session"))
                             (:file "snmp-walk" :depends-on ("session")))
		:depends-on (asn.1 smi mib))))

(defsystem net-snmp-devel
  :description "SNMP Develop"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:net-snmp
               :zebu-compiler)  ; for asn.1 syntax compile
  :components (;; ASN.1
	       (:module asn.1
                :components ((:file "devel")))))

;; (fli:start-collecting-template-info)
#+lispworks
(defun make-fli-templates ()
  (with-open-file (stream "fli-templates.lisp" :direction :output)
    (fli:print-collected-template-info :output-stream stream)))
