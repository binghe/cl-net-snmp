;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; Note: Thanks to John Fremlin from MSI, snmp-dev runs on all supported CL now.

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

#-:snmp
(load (merge-pathnames #p"features.lisp" *load-truename*))

(in-package :snmp-system)

(defsystem snmp-dev
  :description "SNMP Development Package"
  :version "6.0"
  :licence "MIT"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp)
  :components ((:module "vendor"
                :components (#+snmp-system::cl-yacc
                             (:file "yacc")
                             #+snmp-system::cl-yacc
                             (:file "yacc-patch" :depends-on ("yacc"))))
               (:module "compiler"
                :depends-on ("vendor")
		:components ((:file "reader")
			     (:file "syntax")
			     (:file "parser" :depends-on ("reader" "syntax"))
                             (:file "compile-type")
                             (:file "sort")
                             (:file "compiler" :depends-on ("sort" "parser" "compile-type"))
			     (:file "pprint")))
               (:module "interpreter"
                :depends-on ("compiler")
                :components ((:file "loader")))))
