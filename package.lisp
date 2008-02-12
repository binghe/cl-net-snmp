(in-package :cl-user)

(defpackage snmp
  (:use :common-lisp
        #+lispworks :comm
        #+lispworks :stream
        #-no-mib :zebu)
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
           #:snmp-walk
           ;; utils
           #:mib-browser
           #:snmp-utility))

(in-package :snmp)

(let* ((defaults (asdf:component-pathname (asdf:find-system :snmp)))
       (home (make-pathname :name :wild :type :wild
                            :directory (append (pathname-directory defaults)
                                               '(:wild-inferiors))
                            :host (pathname-host defaults)
                            :defaults defaults)))
  (setf (logical-pathname-translations "snmp")
        `(("**;*.*" ,home))))
