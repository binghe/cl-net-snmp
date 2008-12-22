;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMPV2-TM.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew '|SNMPv2-TM| *mib-modules*))
(setf *current-module* '|SNMPv2-TM|)
(defpackage :|ASN.1/SNMPv2-TM|
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |snmpModules| |snmpDomains| |snmpProxys|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))
(in-package :|ASN.1/SNMPv2-TM|)
(defoid |snmpv2tm| (|snmpModules| 19)
  (:type 'module-identity)
  (:description
   "The MIB module for SNMP transport mappings.

             Copyright (C) The Internet Society (2002). This
             version of this MIB module is part of RFC 3417;
             see the RFC itself for full legal notices.
            "))
(defoid |snmpUDPDomain| (|snmpDomains| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over UDP over IPv4 transport domain.
            The corresponding transport address is of type
            SnmpUDPAddress."))
(deftype |SnmpUDPAddress| () 't)
(defoid |snmpCLNSDomain| (|snmpDomains| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over CLNS transport domain.
            The corresponding transport address is of type
            SnmpOSIAddress."))
(defoid |snmpCONSDomain| (|snmpDomains| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over CONS transport domain.
            The corresponding transport address is of type
            SnmpOSIAddress."))
(deftype |SnmpOSIAddress| () 't)
(defoid |snmpDDPDomain| (|snmpDomains| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over DDP transport domain.  The corresponding
            transport address is of type SnmpNBPAddress."))
(deftype |SnmpNBPAddress| () 't)
(defoid |snmpIPXDomain| (|snmpDomains| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over IPX transport domain.  The corresponding
            transport address is of type SnmpIPXAddress."))
(deftype |SnmpIPXAddress| () 't)
(defoid |rfc1157Proxy| (|snmpProxys| 1) (:type 'object-identity))
(defoid |rfc1157Domain| (|rfc1157Proxy| 1)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description
   "The transport domain for SNMPv1 over UDP over IPv4.
            The corresponding transport address is of type
            SnmpUDPAddress."))
