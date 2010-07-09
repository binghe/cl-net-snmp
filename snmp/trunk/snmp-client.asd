;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(unless (find-package ':snmp-features)
  (load (merge-pathnames #p"features.lisp" *load-truename*)))

(in-package :snmp-system)

(defsystem snmp-client
  :description "High-level SNMP Client"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:snmp-base
               :snmp-mib
               #+snmp-features:lisa
               :lisa)
  :components ((:module "vendor"
                :components (#-portable-threads (:file "portable-threads")))
               (:file "snmp-trap")
               (:module "client"
                :depends-on ("vendor")
		:components ((:file "common")
                             (:file "table")
                             (:file "discover")))))
