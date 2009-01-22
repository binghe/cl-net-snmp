;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;INET-ADDRESS-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'inet-address-mib))

(defpackage :asn.1/inet-address-mib
  (:nicknames :inet-address-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|
                |Unsigned32|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :inet-address-mib)

(defoid |inetAddressMIB| (|mib-2| 76)
  (:type 'module-identity)
  (:description
   "This MIB module defines textual conventions for
         representing Internet addresses.  An Internet
         address can be an IPv4 address, an IPv6 address,
         or a DNS domain name.  This module also defines
         textual conventions for Internet port numbers,
         autonomous system numbers, and the length of an
         Internet address prefix.

         Copyright (C) The Internet Society (2005).  This version
         of this MIB module is part of RFC 4001, see the RFC
         itself for full legal notices."))

(deftype |InetAddressType| () 't)

(deftype |InetAddress| () 't)

(deftype |InetAddressIPv4| () 't)

(deftype |InetAddressIPv6| () 't)

(deftype |InetAddressIPv4z| () 't)

(deftype |InetAddressIPv6z| () 't)

(deftype |InetAddressDNS| () 't)

(deftype |InetAddressPrefixLength| () 't)

(deftype |InetPortNumber| () 't)

(deftype |InetAutonomousSystemNumber| () 't)

(deftype |InetScopeType| () 't)

(deftype |InetZoneIndex| () 't)

(deftype |InetVersion| () 't)

(eval-when (:load-toplevel :execute)
  (pushnew 'inet-address-mib *mib-modules*)
  (setf *current-module* nil))

