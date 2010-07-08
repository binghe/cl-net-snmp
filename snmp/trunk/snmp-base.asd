;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(unless (find-package ':snmp-features)
  (load (merge-pathnames #p"features.lisp" *load-truename*)))

(in-package :snmp-system)

(defsystem snmp-base
  :description "SNMP Base System"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "6.0-dev"
  :licence "MIT"
  :depends-on (:asn.1 :ironclad
               #-(or scl lispworks)
               :trivial-gray-streams
               #+snmp-features:usocket
               :usocket
               #+snmp-features:iolib
               :iolib
               #+snmp-features:bordeaux-threads
               :bordeaux-threads)
  :components ((:module "vendor"
                :components (#+(and snmp-features:portable-threads
                                    (not portable-threads))
                             (:file "portable-threads")))
	       (:file "package"     :depends-on ("vendor"))
	       (:file "constants"   :depends-on ("package"))
               (:file "condition"   :depends-on ("constants"))
	       (:file "pdu"         :depends-on ("package" "constants"))
               (:file "keytool"     :depends-on ("package"))
               (:file "snmp-smi"    :depends-on ("constants"))
	       (:file "session"     :depends-on ("keytool"))
               (:file "message"     :depends-on ("constants" "pdu" "session"))
               (:file "network"     :depends-on ("message" "session"))
               (:file "report"      :depends-on ("network" "message"))
               (:file "request"     :depends-on ("report" "pdu"))
               (:file "snmp-get"    :depends-on ("request"))
               (:file "snmp-walk"   :depends-on ("request" "snmp-smi"))))
