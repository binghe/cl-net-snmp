(in-package :cl-user)

(defpackage snmp
  (:use :common-lisp
        #+lispworks :comm
        ;; Gray Stream
        #+(or cmu lispworks) :stream
	#+sbcl :sb-gray
	#+clozure :gray
	:zebu)
  (:export ;; constants
           #:+snmp-version-1+
           #:+snmp-version-2c+
           #:+snmp-version-3+
	   ;; types
	   #:object-id
           ;; snmp session
           #:open-session
           #:close-session
           #:with-open-session
           ;; snmp operation
   	   #:snmp-get
           #:snmp-walk
           #:snmp-bulk
           ;; GUI client
           #:snmp-utility
           ;; server
           #:enable-snmp-service
           #:disable-snmp-service
           #:define-oid-handler
           #:undefine-oid-handler))

(in-package :snmp)

;;; Logical Pathname Translations
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
