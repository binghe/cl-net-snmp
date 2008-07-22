;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:INET-ADDRESS-MIB

(in-package :asn.1)
(setf *current-module* 'inet-address-mib)
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
