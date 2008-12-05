;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

#+lispworks
(defsystem snmp-dev
  :description "SNMP Development"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:asn.1-dev
               :snmp-base)
  :components ((:file "update-mib")))
