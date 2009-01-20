;;;; -*- Mode: Lisp -*-
;;;; $Id$

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(in-package :snmp-system)

#+(and lispworks capi)
(defsystem snmp-ui
  :description "SNMP GUI Utility"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:snmp-client)
  :components ((:module "interface"
                :serial t
		:components ((:file "package")
                             (:file "mibrowser")
                             (:file "lispworks-capi")))))
