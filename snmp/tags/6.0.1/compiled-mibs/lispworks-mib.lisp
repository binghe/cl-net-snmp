;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;LISPWORKS-MIB.TXT by SNMP 6.1

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|LispWorks-MIB|))

(defpackage :|ASN.1/LispWorks-MIB|
  (:nicknames :|LispWorks-MIB|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :|LispWorks-MIB|)

(defoid |lispworks| (|commonLisp| 5)
  (:type 'module-identity)
  (:description "The MIB module for LispWorks."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|LispWorks-MIB| *mib-modules*)
  (setf *current-module* nil))

