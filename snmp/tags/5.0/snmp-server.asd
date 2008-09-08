;;;; -*- Mode: Lisp -*-
;;;; $Id: snmp.asd 434 2008-08-01 15:42:38Z binghe $

(in-package :asdf)

(defsystem snmp-server
  :description "SNMP Server"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp)
  :components ((:file "server-condition")
               (:file "snmp-server" :depends-on ("server-condition"))
               (:file "server-base" :depends-on ("snmp-server"))
               (:file "trap-server" :depends-on ("snmp-server"))
               (:module "server"
                :depends-on ("server-base")
                :components ((:file "core")
                             #+lispworks (:file "lispworks")
                             #+cmu       (:file "cmucl")
                             #+sbcl      (:file "sbcl")
                             #+allegro   (:file "allegro")
                             #+clozure   (:file "clozure")
                             #+cl-http   (:file "cl-http")))))
