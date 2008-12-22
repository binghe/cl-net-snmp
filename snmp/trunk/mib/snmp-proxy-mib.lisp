;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-PROXY-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-proxy-mib *mib-modules*))
(setf *current-module* 'snmp-proxy-mib)
(defpackage :asn.1/snmp-proxy-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |snmpModules|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus| |StorageType|)
  (:import-from :asn.1/snmp-framework-mib |SnmpEngineID|
                |SnmpAdminString|)
  (:import-from :asn.1/snmp-target-mib |SnmpTagValue|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group))
(in-package :asn.1/snmp-proxy-mib)
(defoid |snmpProxyMIB| (|snmpModules| 14)
  (:type 'module-identity)
  (:description
   "This MIB module defines MIB objects which provide
         mechanisms to remotely configure the parameters
         used by a proxy forwarding application.

         Copyright (C) The Internet Society (2002). This
         version of this MIB module is part of RFC 3413;
         see the RFC itself for full legal notices.
        "))
(defoid |snmpProxyObjects| (|snmpProxyMIB| 1) (:type 'object-identity))
(defoid |snmpProxyConformance| (|snmpProxyMIB| 3)
  (:type 'object-identity))
(defoid |snmpProxyTable| (|snmpProxyObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of translation parameters used by proxy forwarder
         applications for forwarding SNMP messages."))
(defoid |snmpProxyEntry| (|snmpProxyTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpProxyEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of translation parameters used by a proxy forwarder
         application for forwarding SNMP messages.

         Entries in the snmpProxyTable are created and deleted
         using the snmpProxyRowStatus object."))
(deftype |SnmpProxyEntry| () 't)
(defoid |snmpProxyName| (|snmpProxyEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this snmpProxyEntry."))
(defoid |snmpProxyType| (|snmpProxyEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of message that may be forwarded using
         the translation parameters defined by this entry."))
(defoid |snmpProxyContextEngineID| (|snmpProxyEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpEngineID|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The contextEngineID contained in messages that
         may be forwarded using the translation parameters
         defined by this entry."))
(defoid |snmpProxyContextName| (|snmpProxyEntry| 4)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The contextName contained in messages that may be
         forwarded using the translation parameters defined
         by this entry.

         This object is optional, and if not supported, the
         contextName contained in a message is ignored when
         selecting an entry in the snmpProxyTable."))
(defoid |snmpProxyTargetParamsIn| (|snmpProxyEntry| 5)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object selects an entry in the snmpTargetParamsTable.
         The selected entry is used to determine which row of the
         snmpProxyTable to use for forwarding received messages."))
(defoid |snmpProxySingleTargetOut| (|snmpProxyEntry| 6)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object selects a management target defined in the
         snmpTargetAddrTable (in the SNMP-TARGET-MIB).  The
         selected target is defined by an entry in the
         snmpTargetAddrTable whose index value (snmpTargetAddrName)
         is equal to this object.

         This object is only used when selection of a single
         target is required (i.e. when forwarding an incoming
         read or write request)."))
(defoid |snmpProxyMultipleTargetOut| (|snmpProxyEntry| 7)
  (:type 'object-type)
  (:syntax '|SnmpTagValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object selects a set of management targets defined
         in the snmpTargetAddrTable (in the SNMP-TARGET-MIB).

         This object is only used when selection of multiple
         targets is required (i.e. when forwarding an incoming
         notification)."))
(defoid |snmpProxyStorageType| (|snmpProxyEntry| 8)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type of this conceptual row.
         Conceptual rows having the value 'permanent' need not
         allow write-access to any columnar objects in the row."))
(defoid |snmpProxyRowStatus| (|snmpProxyEntry| 9)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

         To create a row in this table, a manager must

         set this object to either createAndGo(4) or
         createAndWait(5).

         The following objects may not be modified while the
         value of this object is active(1):
             - snmpProxyType
             - snmpProxyContextEngineID
             - snmpProxyContextName
             - snmpProxyTargetParamsIn
             - snmpProxySingleTargetOut
             - snmpProxyMultipleTargetOut"))
(defoid |snmpProxyCompliances| (|snmpProxyConformance| 1)
  (:type 'object-identity))
(defoid |snmpProxyGroups| (|snmpProxyConformance| 2)
  (:type 'object-identity))
(defoid |snmpProxyCompliance| (|snmpProxyCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which include
         a proxy forwarding application."))
(defoid |snmpProxyGroup| (|snmpProxyGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing remote configuration of
         management target translation parameters for use by
         proxy forwarder applications."))
