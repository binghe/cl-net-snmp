;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANAIFTYPE-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|IANAifType-MIB| *mib-modules*)
  (setf *current-module* '|IANAifType-MIB|))

(defpackage :|ASN.1/IANAifType-MIB|
  (:nicknames :|IANAifType-MIB|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :|IANAifType-MIB|)

(defoid |ianaifType| (|mib-2| 30)
  (:type 'module-identity)
  (:description
   "This MIB module defines the IANAifType Textual
                     Convention, and thus the enumerated values of
                     the ifType object defined in MIB-II's ifTable."))

(deftype |IANAifType| () 't)

(deftype |IANAtunnelType| () 't)

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

