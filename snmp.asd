;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.1"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:asn.1    ; Standalone ASN.1 utility
	       :ironclad ; SNMPv3 authentication/encryption support
               #+lispworks :lispworks-udp
               #-lispworks :usocket-udp
               #-lispworks :split-sequence)
  :serial t
  :components ((:file "package")
               (:module "mib"
                :serial t
                :components ((:file "snmpv2-smi")
                             (:file "snmpv2-mib")))
	       (:file "constants")
               (:file "utility")
               (:file "condition")
	       (:file "pdu")
               (:file "keytool")
	       (:file "session")
               (:file "message")
               (:file "network")
               (:file "report")
               (:file "snmp-get")
               (:file "snmp-set")
               (:file "snmp-smi")
               (:file "snmp-walk")
               ;; (:file "snmp-trap")
               #+lispworks
               (:file "snmp-server")
	       #+lispworks
               (:file "update-mib")))
