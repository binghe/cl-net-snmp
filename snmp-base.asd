;;;; -*- Mode: Lisp -*-
;;;; $Id$

(unless (find-package ':snmp-system)
  (make-package ':snmp-system
                :use '(:common-lisp :asdf)))

(in-package :snmp-system)

(defpackage snmp-features
  (:use :common-lisp)
  (:export #:usocket #:iolib #:lispworks-udp
           #:portable-threads #:bordeaux-threads))

#+(and lispworks4 win32)
(pushnew :mswindows *features*)

(defparameter *snmp-features*
  (with-open-file
      (s (merge-pathnames (make-pathname :name "features"
                                         :type "lisp-expr")
                          *load-truename*)
         :direction :input)
    (let ((*package* (find-package :snmp-features)))
      (read s))))

(dolist (i *snmp-features*)
  (pushnew i *features*))

(defsystem snmp-base
  :description "SNMP Base System"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :version "6.0-dev"
  :licence "MIT"
  :depends-on (:asn.1
	       :ironclad
               #+snmp-features:usocket
               :usocket ; experimental-udp branch
               #+snmp-features:iolib
               :iolib
               #-(or scl lispworks)
               :trivial-gray-streams
               #+(and lispworks mswindows)
               :lispworks-udp
               #+(and snmp-features:portable-threads (not portable-threads))
               :portable-threads
               #+snmp-features:bordeaux-threads
               :bordeaux-threads)
  :components ((:file "package")
	       (:file "constants"   :depends-on ("package"))
               (:file "condition"   :depends-on ("constants"))
	       (:file "pdu"         :depends-on ("package" "constants"))
               (:file "keytool"     :depends-on ("package"))
               (:file "snmp-smi"    :depends-on ("constants"))
	       (:file "session"     :depends-on ("keytool"))
               (:file "message"     :depends-on ("constants" "pdu" "session"))
               (:file "network"     :depends-on ("message" "session"))
               (:file "report"      :depends-on ("network" "message"))
               (:file "request"     :depends-on ("report" "pdu"))
               (:file "snmp-get"    :depends-on ("request"))
               (:file "snmp-walk"   :depends-on ("request" "snmp-smi"))))
