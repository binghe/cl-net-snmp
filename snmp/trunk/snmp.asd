;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(require "comm")

;;; comment this if you do not need MIB or you don't like/have ZEBU
(pushnew :mib *features*)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (lispworks-udp ;; for UDP networking on LispWorks
               ironclad      ;; for SNMPv3
               ieee-floats   ;; for SMI opaque (single-float) type
               split-sequence ; for OID parse
               #+mib zebu)
  :components ((:file "package")
               (:file "ber" :depends-on ("package"))
	       (:file "smi" :depends-on ("ber"))
               (:file "null" :depends-on ("ber"))
	       (:file "integer" :depends-on ("ber"))
	       (:file "string" :depends-on ("ber"))
	       (:file "sequence" :depends-on ("ber"))
	       (:file "opaque" :depends-on ("integer" "smi"))
	       (:file "counter" :depends-on ("integer" "smi"))
	       (:file "gauge" :depends-on ("integer" "smi"))
	       (:file "ipaddress" :depends-on ("smi"))
	       (:file "oid" :depends-on ("ber"))
	       (:file "timeticks" :depends-on ("ber"))
	       (:file "pdu" :depends-on ("ber"))
	       (:file "bulk-pdu" :depends-on ("pdu"))
	       (:file "constants" :depends-on ("package"))
               (:file "keytool"   :depends-on ("package"))
               (:file "session"   :depends-on ("keytool" "constants"))
               (:file "message"   :depends-on ("session" "constants" "pdu"))
               (:file "report"    :depends-on ("message" "session" "sequence"))
               (:file "snmp-get"  :depends-on ("report" "oid"))
               (:file "snmp-walk" :depends-on ("report" "oid"))
               #+mib (:file "syntax")
               #+mib (:file "mib-tree" :depends-on ("syntax" "oid"))
               #+mib (:file "mib-build" :depends-on ("mib-tree"))
               (:file "print-oid" :depends-on ("oid"))
               #+(and mib lispworks capi)
               (:file "mib-browser" :depends-on ("mib-tree"))))

(defsystem snmp-devel
  :description "Simple Network Manangement Protocol (Development)"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (snmp
               zebu-compiler)
  :components ((:file "devel")))
