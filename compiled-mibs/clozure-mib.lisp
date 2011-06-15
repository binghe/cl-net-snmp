;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;CLOZURE-MIB.TXT by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|Clozure-MIB|))

(defpackage :|ASN.1/Clozure-MIB|
  (:nicknames :|Clozure-MIB|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :|Clozure-MIB|)

(defoid |ccl| (|commonLisp| 8)
  (:type 'module-identity)
  (:description "The MIB module for Clozure CL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|Clozure-MIB| *mib-modules*)
  (setf *current-module* nil))

