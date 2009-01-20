;;;; -*- Mode: Lisp -*-
;;;; $Id$

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(in-package :snmp-system)

(defsystem snmp-test
  :description "SNMP Package Test"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp :snmp-server)
  :components ((:module "test"
                :components ((:file "package")
                             (:file "server-test" :depends-on ("package"))))))
