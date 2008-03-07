;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:ieee-floats
               :ironclad
               #+lispworks :lispworks-udp
               #-lispworks :split-sequence
               :usocket
               :zebu)
  :components ((:file "package")
               (:file "ber"		:depends-on ("package"))
	       (:file "smi"		:depends-on ("ber"))
               (:file "null"		:depends-on ("ber"))
	       (:file "integer"		:depends-on ("ber"))
	       (:file "string"		:depends-on ("ber"))
	       (:file "sequence"	:depends-on ("ber"))
	       (:file "opaque"		:depends-on ("smi" "integer"))
	       (:file "counter"		:depends-on ("smi" "integer"))
	       (:file "gauge"		:depends-on ("smi" "integer"))
	       (:file "ipaddress"	:depends-on ("smi"))
	       (:file "oid"		:depends-on ("ber"))
               (:file "syntax"		:depends-on ("package"))
               (:file "mib-tree"	:depends-on ("syntax" "oid"))
               (:file "mib-build"	:depends-on ("mib-tree"))
               (:file "print-oid"	:depends-on ("oid" "mib-tree"))
	       (:file "timeticks"	:depends-on ("ber"))
	       (:file "pdu"		:depends-on ("sequence" "oid" "timeticks"))
	       (:file "constants"	:depends-on ("package"))
               (:file "keytool"		:depends-on ("package"))
               (:file "session"		:depends-on ("keytool" "constants"))
               (:file "message"		:depends-on ("pdu" "session"))
               (:file "network"		:depends-on ("session" "message"))
               (:file "report"		:depends-on ("sequence" "session" "message"))
               (:file "snmp-get"	:depends-on ("oid" "pdu" "network" "report"))
               (:file "snmp-walk"	:depends-on ("oid" "pdu" "network" "report"))
               (:file "snmp-trap"	:depends-on ("oid" "pdu" "network" "report"))
               (:file "snmp-server"	:depends-on ("oid" "message" "pdu"))
               (:file "oid-handler"	:depends-on ("snmp-server" "mib-build"))
               #+capi
               (:file "snmp-utility"	:depends-on ("snmp-get" "snmp-walk" "mib-tree"))))

;;; Only needed when you want to modify the ASN.1 syntax file (asn1.zb)
(defsystem snmp-devel
  :description "Simple Network Manangement Protocol (Development)"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (snmp
               zebu-compiler)
  :components ((:file "devel")))
