;;;; -*- Mode: Lisp -*-

(in-package :cl-user)

(defpackage snmp-system
  (:use :common-lisp :asdf))

(in-package :snmp-system)

(defparameter *mib.lisp-expr*
  (with-open-file
      (s (merge-pathnames (make-pathname :name "mib"
                                         :type "lisp-expr")
                          *load-truename*)
         :direction :input)
    (read s)))

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "4.2"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:asn.1        ; Standalone ASN.1 support
	       :ironclad     ; SNMPv3 authentication/encryption support
               :usocket-udp) ; Portable UDP networking
  :components ((:file "package")
	       (:file "constants"   :depends-on ("package"))
               (:file "utility"     :depends-on ("package"))
               (:file "condition"   :depends-on ("package"))
	       (:file "pdu"         :depends-on ("package"))
               (:file "keytool"     :depends-on ("package"))
               (:file "snmp-smi"    :depends-on ("package"))
	       (:file "session"     :depends-on ("keytool"))
               (:file "message"     :depends-on ("constants" "pdu" "session"))
               (:file "network"     :depends-on ("message" "session" "utility"))
               (:file "report"      :depends-on ("message" "network" "session"))
               (:file "snmp-get"    :depends-on ("message" "network" "pdu"
                                                 "session"))
               (:file "snmp-set"    :depends-on ("message" "network" "pdu"
                                                 "session"))
               (:file "snmp-walk"   :depends-on ("message" "mib" "network"
                                                 "pdu" "report" "session"
                                                 "snmp-smi"))
               (:file "snmp-trap"   :depends-on ("message" "mib" "network"
                                                 "pdu" "report" "session"))
	       #+lispworks
               (:file "update-mib"  :depends-on ("mib"))
               (:module "mib"       :depends-on ("package")
                :components #.*mib.lisp-expr*)
               (:module "vendor"
                :components (#-portable-threads
                             (:file "portable-threads")))))

(defsystem snmp-server
  :description "SNMP Server"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp)
  :components ((:file "snmp-server")
               (:file "server-base" :depends-on ("snmp-server"))))
