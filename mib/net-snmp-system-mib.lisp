;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-SYSTEM-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'net-snmp-system-mib))

(defpackage :asn.1/net-snmp-system-mib
  (:nicknames :net-snmp-system-mib)
  (:use :common-lisp :asn.1)
  (:import-from :asn.1/net-snmp-mib |netSnmpObjects|
                |netSnmpModuleIDs|)
  (:import-from :asn.1/net-snmp-tc |Float|)
  (:import-from :|ASN.1/SNMPv2-SMI| object-type notification-type
                module-identity |Integer32| |Counter32|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|))

(in-package :net-snmp-system-mib)

(defoid |netSnmpSystemMIB| (|netSnmpModuleIDs| 4)
  (:type 'module-identity)
  (:description "Characteristics of the current running system"))

(defoid |nsMemory| (|netSnmpObjects| 31) (:type 'object-identity))

(defoid |nsSwap| (|netSnmpObjects| 32) (:type 'object-identity))

(defoid |nsCPU| (|netSnmpObjects| 33) (:type 'object-identity))

(defoid |nsLoad| (|netSnmpObjects| 34) (:type 'object-identity))

(defoid |nsDiskIO| (|netSnmpObjects| 35) (:type 'object-identity))

(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-system-mib *mib-modules*)
  (setf *current-module* nil))

