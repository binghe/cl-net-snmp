;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp-client
  :description "High-level SNMP Client"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:snmp-base
               :snmp-mib)
  :components ((:file "snmp-trap")
               (:module "client"
		:components ((:file "table")))))
