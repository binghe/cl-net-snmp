;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:IETF;SNMPV2-TM by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|SNMPv2-TM|))

(defpackage :|ASN.1/SNMPv2-TM|
  (:nicknames :|SNMPv2-TM|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |snmpModules| |snmpDomains| |snmpProxys|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :|SNMPv2-TM|)

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

(define-textual-convention |SnmpUDPAddress|
                           octet-string
                           (:display-hint '"1d.1d.1d.1d/2d")
                           (:status '|current|)
                           (:description
                            "Represents a UDP over IPv4 address:

               octets   contents        encoding
                1-4     IP-address      network-byte order
                5-6     UDP-port        network-byte order
            "))

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

(define-textual-convention |SnmpOSIAddress|
                           octet-string
                           (:display-hint '"*1x:/1x:")
                           (:status '|current|)
                           (:description
                            "Represents an OSI transport-address:

          octets   contents           encoding
             1     length of NSAP     'n' as an unsigned-integer
                                         (either 0 or from 3 to 20)
          2..(n+1) NSAP                concrete binary representation
          (n+2)..m TSEL                string of (up to 64) octets
            "))

(defoid |snmpDDPDomain| (|snmpDomains| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over DDP transport domain.  The corresponding
            transport address is of type SnmpNBPAddress."))

(define-textual-convention |SnmpNBPAddress|
                           octet-string
                           (:status '|current|)
                           (:description
                            "Represents an NBP name:

         octets        contents          encoding
            1          length of object  'n' as an unsigned integer
          2..(n+1)     object            string of (up to 32) octets
           n+2         length of type    'p' as an unsigned integer
      (n+3)..(n+2+p)   type              string of (up to 32) octets
          n+3+p        length of zone    'q' as an unsigned integer
    (n+4+p)..(n+3+p+q) zone              string of (up to 32) octets

            For comparison purposes, strings are
            case-insensitive. All strings may contain any octet
            other than 255 (hex ff)."))

(defoid |snmpIPXDomain| (|snmpDomains| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP over IPX transport domain.  The corresponding
            transport address is of type SnmpIPXAddress."))

(define-textual-convention |SnmpIPXAddress|
                           octet-string
                           (:display-hint '"4x.1x:1x:1x:1x:1x:1x.2d")
                           (:status '|current|)
                           (:description
                            "Represents an IPX address:

               octets   contents            encoding
                1-4     network-number      network-byte order
                5-10    physical-address    network-byte order
               11-12    socket-number       network-byte order
            "))

(defoid |rfc1157Proxy| (|snmpProxys| 1) (:type 'object-identity))

(defoid |rfc1157Domain| (|rfc1157Proxy| 1)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description
   "The transport domain for SNMPv1 over UDP over IPv4.
            The corresponding transport address is of type
            SnmpUDPAddress."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|SNMPv2-TM| *mib-modules*)
  (setf *current-module* nil))

