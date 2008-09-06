;;;; Auto-generated from ASN-SNMP:IPV6-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'IPV6-MIB)
(DEFOID |ipv6MIB| (|mib-2| 55))
(DEFOID |ipv6MIBObjects| (|ipv6MIB| 1))
(DEFOID |ipv6Forwarding| (|ipv6MIBObjects| 1))
(DEFOID |ipv6DefaultHopLimit| (|ipv6MIBObjects| 2))
(DEFOID |ipv6Interfaces| (|ipv6MIBObjects| 3))
(DEFOID |ipv6IfTableLastChange| (|ipv6MIBObjects| 4))
(DEFOID |ipv6IfTable| (|ipv6MIBObjects| 5))
(DEFOID |ipv6IfEntry| (|ipv6IfTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |ipv6IfIndex| (|ipv6IfEntry| 1))
(DEFOID |ipv6IfDescr| (|ipv6IfEntry| 2))
(DEFOID |ipv6IfLowerLayer| (|ipv6IfEntry| 3))
(DEFOID |ipv6IfEffectiveMtu| (|ipv6IfEntry| 4))
(DEFOID |ipv6IfReasmMaxSize| (|ipv6IfEntry| 5))
(DEFOID |ipv6IfIdentifier| (|ipv6IfEntry| 6))
(DEFOID |ipv6IfIdentifierLength| (|ipv6IfEntry| 7))
(DEFOID |ipv6IfPhysicalAddress| (|ipv6IfEntry| 8))
(DEFOID |ipv6IfAdminStatus| (|ipv6IfEntry| 9))
(DEFOID |ipv6IfOperStatus| (|ipv6IfEntry| 10))
(DEFOID |ipv6IfLastChange| (|ipv6IfEntry| 11))
(DEFOID |ipv6IfStatsTable| (|ipv6MIBObjects| 6))
(DEFOID |ipv6IfStatsEntry| (|ipv6IfStatsTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |ipv6IfStatsInReceives| (|ipv6IfStatsEntry| 1))
(DEFOID |ipv6IfStatsInHdrErrors| (|ipv6IfStatsEntry| 2))
(DEFOID |ipv6IfStatsInTooBigErrors| (|ipv6IfStatsEntry| 3))
(DEFOID |ipv6IfStatsInNoRoutes| (|ipv6IfStatsEntry| 4))
(DEFOID |ipv6IfStatsInAddrErrors| (|ipv6IfStatsEntry| 5))
(DEFOID |ipv6IfStatsInUnknownProtos| (|ipv6IfStatsEntry| 6))
(DEFOID |ipv6IfStatsInTruncatedPkts| (|ipv6IfStatsEntry| 7))
(DEFOID |ipv6IfStatsInDiscards| (|ipv6IfStatsEntry| 8))
(DEFOID |ipv6IfStatsInDelivers| (|ipv6IfStatsEntry| 9))
(DEFOID |ipv6IfStatsOutForwDatagrams| (|ipv6IfStatsEntry| 10))
(DEFOID |ipv6IfStatsOutRequests| (|ipv6IfStatsEntry| 11))
(DEFOID |ipv6IfStatsOutDiscards| (|ipv6IfStatsEntry| 12))
(DEFOID |ipv6IfStatsOutFragOKs| (|ipv6IfStatsEntry| 13))
(DEFOID |ipv6IfStatsOutFragFails| (|ipv6IfStatsEntry| 14))
(DEFOID |ipv6IfStatsOutFragCreates| (|ipv6IfStatsEntry| 15))
(DEFOID |ipv6IfStatsReasmReqds| (|ipv6IfStatsEntry| 16))
(DEFOID |ipv6IfStatsReasmOKs| (|ipv6IfStatsEntry| 17))
(DEFOID |ipv6IfStatsReasmFails| (|ipv6IfStatsEntry| 18))
(DEFOID |ipv6IfStatsInMcastPkts| (|ipv6IfStatsEntry| 19))
(DEFOID |ipv6IfStatsOutMcastPkts| (|ipv6IfStatsEntry| 20))
(DEFOID |ipv6AddrPrefixTable| (|ipv6MIBObjects| 7))
(DEFOID |ipv6AddrPrefixEntry| (|ipv6AddrPrefixTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |ipv6AddrPrefix| (|ipv6AddrPrefixEntry| 1))
(DEFOID |ipv6AddrPrefixLength| (|ipv6AddrPrefixEntry| 2))
(DEFOID |ipv6AddrPrefixOnLinkFlag| (|ipv6AddrPrefixEntry| 3))
(DEFOID |ipv6AddrPrefixAutonomousFlag| (|ipv6AddrPrefixEntry| 4))
(DEFOID |ipv6AddrPrefixAdvPreferredLifetime| (|ipv6AddrPrefixEntry| 5))
(DEFOID |ipv6AddrPrefixAdvValidLifetime| (|ipv6AddrPrefixEntry| 6))
(DEFOID |ipv6AddrTable| (|ipv6MIBObjects| 8))
(DEFOID |ipv6AddrEntry| (|ipv6AddrTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |ipv6AddrAddress| (|ipv6AddrEntry| 1))
(DEFOID |ipv6AddrPfxLength| (|ipv6AddrEntry| 2))
(DEFOID |ipv6AddrType| (|ipv6AddrEntry| 3))
(DEFOID |ipv6AddrAnycastFlag| (|ipv6AddrEntry| 4))
(DEFOID |ipv6AddrStatus| (|ipv6AddrEntry| 5))
(DEFOID |ipv6RouteNumber| (|ipv6MIBObjects| 9))
(DEFOID |ipv6DiscardedRoutes| (|ipv6MIBObjects| 10))
(DEFOID |ipv6RouteTable| (|ipv6MIBObjects| 11))
(DEFOID |ipv6RouteEntry| (|ipv6RouteTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |ipv6RouteDest| (|ipv6RouteEntry| 1))
(DEFOID |ipv6RoutePfxLength| (|ipv6RouteEntry| 2))
(DEFOID |ipv6RouteIndex| (|ipv6RouteEntry| 3))
(DEFOID |ipv6RouteIfIndex| (|ipv6RouteEntry| 4))
(DEFOID |ipv6RouteNextHop| (|ipv6RouteEntry| 5))
(DEFOID |ipv6RouteType| (|ipv6RouteEntry| 6))
(DEFOID |ipv6RouteProtocol| (|ipv6RouteEntry| 7))
(DEFOID |ipv6RoutePolicy| (|ipv6RouteEntry| 8))
(DEFOID |ipv6RouteAge| (|ipv6RouteEntry| 9))
(DEFOID |ipv6RouteNextHopRDI| (|ipv6RouteEntry| 10))
(DEFOID |ipv6RouteMetric| (|ipv6RouteEntry| 11))
(DEFOID |ipv6RouteWeight| (|ipv6RouteEntry| 12))
(DEFOID |ipv6RouteInfo| (|ipv6RouteEntry| 13))
(DEFOID |ipv6RouteValid| (|ipv6RouteEntry| 14))
(DEFOID |ipv6NetToMediaTable| (|ipv6MIBObjects| 12))
(DEFOID |ipv6NetToMediaEntry| (|ipv6NetToMediaTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |ipv6NetToMediaNetAddress| (|ipv6NetToMediaEntry| 1))
(DEFOID |ipv6NetToMediaPhysAddress| (|ipv6NetToMediaEntry| 2))
(DEFOID |ipv6NetToMediaType| (|ipv6NetToMediaEntry| 3))
(DEFOID |ipv6IfNetToMediaState| (|ipv6NetToMediaEntry| 4))
(DEFOID |ipv6IfNetToMediaLastUpdated| (|ipv6NetToMediaEntry| 5))
(DEFOID |ipv6NetToMediaValid| (|ipv6NetToMediaEntry| 6))
(DEFOID |ipv6Notifications| (|ipv6MIB| 2))
(DEFOID |ipv6NotificationPrefix| (|ipv6Notifications| 0))
(DEFOID |ipv6IfStateChange| (|ipv6NotificationPrefix| 1))
(DEFOID |ipv6Conformance| (|ipv6MIB| 3))
(DEFOID |ipv6Compliances| (|ipv6Conformance| 1))
(DEFOID |ipv6Groups| (|ipv6Conformance| 2))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |ipv6GeneralGroup| (|ipv6Groups| 1))
(DEFOID |ipv6NotificationGroup| (|ipv6Groups| 2))