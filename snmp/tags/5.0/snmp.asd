;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(defpackage snmp-system
  (:use :common-lisp :asdf)
  (:export #:dbind))

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
  :version "5.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:asn.1        ; Standalone ASN.1 support
	       :ironclad     ; SNMPv3 authentication/encryption support
               :usocket-udp) ; Portable UDP networking
  :components ((:file "package"     :depends-on ("vendor"))
	       (:file "constants"   :depends-on ("package"))
               (:file "condition"   :depends-on ("constants"))
	       (:file "pdu"         :depends-on ("package"))
               (:file "keytool"     :depends-on ("package"))
               (:file "snmp-smi"    :depends-on ("package"))
	       (:file "session"     :depends-on ("keytool"))
               (:file "message"     :depends-on ("constants" "pdu" "session"))
               (:file "network"     :depends-on ("message" "session"))
               (:file "report"      :depends-on ("network"))
               (:file "request"     :depends-on ("report" "pdu"))
               (:file "snmp-get"    :depends-on ("request"))
               (:file "snmp-walk"   :depends-on ("request" "snmp-smi"))
               (:file "snmp-trap"   :depends-on ("request" "mib"))
               (:file "worker")
	       #+lispworks
               (:file "update-mib"  :depends-on ("mib"))
               (:file "mib-depend"  :depends-on ("package"))
               (:module "mib"       :depends-on ("package")
                :components #.*mib.lisp-expr*)
               (:module "vendor"
                :components ((:file "onlisp")
                             #-portable-threads
                             (:file "portable-threads")))
               #+(and lispworks capi)
               (:module "gui"
                :components ((:file "snmp-client")))))
