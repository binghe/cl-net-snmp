;;;; Auto-generated from ASN-SNMP:BGP4-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'BGP4-MIB)
(DEFOID |bgp| (|mib-2| 15))
(DEFOID |bgpVersion| (|bgp| 1))
(DEFOID |bgpLocalAs| (|bgp| 2))
(DEFOID |bgpPeerTable| (|bgp| 3))
(DEFOID |bgpPeerEntry| (|bgpPeerTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |bgpPeerIdentifier| (|bgpPeerEntry| 1))
(DEFOID |bgpPeerState| (|bgpPeerEntry| 2))
(DEFOID |bgpPeerAdminStatus| (|bgpPeerEntry| 3))
(DEFOID |bgpPeerNegotiatedVersion| (|bgpPeerEntry| 4))
(DEFOID |bgpPeerLocalAddr| (|bgpPeerEntry| 5))
(DEFOID |bgpPeerLocalPort| (|bgpPeerEntry| 6))
(DEFOID |bgpPeerRemoteAddr| (|bgpPeerEntry| 7))
(DEFOID |bgpPeerRemotePort| (|bgpPeerEntry| 8))
(DEFOID |bgpPeerRemoteAs| (|bgpPeerEntry| 9))
(DEFOID |bgpPeerInUpdates| (|bgpPeerEntry| 10))
(DEFOID |bgpPeerOutUpdates| (|bgpPeerEntry| 11))
(DEFOID |bgpPeerInTotalMessages| (|bgpPeerEntry| 12))
(DEFOID |bgpPeerOutTotalMessages| (|bgpPeerEntry| 13))
(DEFOID |bgpPeerLastError| (|bgpPeerEntry| 14))
(DEFOID |bgpPeerFsmEstablishedTransitions| (|bgpPeerEntry| 15))
(DEFOID |bgpPeerFsmEstablishedTime| (|bgpPeerEntry| 16))
(DEFOID |bgpPeerConnectRetryInterval| (|bgpPeerEntry| 17))
(DEFOID |bgpPeerHoldTime| (|bgpPeerEntry| 18))
(DEFOID |bgpPeerKeepAlive| (|bgpPeerEntry| 19))
(DEFOID |bgpPeerHoldTimeConfigured| (|bgpPeerEntry| 20))
(DEFOID |bgpPeerKeepAliveConfigured| (|bgpPeerEntry| 21))
(DEFOID |bgpPeerMinASOriginationInterval| (|bgpPeerEntry| 22))
(DEFOID |bgpPeerMinRouteAdvertisementInterval| (|bgpPeerEntry| 23))
(DEFOID |bgpPeerInUpdateElapsedTime| (|bgpPeerEntry| 24))
(DEFOID |bgpIdentifier| (|bgp| 4))
(DEFOID |bgpRcvdPathAttrTable| (|bgp| 5))
(DEFOID |bgpPathAttrEntry| (|bgpRcvdPathAttrTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |bgpPathAttrPeer| (|bgpPathAttrEntry| 1))
(DEFOID |bgpPathAttrDestNetwork| (|bgpPathAttrEntry| 2))
(DEFOID |bgpPathAttrOrigin| (|bgpPathAttrEntry| 3))
(DEFOID |bgpPathAttrASPath| (|bgpPathAttrEntry| 4))
(DEFOID |bgpPathAttrNextHop| (|bgpPathAttrEntry| 5))
(DEFOID |bgpPathAttrInterASMetric| (|bgpPathAttrEntry| 6))
(DEFOID |bgp4PathAttrTable| (|bgp| 6))
(DEFOID |bgp4PathAttrEntry| (|bgp4PathAttrTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |bgp4PathAttrPeer| (|bgp4PathAttrEntry| 1))
(DEFOID |bgp4PathAttrIpAddrPrefixLen| (|bgp4PathAttrEntry| 2))
(DEFOID |bgp4PathAttrIpAddrPrefix| (|bgp4PathAttrEntry| 3))
(DEFOID |bgp4PathAttrOrigin| (|bgp4PathAttrEntry| 4))
(DEFOID |bgp4PathAttrASPathSegment| (|bgp4PathAttrEntry| 5))
(DEFOID |bgp4PathAttrNextHop| (|bgp4PathAttrEntry| 6))
(DEFOID |bgp4PathAttrMultiExitDisc| (|bgp4PathAttrEntry| 7))
(DEFOID |bgp4PathAttrLocalPref| (|bgp4PathAttrEntry| 8))
(DEFOID |bgp4PathAttrAtomicAggregate| (|bgp4PathAttrEntry| 9))
(DEFOID |bgp4PathAttrAggregatorAS| (|bgp4PathAttrEntry| 10))
(DEFOID |bgp4PathAttrAggregatorAddr| (|bgp4PathAttrEntry| 11))
(DEFOID |bgp4PathAttrCalcLocalPref| (|bgp4PathAttrEntry| 12))
(DEFOID |bgp4PathAttrBest| (|bgp4PathAttrEntry| 13))
(DEFOID |bgp4PathAttrUnknown| (|bgp4PathAttrEntry| 14))
(DEFOID |bgpTraps| (|bgp| 0))
(DEFOID |bgpEstablished| (|bgpTraps| 1))
(DEFOID |bgpBackwardTransition| (|bgpTraps| 2))
(DEFOID |bgpMIBConformance| (|bgp| 8))
(DEFOID |bgpMIBCompliances| (|bgpMIBConformance| 1))
(DEFOID |bgpMIBGroups| (|bgpMIBConformance| 2))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |bgp4MIBGlobalsGroup| (|bgpMIBGroups| 1))
(DEFOID |bgp4MIBPeerGroup| (|bgpMIBGroups| 2))
(DEFOID |bgp4MIBRcvdPathAttrGroup| (|bgpMIBGroups| 3))
(DEFOID |bgp4MIBPathAttrGroup| (|bgpMIBGroups| 4))
(DEFOID |bgp4MIBNotificationGroup| (|bgpMIBGroups| 5))
