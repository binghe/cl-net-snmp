;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

#-(and lispworks capi)
(error "SNMP-UI only support LispWorks/CAPI")

(defsystem snmp-ui
  :description "SNMP UI"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp-client)
  :components ((:module "interface"
	        :components ((:file "snmp-client")))))
