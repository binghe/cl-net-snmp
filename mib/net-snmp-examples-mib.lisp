;;;; Auto-generated from ASN-SNMP:NET-SNMP-EXAMPLES-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'NET-SNMP-EXAMPLES-MIB)
(DEFOID |netSnmpExamples| (|netSnmp| 2))
(DEFOID |netSnmpExampleScalars| (|netSnmpExamples| 1))
(DEFOID |netSnmpExampleTables| (|netSnmpExamples| 2))
(DEFOID |netSnmpExampleNotifications| (|netSnmpExamples| 3))
(DEFOID |netSnmpExampleNotificationPrefix|
        (|netSnmpExampleNotifications| 0))
(DEFOID |netSnmpExampleNotificationObjects|
        (|netSnmpExampleNotifications| 2))
(DEFOID |netSnmpExampleInteger| (|netSnmpExampleScalars| 1))
(DEFOID |netSnmpExampleSleeper| (|netSnmpExampleScalars| 2))
(DEFOID |netSnmpExampleString| (|netSnmpExampleScalars| 3))
(DEFOID |netSnmpIETFWGTable| (|netSnmpExampleTables| 1))
(DEFOID |netSnmpIETFWGEntry| (|netSnmpIETFWGTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsIETFWGName| (|netSnmpIETFWGEntry| 1))
(DEFOID |nsIETFWGChair1| (|netSnmpIETFWGEntry| 2))
(DEFOID |nsIETFWGChair2| (|netSnmpIETFWGEntry| 3))
(DEFOID |netSnmpHostsTable| (|netSnmpExampleTables| 2))
(DEFOID |netSnmpHostsEntry| (|netSnmpHostsTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |netSnmpHostName| (|netSnmpHostsEntry| 1))
(DEFOID |netSnmpHostAddressType| (|netSnmpHostsEntry| 2))
(DEFOID |netSnmpHostAddress| (|netSnmpHostsEntry| 3))
(DEFOID |netSnmpHostStorage| (|netSnmpHostsEntry| 4))
(DEFOID |netSnmpHostRowStatus| (|netSnmpHostsEntry| 5))
(DEFOID |netSnmpExampleHeartbeatRate|
        (|netSnmpExampleNotificationObjects| 1))
(DEFOID |netSnmpExampleHeartbeatName|
        (|netSnmpExampleNotificationObjects| 2))
(DEFOID |netSnmpExampleHeartbeatNotification|
        (|netSnmpExampleNotificationPrefix| 1))
(DEFOID |netSnmpExampleNotification| (|netSnmpExampleNotifications| 1))
