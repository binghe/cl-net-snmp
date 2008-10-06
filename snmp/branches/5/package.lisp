;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(defpackage snmp
  (:use #+genera :future-common-lisp
        #-genera :common-lisp
        :trivial-gray-streams
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
           #:close-session
           #:control-center
           #:def-scalar-variable
           #:def-listy-mib-table
           #:disable-snmp-service
           #:enable-snmp-service
           #:open-session
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
           #:with-open-session))

(in-package :snmp)

;;; Logical Pathname Translations, learn from CL-HTTP source code
(eval-when (:load-toplevel :execute)
  (let* ((defaults #+asdf (asdf:component-pathname (asdf:find-system :snmp))
                   #-asdf *load-truename*)
         (home (make-pathname :name :wild :type :wild
                              :directory (append (pathname-directory defaults)
                                                 '(:wild-inferiors))
                              :host (pathname-host defaults)
                              :defaults defaults
			      :version :newest)))
    (setf (logical-pathname-translations "SNMP")
          `(("**;*.*.NEWEST" ,home)
	    ("**;*.*" ,home))
          (logical-pathname-translations "MIB")
          `(("**;*.*.NEWEST" "SNMP:ASN;**;*.*")
            ("**;*.*" "SNMP:ASN;**;*.*")))))

(defvar *major-version* 5)
(defvar *minor-version* 14)

(eval-when (:load-toplevel :execute)
  (assert (or (> asn.1::*major-version* 4)
              (and (= asn.1::*major-version* 4)
                   (>= asn.1::*minor-version* 10)))))
