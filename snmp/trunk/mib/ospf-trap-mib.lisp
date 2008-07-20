;;;; Auto-generated from ASN-SNMP:OSPF-TRAP-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'OSPF-TRAP-MIB)
(DEFOID |ospfTrap| (|ospf| 16))
(DEFOID |ospfTrapControl| (|ospfTrap| 1))
(DEFOID |ospfTraps| (|ospfTrap| 2))
(DEFOID |ospfSetTrap| (|ospfTrapControl| 1))
(DEFOID |ospfConfigErrorType| (|ospfTrapControl| 2))
(DEFOID |ospfPacketType| (|ospfTrapControl| 3))
(DEFOID |ospfPacketSrc| (|ospfTrapControl| 4))
(DEFOID |ospfIfStateChange| (|ospfTraps| 16))
(DEFOID |ospfVirtIfStateChange| (|ospfTraps| 1))
(DEFOID |ospfNbrStateChange| (|ospfTraps| 2))
(DEFOID |ospfVirtNbrStateChange| (|ospfTraps| 3))
(DEFOID |ospfIfConfigError| (|ospfTraps| 4))
(DEFOID |ospfVirtIfConfigError| (|ospfTraps| 5))
(DEFOID |ospfIfAuthFailure| (|ospfTraps| 6))
(DEFOID |ospfVirtIfAuthFailure| (|ospfTraps| 7))
(DEFOID |ospfIfRxBadPacket| (|ospfTraps| 8))
(DEFOID |ospfVirtIfRxBadPacket| (|ospfTraps| 9))
(DEFOID |ospfTxRetransmit| (|ospfTraps| 10))
(DEFOID |ospfVirtIfTxRetransmit| (|ospfTraps| 11))
(DEFOID |ospfOriginateLsa| (|ospfTraps| 12))
(DEFOID |ospfMaxAgeLsa| (|ospfTraps| 13))
(DEFOID |ospfLsdbOverflow| (|ospfTraps| 14))
(DEFOID |ospfLsdbApproachingOverflow| (|ospfTraps| 15))
(DEFOID |ospfTrapConformance| (|ospfTrap| 3))
(DEFOID |ospfTrapGroups| (|ospfTrapConformance| 1))
(DEFOID |ospfTrapCompliances| (|ospfTrapConformance| 2))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |ospfTrapControlGroup| (|ospfTrapGroups| 1))
