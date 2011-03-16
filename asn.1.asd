;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

#-:SNMP
(load (merge-pathnames #p"features.lisp" *load-truename*))

(in-package :snmp-system)

(defsystem ASN.1
  :description "ASN.1 for Common Lisp"
  :version "5.0"
  :licence "MIT"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :components ((:module "vendor"
                :components ((:file "ieee-floats")
                            #+snmp-system::cl-yacc
                             (:file "yacc")
                             #+snmp-system::cl-yacc
                             (:file "yacc-patch" :depends-on ("yacc"))))
               (:file "package")
               (:module "runtime"                :depends-on ("package" "vendor")
		:components ((:file "constants")
			     (:file "base")
                             (:file "condition")
			     (:file "ber"        :depends-on ("condition" "constants" "base"))
			     (:file "object-id"  :depends-on ("ber"))
                             (:file "oid-reader" :depends-on ("object-id"))
                             (:file "oid-walk"   :depends-on ("object-id"))
                             (:file "integer"    :depends-on ("ber"))
                             (:file "null"       :depends-on ("ber"))
                             (:file "sequence"   :depends-on ("object-id"))
                             (:file "string"     :depends-on ("ber"))
                             (:file "ipaddress"  :depends-on ("ber"))
                             (:file "counter"    :depends-on ("ber"))
                             (:file "gauge"      :depends-on ("ber"))
                             (:file "timeticks"  :depends-on ("ber"))
                             (:file "opaque"     :depends-on ("ber"))
                             (:file "bits"       :depends-on ("ber"))
                             (:file "convention" :depends-on ("string" "integer"))))
               ;; MIB compiler
               (:module "compiler"               :depends-on ("runtime")
		:components ((:file "reader")
			     (:file "syntax")
			     (:file "parser"     :depends-on ("reader" "syntax"))
                             (:file "compile-type")
                             (:file "sort")
                             (:file "compiler"   :depends-on ("sort" "parser" "compile-type"))
			     (:file "pprint")
                             (:file "loader"     :depends-on ("compiler"))))))
