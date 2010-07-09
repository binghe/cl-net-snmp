;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(unless (find-package ':snmp-features)
  (load (merge-pathnames #p"features.lisp" *load-truename*)))

(in-package :snmp-system)

(defsystem snmp-vendor
  :description "Vendor utilities for SNMP packages"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :components ((:module "vendor"
                :components (#-portable-threads (:file "portable-threads")))))
