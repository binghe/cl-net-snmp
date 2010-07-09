;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp
  :description "SNMP Collection"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :licence "MIT"
  :depends-on (:snmp-base
	       :snmp-server))