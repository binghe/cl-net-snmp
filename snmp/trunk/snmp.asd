;;;; -*- Mode: Lisp -*-

(in-package :asdf)

;;; Load networking support
#+sbcl (require :sb-bsd-sockets)
#+cmucl (require :gray-streams)

#+lispworks
(pushnew :mib *features*)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:ieee-floats
               :ironclad
               #+lispworks :lispworks-udp
               #-lispworks :split-sequence
               :usocket
               #+mib :zebu-compiler)
  :components ((:file "package")
               (:file "ber"		:depends-on ("package"))
	       (:file "smi"		:depends-on ("ber"))
               (:file "null"		:depends-on ("ber"))
	       (:file "integer"		:depends-on ("ber"))
	       (:file "string"		:depends-on ("ber"))
	       (:file "sequence"	:depends-on ("ber"))
	       (:file "timeticks"	:depends-on ("smi" "integer"))
	       (:file "opaque"		:depends-on ("smi" "integer"))
	       (:file "counter"		:depends-on ("smi" "integer"))
	       (:file "gauge"		:depends-on ("smi" "integer"))
	       (:file "ipaddress"	:depends-on ("smi"))
	       (:file "oid"		:depends-on ("ber"))
	       #+mib
               (:file "syntax"		:depends-on ("package"))
	       #+mib
               (:file "mib-tree"	:depends-on ("syntax" "oid"))
	       #+mib
               (:file "mib-build"	:depends-on ("mib-tree"))
               (:file "print-oid"	:depends-on ("oid" #+mib "mib-tree"))
	       (:file "pdu"		:depends-on ("sequence" "oid" "timeticks"))
	       (:file "constants"	:depends-on ("package"))
               (:file "keytool"		:depends-on ("package"))
	       #+(or sbcl lispworks)
	       (:file "session"		:depends-on ("keytool" "constants"))
	       #+(or sbcl lispworks)
               (:file "message"		:depends-on ("pdu" "session"))
	       #+(or sbcl lispworks)
               (:file "network"		:depends-on ("session" "message"))
	       #+(or sbcl lispworks)
               (:file "report"		:depends-on ("sequence" "session" "message"))
	       #+(or sbcl lispworks)
               (:file "snmp-get"	:depends-on ("oid" "pdu" "network" "report"))
	       #+(or sbcl lispworks)
               (:file "snmp-walk"	:depends-on ("oid" "pdu" "network" "report"))
	       #+(or sbcl lispworks)
               (:file "snmp-trap"	:depends-on ("oid" "pdu" "network" "report"))
	       #+lispworks
               (:file "snmp-server"	:depends-on ("oid" "message" "pdu"))
	       #+(and mib lispworks)
               (:file "oid-handler"	:depends-on ("snmp-server" "mib-build"))
               #+(and mib lispworks)
	       (:file "snmp-utility"	:depends-on ("snmp-get" "snmp-walk" "mib-tree"))))

