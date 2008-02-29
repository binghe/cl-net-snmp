;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(require "comm")

;;; Use this if you do not need MIB or you don't like/have ZEBU
;; (pushnew :no-mib *features*)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (#+lispworks :lispworks-udp
               :ironclad         ;; for SNMPv3
               :ieee-floats      ;; for SMI opaque (single-float) type
               #-lispworks :split-sequence
               #+ignore :usocket ;; Networking base in the future
               #-no-mib :zebu)
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
               (:file "snmp-get"  :depends-on ("report" "oid" "pdu"))
               (:file "snmp-get-next" :depends-on ("report" "oid" "pdu"))
               (:file "snmp-get-bulk" :depends-on ("report" "oid" "bulk-pdu"))
               (:file "snmp-walk" :depends-on ("snmp-get-next"))
               #-no-mib (:file "syntax" :depends-on ("package"))
               #-no-mib (:file "mib-tree" :depends-on ("syntax" "oid"))
               #-no-mib (:file "mib-build" :depends-on ("mib-tree"))
               (:file "print-oid" :depends-on ("oid"))
               #+(and (not no-mib) lispworks)
               (:file "mib-browser" :depends-on ("mib-tree"))
               #+(and (not no-mib) lispworks)
               (:file "snmp-utility" :depends-on ("snmp-get" "snmp-walk"))
               (:file "snmp-response" :depends-on ("report" "oid" "pdu"))
               (:file "snmp-server" :depends-on ("snmp-response"))))

;;; Only needed when you want to modify the ASN.1 syntax file (asn1.zb)
#-no-mib
(defsystem snmp-devel
  :description "Simple Network Manangement Protocol (Development)"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (snmp
               zebu-compiler)
  :components ((:file "devel")))
