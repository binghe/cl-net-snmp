;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:LISP;LISP-CL-HTTP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'lisp-cl-http-mib))

(defpackage :asn.1/lisp-cl-http-mib
  (:nicknames :lisp-cl-http-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |lispPackages|))

(in-package :lisp-cl-http-mib)

(defoid |cl-http| (|lispPackages| 2)
  (:type 'module-identity)
  (:description "The MIB module for CL-HTTP"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-cl-http-mib *mib-modules*)
  (setf *current-module* nil))

