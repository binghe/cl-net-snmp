;;;; Auto-generated from ASN-SNMP:BRIDGE-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'BRIDGE-MIB)
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot1dBridge| (|mib-2| 17))
(DEFOID |dot1dBase| (|dot1dBridge| 1))
(DEFOID |dot1dStp| (|dot1dBridge| 2))
(DEFOID |dot1dSr| (|dot1dBridge| 3))
(DEFOID |dot1dTp| (|dot1dBridge| 4))
(DEFOID |dot1dStatic| (|dot1dBridge| 5))
(DEFOID |dot1dBaseBridgeAddress| (|dot1dBase| 1))
(DEFOID |dot1dBaseNumPorts| (|dot1dBase| 2))
(DEFOID |dot1dBaseType| (|dot1dBase| 3))
(DEFOID |dot1dBasePortTable| (|dot1dBase| 4))
(DEFOID |dot1dBasePortEntry| (|dot1dBasePortTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot1dBasePort| (|dot1dBasePortEntry| 1))
(DEFOID |dot1dBasePortIfIndex| (|dot1dBasePortEntry| 2))
(DEFOID |dot1dBasePortCircuit| (|dot1dBasePortEntry| 3))
(DEFOID |dot1dBasePortDelayExceededDiscards| (|dot1dBasePortEntry| 4))
(DEFOID |dot1dBasePortMtuExceededDiscards| (|dot1dBasePortEntry| 5))
(DEFOID |dot1dStpProtocolSpecification| (|dot1dStp| 1))
(DEFOID |dot1dStpPriority| (|dot1dStp| 2))
(DEFOID |dot1dStpTimeSinceTopologyChange| (|dot1dStp| 3))
(DEFOID |dot1dStpTopChanges| (|dot1dStp| 4))
(DEFOID |dot1dStpDesignatedRoot| (|dot1dStp| 5))
(DEFOID |dot1dStpRootCost| (|dot1dStp| 6))
(DEFOID |dot1dStpRootPort| (|dot1dStp| 7))
(DEFOID |dot1dStpMaxAge| (|dot1dStp| 8))
(DEFOID |dot1dStpHelloTime| (|dot1dStp| 9))
(DEFOID |dot1dStpHoldTime| (|dot1dStp| 10))
(DEFOID |dot1dStpForwardDelay| (|dot1dStp| 11))
(DEFOID |dot1dStpBridgeMaxAge| (|dot1dStp| 12))
(DEFOID |dot1dStpBridgeHelloTime| (|dot1dStp| 13))
(DEFOID |dot1dStpBridgeForwardDelay| (|dot1dStp| 14))
(DEFOID |dot1dStpPortTable| (|dot1dStp| 15))
(DEFOID |dot1dStpPortEntry| (|dot1dStpPortTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot1dStpPort| (|dot1dStpPortEntry| 1))
(DEFOID |dot1dStpPortPriority| (|dot1dStpPortEntry| 2))
(DEFOID |dot1dStpPortState| (|dot1dStpPortEntry| 3))
(DEFOID |dot1dStpPortEnable| (|dot1dStpPortEntry| 4))
(DEFOID |dot1dStpPortPathCost| (|dot1dStpPortEntry| 5))
(DEFOID |dot1dStpPortDesignatedRoot| (|dot1dStpPortEntry| 6))
(DEFOID |dot1dStpPortDesignatedCost| (|dot1dStpPortEntry| 7))
(DEFOID |dot1dStpPortDesignatedBridge| (|dot1dStpPortEntry| 8))
(DEFOID |dot1dStpPortDesignatedPort| (|dot1dStpPortEntry| 9))
(DEFOID |dot1dStpPortForwardTransitions| (|dot1dStpPortEntry| 10))
(DEFOID |dot1dTpLearnedEntryDiscards| (|dot1dTp| 1))
(DEFOID |dot1dTpAgingTime| (|dot1dTp| 2))
(DEFOID |dot1dTpFdbTable| (|dot1dTp| 3))
(DEFOID |dot1dTpFdbEntry| (|dot1dTpFdbTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot1dTpFdbAddress| (|dot1dTpFdbEntry| 1))
(DEFOID |dot1dTpFdbPort| (|dot1dTpFdbEntry| 2))
(DEFOID |dot1dTpFdbStatus| (|dot1dTpFdbEntry| 3))
(DEFOID |dot1dTpPortTable| (|dot1dTp| 4))
(DEFOID |dot1dTpPortEntry| (|dot1dTpPortTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot1dTpPort| (|dot1dTpPortEntry| 1))
(DEFOID |dot1dTpPortMaxInfo| (|dot1dTpPortEntry| 2))
(DEFOID |dot1dTpPortInFrames| (|dot1dTpPortEntry| 3))
(DEFOID |dot1dTpPortOutFrames| (|dot1dTpPortEntry| 4))
(DEFOID |dot1dTpPortInDiscards| (|dot1dTpPortEntry| 5))
(DEFOID |dot1dStaticTable| (|dot1dStatic| 1))
(DEFOID |dot1dStaticEntry| (|dot1dStaticTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dot1dStaticAddress| (|dot1dStaticEntry| 1))
(DEFOID |dot1dStaticReceivePort| (|dot1dStaticEntry| 2))
(DEFOID |dot1dStaticAllowedToGoTo| (|dot1dStaticEntry| 3))
(DEFOID |dot1dStaticStatus| (|dot1dStaticEntry| 4))
(DEFUNKNOWN 'TRAP-TYPE)
(DEFUNKNOWN 'TRAP-TYPE)
