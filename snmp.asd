;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp
  :description "Simple Network Management Protocol"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp-client
	       :snmp-server
	       #+(and lispworks capi)
	       :snmp-ui))
