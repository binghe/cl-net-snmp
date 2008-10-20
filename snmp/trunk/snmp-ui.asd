;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp-ui
  :description "SNMP GUI Utility"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp-client)
  :components ((:module "interface"
		:components (#+(and lispworks capi)
			       (:file "lispworks-capi")))))
