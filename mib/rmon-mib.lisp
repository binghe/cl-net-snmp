;;;; Auto-generated from ASN-SNMP:RMON-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'RMON-MIB)
(DEFOID |rmon| (|mib-2| 16))
(DEFOID |rmonConformance| (|rmon| 20))
(DEFOID |rmonMibModule| (|rmonConformance| 8))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |statistics| (|rmon| 1))
(DEFOID |history| (|rmon| 2))
(DEFOID |alarm| (|rmon| 3))
(DEFOID |hosts| (|rmon| 4))
(DEFOID |hostTopN| (|rmon| 5))
(DEFOID |matrix| (|rmon| 6))
(DEFOID |filter| (|rmon| 7))
(DEFOID |capture| (|rmon| 8))
(DEFOID |event| (|rmon| 9))
(DEFOID |etherStatsTable| (|statistics| 1))
(DEFOID |etherStatsEntry| (|etherStatsTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |etherStatsIndex| (|etherStatsEntry| 1))
(DEFOID |etherStatsDataSource| (|etherStatsEntry| 2))
(DEFOID |etherStatsDropEvents| (|etherStatsEntry| 3))
(DEFOID |etherStatsOctets| (|etherStatsEntry| 4))
(DEFOID |etherStatsPkts| (|etherStatsEntry| 5))
(DEFOID |etherStatsBroadcastPkts| (|etherStatsEntry| 6))
(DEFOID |etherStatsMulticastPkts| (|etherStatsEntry| 7))
(DEFOID |etherStatsCRCAlignErrors| (|etherStatsEntry| 8))
(DEFOID |etherStatsUndersizePkts| (|etherStatsEntry| 9))
(DEFOID |etherStatsOversizePkts| (|etherStatsEntry| 10))
(DEFOID |etherStatsFragments| (|etherStatsEntry| 11))
(DEFOID |etherStatsJabbers| (|etherStatsEntry| 12))
(DEFOID |etherStatsCollisions| (|etherStatsEntry| 13))
(DEFOID |etherStatsPkts64Octets| (|etherStatsEntry| 14))
(DEFOID |etherStatsPkts65to127Octets| (|etherStatsEntry| 15))
(DEFOID |etherStatsPkts128to255Octets| (|etherStatsEntry| 16))
(DEFOID |etherStatsPkts256to511Octets| (|etherStatsEntry| 17))
(DEFOID |etherStatsPkts512to1023Octets| (|etherStatsEntry| 18))
(DEFOID |etherStatsPkts1024to1518Octets| (|etherStatsEntry| 19))
(DEFOID |etherStatsOwner| (|etherStatsEntry| 20))
(DEFOID |etherStatsStatus| (|etherStatsEntry| 21))
(DEFOID |historyControlTable| (|history| 1))
(DEFOID |historyControlEntry| (|historyControlTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |historyControlIndex| (|historyControlEntry| 1))
(DEFOID |historyControlDataSource| (|historyControlEntry| 2))
(DEFOID |historyControlBucketsRequested| (|historyControlEntry| 3))
(DEFOID |historyControlBucketsGranted| (|historyControlEntry| 4))
(DEFOID |historyControlInterval| (|historyControlEntry| 5))
(DEFOID |historyControlOwner| (|historyControlEntry| 6))
(DEFOID |historyControlStatus| (|historyControlEntry| 7))
(DEFOID |etherHistoryTable| (|history| 2))
(DEFOID |etherHistoryEntry| (|etherHistoryTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |etherHistoryIndex| (|etherHistoryEntry| 1))
(DEFOID |etherHistorySampleIndex| (|etherHistoryEntry| 2))
(DEFOID |etherHistoryIntervalStart| (|etherHistoryEntry| 3))
(DEFOID |etherHistoryDropEvents| (|etherHistoryEntry| 4))
(DEFOID |etherHistoryOctets| (|etherHistoryEntry| 5))
(DEFOID |etherHistoryPkts| (|etherHistoryEntry| 6))
(DEFOID |etherHistoryBroadcastPkts| (|etherHistoryEntry| 7))
(DEFOID |etherHistoryMulticastPkts| (|etherHistoryEntry| 8))
(DEFOID |etherHistoryCRCAlignErrors| (|etherHistoryEntry| 9))
(DEFOID |etherHistoryUndersizePkts| (|etherHistoryEntry| 10))
(DEFOID |etherHistoryOversizePkts| (|etherHistoryEntry| 11))
(DEFOID |etherHistoryFragments| (|etherHistoryEntry| 12))
(DEFOID |etherHistoryJabbers| (|etherHistoryEntry| 13))
(DEFOID |etherHistoryCollisions| (|etherHistoryEntry| 14))
(DEFOID |etherHistoryUtilization| (|etherHistoryEntry| 15))
(DEFOID |alarmTable| (|alarm| 1))
(DEFOID |alarmEntry| (|alarmTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |alarmIndex| (|alarmEntry| 1))
(DEFOID |alarmInterval| (|alarmEntry| 2))
(DEFOID |alarmVariable| (|alarmEntry| 3))
(DEFOID |alarmSampleType| (|alarmEntry| 4))
(DEFOID |alarmValue| (|alarmEntry| 5))
(DEFOID |alarmStartupAlarm| (|alarmEntry| 6))
(DEFOID |alarmRisingThreshold| (|alarmEntry| 7))
(DEFOID |alarmFallingThreshold| (|alarmEntry| 8))
(DEFOID |alarmRisingEventIndex| (|alarmEntry| 9))
(DEFOID |alarmFallingEventIndex| (|alarmEntry| 10))
(DEFOID |alarmOwner| (|alarmEntry| 11))
(DEFOID |alarmStatus| (|alarmEntry| 12))
(DEFOID |hostControlTable| (|hosts| 1))
(DEFOID |hostControlEntry| (|hostControlTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |hostControlIndex| (|hostControlEntry| 1))
(DEFOID |hostControlDataSource| (|hostControlEntry| 2))
(DEFOID |hostControlTableSize| (|hostControlEntry| 3))
(DEFOID |hostControlLastDeleteTime| (|hostControlEntry| 4))
(DEFOID |hostControlOwner| (|hostControlEntry| 5))
(DEFOID |hostControlStatus| (|hostControlEntry| 6))
(DEFOID |hostTable| (|hosts| 2))
(DEFOID |hostEntry| (|hostTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |hostAddress| (|hostEntry| 1))
(DEFOID |hostCreationOrder| (|hostEntry| 2))
(DEFOID |hostIndex| (|hostEntry| 3))
(DEFOID |hostInPkts| (|hostEntry| 4))
(DEFOID |hostOutPkts| (|hostEntry| 5))
(DEFOID |hostInOctets| (|hostEntry| 6))
(DEFOID |hostOutOctets| (|hostEntry| 7))
(DEFOID |hostOutErrors| (|hostEntry| 8))
(DEFOID |hostOutBroadcastPkts| (|hostEntry| 9))
(DEFOID |hostOutMulticastPkts| (|hostEntry| 10))
(DEFOID |hostTimeTable| (|hosts| 3))
(DEFOID |hostTimeEntry| (|hostTimeTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |hostTimeAddress| (|hostTimeEntry| 1))
(DEFOID |hostTimeCreationOrder| (|hostTimeEntry| 2))
(DEFOID |hostTimeIndex| (|hostTimeEntry| 3))
(DEFOID |hostTimeInPkts| (|hostTimeEntry| 4))
(DEFOID |hostTimeOutPkts| (|hostTimeEntry| 5))
(DEFOID |hostTimeInOctets| (|hostTimeEntry| 6))
(DEFOID |hostTimeOutOctets| (|hostTimeEntry| 7))
(DEFOID |hostTimeOutErrors| (|hostTimeEntry| 8))
(DEFOID |hostTimeOutBroadcastPkts| (|hostTimeEntry| 9))
(DEFOID |hostTimeOutMulticastPkts| (|hostTimeEntry| 10))
(DEFOID |hostTopNControlTable| (|hostTopN| 1))
(DEFOID |hostTopNControlEntry| (|hostTopNControlTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |hostTopNControlIndex| (|hostTopNControlEntry| 1))
(DEFOID |hostTopNHostIndex| (|hostTopNControlEntry| 2))
(DEFOID |hostTopNRateBase| (|hostTopNControlEntry| 3))
(DEFOID |hostTopNTimeRemaining| (|hostTopNControlEntry| 4))
(DEFOID |hostTopNDuration| (|hostTopNControlEntry| 5))
(DEFOID |hostTopNRequestedSize| (|hostTopNControlEntry| 6))
(DEFOID |hostTopNGrantedSize| (|hostTopNControlEntry| 7))
(DEFOID |hostTopNStartTime| (|hostTopNControlEntry| 8))
(DEFOID |hostTopNOwner| (|hostTopNControlEntry| 9))
(DEFOID |hostTopNStatus| (|hostTopNControlEntry| 10))
(DEFOID |hostTopNTable| (|hostTopN| 2))
(DEFOID |hostTopNEntry| (|hostTopNTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |hostTopNReport| (|hostTopNEntry| 1))
(DEFOID |hostTopNIndex| (|hostTopNEntry| 2))
(DEFOID |hostTopNAddress| (|hostTopNEntry| 3))
(DEFOID |hostTopNRate| (|hostTopNEntry| 4))
(DEFOID |matrixControlTable| (|matrix| 1))
(DEFOID |matrixControlEntry| (|matrixControlTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |matrixControlIndex| (|matrixControlEntry| 1))
(DEFOID |matrixControlDataSource| (|matrixControlEntry| 2))
(DEFOID |matrixControlTableSize| (|matrixControlEntry| 3))
(DEFOID |matrixControlLastDeleteTime| (|matrixControlEntry| 4))
(DEFOID |matrixControlOwner| (|matrixControlEntry| 5))
(DEFOID |matrixControlStatus| (|matrixControlEntry| 6))
(DEFOID |matrixSDTable| (|matrix| 2))
(DEFOID |matrixSDEntry| (|matrixSDTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |matrixSDSourceAddress| (|matrixSDEntry| 1))
(DEFOID |matrixSDDestAddress| (|matrixSDEntry| 2))
(DEFOID |matrixSDIndex| (|matrixSDEntry| 3))
(DEFOID |matrixSDPkts| (|matrixSDEntry| 4))
(DEFOID |matrixSDOctets| (|matrixSDEntry| 5))
(DEFOID |matrixSDErrors| (|matrixSDEntry| 6))
(DEFOID |matrixDSTable| (|matrix| 3))
(DEFOID |matrixDSEntry| (|matrixDSTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |matrixDSSourceAddress| (|matrixDSEntry| 1))
(DEFOID |matrixDSDestAddress| (|matrixDSEntry| 2))
(DEFOID |matrixDSIndex| (|matrixDSEntry| 3))
(DEFOID |matrixDSPkts| (|matrixDSEntry| 4))
(DEFOID |matrixDSOctets| (|matrixDSEntry| 5))
(DEFOID |matrixDSErrors| (|matrixDSEntry| 6))
(DEFOID |filterTable| (|filter| 1))
(DEFOID |filterEntry| (|filterTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |filterIndex| (|filterEntry| 1))
(DEFOID |filterChannelIndex| (|filterEntry| 2))
(DEFOID |filterPktDataOffset| (|filterEntry| 3))
(DEFOID |filterPktData| (|filterEntry| 4))
(DEFOID |filterPktDataMask| (|filterEntry| 5))
(DEFOID |filterPktDataNotMask| (|filterEntry| 6))
(DEFOID |filterPktStatus| (|filterEntry| 7))
(DEFOID |filterPktStatusMask| (|filterEntry| 8))
(DEFOID |filterPktStatusNotMask| (|filterEntry| 9))
(DEFOID |filterOwner| (|filterEntry| 10))
(DEFOID |filterStatus| (|filterEntry| 11))
(DEFOID |channelTable| (|filter| 2))
(DEFOID |channelEntry| (|channelTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |channelIndex| (|channelEntry| 1))
(DEFOID |channelIfIndex| (|channelEntry| 2))
(DEFOID |channelAcceptType| (|channelEntry| 3))
(DEFOID |channelDataControl| (|channelEntry| 4))
(DEFOID |channelTurnOnEventIndex| (|channelEntry| 5))
(DEFOID |channelTurnOffEventIndex| (|channelEntry| 6))
(DEFOID |channelEventIndex| (|channelEntry| 7))
(DEFOID |channelEventStatus| (|channelEntry| 8))
(DEFOID |channelMatches| (|channelEntry| 9))
(DEFOID |channelDescription| (|channelEntry| 10))
(DEFOID |channelOwner| (|channelEntry| 11))
(DEFOID |channelStatus| (|channelEntry| 12))
(DEFOID |bufferControlTable| (|capture| 1))
(DEFOID |bufferControlEntry| (|bufferControlTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |bufferControlIndex| (|bufferControlEntry| 1))
(DEFOID |bufferControlChannelIndex| (|bufferControlEntry| 2))
(DEFOID |bufferControlFullStatus| (|bufferControlEntry| 3))
(DEFOID |bufferControlFullAction| (|bufferControlEntry| 4))
(DEFOID |bufferControlCaptureSliceSize| (|bufferControlEntry| 5))
(DEFOID |bufferControlDownloadSliceSize| (|bufferControlEntry| 6))
(DEFOID |bufferControlDownloadOffset| (|bufferControlEntry| 7))
(DEFOID |bufferControlMaxOctetsRequested| (|bufferControlEntry| 8))
(DEFOID |bufferControlMaxOctetsGranted| (|bufferControlEntry| 9))
(DEFOID |bufferControlCapturedPackets| (|bufferControlEntry| 10))
(DEFOID |bufferControlTurnOnTime| (|bufferControlEntry| 11))
(DEFOID |bufferControlOwner| (|bufferControlEntry| 12))
(DEFOID |bufferControlStatus| (|bufferControlEntry| 13))
(DEFOID |captureBufferTable| (|capture| 2))
(DEFOID |captureBufferEntry| (|captureBufferTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |captureBufferControlIndex| (|captureBufferEntry| 1))
(DEFOID |captureBufferIndex| (|captureBufferEntry| 2))
(DEFOID |captureBufferPacketID| (|captureBufferEntry| 3))
(DEFOID |captureBufferPacketData| (|captureBufferEntry| 4))
(DEFOID |captureBufferPacketLength| (|captureBufferEntry| 5))
(DEFOID |captureBufferPacketTime| (|captureBufferEntry| 6))
(DEFOID |captureBufferPacketStatus| (|captureBufferEntry| 7))
(DEFOID |eventTable| (|event| 1))
(DEFOID |eventEntry| (|eventTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |eventIndex| (|eventEntry| 1))
(DEFOID |eventDescription| (|eventEntry| 2))
(DEFOID |eventType| (|eventEntry| 3))
(DEFOID |eventCommunity| (|eventEntry| 4))
(DEFOID |eventLastTimeSent| (|eventEntry| 5))
(DEFOID |eventOwner| (|eventEntry| 6))
(DEFOID |eventStatus| (|eventEntry| 7))
(DEFOID |logTable| (|event| 2))
(DEFOID |logEntry| (|logTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |logEventIndex| (|logEntry| 1))
(DEFOID |logIndex| (|logEntry| 2))
(DEFOID |logTime| (|logEntry| 3))
(DEFOID |logDescription| (|logEntry| 4))
(DEFOID |rmonEventsV2| (|rmon| 0))
(DEFOID |risingAlarm| (|rmonEventsV2| 1))
(DEFOID |fallingAlarm| (|rmonEventsV2| 2))
(DEFOID |rmonCompliances| (|rmonConformance| 9))
(DEFOID |rmonGroups| (|rmonConformance| 10))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |rmonEtherStatsGroup| (|rmonGroups| 1))
(DEFOID |rmonHistoryControlGroup| (|rmonGroups| 2))
(DEFOID |rmonEthernetHistoryGroup| (|rmonGroups| 3))
(DEFOID |rmonAlarmGroup| (|rmonGroups| 4))
(DEFOID |rmonHostGroup| (|rmonGroups| 5))
(DEFOID |rmonHostTopNGroup| (|rmonGroups| 6))
(DEFOID |rmonMatrixGroup| (|rmonGroups| 7))
(DEFOID |rmonFilterGroup| (|rmonGroups| 8))
(DEFOID |rmonPacketCaptureGroup| (|rmonGroups| 9))
(DEFOID |rmonEventGroup| (|rmonGroups| 10))
(DEFOID |rmonNotificationGroup| (|rmonGroups| 11))
