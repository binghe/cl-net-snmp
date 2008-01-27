(in-package :cl-user)

(defpackage snmp
  (:use :common-lisp :comm :stream)
  (:export #:open-session #:close-session
	   #:snmp-get #:snmp-walk))
