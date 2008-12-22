;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-AGENT-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-agent-mib *mib-modules*))
(setf *current-module* 'net-snmp-agent-mib)
(defpackage :asn.1/net-snmp-agent-mib
  (:use :cl :asn.1)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :asn.1/net-snmp-mib |netSnmpObjects| |netSnmpModuleIDs|
                |netSnmpNotifications| |netSnmpGroups|)
  (:import-from :|ASN.1/SNMPv2-SMI| object-type notification-type
                module-identity |Integer32| |Unsigned32|)
  (:import-from :|ASN.1/SNMPv2-CONF| object-group notification-group)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |DisplayString|
                |RowStatus| |TruthValue|))
(in-package :asn.1/net-snmp-agent-mib)
(defoid |netSnmpAgentMIB| (|netSnmpModuleIDs| 2)
  (:type 'module-identity)
  (:description
   "Defines control and monitoring structures for the Net-SNMP agent."))
(defoid |nsVersion| (|netSnmpObjects| 1) (:type 'object-identity))
(defoid |nsMibRegistry| (|netSnmpObjects| 2) (:type 'object-identity))
(defoid |nsExtensions| (|netSnmpObjects| 3) (:type 'object-identity))
(defoid |nsDLMod| (|netSnmpObjects| 4) (:type 'object-identity))
(defoid |nsCache| (|netSnmpObjects| 5) (:type 'object-identity))
(defoid |nsErrorHistory| (|netSnmpObjects| 6) (:type 'object-identity))
(defoid |nsConfiguration| (|netSnmpObjects| 7) (:type 'object-identity))
(defoid |nsTransactions| (|netSnmpObjects| 8) (:type 'object-identity))
(deftype |NetsnmpCacheStatus| () 't)
(defoid |nsCacheDefaultTimeout| (|nsCache| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Default cache timeout value (unless overridden
       for a particular cache entry)."))
(defoid |nsCacheEnabled| (|nsCache| 2)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "Whether data caching is active overall."))
(defoid |nsCacheTable| (|nsCache| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of individual MIB module data caches."))
(defoid |nsCacheEntry| (|nsCacheTable| 1)
  (:type 'object-type)
  (:syntax '|NsCacheEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row within the cache table."))
(deftype |NsCacheEntry| () 't)
(defoid |nsCachedOID| (|nsCacheEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The root OID of the data being cached."))
(defoid |nsCacheTimeout| (|nsCacheEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The length of time (?in seconds) for which the data in
       this particular cache entry will remain valid."))
(defoid |nsCacheStatus| (|nsCacheEntry| 3)
  (:type 'object-type)
  (:syntax '|NetsnmpCacheStatus|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The current status of this particular cache entry.
       Acceptable values for Set requests are 'enabled(1)',
       'disabled(2)' or 'empty(3)' (to clear all cached data).
       Requests to read the value of such an object will
       return 'disabled(2)' through to 'expired(5)'."))
(defoid |nsConfigDebug| (|nsConfiguration| 1) (:type 'object-identity))
(defoid |nsConfigLogging| (|nsConfiguration| 2)
  (:type 'object-identity))
(defoid |nsDebugEnabled| (|nsConfigDebug| 1)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Whether the agent is configured to generate debugging output"))
(defoid |nsDebugOutputAll| (|nsConfigDebug| 2)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Whether the agent is configured to display all debugging output
       rather than filtering on individual debug tokens.  Nothing will
       be generated unless nsDebugEnabled is also true(1)"))
(defoid |nsDebugDumpPdu| (|nsConfigDebug| 3)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Whether the agent is configured to display raw packet dumps.
       This is unrelated to the nsDebugEnabled setting."))
(defoid |nsDebugTokenTable| (|nsConfigDebug| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of individual debug tokens, used to control the selection
       of what debugging output should be produced.  This table is only
       effective if nsDebugOutputAll is false(2), and nothing will
       be generated unless nsDebugEnabled is also true(1)"))
(defoid |nsDebugTokenEntry| (|nsDebugTokenTable| 1)
  (:type 'object-type)
  (:syntax '|NsDebugTokenEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row within the debug token table."))
(deftype |NsDebugTokenEntry| () 't)
(defoid |nsDebugTokenPrefix| (|nsDebugTokenEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A token prefix for which to generate the corresponding
       debugging output.  Note that debug output will be generated
       for all registered debug statements sharing this prefix
       (rather than an exact match).  Nothing will be generated
       unless both nsDebuggingEnabled is set true(1) and the
       corresponding nsDebugTokenStatus value is active(1)."))
(defoid |nsDebugTokenStatus| (|nsDebugTokenEntry| 4)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Whether to generate debug output for the corresponding debug
       token prefix.  Nothing will be generated unless both
       nsDebuggingEnabled is true(1) and this instance is active(1).
       Note that is valid for an instance to be left with the value
       notInService(2) indefinitely - i.e. the meaning of 'abnormally
       long' (see RFC 2579, RowStatus) for this table is infinite."))
(defoid |nsLoggingTable| (|nsConfigLogging| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of individual logging output destinations, used to control
       where various levels of output from the agent should be directed."))
(defoid |nsLoggingEntry| (|nsLoggingTable| 1)
  (:type 'object-type)
  (:syntax '|NsLoggingEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row within the logging table."))
(deftype |NsLoggingEntry| () 't)
(defoid |nsLogLevel| (|nsLoggingEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (minimum) priority level for which this logging entry
       should be applied."))
(defoid |nsLogToken| (|nsLoggingEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A token for which to generate logging entries.
       Depending on the style of logging, this may either
       be simply an arbitrary token, or may have some
       particular meaning (such as the filename to log to)."))
(defoid |nsLogType| (|nsLoggingEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The type of logging for this entry."))
(defoid |nsLogMaxLevel| (|nsLoggingEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum priority level for which this logging entry
       should be applied."))
(defoid |nsLogStatus| (|nsLoggingEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Whether to generate logging output for this entry.
       Note that is valid for an instance to be left with the value
       notInService(2) indefinitely - i.e. the meaning of 'abnormally
       long' (see RFC 2579, RowStatus) for this table is infinite."))
(defoid |nsTransactionTable| (|nsTransactions| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Lists currently outstanding transactions in the net-snmp agent.
	 This includes requests to AgentX subagents, or proxied SNMP agents."))
(defoid |nsTransactionEntry| (|nsTransactionTable| 1)
  (:type 'object-type)
  (:syntax '|NsTransactionEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A row describing a given transaction."))
(deftype |NsTransactionEntry| () 't)
(defoid |nsTransactionID| (|nsTransactionEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The internal identifier for a given transaction."))
(defoid |nsTransactionMode| (|nsTransactionEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The mode number for the current operation being performed."))
(defoid |nsModuleTable| (|nsMibRegistry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table displaying all the oid's registered by mib modules in
	 the agent.  Since the agent is modular in nature, this lists
	 each module's OID it is responsible for and the name of the module"))
(defoid |nsModuleEntry| (|nsModuleTable| 1)
  (:type 'object-type)
  (:syntax '|NsModuleEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a registered mib oid."))
(deftype |NsModuleEntry| () 't)
(defoid |nsmContextName| (|nsModuleEntry| 1)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The context name the module is registered under."))
(defoid |nsmRegistrationPoint| (|nsModuleEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The registry OID of a mib module."))
(defoid |nsmRegistrationPriority| (|nsModuleEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The priority of the registered mib module."))
(defoid |nsModuleName| (|nsModuleEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The module name that registered this OID."))
(defoid |nsModuleModes| (|nsModuleEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The modes that the particular lower level handler can cope
  	 with directly."))
(defoid |nsModuleTimeout| (|nsModuleEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The registered timeout.  This is only meaningful for handlers
	 that expect to return results at a later date (subagents,
	 etc)"))
(defoid |nsNotifyStart| (|netSnmpNotifications| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description "An indication that the agent has started running."))
(defoid |nsNotifyShutdown| (|netSnmpNotifications| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An indication that the agent is in the process of being shut down."))
(defoid |nsNotifyRestart| (|netSnmpNotifications| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An indication that the agent has been restarted.
	 This does not imply anything about whether the configuration has
	 changed or not (unlike the standard coldStart or warmStart traps)"))
(defoid |nsModuleGroup| (|netSnmpGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The objects relating to the list of MIB modules registered
	 with the Net-SNMP agent."))
(defoid |nsCacheGroup| (|netSnmpGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The objects relating to data caching in the Net-SNMP agent."))
(defoid |nsConfigGroups| (|netSnmpGroups| 7) (:type 'object-identity))
(defoid |nsDebugGroup| (|nsConfigGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The objects relating to debug configuration in the Net-SNMP agent."))
(defoid |nsLoggingGroup| (|nsConfigGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The objects relating to logging configuration in the Net-SNMP agent."))
(defoid |nsTransactionGroup| (|netSnmpGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The objects relating to transaction monitoring in the Net-SNMP agent."))
(defoid |nsAgentNotifyGroup| (|netSnmpGroups| 9)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "The notifications relating to the basic operation of the Net-SNMP agent."))
