;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(defpackage snmp-system
  (:use :common-lisp :asdf))

(in-package :snmp-system)

(defparameter *mib.lisp-expr*
  (with-open-file
      (s (merge-pathnames (make-pathname :name "mib"
                                         :type "lisp-expr")
                          *load-truename*)
         :direction :input)
    (read s)))

(defsystem snmp-mib
  :description "SNMP MIB"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "1.0"
  :licence "MIT"
  :depends-on (:snmp-base)
  :components ((:file "mib-depend")
               (:module "mib"
                :components #.*mib.lisp-expr*)))
