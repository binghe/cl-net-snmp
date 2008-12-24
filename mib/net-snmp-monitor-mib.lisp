;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-MONITOR-MIB.TXT by ASN.1 5.0

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-monitor-mib *mib-modules*)
  (setf *current-module* 'net-snmp-monitor-mib))
(defpackage :asn.1/net-snmp-monitor-mib
  (:nicknames :net-snmp-monitor-mib)
  (:use :common-lisp :asn.1)
  (:import-from :asn.1/net-snmp-mib |netSnmpObjects|
                |netSnmpModuleIDs|)
  (:import-from :|ASN.1/SNMPv2-SMI| object-type notification-type
                module-identity |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|))
(in-package :net-snmp-monitor-mib)
(defoid |netSnmpMonitorMIB| (|netSnmpModuleIDs| 3)
  (:type 'module-identity)
  (:description
   "Configured elements of the system to monitor
	 (XXX - ugh! - need a better description!)"))
(defoid |nsProcess| (|netSnmpObjects| 21) (:type 'object-identity))
(defoid |nsDisk| (|netSnmpObjects| 22) (:type 'object-identity))
(defoid |nsFile| (|netSnmpObjects| 23) (:type 'object-identity))
(defoid |nsLog| (|netSnmpObjects| 24) (:type 'object-identity))
(eval-when (:load-toplevel :execute) (setf *current-module* nil))
