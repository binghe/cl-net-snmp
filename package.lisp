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
           #:snmp-get-next
           #:snmp-walk
           #:snmp-get-bulk
           ;; utils
           #:mib-browser
           #:snmp-utility))

(in-package :snmp)

;;; Logical Pathname Translations
(eval-when (:load-toplevel :execute)
  (let* ((defaults #+asdf (asdf:component-pathname (asdf:find-system :snmp))
                   #-asdf *load-pathname*)
         (home (make-pathname :name :wild :type :wild
                              :directory (append (pathname-directory defaults)
                                                 '(:wild-inferiors))
                              :host (pathname-host defaults)
                              :defaults defaults)))
    (setf (logical-pathname-translations "snmp")
          `(("**;*.*" ,home)))))
