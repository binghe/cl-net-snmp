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

(defparameter *major-version* 5)
(defparameter *minor-version* 19)

(defparameter *server-major-version* 3)
(defparameter *server-minor-version* 9)

(eval-when (:load-toplevel :execute)
  (if (and (boundp 'asn.1::*major-version*)
           (boundp 'asn.1::*minor-version*))
      (assert (or (> asn.1::*major-version* 4)
                  (and (= asn.1::*major-version* 4)
                       (>= asn.1::*minor-version* 14))))
    (error "Please use a newer version of ASN.1 package (>= 4.14)"))
  (if (and (boundp 'usocket::*major-version*)
           (boundp 'usocket::*minor-version*))
      (assert (or (> usocket::*major-version* 2)
                  (and (= usocket::*major-version* 2)
                       (>= usocket::*minor-version* 3))))
    (if (fboundp 'usocket::socket-send)
	(error "Please use a newer version of USOCKET-UDP package (>= 2.3)"))))