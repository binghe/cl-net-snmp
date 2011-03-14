;;;; -*- Mode: Lisp -*-
;;;; $Id: asn.1.asd 806 2010-07-10 13:44:57Z binghe $

(in-package :cl-user)

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

#-:snmp
(load (merge-pathnames #p"features.lisp" *load-truename*))

(in-package :snmp-system)

(defsystem asn.1
  :description "ASN.1 for Common Lisp"
  :version "5.0"
  :licence "MIT"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :components ((:file "package")
               (:module "vendor"
                :components ((:file "ieee-floats")))
               (:module "runtime"
                :depends-on ("package" "vendor")
		:components ((:file "constants")
			     (:file "base")
                             (:file "condition")
			     (:file "ber"
                              :depends-on ("condition" "constants" "base"))
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
                             (:file "textual-convention"
                              :depends-on ("string" "integer"))))))
