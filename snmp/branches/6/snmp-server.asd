;;;; -*- Mode: Lisp -*-
;;;; $Id$

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(in-package :snmp-system)

(defsystem snmp-server
  :description "SNMP Server"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "4.0"
  :licence "MIT"
  :depends-on (:snmp :snmp-mib)
  :components ((:file "server-condition")
               (:file "snmp-server" :depends-on ("server-condition"))
               (:file "server-vacm" :depends-on ("snmp-server"))
               (:file "server-walk" :depends-on ("snmp-server"))
               (:file "server-base" :depends-on ("server-walk"))
               (:module "server"
                :depends-on ("server-base")
                :components ((:file "core")
                             (:file "lisp-base")
			     #+abcl      (:file "abcl")
                             #+allegro   (:file "allegro")
                             #+clozure   (:file "clozure")
                             #+cmu       (:file "cmucl")
                             #+ecl       (:file "ecl")
                             #+lispworks (:file "lispworks")
                             #+sbcl      (:file "sbcl")
                             #+cl-http   (:file "cl-http")))))
