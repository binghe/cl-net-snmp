;;;; Auto-generated from ASN-SNMP:NET-SNMP-AGENT-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'NET-SNMP-AGENT-MIB)
(DEFOID |netSnmpAgentMIB| (|netSnmpModuleIDs| 2))
(DEFOID |nsVersion| (|netSnmpObjects| 1))
(DEFOID |nsMibRegistry| (|netSnmpObjects| 2))
(DEFOID |nsExtensions| (|netSnmpObjects| 3))
(DEFOID |nsDLMod| (|netSnmpObjects| 4))
(DEFOID |nsCache| (|netSnmpObjects| 5))
(DEFOID |nsErrorHistory| (|netSnmpObjects| 6))
(DEFOID |nsConfiguration| (|netSnmpObjects| 7))
(DEFOID |nsTransactions| (|netSnmpObjects| 8))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsCacheDefaultTimeout| (|nsCache| 1))
(DEFOID |nsCacheEnabled| (|nsCache| 2))
(DEFOID |nsCacheTable| (|nsCache| 3))
(DEFOID |nsCacheEntry| (|nsCacheTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsCachedOID| (|nsCacheEntry| 1))
(DEFOID |nsCacheTimeout| (|nsCacheEntry| 2))
(DEFOID |nsCacheStatus| (|nsCacheEntry| 3))
(DEFOID |nsConfigDebug| (|nsConfiguration| 1))
(DEFOID |nsConfigLogging| (|nsConfiguration| 2))
(DEFOID |nsDebugEnabled| (|nsConfigDebug| 1))
(DEFOID |nsDebugOutputAll| (|nsConfigDebug| 2))
(DEFOID |nsDebugDumpPdu| (|nsConfigDebug| 3))
(DEFOID |nsDebugTokenTable| (|nsConfigDebug| 4))
(DEFOID |nsDebugTokenEntry| (|nsDebugTokenTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsDebugTokenPrefix| (|nsDebugTokenEntry| 2))
(DEFOID |nsDebugTokenStatus| (|nsDebugTokenEntry| 4))
(DEFOID |nsLoggingTable| (|nsConfigLogging| 1))
(DEFOID |nsLoggingEntry| (|nsLoggingTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsLogLevel| (|nsLoggingEntry| 1))
(DEFOID |nsLogToken| (|nsLoggingEntry| 2))
(DEFOID |nsLogType| (|nsLoggingEntry| 3))
(DEFOID |nsLogMaxLevel| (|nsLoggingEntry| 4))
(DEFOID |nsLogStatus| (|nsLoggingEntry| 5))
(DEFOID |nsTransactionTable| (|nsTransactions| 1))
(DEFOID |nsTransactionEntry| (|nsTransactionTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsTransactionID| (|nsTransactionEntry| 1))
(DEFOID |nsTransactionMode| (|nsTransactionEntry| 2))
(DEFOID |nsModuleTable| (|nsMibRegistry| 1))
(DEFOID |nsModuleEntry| (|nsModuleTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsmContextName| (|nsModuleEntry| 1))
(DEFOID |nsmRegistrationPoint| (|nsModuleEntry| 2))
(DEFOID |nsmRegistrationPriority| (|nsModuleEntry| 3))
(DEFOID |nsModuleName| (|nsModuleEntry| 4))
(DEFOID |nsModuleModes| (|nsModuleEntry| 5))
(DEFOID |nsModuleTimeout| (|nsModuleEntry| 6))
(DEFOID |nsNotifyStart| (|netSnmpNotifications| 1))
(DEFOID |nsNotifyShutdown| (|netSnmpNotifications| 2))
(DEFOID |nsNotifyRestart| (|netSnmpNotifications| 3))
(DEFOID |nsModuleGroup| (|netSnmpGroups| 2))
(DEFOID |nsCacheGroup| (|netSnmpGroups| 4))
(DEFOID |nsConfigGroups| (|netSnmpGroups| 7))
(DEFOID |nsDebugGroup| (|nsConfigGroups| 1))
(DEFOID |nsLoggingGroup| (|nsConfigGroups| 2))
(DEFOID |nsTransactionGroup| (|netSnmpGroups| 8))
(DEFOID |nsAgentNotifyGroup| (|netSnmpGroups| 9))
