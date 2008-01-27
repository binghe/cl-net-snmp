;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(require "comm")

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (lispworks-udp ;; for UDP networking on LispWorks
               ironclad      ;; for SNMPv3
               ieee-floats)  ;; for SMI opaque (single-float) type
  :components ((:file "package")
               (:file "ber" :depends-on ("package"))
	       (:file "smi" :depends-on ("ber"))
               (:file "null" :depends-on ("ber"))
	       (:file "integer" :depends-on ("ber"))
	       (:file "string" :depends-on ("ber"))
	       (:file "sequence" :depends-on ("ber"))
	       (:file "ipaddress" :depends-on ("smi"))
	       (:file "oid" :depends-on ("ber"))
	       (:file "timeticks" :depends-on ("ber"))
	       (:file "pdu" :depends-on ("ber"))
	       (:file "bulk-pdu" :depends-on ("pdu"))
	       (:file "opaque" :depends-on ("integer" "smi"))
	       (:file "counter" :depends-on ("integer" "smi"))
	       (:file "gauge" :depends-on ("integer" "smi"))
	       (:file "constants" :depends-on ("package"))
               (:file "message"   :depends-on ("constants" "pdu"))
               (:file "session"   :depends-on ("message"))
               (:file "report"    :depends-on ("session" "sequence"))
               (:file "snmp-get"  :depends-on ("report"))
               (:file "snmp-walk" :depends-on ("report"))))
