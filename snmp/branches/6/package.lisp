;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp-system)

#+(or abcl cmu)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :gray-streams))

#+ecl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (gray::redefine-cl-functions))

(defpackage asn.1
  (:use :common-lisp
        #+sbcl :sb-gray #+sbcl :sb-pcl
        #+allegro :excl #+allegro :aclmop
        #+cmu :ext #+cmu :pcl #+cmu :clos-mop
        #+clisp :gray
        #+(or mcl clozure) :ccl
        #+lispworks :stream #+lispworks :clos
        #+ecl :gray #+ecl :clos
        #+scl :ext
        #+abcl :system #+abcl :mop #+abcl :gray-streams)
  #+abcl
  (:import-from :mop #:class-direct-subclasses
                     #:class-direct-slots)
  (:export #:*asn.1-package*
           #:*mib-modules*
           #:*mib-module-dependency*
           #:*oid-database*
           #:asn.1-class
           #:asn.1-type
	   #:ber-decode
	   #:ber-decode<-string
           #:ber-decode-value
           #:ber-encode
	   #:ber-encode->string
           #:ber-encode-length
	   #:ber-encode-list
           #:ber-encode-type
           #:ber-equal
           #:ber-stream
           #:bits
           #:compile-asn.1
           #:counter
           #:counter32
           #:counter64
           #:define-textual-convention
           #:defunknown
           #:defoid
           #:delete-object
           #:ensure-oid
           #:gauge
	   #:general-type
           #:get-asn.1-type
           #:install-asn.1-type
           #:integer
           #:ipaddress
           #:list-all-mib-classes
           #:list-all-mib-tables
           #:list-children
           #:load-asn.1
           #:number-type
           #:object-id
           #:octet-string
           #:oid
           #:oid-find-base
           #:oid-find-leaf
           #:oid-leaf-p
           #:oid-length
           #:oid-name
           #:oid-name-string
           #:oid-name-list
           #:oid-next
           #:oid-walk
           #:oid-number-list
           #:oid-parent
           #:oid-parent-p
           #:oid-scalar-variable-p
           #:oid-syntax
           #:oid-syntax-p
           #:oid-trunk-p
           #:oid-value
	   #:oid-<
	   #:oid->=
           #:opaque
           #:parse
           #:plain-value
           #:raw
           #:sequence-type
           #:simple-oid
           #:slot-value-using-oid
           #:string
           #:timeticks
           #:uninstall-asn.1-type
	   #:value-of)
  ;; SNMP-specific exports
  (:export #:|zero| #:|iso| #:|org| #:|dod|
           #:*current-module*
           ;; access
           #:|not-accessible|
           #:|accessible-for-notify|
           #:|read-only|
           #:|read-write|
           #:|read-create|
           ;; status
           #:|current|
           #:|deprecated|
           #:|mandatory|
           #:|obsolete|
           ;; type
           #:module-identity
           #:module-compliance
           #:object-identity
           #:object-type
           #:object-group
           #:notification-type
           #:notification-group
           #:agent-capabilities
           ;; textual convention
           #:display-hint
           #:status
           #:description
           #:reference))

(defpackage snmp
  (:use :common-lisp :asn.1)
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
           #:compile-mib
           #:def-scalar-variable
           #:def-listy-mib-table
           #:disable-snmp-service
           #:enable-snmp-service
           #:load-mib
           #:open-session
           #:register-variable
           #:snmp-bulk
           #:snmp-get
           #:snmp-get-next
           #:snmp-inform
           #:snmp-set
           #:snmp-server
           #:snmp-trap
           #:snmp-walk
	   #:update-mib
           #:with-open-session)
  ;; Patch facility
  (:export #:load-all-patches))

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
          `(("**;*.*.NEWEST" "SNMP:MIBS;**;*.*")
	    ("**;*.*" "SNMP:MIBS;**;*.*")))))


(defvar *asn.1-package* (find-package :asn.1))
(defvar *snmp-package* (find-package :snmp))
