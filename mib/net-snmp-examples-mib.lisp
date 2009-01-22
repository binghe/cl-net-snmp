;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-EXAMPLES-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'net-snmp-examples-mib))

(defpackage :asn.1/net-snmp-examples-mib
  (:nicknames :net-snmp-examples-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| notification-type)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :asn.1/net-snmp-mib |netSnmp|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus| |StorageType|)
  (:import-from :asn.1/inet-address-mib |InetAddressType|
                |InetAddress|))

(in-package :net-snmp-examples-mib)

(defoid |netSnmpExamples| (|netSnmp| 2)
  (:type 'module-identity)
  (:description
   "Example MIB objects for agent module example implementations"))

(defoid |netSnmpExampleScalars| (|netSnmpExamples| 1)
  (:type 'object-identity))

(defoid |netSnmpExampleTables| (|netSnmpExamples| 2)
  (:type 'object-identity))

(defoid |netSnmpExampleNotifications| (|netSnmpExamples| 3)
  (:type 'object-identity))

(defoid |netSnmpExampleNotificationPrefix|
        (|netSnmpExampleNotifications| 0)
  (:type 'object-identity))

(defoid |netSnmpExampleNotificationObjects|
        (|netSnmpExampleNotifications| 2)
  (:type 'object-identity))

(defoid |netSnmpExampleInteger| (|netSnmpExampleScalars| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This is a simple object which merely houses a writable
	 integer.  It's only purposes is to hold the value of a single
	 integer.  Writing to it will simply change the value for
	 subsequent GET/GETNEXT/GETBULK retrievals.

	 This example object is implemented in the
	 agent/mibgroup/examples/scalar_int.c file."))

(defoid |netSnmpExampleSleeper| (|netSnmpExampleScalars| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This is a simple object which is a basic integer.  It's value
	 indicates the number of seconds that the agent will take in
	 responding to requests of this object.  This is implemented
	 in a way which will allow the agent to keep responding to
	 other requests while access to this object is blocked.  It is
	 writable, and changing it's value will change the amount of
	 time the agent will effectively wait for before returning a
	 response when this object is manipulated.  Note that SET
	 requests through this object will take longer, since the
	 delay is applied to each internal transaction phase, which
	 could result in delays of up to 4 times the value of this
	 object.

	 This example object is implemented in the
	 agent/mibgroup/examples/delayed_instance.c file."))

(defoid |netSnmpExampleString| (|netSnmpExampleScalars| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This is a simple object which merely houses a writable
	 string.  It's only purposes is to hold the value of a single
	 string.  Writing to it will simply change the value for
	 subsequent GET/GETNEXT/GETBULK retrievals.

	 This example object is implemented in the
	 agent/mibgroup/examples/watched.c file."))

(defoid |netSnmpIETFWGTable| (|netSnmpExampleTables| 1)
  (:type 'object-type)
  (:syntax '(vector |NetSnmpIETFWGEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table merely contains a set of data which is otherwise
	 useless for true network management.  It is a table which
	 describes properies about a IETF Working Group, such as the
	 names of the two working group chairs.

	 This example table is implemented in the
	 agent/mibgroup/examples/data_set.c file."))

(defoid |netSnmpIETFWGEntry| (|netSnmpIETFWGTable| 1)
  (:type 'object-type)
  (:syntax '|NetSnmpIETFWGEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A row describing a given working group"))

(defclass |NetSnmpIETFWGEntry| (sequence-type)
  ((|nsIETFWGName| :type t)
   (|nsIETFWGChair1| :type t)
   (|nsIETFWGChair2| :type t)))

(defoid |nsIETFWGName| (|netSnmpIETFWGEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The name of the IETF Working Group this table describes."))

(defoid |nsIETFWGChair1| (|netSnmpIETFWGEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "One of the names of the chairs for the IETF working group."))

(defoid |nsIETFWGChair2| (|netSnmpIETFWGEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The other name, if one exists, of the chairs for the IETF
	working group."))

(defoid |netSnmpHostsTable| (|netSnmpExampleTables| 2)
  (:type 'object-type)
  (:syntax '(vector |NetSnmpHostsEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An example table that implements a wrapper around the
	/etc/hosts file on a machine using the iterator helper API."))

(defoid |netSnmpHostsEntry| (|netSnmpHostsTable| 1)
  (:type 'object-type)
  (:syntax '|NetSnmpHostsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A host name mapped to an ip address"))

(defclass |NetSnmpHostsEntry| (sequence-type)
  ((|netSnmpHostName| :type t)
   (|netSnmpHostAddressType| :type |InetAddressType|)
   (|netSnmpHostAddress| :type |InetAddress|)
   (|netSnmpHostStorage| :type |StorageType|)
   (|netSnmpHostRowStatus| :type |RowStatus|)))

(defoid |netSnmpHostName| (|netSnmpHostsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A host name that exists in the /etc/hosts (unix) file."))

(defoid |netSnmpHostAddressType| (|netSnmpHostsEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The address type of then given host."))

(defoid |netSnmpHostAddress| (|netSnmpHostsEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The address of then given host."))

(defoid |netSnmpHostStorage| (|netSnmpHostsEntry| 4)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The storage type for this conceptual row."))

(defoid |netSnmpHostRowStatus| (|netSnmpHostsEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The status of this conceptual row."))

(defoid |netSnmpExampleHeartbeatRate|
        (|netSnmpExampleNotificationObjects| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "A simple integer object, to act as a payload for the
         netSnmpExampleHeartbeatNotification.  The value has
         no real meaning, but is nominally the interval (in
         seconds) between successive heartbeat notifications."))

(defoid |netSnmpExampleHeartbeatName|
        (|netSnmpExampleNotificationObjects| 2)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "A simple string object, to act as an optional payload
         for the netSnmpExampleHeartbeatNotification.  This varbind
         is not part of the notification definition, so is optional
         and need not be included in the notification payload. 
         The value has no real meaning, but the romantically inclined
         may take it to be the object of the sender's affection,
         and hence the cause of the heart beating faster."))

(defoid |netSnmpExampleHeartbeatNotification|
        (|netSnmpExampleNotificationPrefix| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An example notification, used to illustrate the
         definition and generation of trap and inform PDUs
         (including the use of both standard and additional
         varbinds in the notification payload).
         This notification will typically be sent every
	 30 seconds, using the code found in the example module
             agent/mibgroup/examples/notification.c"))

(defoid |netSnmpExampleNotification| (|netSnmpExampleNotifications| 1)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|obsolete|)
  (:description
   "This object was improperly defined for its original purpose,
         and should no longer be used."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-examples-mib *mib-modules*)
  (setf *current-module* nil))

