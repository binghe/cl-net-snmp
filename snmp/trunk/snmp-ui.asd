;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

#+(and lispworks capi)
(defsystem snmp-ui
  :description "SNMP GUI Utility"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:snmp-client)
  :serial t
  :components ((:module "interface"
		:components ((:file "package")
                             (:file "mibrowser")
                             (:file "lispworks-capi")))))
