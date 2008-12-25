;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-MPD-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-mpd-mib *mib-modules*)
  (setf *current-module* 'snmp-mpd-mib))

(defpackage :asn.1/snmp-mpd-mib
  (:nicknames :snmp-mpd-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |snmpModules| |Counter32|))

(in-package :snmp-mpd-mib)

(defoid |snmpMPDMIB| (|snmpModules| 11)
  (:type 'module-identity)
  (:description
   "The MIB for Message Processing and Dispatching

                  Copyright (C) The Internet Society (2002). This
                  version of this MIB module is part of RFC 3412;
                  see the RFC itself for full legal notices.
                 "))

(defoid |snmpMPDAdmin| (|snmpMPDMIB| 1) (:type 'object-identity))

(defoid |snmpMPDMIBObjects| (|snmpMPDMIB| 2) (:type 'object-identity))

(defoid |snmpMPDMIBConformance| (|snmpMPDMIB| 3)
  (:type 'object-identity))

(defoid |snmpMPDStats| (|snmpMPDMIBObjects| 1) (:type 'object-identity))

(defoid |snmpUnknownSecurityModels| (|snmpMPDStats| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they referenced a
                 securityModel that was not known to or supported by
                 the SNMP engine.
                "))

(defoid |snmpInvalidMsgs| (|snmpMPDStats| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because there were invalid
                 or inconsistent components in the SNMP message.
                "))

(defoid |snmpUnknownPDUHandlers| (|snmpMPDStats| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because the PDU contained
                 in the packet could not be passed to an application
                 responsible for handling the pduType, e.g. no SNMP
                 application had registered for the proper
                 combination of the contextEngineID and the pduType.
                "))

(defoid |snmpMPDMIBCompliances| (|snmpMPDMIBConformance| 1)
  (:type 'object-identity))

(defoid |snmpMPDMIBGroups| (|snmpMPDMIBConformance| 2)
  (:type 'object-identity))

(defoid |snmpMPDCompliance| (|snmpMPDMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which
                 implement the SNMP-MPD-MIB.
                "))

(defoid |snmpMPDGroup| (|snmpMPDMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing for remote
                 monitoring of the SNMP Message Processing and
                 Dispatching process.
                "))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

