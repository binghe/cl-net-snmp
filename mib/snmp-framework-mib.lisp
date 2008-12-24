;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-FRAMEWORK-MIB.TXT by ASN.1 5.0

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-framework-mib *mib-modules*)
  (setf *current-module* 'snmp-framework-mib))
(defpackage :asn.1/snmp-framework-mib
  (:nicknames :snmp-framework-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity |snmpModules|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group))
(in-package :snmp-framework-mib)
(defoid |snmpFrameworkMIB| (|snmpModules| 10)
  (:type 'module-identity)
  (:description
   "The SNMP Management Architecture MIB

                     Copyright (C) The Internet Society (2002). This
                     version of this MIB module is part of RFC 3411;
                     see the RFC itself for full legal notices.
                    "))
(deftype |SnmpEngineID| () 't)
(deftype |SnmpSecurityModel| () 't)
(deftype |SnmpMessageProcessingModel| () 't)
(deftype |SnmpSecurityLevel| () 't)
(deftype |SnmpAdminString| () 't)
(defoid |snmpFrameworkAdmin| (|snmpFrameworkMIB| 1)
  (:type 'object-identity))
(defoid |snmpFrameworkMIBObjects| (|snmpFrameworkMIB| 2)
  (:type 'object-identity))
(defoid |snmpFrameworkMIBConformance| (|snmpFrameworkMIB| 3)
  (:type 'object-identity))
(defoid |snmpEngine| (|snmpFrameworkMIBObjects| 1)
  (:type 'object-identity))
(defoid |snmpEngineID| (|snmpEngine| 1)
  (:type 'object-type)
  (:syntax '|SnmpEngineID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An SNMP engine's administratively-unique identifier.

                 This information SHOULD be stored in non-volatile
                 storage so that it remains constant across
                 re-initializations of the SNMP engine.
                "))
(defoid |snmpEngineBoots| (|snmpEngine| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that the SNMP engine has
                 (re-)initialized itself since snmpEngineID
                 was last configured.
                "))
(defoid |snmpEngineTime| (|snmpEngine| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of seconds since the value of
                 the snmpEngineBoots object last changed.
                 When incrementing this object's value would
                 cause it to exceed its maximum,
                 snmpEngineBoots is incremented as if a
                 re-initialization had occurred, and this
                 object's value consequently reverts to zero.
                "))
(defoid |snmpEngineMaxMessageSize| (|snmpEngine| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum length in octets of an SNMP message
                 which this SNMP engine can send or receive and
                 process, determined as the minimum of the maximum
                 message size values supported among all of the
                 transports available to and supported by the engine.
                "))
(defoid |snmpAuthProtocols| (|snmpFrameworkAdmin| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Registration point for standards-track
                  authentication protocols used in SNMP Management
                  Frameworks.
                 "))
(defoid |snmpPrivProtocols| (|snmpFrameworkAdmin| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Registration point for standards-track privacy
                  protocols used in SNMP Management Frameworks.
                 "))
(defoid |snmpFrameworkMIBCompliances| (|snmpFrameworkMIBConformance| 1)
  (:type 'object-identity))
(defoid |snmpFrameworkMIBGroups| (|snmpFrameworkMIBConformance| 2)
  (:type 'object-identity))
(defoid |snmpFrameworkMIBCompliance| (|snmpFrameworkMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP engines which
                 implement the SNMP Management Framework MIB.
                "))
(defoid |snmpEngineGroup| (|snmpFrameworkMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects for identifying and
                 determining the configuration and current timeliness

                 values of an SNMP engine.
                "))
(eval-when (:load-toplevel :execute) (setf *current-module* nil))
