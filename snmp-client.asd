;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem snmp-client
  :description "High-level SNMP Client"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :licence "MIT"
  :version "1.0"
  :depends-on (:snmp-base)
  :components ((:module "client"
		:components ((:file "table")))))
