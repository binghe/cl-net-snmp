;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp
  :description "SNMP Collection"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "6.0"
  :licence "MIT"
  :depends-on (:snmp-client
	       :snmp-server
	       :snmp-ui))
