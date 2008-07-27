;;;; Auto-generated from ASN-SNMP:ETHERLIKE-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* '|EtherLike-MIB|)
(DEFOID |etherMIB| (|mib-2| 35))
(DEFOID |etherMIBObjects| (|etherMIB| 1))
(DEFOID |dot3| (|transmission| 7))
(DEFOID |dot3StatsTable| (|dot3| 2))
(DEFOID |dot3StatsEntry| (|dot3StatsTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot3StatsIndex| (|dot3StatsEntry| 1))
(DEFOID |dot3StatsAlignmentErrors| (|dot3StatsEntry| 2))
(DEFOID |dot3StatsFCSErrors| (|dot3StatsEntry| 3))
(DEFOID |dot3StatsSingleCollisionFrames| (|dot3StatsEntry| 4))
(DEFOID |dot3StatsMultipleCollisionFrames| (|dot3StatsEntry| 5))
(DEFOID |dot3StatsSQETestErrors| (|dot3StatsEntry| 6))
(DEFOID |dot3StatsDeferredTransmissions| (|dot3StatsEntry| 7))
(DEFOID |dot3StatsLateCollisions| (|dot3StatsEntry| 8))
(DEFOID |dot3StatsExcessiveCollisions| (|dot3StatsEntry| 9))
(DEFOID |dot3StatsInternalMacTransmitErrors| (|dot3StatsEntry| 10))
(DEFOID |dot3StatsCarrierSenseErrors| (|dot3StatsEntry| 11))
(DEFOID |dot3StatsFrameTooLongs| (|dot3StatsEntry| 13))
(DEFOID |dot3StatsInternalMacReceiveErrors| (|dot3StatsEntry| 16))
(DEFOID |dot3StatsEtherChipSet| (|dot3StatsEntry| 17))
(DEFOID |dot3StatsSymbolErrors| (|dot3StatsEntry| 18))
(DEFOID |dot3StatsDuplexStatus| (|dot3StatsEntry| 19))
(DEFOID |dot3StatsRateControlAbility| (|dot3StatsEntry| 20))
(DEFOID |dot3StatsRateControlStatus| (|dot3StatsEntry| 21))
(DEFOID |dot3CollTable| (|dot3| 5))
(DEFOID |dot3CollEntry| (|dot3CollTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot3CollCount| (|dot3CollEntry| 2))
(DEFOID |dot3CollFrequencies| (|dot3CollEntry| 3))
(DEFOID |dot3ControlTable| (|dot3| 9))
(DEFOID |dot3ControlEntry| (|dot3ControlTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot3ControlFunctionsSupported| (|dot3ControlEntry| 1))
(DEFOID |dot3ControlInUnknownOpcodes| (|dot3ControlEntry| 2))
(DEFOID |dot3HCControlInUnknownOpcodes| (|dot3ControlEntry| 3))
(DEFOID |dot3PauseTable| (|dot3| 10))
(DEFOID |dot3PauseEntry| (|dot3PauseTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot3PauseAdminMode| (|dot3PauseEntry| 1))
(DEFOID |dot3PauseOperMode| (|dot3PauseEntry| 2))
(DEFOID |dot3InPauseFrames| (|dot3PauseEntry| 3))
(DEFOID |dot3OutPauseFrames| (|dot3PauseEntry| 4))
(DEFOID |dot3HCInPauseFrames| (|dot3PauseEntry| 5))
(DEFOID |dot3HCOutPauseFrames| (|dot3PauseEntry| 6))
(DEFOID |dot3HCStatsTable| (|dot3| 11))
(DEFOID |dot3HCStatsEntry| (|dot3HCStatsTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot3HCStatsAlignmentErrors| (|dot3HCStatsEntry| 1))
(DEFOID |dot3HCStatsFCSErrors| (|dot3HCStatsEntry| 2))
(DEFOID |dot3HCStatsInternalMacTransmitErrors| (|dot3HCStatsEntry| 3))
(DEFOID |dot3HCStatsFrameTooLongs| (|dot3HCStatsEntry| 4))
(DEFOID |dot3HCStatsInternalMacReceiveErrors| (|dot3HCStatsEntry| 5))
(DEFOID |dot3HCStatsSymbolErrors| (|dot3HCStatsEntry| 6))
(DEFOID |dot3Tests| (|dot3| 6))
(DEFOID |dot3Errors| (|dot3| 7))
(DEFOID |dot3TestTdr| (|dot3Tests| 1))
(DEFOID |dot3TestLoopBack| (|dot3Tests| 2))
(DEFOID |dot3ErrorInitError| (|dot3Errors| 1))
(DEFOID |dot3ErrorLoopbackError| (|dot3Errors| 2))
(DEFOID |etherConformance| (|etherMIB| 2))
(DEFOID |etherGroups| (|etherConformance| 1))
(DEFOID |etherCompliances| (|etherConformance| 2))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |etherStatsGroup| (|etherGroups| 1))
(DEFOID |etherCollisionTableGroup| (|etherGroups| 2))
(DEFOID |etherStats100MbsGroup| (|etherGroups| 3))
(DEFOID |etherStatsBaseGroup| (|etherGroups| 4))
(DEFOID |etherStatsLowSpeedGroup| (|etherGroups| 5))
(DEFOID |etherStatsHighSpeedGroup| (|etherGroups| 6))
(DEFOID |etherDuplexGroup| (|etherGroups| 7))
(DEFOID |etherControlGroup| (|etherGroups| 8))
(DEFOID |etherControlPauseGroup| (|etherGroups| 9))
(DEFOID |etherStatsBaseGroup2| (|etherGroups| 10))
(DEFOID |etherStatsHalfDuplexGroup| (|etherGroups| 11))
(DEFOID |etherHCStatsGroup| (|etherGroups| 12))
(DEFOID |etherHCControlGroup| (|etherGroups| 13))
(DEFOID |etherHCControlPauseGroup| (|etherGroups| 14))
(DEFOID |etherRateControlGroup| (|etherGroups| 15))