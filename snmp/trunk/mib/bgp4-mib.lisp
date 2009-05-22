;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;BGP4-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'bgp4-mib))

(defpackage :asn.1/bgp4-mib
  (:nicknames :bgp4-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                notification-type |IpAddress| |Integer32| |Counter32|
                |Gauge32| |mib-2|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group))

(in-package :bgp4-mib)

(defoid |bgp| (|mib-2| 15)
  (:type 'module-identity)
  (:description "The MIB module for BGP-4."))

(defoid |bgpVersion| (|bgp| 1)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Vector of supported BGP protocol version
                    numbers.  Each peer negotiates the version
                    from this vector.  Versions are identified
                    via the string of bits contained within this
                    object.  The first octet contains bits 0 to
                    7, the second octet contains bits 8 to 15,
                    and so on, with the most significant bit
                    referring to the lowest bit number in the
                    octet (e.g., the MSB of the first octet
                    refers to bit 0).  If a bit, i, is present
                    and set, then the version (i+1) of the BGP
                    is supported."))

(defoid |bgpLocalAs| (|bgp| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The local autonomous system number."))

(defoid |bgpPeerTable| (|bgp| 3)
  (:type 'object-type)
  (:syntax '(vector |BgpPeerEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "BGP peer table.  This table contains,
                    one entry per BGP peer, information about the
                    connections with BGP peers."))

(defoid |bgpPeerEntry| (|bgpPeerTable| 1)
  (:type 'object-type)
  (:syntax '|BgpPeerEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Entry containing information about the
                    connection with a BGP peer."))

(defclass |BgpPeerEntry|
          (sequence-type)
          ((|bgpPeerIdentifier| :type |IpAddress|)
           (|bgpPeerState| :type integer)
           (|bgpPeerAdminStatus| :type integer)
           (|bgpPeerNegotiatedVersion| :type |Integer32|)
           (|bgpPeerLocalAddr| :type |IpAddress|)
           (|bgpPeerLocalPort| :type integer)
           (|bgpPeerRemoteAddr| :type |IpAddress|)
           (|bgpPeerRemotePort| :type integer)
           (|bgpPeerRemoteAs| :type integer)
           (|bgpPeerInUpdates| :type |Counter32|)
           (|bgpPeerOutUpdates| :type |Counter32|)
           (|bgpPeerInTotalMessages| :type |Counter32|)
           (|bgpPeerOutTotalMessages| :type |Counter32|)
           (|bgpPeerLastError| :type octet-string)
           (|bgpPeerFsmEstablishedTransitions| :type |Counter32|)
           (|bgpPeerFsmEstablishedTime| :type |Gauge32|)
           (|bgpPeerConnectRetryInterval| :type integer)
           (|bgpPeerHoldTime| :type integer)
           (|bgpPeerKeepAlive| :type integer)
           (|bgpPeerHoldTimeConfigured| :type integer)
           (|bgpPeerKeepAliveConfigured| :type integer)
           (|bgpPeerMinASOriginationInterval| :type integer)
           (|bgpPeerMinRouteAdvertisementInterval| :type integer)
           (|bgpPeerInUpdateElapsedTime| :type |Gauge32|)))

(defoid |bgpPeerIdentifier| (|bgpPeerEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The BGP Identifier of this entry's BGP peer."))

(defoid |bgpPeerState| (|bgpPeerEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The BGP peer connection state."))

(defoid |bgpPeerAdminStatus| (|bgpPeerEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The desired state of the BGP connection.  A
                    transition from 'stop' to 'start' will cause
                    the BGP Start Event to be generated.  A
                    transition from 'start' to 'stop' will cause
                    the BGP Stop Event to be generated.  This
                    parameter can be used to restart BGP peer
                    connections.  Care should be used in providing
                    write access to this object without adequate
                    authentication."))

(defoid |bgpPeerNegotiatedVersion| (|bgpPeerEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The negotiated version of BGP running between
                    the two peers."))

(defoid |bgpPeerLocalAddr| (|bgpPeerEntry| 5)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The local IP address of this entry's BGP
                    connection."))

(defoid |bgpPeerLocalPort| (|bgpPeerEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The local port for the TCP connection between
                    the BGP peers."))

(defoid |bgpPeerRemoteAddr| (|bgpPeerEntry| 7)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The remote IP address of this entry's BGP
                    peer."))

(defoid |bgpPeerRemotePort| (|bgpPeerEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The remote port for the TCP connection between
                    the BGP peers.  Note that the objects
                    bgpPeerLocalAddr, bgpPeerLocalPort,
                    bgpPeerRemoteAddr and bgpPeerRemotePort
                    provide the appropriate reference to the
                    standard MIB TCP connection table."))

(defoid |bgpPeerRemoteAs| (|bgpPeerEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The remote autonomous system number."))

(defoid |bgpPeerInUpdates| (|bgpPeerEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of BGP UPDATE messages received on
                    this connection.  This object should be
                    initialized to zero (0) when the connection is
                    established."))

(defoid |bgpPeerOutUpdates| (|bgpPeerEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of BGP UPDATE messages transmitted
                    on this connection.  This object should be
                    initialized to zero (0) when the connection is
                    established."))

(defoid |bgpPeerInTotalMessages| (|bgpPeerEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of messages received from the
                    remote peer on this connection.  This object
                    should be initialized to zero when the
                    connection is established."))

(defoid |bgpPeerOutTotalMessages| (|bgpPeerEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of messages transmitted to
                    the remote peer on this connection.  This object
                    should be initialized to zero when the
                    connection is established."))

(defoid |bgpPeerLastError| (|bgpPeerEntry| 14)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The last error code and subcode seen by this
                    peer on this connection.  If no error has
                    occurred, this field is zero.  Otherwise, the
                    first byte of this two byte OCTET STRING
                    contains the error code, and the second byte
                    contains the subcode."))

(defoid |bgpPeerFsmEstablishedTransitions| (|bgpPeerEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of times the BGP FSM
                    transitioned into the established state."))

(defoid |bgpPeerFsmEstablishedTime| (|bgpPeerEntry| 16)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This timer indicates how long (in seconds) this
                    peer has been in the Established state or how long
                    since this peer was last in the Established state.
                    It is set to zero when a new peer is configured or
                    the router is booted."))

(defoid |bgpPeerConnectRetryInterval| (|bgpPeerEntry| 17)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the ConnectRetry
                    timer.  The suggested value for this timer is
                    120 seconds."))

(defoid |bgpPeerHoldTime| (|bgpPeerEntry| 18)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the Hold Timer
                    established with the peer.  The value of this
                    object is calculated by this BGP speaker by
                    using the smaller of the value in
                    bgpPeerHoldTimeConfigured and the Hold Time
                    received in the OPEN message.  This value
                    must be at lease three seconds if it is not
                    zero (0) in which case the Hold Timer has
                    not been established with the peer, or, the
                    value of bgpPeerHoldTimeConfigured is zero (0)."))

(defoid |bgpPeerKeepAlive| (|bgpPeerEntry| 19)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the KeepAlive
                    timer established with the peer.  The value of
                    this object is calculated by this BGP speaker
                    such that, when compared with bgpPeerHoldTime,
                    it has the same proportion as what
                    bgpPeerKeepAliveConfigured has when compared
                    with bgpPeerHoldTimeConfigured.  If the value
                    of this object is zero (0), it indicates that
                    the KeepAlive timer has not been established
                    with the peer, or, the value of
                    bgpPeerKeepAliveConfigured is zero (0)."))

(defoid |bgpPeerHoldTimeConfigured| (|bgpPeerEntry| 20)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the Hold Time
                    configured for this BGP speaker with this peer.
                    This value is placed in an OPEN message sent to
                    this peer by this BGP speaker, and is compared
                    with the Hold Time field in an OPEN message
                    received from the peer when determining the Hold
                    Time (bgpPeerHoldTime) with the peer.  This value
                    must not be less than three seconds if it is not
                    zero (0) in which case the Hold Time is NOT to be
                    established with the peer.  The suggested value for
                    this timer is 90 seconds."))

(defoid |bgpPeerKeepAliveConfigured| (|bgpPeerEntry| 21)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the KeepAlive timer
                    configured for this BGP speaker with this peer.
                    The value of this object will only determine the
                    KEEPALIVE messages' frequency relative to the value
                    specified in bgpPeerHoldTimeConfigured; the actual
                    time interval for the KEEPALIVE messages is
                    indicated by bgpPeerKeepAlive.  A reasonable
                    maximum value for this timer would be configured to
                    be one third of that of bgpPeerHoldTimeConfigured.
                    If the value of this object is zero (0), no
                    periodical KEEPALIVE messages are sent to the peer
                    after the BGP connection has been established.  The
                    suggested value for this timer is 30 seconds."))

(defoid |bgpPeerMinASOriginationInterval| (|bgpPeerEntry| 22)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the
                    MinASOriginationInterval timer.
                    The suggested value for this timer is 15 seconds."))

(defoid |bgpPeerMinRouteAdvertisementInterval| (|bgpPeerEntry| 23)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Time interval in seconds for the
                    MinRouteAdvertisementInterval timer.
                    The suggested value for this timer is 30 seconds."))

(defoid |bgpPeerInUpdateElapsedTime| (|bgpPeerEntry| 24)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Elapsed time in seconds since the last BGP
                    UPDATE message was received from the peer.
                    Each time bgpPeerInUpdates is incremented,
                    the value of this object is set to zero (0)."))

(defoid |bgpIdentifier| (|bgp| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The BGP Identifier of local system."))

(defoid |bgpRcvdPathAttrTable| (|bgp| 5)
  (:type 'object-type)
  (:syntax '(vector |BgpPathAttrEntry|))
  (:max-access '|not-accessible|)
  (:status '|obsolete|)
  (:description
   "The BGP Received Path Attribute Table contains
                    information about paths to destination networks
                    received from all peers running BGP version 3 or
                    less."))

(defoid |bgpPathAttrEntry| (|bgpRcvdPathAttrTable| 1)
  (:type 'object-type)
  (:syntax '|BgpPathAttrEntry|)
  (:max-access '|not-accessible|)
  (:status '|obsolete|)
  (:description "Information about a path to a network."))

(defclass |BgpPathAttrEntry|
          (sequence-type)
          ((|bgpPathAttrPeer| :type |IpAddress|)
           (|bgpPathAttrDestNetwork| :type |IpAddress|)
           (|bgpPathAttrOrigin| :type integer)
           (|bgpPathAttrASPath| :type octet-string)
           (|bgpPathAttrNextHop| :type |IpAddress|)
           (|bgpPathAttrInterASMetric| :type |Integer32|)))

(defoid |bgpPathAttrPeer| (|bgpPathAttrEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The IP address of the peer where the path
                    information was learned."))

(defoid |bgpPathAttrDestNetwork| (|bgpPathAttrEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description "The address of the destination network."))

(defoid |bgpPathAttrOrigin| (|bgpPathAttrEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description "The ultimate origin of the path information."))

(defoid |bgpPathAttrASPath| (|bgpPathAttrEntry| 4)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The set of ASs that must be traversed to reach
                    the network.  This object is probably best
                    represented as SEQUENCE OF INTEGER.  For SMI
                    compatibility, though, it is represented as
                    OCTET STRING.  Each AS is represented as a pair
                    of octets according to the following algorithm:

                        first-byte-of-pair = ASNumber / 256;
                        second-byte-of-pair = ASNumber & 255;"))

(defoid |bgpPathAttrNextHop| (|bgpPathAttrEntry| 5)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The address of the border router that should
                    be used for the destination network."))

(defoid |bgpPathAttrInterASMetric| (|bgpPathAttrEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The optional inter-AS metric.  If this
                    attribute has not been provided for this route,
                    the value for this object is 0."))

(defoid |bgp4PathAttrTable| (|bgp| 6)
  (:type 'object-type)
  (:syntax '(vector |Bgp4PathAttrEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The BGP-4 Received Path Attribute Table contains
                    information about paths to destination networks
                    received from all BGP4 peers."))

(defoid |bgp4PathAttrEntry| (|bgp4PathAttrTable| 1)
  (:type 'object-type)
  (:syntax '|Bgp4PathAttrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Information about a path to a network."))

(defclass |Bgp4PathAttrEntry|
          (sequence-type)
          ((|bgp4PathAttrPeer| :type |IpAddress|)
           (|bgp4PathAttrIpAddrPrefixLen| :type integer)
           (|bgp4PathAttrIpAddrPrefix| :type |IpAddress|)
           (|bgp4PathAttrOrigin| :type integer)
           (|bgp4PathAttrASPathSegment| :type octet-string)
           (|bgp4PathAttrNextHop| :type |IpAddress|)
           (|bgp4PathAttrMultiExitDisc| :type integer)
           (|bgp4PathAttrLocalPref| :type integer)
           (|bgp4PathAttrAtomicAggregate| :type integer)
           (|bgp4PathAttrAggregatorAS| :type integer)
           (|bgp4PathAttrAggregatorAddr| :type |IpAddress|)
           (|bgp4PathAttrCalcLocalPref| :type integer)
           (|bgp4PathAttrBest| :type integer)
           (|bgp4PathAttrUnknown| :type octet-string)))

(defoid |bgp4PathAttrPeer| (|bgp4PathAttrEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP address of the peer where the path
                    information was learned."))

(defoid |bgp4PathAttrIpAddrPrefixLen| (|bgp4PathAttrEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Length in bits of the IP address prefix in the
                    Network Layer Reachability Information field."))

(defoid |bgp4PathAttrIpAddrPrefix| (|bgp4PathAttrEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An IP address prefix in the Network Layer
                    Reachability Information field.  This object
                    is an IP address containing the prefix with
                    length specified by bgp4PathAttrIpAddrPrefixLen.
                    Any bits beyond the length specified by
                    bgp4PathAttrIpAddrPrefixLen are zeroed."))

(defoid |bgp4PathAttrOrigin| (|bgp4PathAttrEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The ultimate origin of the path information."))

(defoid |bgp4PathAttrASPathSegment| (|bgp4PathAttrEntry| 5)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The sequence of AS path segments.  Each AS
                    path segment is represented by a triple
                    <type, length, value>.

                    The type is a 1-octet field which has two
                    possible values:
                         1      AS_SET: unordered set of ASs a
                                     route in the UPDATE message
                                     has traversed
                         2      AS_SEQUENCE: ordered set of ASs
                                     a route in the UPDATE message
                                     has traversed.

                    The length is a 1-octet field containing the
                    number of ASs in the value field.

                    The value field contains one or more AS
                    numbers, each AS is represented in the octet
                    string as a pair of octets according to the
                    following algorithm:

                        first-byte-of-pair = ASNumber / 256;
                        second-byte-of-pair = ASNumber & 255;"))

(defoid |bgp4PathAttrNextHop| (|bgp4PathAttrEntry| 6)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The address of the border router that should
                    be used for the destination network."))

(defoid |bgp4PathAttrMultiExitDisc| (|bgp4PathAttrEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This metric is used to discriminate between
                    multiple exit points to an adjacent autonomous
                    system.  A value of -1 indicates the absence of
                    this attribute."))

(defoid |bgp4PathAttrLocalPref| (|bgp4PathAttrEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The originating BGP4 speaker's degree of
                    preference for an advertised route.  A value of
                    -1 indicates the absence of this attribute."))

(defoid |bgp4PathAttrAtomicAggregate| (|bgp4PathAttrEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Whether or not a system has selected
                    a less specific route without selecting a
                    more specific route."))

(defoid |bgp4PathAttrAggregatorAS| (|bgp4PathAttrEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The AS number of the last BGP4 speaker that
                    performed route aggregation.  A value of zero (0)
                    indicates the absence of this attribute."))

(defoid |bgp4PathAttrAggregatorAddr| (|bgp4PathAttrEntry| 11)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP address of the last BGP4 speaker that
                     performed route aggregation.  A value of
                     0.0.0.0 indicates the absence of this attribute."))

(defoid |bgp4PathAttrCalcLocalPref| (|bgp4PathAttrEntry| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The degree of preference calculated by the
                    receiving BGP4 speaker for an advertised route.
                    A value of -1 indicates the absence of this
                    attribute."))

(defoid |bgp4PathAttrBest| (|bgp4PathAttrEntry| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An indication of whether or not this route
                    was chosen as the best BGP4 route."))

(defoid |bgp4PathAttrUnknown| (|bgp4PathAttrEntry| 14)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "One or more path attributes not understood
                     by this BGP4 speaker.  Size zero (0) indicates
                     the absence of such attribute(s).  Octets
                     beyond the maximum size, if any, are not
                     recorded by this object."))

(defoid |bgpTraps| (|bgp| 0) (:type 'object-identity))

(defoid |bgpEstablished| (|bgpTraps| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "The BGP Established event is generated when
                    the BGP FSM enters the ESTABLISHED state."))

(defoid |bgpBackwardTransition| (|bgpTraps| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "The BGPBackwardTransition Event is generated
                    when the BGP FSM moves from a higher numbered
                    state to a lower numbered state."))

(defoid |bgpMIBConformance| (|bgp| 8) (:type 'object-identity))

(defoid |bgpMIBCompliances| (|bgpMIBConformance| 1)
  (:type 'object-identity))

(defoid |bgpMIBGroups| (|bgpMIBConformance| 2) (:type 'object-identity))

(defoid |bgpMIBCompliance| (|bgpMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which
                     implement the BGP4 mib."))

(defoid |bgp4MIBGlobalsGroup| (|bgpMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                     on global BGP state."))

(defoid |bgp4MIBPeerGroup| (|bgpMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects for managing
                     BGP peers."))

(defoid |bgp4MIBRcvdPathAttrGroup| (|bgpMIBGroups| 3)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description
   "A collection of objects for managing BGP
                     path entries.

                     This conformance group is obsolete,
                     replaced by bgp4MIBPathAttrGroup."))

(defoid |bgp4MIBPathAttrGroup| (|bgpMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects for managing
                     BGP path entries."))

(defoid |bgp4MIBNotificationGroup| (|bgpMIBGroups| 5)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "A collection of notifications for signaling
                    changes in BGP peer relationships."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'bgp4-mib *mib-modules*)
  (setf *current-module* nil))

