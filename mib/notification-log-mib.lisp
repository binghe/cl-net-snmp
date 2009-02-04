;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NOTIFICATION-LOG-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'notification-log-mib))

(defpackage :asn.1/notification-log-mib
  (:nicknames :notification-log-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Unsigned32| |TimeTicks| |Counter32|
                |Counter64| |IpAddress| |Opaque| |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| |TimeStamp| |DateAndTime|
                |StorageType| |RowStatus| |TAddress| |TDomain|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|
                |SnmpEngineID|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group))

(in-package :notification-log-mib)

(defoid |notificationLogMIB| (|mib-2| 92)
  (:type 'module-identity)
  (:description
   "The MIB module for logging SNMP Notifications, that is, Traps


     and Informs."))

(defoid |notificationLogMIBObjects| (|notificationLogMIB| 1)
  (:type 'object-identity))

(defoid |nlmConfig| (|notificationLogMIBObjects| 1)
  (:type 'object-identity))

(defoid |nlmStats| (|notificationLogMIBObjects| 2)
  (:type 'object-identity))

(defoid |nlmLog| (|notificationLogMIBObjects| 3)
  (:type 'object-identity))

(defoid |nlmConfigGlobalEntryLimit| (|nlmConfig| 1)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The maximum number of notification entries that may be held
     in nlmLogTable for all nlmLogNames added together.  A particular
     setting does not guarantee that much data can be held.

     If an application changes the limit while there are
     Notifications in the log, the oldest Notifications MUST be
     discarded to bring the log down to the new limit - thus the
     value of nlmConfigGlobalEntryLimit MUST take precedence over
     the values of nlmConfigGlobalAgeOut and nlmConfigLogEntryLimit,
     even if the Notification being discarded has been present for
     fewer minutes than the value of nlmConfigGlobalAgeOut, or if
     the named log has fewer entries than that specified in
     nlmConfigLogEntryLimit.

     A value of 0 means no limit.

     Please be aware that contention between multiple managers
     trying to set this object to different values MAY affect the
     reliability and completeness of data seen by each manager."))

(defoid |nlmConfigGlobalAgeOut| (|nlmConfig| 2)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The number of minutes a Notification SHOULD be kept in a log
     before it is automatically removed.

     If an application changes the value of nlmConfigGlobalAgeOut,
     Notifications older than the new time MAY be discarded to meet the
     new time.

     A value of 0 means no age out.

     Please be aware that contention between multiple managers
     trying to set this object to different values MAY affect the
     reliability and completeness of data seen by each manager."))

(defoid |nlmConfigLogTable| (|nlmConfig| 3)
  (:type 'object-type)
  (:syntax '(vector |NlmConfigLogEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of logging control entries."))

(defoid |nlmConfigLogEntry| (|nlmConfigLogTable| 1)
  (:type 'object-type)
  (:syntax '|NlmConfigLogEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A logging control entry.  Depending on the entry's storage type
     entries may be supplied by the system or created and deleted by
     applications using nlmConfigLogEntryStatus."))

(defclass |NlmConfigLogEntry| (sequence-type)
  ((|nlmLogName| :type |SnmpAdminString|)
   (|nlmConfigLogFilterName| :type |SnmpAdminString|)
   (|nlmConfigLogEntryLimit| :type |Unsigned32|)
   (|nlmConfigLogAdminStatus| :type integer)
   (|nlmConfigLogOperStatus| :type integer)
   (|nlmConfigLogStorageType| :type |StorageType|)
   (|nlmConfigLogEntryStatus| :type |RowStatus|)))

(defoid |nlmLogName| (|nlmConfigLogEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The name of the log.

     An implementation may allow multiple named logs, up to some
     implementation-specific limit (which may be none).  A
     zero-length log name is reserved for creation and deletion by
     the managed system, and MUST be used as the default log name by
     systems that do not support named logs."))

(defoid |nlmConfigLogFilterName| (|nlmConfigLogEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A value of snmpNotifyFilterProfileName as used as an index
     into the snmpNotifyFilterTable in the SNMP Notification MIB,
     specifying the locally or remotely originated Notifications
     to be filtered out and not logged in this log.

     A zero-length value or a name that does not identify an
     existing entry in snmpNotifyFilterTable indicate no
     Notifications are to be logged in this log."))

(defoid |nlmConfigLogEntryLimit| (|nlmConfigLogEntry| 3)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of notification entries that can be held in
     nlmLogTable for this named log.  A particular setting does not
     guarantee that that much data can be held.

     If an application changes the limit while there are
     Notifications in the log, the oldest Notifications are discarded
     to bring the log down to the new limit.



     A value of 0 indicates no limit.

     Please be aware that contention between multiple managers
     trying to set this object to different values MAY affect the
     reliability and completeness of data seen by each manager."))

(defoid |nlmConfigLogAdminStatus| (|nlmConfigLogEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Control to enable or disable the log without otherwise
     disturbing the log's entry.

     Please be aware that contention between multiple managers
     trying to set this object to different values MAY affect the
     reliability and completeness of data seen by each manager."))

(defoid |nlmConfigLogOperStatus| (|nlmConfigLogEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The operational status of this log:

          disabled  administratively disabled

          operational    administratively enabled and working

          noFilter  administratively enabled but either
                    nlmConfigLogFilterName is zero length
                    or does not name an existing entry in
                    snmpNotifyFilterTable"))

(defoid |nlmConfigLogStorageType| (|nlmConfigLogEntry| 6)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The storage type of this conceptual row."))

(defoid |nlmConfigLogEntryStatus| (|nlmConfigLogEntry| 7)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Control for creating and deleting entries.  Entries may be
     modified while active.

     For non-null-named logs, the managed system records the security
     credentials from the request that sets nlmConfigLogStatus
     to 'active' and uses that identity to apply access control to
     the objects in the Notification to decide if that Notification
     may be logged."))

(defoid |nlmStatsGlobalNotificationsLogged| (|nlmStats| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of Notifications put into the nlmLogTable.  This
     counts a Notification once for each log entry, so a Notification
      put into multiple logs is counted multiple times."))

(defoid |nlmStatsGlobalNotificationsBumped| (|nlmStats| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of log entries discarded to make room for a new entry
     due to lack of resources or the value of nlmConfigGlobalEntryLimit
     or nlmConfigLogEntryLimit.  This does not include entries discarded
     due to the value of nlmConfigGlobalAgeOut."))

(defoid |nlmStatsLogTable| (|nlmStats| 3)
  (:type 'object-type)
  (:syntax '(vector |NlmStatsLogEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of Notification log statistics entries."))

(defoid |nlmStatsLogEntry| (|nlmStatsLogTable| 1)
  (:type 'object-type)
  (:syntax '|NlmStatsLogEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A Notification log statistics entry."))

(defclass |NlmStatsLogEntry| (sequence-type)
  ((|nlmStatsLogNotificationsLogged| :type |Counter32|)
   (|nlmStatsLogNotificationsBumped| :type |Counter32|)))

(defoid |nlmStatsLogNotificationsLogged| (|nlmStatsLogEntry| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The number of Notifications put in this named log."))

(defoid |nlmStatsLogNotificationsBumped| (|nlmStatsLogEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of log entries discarded from this named log to make
     room for a new entry due to lack of resources or the value of
     nlmConfigGlobalEntryLimit or nlmConfigLogEntryLimit.  This does not
     include entries discarded due to the value of
     nlmConfigGlobalAgeOut."))

(defoid |nlmLogTable| (|nlmLog| 1)
  (:type 'object-type)
  (:syntax '(vector |NlmLogEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of Notification log entries.

     It is an implementation-specific matter whether entries in this
     table are preserved across initializations of the management
     system.  In general one would expect that they are not.

     Note that keeping entries across initializations of the
     management system leads to some confusion with counters and
     TimeStamps, since both of those are based on sysUpTime, which
     resets on management initialization.  In this situation,
     counters apply only after the reset and nlmLogTime for entries
     made before the reset MUST be set to 0."))

(defoid |nlmLogEntry| (|nlmLogTable| 1)
  (:type 'object-type)
  (:syntax '|NlmLogEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A Notification log entry.

     Entries appear in this table when Notifications occur and pass
     filtering by nlmConfigLogFilterName and access control.  They are
     removed to make way for new entries due to lack of resources or
     the values of nlmConfigGlobalEntryLimit, nlmConfigGlobalAgeOut, or
     nlmConfigLogEntryLimit.

     If adding an entry would exceed nlmConfigGlobalEntryLimit or system
     resources in general, the oldest entry in any log SHOULD be removed
     to make room for the new one.

     If adding an entry would exceed nlmConfigLogEntryLimit the oldest
     entry in that log SHOULD be removed to make room for the new one.

     Before the managed system puts a locally-generated Notification
     into a non-null-named log it assures that the creator of the log
     has access to the information in the Notification.  If not it
     does not log that Notification in that log."))

(defclass |NlmLogEntry| (sequence-type)
  ((|nlmLogIndex| :type |Unsigned32|)
   (|nlmLogTime| :type |TimeStamp|)
   (|nlmLogDateAndTime| :type |DateAndTime|)
   (|nlmLogEngineID| :type |SnmpEngineID|)
   (|nlmLogEngineTAddress| :type |TAddress|)
   (|nlmLogEngineTDomain| :type |TDomain|)
   (|nlmLogContextEngineID| :type |SnmpEngineID|)
   (|nlmLogContextName| :type |SnmpAdminString|)
   (|nlmLogNotificationID| :type object-id)))

(defoid |nlmLogIndex| (|nlmLogEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A monotonically increasing integer for the sole purpose of
     indexing entries within the named log.  When it reaches the
     maximum value, an extremely unlikely event, the agent wraps the
     value back to 1."))

(defoid |nlmLogTime| (|nlmLogEntry| 2)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the entry was placed in the log. If
     the entry occurred before the most recent management system
     initialization this object value MUST be set to zero."))

(defoid |nlmLogDateAndTime| (|nlmLogEntry| 3)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The local date and time when the entry was logged, instantiated
     only by systems that have date and time capability."))

(defoid |nlmLogEngineID| (|nlmLogEntry| 4)
  (:type 'object-type)
  (:syntax '|SnmpEngineID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The identification of the SNMP engine at which the Notification


     originated.

     If the log can contain Notifications from only one engine
     or the Trap is in SNMPv1 format, this object is a zero-length
     string."))

(defoid |nlmLogEngineTAddress| (|nlmLogEntry| 5)
  (:type 'object-type)
  (:syntax '|TAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The transport service address of the SNMP engine from which the
     Notification was received, formatted according to the corresponding
     value of nlmLogEngineTDomain. This is used to identify the source
     of an SNMPv1 trap, since an nlmLogEngineId cannot be extracted
     from the SNMPv1 trap pdu.

     This object MUST always be instantiated, even if the log
     can contain Notifications from only one engine.

     Please be aware that the nlmLogEngineTAddress may not uniquely
     identify the SNMP engine from which the Notification was received.
     For example, if an SNMP engine uses DHCP or NAT to obtain
     ip addresses, the address it uses may be shared with other
     network devices, and hence will not uniquely identify the
     SNMP engine."))

(defoid |nlmLogEngineTDomain| (|nlmLogEntry| 6)
  (:type 'object-type)
  (:syntax '|TDomain|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Indicates the kind of transport service by which a Notification
     was received from an SNMP engine. nlmLogEngineTAddress contains
     the transport service address of the SNMP engine from which
     this Notification was received.

     Possible values for this object are presently found in the
     Transport Mappings for SNMPv2 document (RFC 1906 [8])."))

(defoid |nlmLogContextEngineID| (|nlmLogEntry| 7)
  (:type 'object-type)
  (:syntax '|SnmpEngineID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "If the Notification was received in a protocol which has a
      contextEngineID element like SNMPv3, this object has that value.
      Otherwise its value is a zero-length string."))

(defoid |nlmLogContextName| (|nlmLogEntry| 8)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The name of the SNMP MIB context from which the Notification came.
     For SNMPv1 Traps this is the community string from the Trap."))

(defoid |nlmLogNotificationID| (|nlmLogEntry| 9)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The NOTIFICATION-TYPE object identifier of the Notification that
     occurred."))

(defoid |nlmLogVariableTable| (|nlmLog| 2)
  (:type 'object-type)
  (:syntax '(vector |NlmLogVariableEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of variables to go with Notification log entries."))

(defoid |nlmLogVariableEntry| (|nlmLogVariableTable| 1)
  (:type 'object-type)
  (:syntax '|NlmLogVariableEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A Notification log entry variable.

     Entries appear in this table when there are variables in
     the varbind list of a Notification in nlmLogTable."))

(defclass |NlmLogVariableEntry| (sequence-type)
  ((|nlmLogVariableIndex| :type |Unsigned32|)
   (|nlmLogVariableID| :type object-id)
   (|nlmLogVariableValueType| :type integer)
   (|nlmLogVariableCounter32Val| :type |Counter32|)
   (|nlmLogVariableUnsigned32Val| :type |Unsigned32|)
   (|nlmLogVariableTimeTicksVal| :type |TimeTicks|)
   (|nlmLogVariableInteger32Val| :type |Integer32|)
   (|nlmLogVariableOctetStringVal| :type octet-string)
   (|nlmLogVariableIpAddressVal| :type |IpAddress|)
   (|nlmLogVariableOidVal| :type object-id)
   (|nlmLogVariableCounter64Val| :type |Counter64|)
   (|nlmLogVariableOpaqueVal| :type |Opaque|)))

(defoid |nlmLogVariableIndex| (|nlmLogVariableEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A monotonically increasing integer, starting at 1 for a given
     nlmLogIndex, for indexing variables within the logged
     Notification."))

(defoid |nlmLogVariableID| (|nlmLogVariableEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The variable's object identifier."))

(defoid |nlmLogVariableValueType| (|nlmLogVariableEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type of the value.  One and only one of the value
     objects that follow must be instantiated, based on this type."))

(defoid |nlmLogVariableCounter32Val| (|nlmLogVariableEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'counter32'."))

(defoid |nlmLogVariableUnsigned32Val| (|nlmLogVariableEntry| 5)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'unsigned32'."))

(defoid |nlmLogVariableTimeTicksVal| (|nlmLogVariableEntry| 6)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'timeTicks'."))

(defoid |nlmLogVariableInteger32Val| (|nlmLogVariableEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'integer32'."))

(defoid |nlmLogVariableOctetStringVal| (|nlmLogVariableEntry| 8)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'octetString'."))

(defoid |nlmLogVariableIpAddressVal| (|nlmLogVariableEntry| 9)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value when nlmLogVariableType is 'ipAddress'.
     Although this seems to be unfriendly for IPv6, we
     have to recognize that there are a number of older
     MIBs that do contain an IPv4 format address, known
     as IpAddress.

     IPv6 addresses are represented using TAddress or
     InetAddress, and so the underlying datatype is


     OCTET STRING, and their value would be stored in
     the nlmLogVariableOctetStringVal column."))

(defoid |nlmLogVariableOidVal| (|nlmLogVariableEntry| 10)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'objectId'."))

(defoid |nlmLogVariableCounter64Val| (|nlmLogVariableEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'counter64'."))

(defoid |nlmLogVariableOpaqueVal| (|nlmLogVariableEntry| 12)
  (:type 'object-type)
  (:syntax '|Opaque|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value when nlmLogVariableType is 'opaque'."))

(defoid |notificationLogMIBConformance| (|notificationLogMIB| 3)
  (:type 'object-identity))

(defoid |notificationLogMIBCompliances|
        (|notificationLogMIBConformance| 1)
  (:type 'object-identity))

(defoid |notificationLogMIBGroups| (|notificationLogMIBConformance| 2)
  (:type 'object-identity))

(defoid |notificationLogMIBCompliance|
        (|notificationLogMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement
          the Notification Log MIB."))

(defoid |notificationLogConfigGroup| (|notificationLogMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "Notification log configuration management."))

(defoid |notificationLogStatsGroup| (|notificationLogMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description "Notification log statistics."))

(defoid |notificationLogLogGroup| (|notificationLogMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description "Notification log data."))

(defoid |notificationLogDateGroup| (|notificationLogMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Conditionally mandatory notification log data.
          This group is mandatory on systems that keep wall
          clock date and time and should not be implemented
          on systems that do not have a wall clock date."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'notification-log-mib *mib-modules*)
  (setf *current-module* nil))

