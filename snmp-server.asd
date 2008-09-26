;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp-system)

(defsystem snmp-server
  :description "SNMP Server"
  :version "3.3"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:asn.1 ; version >= 4.1
               :snmp) ; version >= 5.0
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
