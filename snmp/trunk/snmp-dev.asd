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
  :description "SNMP Development Package"
  :version "6.0"
  :licence "MIT"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp)
  :components ((:module "compiler"
                :depends-on ("vendor")
		:components ((:file "reader")
			     (:file "syntax")
			     (:file "parser"
                              :depends-on ("reader" "syntax"))
                             (:file "compile-type")
                             (:file "sort")
                             (:file "compiler"
                              :depends-on ("sort" "parser" "compile-type"))
			     (:file "pprint")))
               (:module "interpreter"
                :depends-on ("compiler")
                :components ((:file "loader")))
               (:module "vendor"
                :components (#+snmp-features:cl-yacc
                             (:file "yacc")
                             #+snmp-features:cl-yacc
                             (:file "patch-yacc" :depends-on ("yacc"))))
               (:file "update-mib")))
