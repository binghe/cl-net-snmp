;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANAIFTYPE-MIB.TXT

(in-package :asn.1)
(setf *current-module* '|IANAifType-MIB|)
(eval-when (:load-toplevel :execute)
  (pushnew '|IANAifType-MIB| *mib-modules*))
(defoid |ianaifType| (|mib-2| 30)
  (:type 'module-identity)
  (:description
   "This MIB module defines the IANAifType Textual
                     Convention, and thus the enumerated values of
                     the ifType object defined in MIB-II's ifTable."))
(deftype |IANAifType| () 't)
(deftype |IANAtunnelType| () 't)
