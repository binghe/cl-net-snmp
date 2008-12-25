;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;TRANSPORT-ADDRESS-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'transport-address-mib *mib-modules*)
  (setf *current-module* 'transport-address-mib))

(defpackage :asn.1/transport-address-mib
  (:nicknames :transport-address-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :transport-address-mib)

(defoid |transportAddressMIB| (|mib-2| 100)
  (:type 'module-identity)
  (:description
   "This MIB module provides commonly used transport
         address definitions.

         Copyright (C) The Internet Society (2002). This version of
         this MIB module is part of RFC 3419; see the RFC itself for
         full legal notices."))

(defoid |transportDomains| (|transportAddressMIB| 1)
  (:type 'object-identity))

(defoid |transportDomainUdpIpv4| (|transportDomains| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The UDP over IPv4 transport domain.  The corresponding
         transport address is of type TransportAddressIPv4 for
         global IPv4 addresses."))

(defoid |transportDomainUdpIpv6| (|transportDomains| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The UDP over IPv6 transport domain.  The corresponding
         transport address is of type TransportAddressIPv6 for
         global IPv6 addresses."))

(defoid |transportDomainUdpIpv4z| (|transportDomains| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The UDP over IPv4 transport domain.  The corresponding
         transport address is of type TransportAddressIPv4z for
         scoped IPv4 addresses with a zone index."))

(defoid |transportDomainUdpIpv6z| (|transportDomains| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The UDP over IPv6 transport domain.  The corresponding
         transport address is of type TransportAddressIPv6z for
         scoped IPv6 addresses with a zone index."))

(defoid |transportDomainTcpIpv4| (|transportDomains| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The TCP over IPv4 transport domain.  The corresponding
         transport address is of type TransportAddressIPv4 for
         global IPv4 addresses."))

(defoid |transportDomainTcpIpv6| (|transportDomains| 6)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The TCP over IPv6 transport domain.  The corresponding
         transport address is of type TransportAddressIPv6 for
         global IPv6 addresses."))

(defoid |transportDomainTcpIpv4z| (|transportDomains| 7)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The TCP over IPv4 transport domain.  The corresponding
         transport address is of type TransportAddressIPv4z for
         scoped IPv4 addresses with a zone index."))

(defoid |transportDomainTcpIpv6z| (|transportDomains| 8)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The TCP over IPv6 transport domain.  The corresponding
         transport address is of type TransportAddressIPv6z for
         scoped IPv6 addresses with a zone index."))

(defoid |transportDomainSctpIpv4| (|transportDomains| 9)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SCTP over IPv4 transport domain.  The corresponding
         transport address is of type TransportAddressIPv4 for
         global IPv4 addresses. This transport domain usually
         represents the primary address on multihomed SCTP
         endpoints."))

(defoid |transportDomainSctpIpv6| (|transportDomains| 10)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SCTP over IPv6 transport domain.  The corresponding
         transport address is of type TransportAddressIPv6 for
         global IPv6 addresses. This transport domain usually
         represents the primary address on multihomed SCTP
         endpoints."))

(defoid |transportDomainSctpIpv4z| (|transportDomains| 11)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SCTP over IPv4 transport domain.  The corresponding
         transport address is of type TransportAddressIPv4z for
         scoped IPv4 addresses with a zone index. This transport
         domain usually represents the primary address on
         multihomed SCTP endpoints."))

(defoid |transportDomainSctpIpv6z| (|transportDomains| 12)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SCTP over IPv6 transport domain.  The corresponding
         transport address is of type TransportAddressIPv6z for
         scoped IPv6 addresses with a zone index. This transport
         domain usually represents the primary address on
         multihomed SCTP endpoints."))

(defoid |transportDomainLocal| (|transportDomains| 13)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The Posix Local IPC transport domain. The corresponding
         transport address is of type TransportAddressLocal.

         The Posix Local IPC transport domain incorporates the
         well-known UNIX domain sockets."))

(defoid |transportDomainUdpDns| (|transportDomains| 14)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The UDP transport domain using fully qualified domain
         names. The corresponding transport address is of type
         TransportAddressDns."))

(defoid |transportDomainTcpDns| (|transportDomains| 15)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The TCP transport domain using fully qualified domain
         names. The corresponding transport address is of type
         TransportAddressDns."))

(defoid |transportDomainSctpDns| (|transportDomains| 16)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SCTP transport domain using fully qualified domain
         names. The corresponding transport address is of type
         TransportAddressDns."))

(deftype |TransportDomain| () 't)

(deftype |TransportAddressType| () 't)

(deftype |TransportAddress| () 't)

(deftype |TransportAddressIPv4| () 't)

(deftype |TransportAddressIPv6| () 't)

(deftype |TransportAddressIPv4z| () 't)

(deftype |TransportAddressIPv6z| () 't)

(deftype |TransportAddressLocal| () 't)

(deftype |TransportAddressDns| () 't)

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

