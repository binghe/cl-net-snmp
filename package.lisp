;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(defpackage snmp
  (:use :common-lisp
        :portable-threads
        :usocket
        :asn.1)
  (:export #:+snmp-version-1+
           #:+snmp-version-2c+
           #:+snmp-version-3+
           #:*default-snmp-community*
           #:*default-snmp-port*
           #:*default-snmp-server-address*
           #:*default-snmp-server-port*
           #:*default-snmp-server*
           #:*default-snmp-version*
           #:*default-context*
           #:*snmp-readtable*
           #:clean-default-dispatch
           #:close-session
           #:control-center
           #:def-scalar-variable
           #:def-listy-mib-table
           #:disable-snmp-service
           #:enable-snmp-service
           #:open-session
           #:register-variable
           #:reload-snmp-service
           #:snmp-bulk
           #:snmp-client
           #:snmp-get
           #:snmp-get-next
           #:snmp-inform
           #:snmp-set
           #:snmp-server
           #:snmp-trap
           #:snmp-walk
           #:update-mib
           #:with-open-session)
  (:import-from :usocket
           #:rtt-rtocalc
           #:rtt-minmax
           #:rtt-init
           #:rtt-ts
           #:rtt-start
           #:rtt-stop
           #:rtt-timeout
           #:rtt-newpack))

(in-package :snmp)

;;; Logical Pathname Translations, learn from CL-HTTP source code
(eval-when (:load-toplevel :execute)
  (let* ((defaults #+asdf (asdf:component-pathname (asdf:find-system :snmp))
                   #-asdf *load-truename*)
         (home (make-pathname :name :wild :type :wild
                              :directory (append (pathname-directory defaults
								     :case :common)
                                                 '(:wild-inferiors))
                              :host (pathname-host defaults :case :common)
                              :defaults defaults
			      :version :newest
			      :case :common)))
    (setf (logical-pathname-translations "SNMP")
          `(("**;*.*.NEWEST" ,home)
	    ("**;*.*" ,home))
          (logical-pathname-translations "MIB")
          `(("**;*.*.NEWEST" "SNMP:ASN;**;*.*")
            ("**;*.*" "SNMP:ASN;**;*.*")))))

(defparameter *major-version* 6)
(defparameter *minor-version* 0)

(defparameter *server-major-version* 4)
(defparameter *server-minor-version* 0)
