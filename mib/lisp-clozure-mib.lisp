;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from SNMP:SERVER;MIB;LISP-CLOZURE-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-clozure-mib *mib-modules*))
(setf *current-module* 'lisp-clozure-mib)
(defpackage :asn.1/lisp-clozure-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))
(in-package :asn.1/lisp-clozure-mib)
(defoid |clozure| (|common-lisp| 8)
  (:type 'module-identity)
  (:description "The MIB module for Clozure CL"))
