;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:LISP;LISP-SCL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-scl-mib *mib-modules*)
  (setf *current-module* 'lisp-scl-mib))

(defpackage :asn.1/lisp-scl-mib
  (:nicknames :lisp-scl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))

(in-package :lisp-scl-mib)

(defoid |scl| (|common-lisp| 10)
  (:type 'module-identity)
  (:description "The MIB module for Scieneer CL"))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

