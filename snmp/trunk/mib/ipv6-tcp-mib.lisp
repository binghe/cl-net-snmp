;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-TCP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ipv6-tcp-mib))

(defpackage :asn.1/ipv6-tcp-mib
  (:nicknames :ipv6-tcp-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type |mib-2|
                |experimental|)
  (:import-from :asn.1/ipv6-tc |Ipv6Address| |Ipv6IfIndexOrZero|))

(in-package :ipv6-tcp-mib)

(defoid |ipv6TcpMIB| (|experimental| 86)
  (:type 'module-identity)
  (:description
   "The MIB module for entities implementing TCP over IPv6."))

(defoid |tcp| (|mib-2| 6) (:type 'object-identity))

(defoid |ipv6TcpConnTable| (|tcp| 16)
  (:type 'object-type)
  (:syntax '(vector |Ipv6TcpConnEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing TCP connection-specific information,
         for only those connections whose endpoints are IPv6 addresses."))

(defoid |ipv6TcpConnEntry| (|ipv6TcpConnTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv6TcpConnEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A conceptual row of the ipv6TcpConnTable containing
         information about a particular current TCP connection.
         Each row of this table is transient, in that it ceases to
         exist when (or soon after) the connection makes the transition
         to the CLOSED state.

         Note that conceptual rows in this table require an additional
         index object compared to tcpConnTable, since IPv6 addresses
         are not guaranteed to be unique on the managed node."))

(defclass |Ipv6TcpConnEntry| (sequence-type)
  ((|ipv6TcpConnLocalAddress| :type |Ipv6Address|)
   (|ipv6TcpConnLocalPort| :type t)
   (|ipv6TcpConnRemAddress| :type |Ipv6Address|)
   (|ipv6TcpConnRemPort| :type t)
   (|ipv6TcpConnIfIndex| :type |Ipv6IfIndexOrZero|)
   (|ipv6TcpConnState| :type integer)))

(defoid |ipv6TcpConnLocalAddress| (|ipv6TcpConnEntry| 1)
  (:type 'object-type)
  (:syntax '|Ipv6Address|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The local IPv6 address for this TCP connection. In
         the case of a connection in the listen state which
         is willing to accept connections for any IPv6
         address associated with the managed node, the value
         ::0 is used."))

(defoid |ipv6TcpConnLocalPort| (|ipv6TcpConnEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The local port number for this TCP connection."))

(defoid |ipv6TcpConnRemAddress| (|ipv6TcpConnEntry| 3)
  (:type 'object-type)
  (:syntax '|Ipv6Address|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The remote IPv6 address for this TCP connection."))

(defoid |ipv6TcpConnRemPort| (|ipv6TcpConnEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The remote port number for this TCP connection."))

(defoid |ipv6TcpConnIfIndex| (|ipv6TcpConnEntry| 5)
  (:type 'object-type)
  (:syntax '|Ipv6IfIndexOrZero|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An index object used to disambiguate conceptual rows in
         the table, since the connection 4-tuple may not be unique.

         If the connection's remote address (ipv6TcpConnRemAddress)
         is a link-local address and the connection's local address

         (ipv6TcpConnLocalAddress) is not a link-local address, this
         object identifies a local interface on the same link as
         the connection's remote link-local address.

         Otherwise, this object identifies the local interface that
         is associated with the ipv6TcpConnLocalAddress for this
         TCP connection.  If such a local interface cannot be determined,
         this object should take on the value 0.  (A possible example
         of this would be if the value of ipv6TcpConnLocalAddress is ::0.)

         The interface identified by a particular non-0 value of this
         index is the same interface as identified by the same value
         of ipv6IfIndex.

         The value of this object must remain constant during the life
         of the TCP connection."))

(defoid |ipv6TcpConnState| (|ipv6TcpConnEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The state of this TCP connection.

         The only value which may be set by a management station is
         deleteTCB(12).  Accordingly, it is appropriate for an agent
         to return an error response (`badValue' for SNMPv1, 'wrongValue'
         for SNMPv2) if a management station attempts to set this
         object to any other value.

         If a management station sets this object to the value
         deleteTCB(12), then this has the effect of deleting the TCB
         (as defined in RFC 793) of the corresponding connection on
         the managed node, resulting in immediate termination of the
         connection.

         As an implementation-specific option, a RST segment may be
         sent from the managed node to the other TCP endpoint (note
         however that RST segments are not sent reliably)."))

(defoid |ipv6TcpConformance| (|ipv6TcpMIB| 2) (:type 'object-identity))

(defoid |ipv6TcpCompliances| (|ipv6TcpConformance| 1)
  (:type 'object-identity))

(defoid |ipv6TcpGroups| (|ipv6TcpConformance| 2)
  (:type 'object-identity))

(defoid |ipv6TcpCompliance| (|ipv6TcpCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMPv2 entities which
         implement TCP over IPv6."))

(defoid |ipv6TcpGroup| (|ipv6TcpGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects providing management of
         TCP over IPv6."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-tcp-mib *mib-modules*)
  (setf *current-module* nil))

