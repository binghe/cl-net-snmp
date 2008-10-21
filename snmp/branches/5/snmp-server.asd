;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp-server
  :description "SNMP Server"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "3.5"
  :licence "MIT"
  :depends-on (:snmp-base)
  :components ((:file "server-condition")
               (:file "snmp-server" :depends-on ("server-condition"))
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
