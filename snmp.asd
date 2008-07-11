;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"

  :depends-on (:asn.1    ; Standalone ASN.1      
               :ironclad ; SNMPv3 authentication/encryption support
               #+lispworks :lispworks-udp
               #-lispworks :usocket-udp
               #-lispworks :split-sequence)
  :serial t
  :components ((:file "package")
               (:file "utility")
               (:file "ber")
	       (:file "smi")
               (:file "null")
	       (:file "integer")
	       (:file "string")
	       (:file "sequence")
	       (:file "timeticks")
	       (:file "opaque")
	       (:file "counter")
	       (:file "gauge")
	       (:file "ipaddress")
	       (:file "oid")
	       (:file "pdu")
               (:file "print-oid")
	       (:file "constants")
               (:file "keytool")
	       (:file "session")
               (:file "message")
               (:file "network")
               (:file "report")
               (:file "snmp-get")
               (:file "snmp-set")
               (:file "snmp-walk")
               (:file "snmp-trap")
               #+lispworks
               (:file "snmp-server")))
