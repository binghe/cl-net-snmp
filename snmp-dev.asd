;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; Note: Thanks to John Fremlin from MSI, snmp-dev runs on all supported CL now.

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(unless (find-package ':snmp-features)
  (load (merge-pathnames #p"features.lisp" *load-truename*)))

(in-package :snmp-system)

(defsystem snmp-dev
  :description "SNMP Development"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "6.0-dev"
  :licence "MIT"
  :depends-on (:asn.1-dev
               :snmp-base)
  :components ((:file "update-mib")))
