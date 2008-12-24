;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:LISP;LISP-CLOZURE-MIB.TXT by ASN.1 5.0

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-clozure-mib *mib-modules*)
  (setf *current-module* 'lisp-clozure-mib))
(defpackage :asn.1/lisp-clozure-mib
  (:nicknames :lisp-clozure-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))
(in-package :lisp-clozure-mib)
(defoid |clozure| (|common-lisp| 8)
  (:type 'module-identity)
  (:description "The MIB module for Clozure CL"))
(eval-when (:load-toplevel :execute) (setf *current-module* nil))
