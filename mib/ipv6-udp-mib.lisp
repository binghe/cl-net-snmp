;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-UDP-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-udp-mib *mib-modules*))
(setf *current-module* 'ipv6-udp-mib)
(defpackage :asn.1/ipv6-udp-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type |mib-2|
                |experimental|)
  (:import-from :asn.1/ipv6-tc |Ipv6Address| |Ipv6IfIndexOrZero|))
(in-package :asn.1/ipv6-udp-mib)
(defoid |ipv6UdpMIB| (|experimental| 87)
  (:type 'module-identity)
  (:description
   "The MIB module for entities implementing UDP over IPv6."))
(defoid |udp| (|mib-2| 7) (:type 'object-identity))
(defoid |ipv6UdpTable| (|udp| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing UDP listener information for
         UDP/IPv6 endpoints."))
(defoid |ipv6UdpEntry| (|ipv6UdpTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv6UdpEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a particular current UDP listener.

         Note that conceptual rows in this table require an
         additional index object compared to udpTable, since
         IPv6 addresses are not guaranteed to be unique on the
         managed node."))
(deftype |Ipv6UdpEntry| () 't)
(defoid |ipv6UdpLocalAddress| (|ipv6UdpEntry| 1)
  (:type 'object-type)
  (:syntax '|Ipv6Address|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The local IPv6 address for this UDP listener.
         In the case of a UDP listener which is willing
         to accept datagrams for any IPv6 address
         associated with the managed node, the value ::0
         is used."))
(defoid |ipv6UdpLocalPort| (|ipv6UdpEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The local port number for this UDP listener."))
(defoid |ipv6UdpIfIndex| (|ipv6UdpEntry| 3)
  (:type 'object-type)
  (:syntax '|Ipv6IfIndexOrZero|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index object used to disambiguate conceptual rows in
         the table, since the ipv6UdpLocalAddress/ipv6UdpLocalPort
         pair may not be unique.

         This object identifies the local interface that is
         associated with ipv6UdpLocalAddress for this UDP listener.
         If such a local interface cannot be determined, this object
         should take on the value 0.  (A possible example of this
         would be if the value of ipv6UdpLocalAddress is ::0.)

         The interface identified by a particular non-0 value of
         this index is the same interface as identified by the same
         value of ipv6IfIndex.

         The value of this object must remain constant during
         the life of this UDP endpoint."))
(defoid |ipv6UdpConformance| (|ipv6UdpMIB| 2) (:type 'object-identity))
(defoid |ipv6UdpCompliances| (|ipv6UdpConformance| 1)
  (:type 'object-identity))
(defoid |ipv6UdpGroups| (|ipv6UdpConformance| 2)
  (:type 'object-identity))
(defoid |ipv6UdpCompliance| (|ipv6UdpCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMPv2 entities which
         implement UDP over IPv6."))
(defoid |ipv6UdpGroup| (|ipv6UdpGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects providing management of
         UDP over IPv6."))
