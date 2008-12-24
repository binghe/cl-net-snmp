;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:LISP;LISP-LISPWORKS-MIB.TXT by ASN.1 5.0

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-lispworks-mib *mib-modules*)
  (setf *current-module* 'lisp-lispworks-mib))
(defpackage :asn.1/lisp-lispworks-mib
  (:nicknames :lisp-lispworks-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))
(in-package :lisp-lispworks-mib)
(defoid |lispworks| (|common-lisp| 5)
  (:type 'module-identity)
  (:description "The MIB module for LispWorks."))
(eval-when (:load-toplevel :execute) (setf *current-module* nil))
