(in-package :cl-user)

(defpackage snmp
  (:use :common-lisp
        #+lispworks :comm
        #+lispworks :stream
        #+mib :zebu)
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
           #:snmp-walk))
