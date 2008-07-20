;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "3.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:asn.1    ; Standalone ASN.1 utility
	       :ironclad ; SNMPv3 authentication/encryption support
               #+lispworks :lispworks-udp
               #-lispworks :usocket-udp
               #-lispworks :split-sequence)
  :components ((:file "package")
	       (:file "constants" :depends-on ("package"))
               (:file "utility" :depends-on ("package"))
               (:file "condition" :depends-on ("package"))
	       (:file "pdu" :depends-on ("package"))
               (:file "keytool" :depends-on ("package"))
	       (:file "session" :depends-on ("keytool"))
               (:file "message" :depends-on ("constants" "session" "pdu"))
               (:file "network" :depends-on ("utility" "session" "message"))
               (:file "report" :depends-on ("network" "session" "message"))
               (:file "snmp-get" :depends-on ("report" "session" "message" "pdu" "network"))
               (:file "snmp-set" :depends-on ("report" "session" "message" "pdu" "network"))
               (:file "snmp-smi" :depends-on ("package"))
               (:file "snmp-walk" :depends-on ("report" "session" "message"
                                               "network" "pdu" "snmp-smi"))
               (:module "mib" :depends-on ("package")
                :components #.(with-open-file
                                  (s (let ((file (merge-pathnames
						  (make-pathname :name "mib"
								 :type "lisp-expr")
						  *load-pathname*)))
                                       (format t ";; Load MIB list from ~A~%" file)
                                       file) :direction :input)
                                (let ((mibs (read s)))
                                  (pprint mibs)
                                  mibs)))
               (:file "snmp-trap" :depends-on ("mib" "report" "session"
						     "message" "pdu"))
               #+lispworks
               (:file "snmp-server" :depends-on ("utility" "mib" "message" "pdu"))
	       #+lispworks
               (:file "update-mib" :depends-on ("mib"))))
