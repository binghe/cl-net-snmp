;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(unless (find-package ':snmp-features)
  (load (merge-pathnames #p"features.lisp" *load-truename*)))

(in-package :snmp-system)

(defsystem snmp-server
  :description "SNMP Server"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "4.0-dev"
  :licence "MIT"
  :depends-on (:snmp-base :snmp-mib :snmp-vendor)
  :components ((:file "server-condition")
               (:file "snmp-server" :depends-on ("server-condition"))
               (:file "server-vacm" :depends-on ("snmp-server"))
               (:file "server-walk" :depends-on ("snmp-server"))
               (:file "server-base" :depends-on ("server-walk"))
               (:file "trap-server" :depends-on ("snmp-server"))
               (:module "server"
                :depends-on ("server-base")
                :components ((:file "core")
                             (:file "lisp-base")
                             #+lispworks (:file "lispworks")
                             #+cmu       (:file "cmucl")
                             #+sbcl      (:file "sbcl")
                             #+allegro   (:file "allegro")
                             #+clozure   (:file "clozure")
                             #+cl-http   (:file "cl-http")))))
