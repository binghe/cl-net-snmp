;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:IANAIFTYPE-MIB

(in-package :asn.1)
(setf *current-module* '|IANAifType-MIB|)
(defoid |ianaifType| (|mib-2| 30)
  (:type 'module-identity)
  (:description
   "This MIB module defines the IANAifType Textual
                     Convention, and thus the enumerated values of
                     the ifType object defined in MIB-II's ifTable."))
(deftype |IANAifType| () 't)
(deftype |IANAtunnelType| () 't)
