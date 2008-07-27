;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-MONITOR-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'net-snmp-monitor-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-monitor-mib *mib-modules*))
(defoid |netSnmpMonitorMIB| (|netSnmpModuleIDs| 3)
  (:type 'module-identity)
  (:description
   "Configured elements of the system to monitor
	 (XXX - ugh! - need a better description!)"))
(defoid |nsProcess| (|netSnmpObjects| 21) (:type 'object-identity))
(defoid |nsDisk| (|netSnmpObjects| 22) (:type 'object-identity))
(defoid |nsFile| (|netSnmpObjects| 23) (:type 'object-identity))
(defoid |nsLog| (|netSnmpObjects| 24) (:type 'object-identity))
