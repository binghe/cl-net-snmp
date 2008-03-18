;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: cl-user; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  package definitions for SNMP
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/package.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "package.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :cl-user)

(defpackage snmp
  (:use #+genera :future-common-lisp
        #-genera :common-lisp
        ;; Networking
        #+lispworks :comm
        ;; Stream
        #+(or cmu lispworks) :stream
	#+sbcl :sb-gray
	#+clozure :gray
	#+mib :zebu)
  (:export ;; constants
           #:+snmp-version-1+
           #:+snmp-version-2c+
           #:+snmp-version-3+
	   ;; types
	   #:object-id
           #:ipaddress
           #:timeticks
           #:opaque
           #:gauge
           #:counter
           ;; snmp session
           #:open-session
           #:close-session
           #:with-open-session
           ;; snmp operation
   	   #:snmp-get
           #:snmp-set
           #:snmp-walk
           #:snmp-bulk
           #:snmp-trap
           #:snmp-inform
           ;; GUI client for LispWorks
	   #+lispworks #:snmp-utility
           ;; server
           #:enable-snmp-service
           #:disable-snmp-service
           #:define-oid-handler
           #:undefine-oid-handler))

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

:eof
