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
               (:module "mib"
                :serial t
                :components #.(with-open-file
                                  (s (let ((file (merge-pathnames (make-pathname :name "mib"
                                                                                 :type "lisp-expr")
                                                                  *load-pathname*)))
                                       (format t ";; Load MIB list from ~A~%" file)
                                       file) :direction :input)
                                (let ((mibs (read s)))
                                  (pprint mibs)
                                  mibs)))
               (:file "snmp-trap")
               #+ignore
               (:file "snmp-server")
	       #+lispworks
               (:file "update-mib")))
