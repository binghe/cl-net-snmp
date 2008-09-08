;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp-test
  :description "SNMP Package Test"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp :snmp-server)
  :components ((:module "test"
                :components ((:file "package")
                             (:file "server-test" :depends-on ("package"))))))
