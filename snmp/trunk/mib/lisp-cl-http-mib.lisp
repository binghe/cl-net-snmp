;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from SNMP:SERVER;MIB;LISP-CL-HTTP-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-cl-http-mib *mib-modules*))
(setf *current-module* 'lisp-cl-http-mib)
(defpackage :asn.1/lisp-cl-http-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |lispPackages|))
(in-package :asn.1/lisp-cl-http-mib)
(defoid |cl-http| (|lispPackages| 2)
  (:type 'module-identity)
  (:description "The MIB module for CL-HTTP"))
