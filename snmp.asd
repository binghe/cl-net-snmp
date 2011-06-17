;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(in-package :snmp-system)

(defparameter *mib.lisp-expr*
  (with-open-file
      (s (merge-pathnames (make-pathname :name "mib"
                                         :type "lisp-expr")
                          *load-truename*)
         :direction :input)
    (read s)))

(defsystem snmp
  :description "Simple Network Management Protocol"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "6.0.2"
  :licence "MIT"
  :depends-on (:ironclad :usocket)
  :components ((:module "vendor"
                :components (#-portable-threads
			     (:file "portable-threads")
			     (:file "ieee-floats")
			     #-lispworks #-lispworks
			     (:file "yacc")
			     (:file "yacc-patch" :depends-on ("yacc"))))
               ;; base system
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
               (:module "compiler"               :depends-on ("runtime" "vendor")
		:components ((:file "reader")
			     (:file "syntax")
			     (:file "parser"     :depends-on ("reader" "syntax"))
                             (:file "compile-type")
                             (:file "sort")
                             (:file "compiler"   :depends-on ("sort" "parser" "compile-type"))
			     (:file "pprint")
                             (:file "loader"     :depends-on ("compiler"))))
	       (:file "constants")
               (:file "condition"                :depends-on ("constants"))
               (:file "keytool"                  :depends-on ("constants"))
	       (:file "pdu"                      :depends-on ("runtime" "constants"))
               (:file "snmp-smi"                 :depends-on ("runtime" "constants"))
	       (:file "session"                  :depends-on ("keytool"))
               (:file "message"                  :depends-on ("constants" "pdu" "session"))
               (:file "network"                  :depends-on ("message" "session"))
               (:file "request"                  :depends-on ("network" "message" "pdu" "snmp-smi"))
               (:file "snmp-get"                 :depends-on ("request"))
               (:file "snmp-walk"                :depends-on ("request"))
               (:file "snmp-trap"                :depends-on ("request"))
               (:file "update-mib"               :depends-on ("package" "compiler"))
	       (:file "patch"                    :depends-on ("package"))
               (:file "mib-depend"               :depends-on ("runtime"))
               (:module "compiled-mibs"          :depends-on ("runtime")
                :components #.*mib.lisp-expr*)))

(defmethod perform ((op test-op) (c (eql (find-system :snmp))))
  (oos 'load-op :snmp-test)
  (oos 'test-op :snmp-test))

(defmethod perform :after ((op load-op) (c (eql (find-system :snmp))))
  (funcall (intern "LOAD-ALL-PATCHES" "SNMP") c))
