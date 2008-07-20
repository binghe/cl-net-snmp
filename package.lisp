;;;; -*- Mode: lisp -*-

(in-package :cl-user)

(defpackage snmp
  (:use #+genera :future-common-lisp
        #-genera :common-lisp
        #+lispworks :harlequin-common-lisp
        #+lispworks :lispworks
        #+lispworks :comm
        #-lispworks :usocket
        :trivial-gray-streams
        :asn.1)
  (:export ;; constants
           #:+snmp-version-1+
           #:+snmp-version-2c+
           #:+snmp-version-3+
           ;; snmp session
           #:open-session
           #:close-session
           #:with-open-session
           ;; snmp operation
   	   #:snmp-get
           #:snmp-set
           #:snmp-get-next
           #:snmp-walk
           #:snmp-bulk
           #:snmp-trap
           #:snmp-inform
           ;; server
           #:snmp-server
           #:enable-snmp-service
           #:disable-snmp-service
           #:export-object-id
           #:unexport-object-id
           ;; other
           #:update-mib))

(in-package :snmp)

;;; Logical Pathname Translations, learn from CL-HTTP source code

(eval-when (:load-toplevel :execute)
  (let* ((defaults #+asdf (asdf:component-pathname (asdf:find-system :snmp))
                   #-asdf *load-pathname*)
         (home (make-pathname :name :wild :type :wild
                              :directory (append (pathname-directory defaults)
                                                 '(:wild-inferiors))
                              :host (pathname-host defaults)
                              :defaults defaults
			      :version :newest)))
    (setf (logical-pathname-translations "SNMP")
          `(("**;*.*.NEWEST" ,home)
	    ("**;*.*" ,home)))))
