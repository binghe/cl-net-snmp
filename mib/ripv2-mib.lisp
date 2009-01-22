;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;RIPV2-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|RIPv2-MIB|))

(defpackage :|ASN.1/RIPv2-MIB|
  (:nicknames :|RIPv2-MIB|)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Counter32| |TimeTicks| |IpAddress|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |RowStatus|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-SMI| |mib-2|))

(in-package :|RIPv2-MIB|)

(defoid |rip2| (|mib-2| 23)
  (:type 'module-identity)
  (:description
   "The MIB module to describe the RIP2 Version 2 Protocol"))

(deftype |RouteTag| () 't)

(defoid |rip2Globals| (|rip2| 1) (:type 'object-identity))

(defoid |rip2GlobalRouteChanges| (|rip2Globals| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of route changes made to the IP Route
           Database by RIP.  This does not include the refresh
           of a route's age."))

(defoid |rip2GlobalQueries| (|rip2Globals| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of responses sent to RIP queries
           from other systems."))

(defoid |rip2IfStatTable| (|rip2| 2)
  (:type 'object-type)
  (:syntax '(vector |Rip2IfStatEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of subnets which require separate
           status monitoring in RIP."))

(defoid |rip2IfStatEntry| (|rip2IfStatTable| 1)
  (:type 'object-type)
  (:syntax '|Rip2IfStatEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A Single Routing Domain in a single Subnet."))

(defclass |Rip2IfStatEntry| (sequence-type)
  ((|rip2IfStatAddress| :type |IpAddress|)
   (|rip2IfStatRcvBadPackets| :type |Counter32|)
   (|rip2IfStatRcvBadRoutes| :type |Counter32|)
   (|rip2IfStatSentUpdates| :type |Counter32|)
   (|rip2IfStatStatus| :type |RowStatus|)))

(defoid |rip2IfStatAddress| (|rip2IfStatEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP Address of this system on the indicated
           subnet. For unnumbered interfaces, the value 0.0.0.N,
           where the least significant 24 bits (N) is the ifIndex
           for the IP Interface in network byte order."))

(defoid |rip2IfStatRcvBadPackets| (|rip2IfStatEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of RIP response packets received by
           the RIP process which were subsequently discarded
           for any reason (e.g. a version 0 packet, or an
           unknown command type)."))

(defoid |rip2IfStatRcvBadRoutes| (|rip2IfStatEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of routes, in valid RIP packets,
           which were ignored for any reason (e.g. unknown
           address family, or invalid metric)."))

(defoid |rip2IfStatSentUpdates| (|rip2IfStatEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of triggered RIP updates actually
           sent on this interface.  This explicitly does
           NOT include full updates sent containing new
           information."))

(defoid |rip2IfStatStatus| (|rip2IfStatEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Writing invalid has the effect of deleting
           this interface."))

(defoid |rip2IfConfTable| (|rip2| 3)
  (:type 'object-type)
  (:syntax '(vector |Rip2IfConfEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of subnets which require separate
           configuration in RIP."))

(defoid |rip2IfConfEntry| (|rip2IfConfTable| 1)
  (:type 'object-type)
  (:syntax '|Rip2IfConfEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A Single Routing Domain in a single Subnet."))

(defclass |Rip2IfConfEntry| (sequence-type)
  ((|rip2IfConfAddress| :type |IpAddress|)
   (|rip2IfConfDomain| :type |RouteTag|)
   (|rip2IfConfAuthType| :type integer)
   (|rip2IfConfAuthKey| :type t)
   (|rip2IfConfSend| :type integer)
   (|rip2IfConfReceive| :type integer)
   (|rip2IfConfDefaultMetric| :type integer)
   (|rip2IfConfStatus| :type |RowStatus|)
   (|rip2IfConfSrcAddress| :type |IpAddress|)))

(defoid |rip2IfConfAddress| (|rip2IfConfEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP Address of this system on the indicated
           subnet.  For unnumbered interfaces, the value 0.0.0.N,
           where the least significant 24 bits (N) is the ifIndex
           for the IP Interface in network byte order."))

(defoid |rip2IfConfDomain| (|rip2IfConfEntry| 2)
  (:type 'object-type)
  (:syntax '|RouteTag|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "Value inserted into the Routing Domain field
           of all RIP packets sent on this interface."))

(defoid |rip2IfConfAuthType| (|rip2IfConfEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of Authentication used on this
           interface."))

(defoid |rip2IfConfAuthKey| (|rip2IfConfEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value to be used as the Authentication Key
           whenever the corresponding instance of
           rip2IfConfAuthType has a value other than
           noAuthentication.  A modification of the corresponding
           instance of rip2IfConfAuthType does not modify
           the rip2IfConfAuthKey value.  If a string shorter
           than 16 octets is supplied, it will be left-
           justified and padded to 16 octets, on the right,
           with nulls (0x00).

           Reading this object always results in an  OCTET
           STRING of length zero; authentication may not
           be bypassed by reading the MIB object."))

(defoid |rip2IfConfSend| (|rip2IfConfEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "What the router sends on this interface.
           ripVersion1 implies sending RIP updates compliant
           with  RFC  1058.   rip1Compatible implies
           broadcasting RIP-2 updates using RFC 1058 route
           subsumption rules.  ripVersion2 implies
           multicasting RIP-2 updates.  ripV1Demand indicates
           the use of Demand RIP on a WAN interface under RIP
           Version 1 rules.  ripV2Demand indicates the use of
           Demand RIP on a WAN interface under Version 2 rules."))

(defoid |rip2IfConfReceive| (|rip2IfConfEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This indicates which version of RIP updates
           are to be accepted.  Note that rip2 and
           rip1OrRip2 implies reception of multicast
           packets."))

(defoid |rip2IfConfDefaultMetric| (|rip2IfConfEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable indicates the metric that is to
           be used for the default route entry in RIP updates
           originated on this interface.  A value of zero
           indicates that no default route should be
           originated; in this case, a default route via
           another router may be propagated."))

(defoid |rip2IfConfStatus| (|rip2IfConfEntry| 8)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Writing invalid has  the  effect  of  deleting
           this interface."))

(defoid |rip2IfConfSrcAddress| (|rip2IfConfEntry| 9)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The IP Address this system will use as a source
            address on this interface.  If it is a numbered
            interface, this MUST be the same value as
            rip2IfConfAddress.  On unnumbered interfaces,
            it must be the value of rip2IfConfAddress for
            some interface on the system."))

(defoid |rip2PeerTable| (|rip2| 4)
  (:type 'object-type)
  (:syntax '(vector |Rip2PeerEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of RIP Peers."))

(defoid |rip2PeerEntry| (|rip2PeerTable| 1)
  (:type 'object-type)
  (:syntax '|Rip2PeerEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Information regarding a single routing peer."))

(defclass |Rip2PeerEntry| (sequence-type)
  ((|rip2PeerAddress| :type |IpAddress|)
   (|rip2PeerDomain| :type |RouteTag|)
   (|rip2PeerLastUpdate| :type |TimeTicks|)
   (|rip2PeerVersion| :type integer)
   (|rip2PeerRcvBadPackets| :type |Counter32|)
   (|rip2PeerRcvBadRoutes| :type |Counter32|)))

(defoid |rip2PeerAddress| (|rip2PeerEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP Address that the peer is using as its source
            address.  Note that on an unnumbered link, this may
            not be a member of any subnet on the system."))

(defoid |rip2PeerDomain| (|rip2PeerEntry| 2)
  (:type 'object-type)
  (:syntax '|RouteTag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value in the Routing Domain field  in  RIP
           packets received from the peer.  As domain suuport
           is deprecated, this must be zero."))

(defoid |rip2PeerLastUpdate| (|rip2PeerEntry| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the most recent
           RIP update was received from this system."))

(defoid |rip2PeerVersion| (|rip2PeerEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The RIP version number in the header of the
           last RIP packet received."))

(defoid |rip2PeerRcvBadPackets| (|rip2PeerEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of RIP response packets from this
           peer discarded as invalid."))

(defoid |rip2PeerRcvBadRoutes| (|rip2PeerEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of routes from this peer that were
           ignored because the entry format was invalid."))

(defoid |rip2Conformance| (|rip2| 5) (:type 'object-identity))

(defoid |rip2Groups| (|rip2Conformance| 1) (:type 'object-identity))

(defoid |rip2Compliances| (|rip2Conformance| 2)
  (:type 'object-identity))

(defoid |rip2Compliance| (|rip2Compliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description "The compliance statement "))

(defoid |rip2GlobalGroup| (|rip2Groups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "This group defines global controls for RIP-II systems."))

(defoid |rip2IfStatGroup| (|rip2Groups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "This group defines interface statistics for RIP-II systems."))

(defoid |rip2IfConfGroup| (|rip2Groups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "This group defines interface configuration for RIP-II systems."))

(defoid |rip2PeerGroup| (|rip2Groups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "This group defines peer information for RIP-II systems."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|RIPv2-MIB| *mib-modules*)
  (setf *current-module* nil))

