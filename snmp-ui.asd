;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp-ui
  :description "SNMP GUI Utility"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:snmp-client)
  :components ((:module "interface"
		:components (#+(and lispworks capi)
			       (:file "lispworks-capi")))))
