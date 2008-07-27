;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-SYSTEM-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'net-snmp-system-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-system-mib *mib-modules*))
(defoid |netSnmpSystemMIB| (|netSnmpModuleIDs| 4)
  (:type 'module-identity)
  (:description "Characteristics of the current running system"))
(defoid |nsMemory| (|netSnmpObjects| 31) (:type 'object-identity))
(defoid |nsSwap| (|netSnmpObjects| 32) (:type 'object-identity))
(defoid |nsCPU| (|netSnmpObjects| 33) (:type 'object-identity))
(defoid |nsLoad| (|netSnmpObjects| 34) (:type 'object-identity))
(defoid |nsDiskIO| (|netSnmpObjects| 35) (:type 'object-identity))
