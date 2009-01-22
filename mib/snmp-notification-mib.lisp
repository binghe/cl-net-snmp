;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-NOTIFICATION-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'snmp-notification-mib))

(defpackage :asn.1/snmp-notification-mib
  (:nicknames :snmp-notification-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |snmpModules|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus| |StorageType|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :asn.1/snmp-target-mib |SnmpTagValue|
                |snmpTargetParamsName|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group))

(in-package :snmp-notification-mib)

(defoid |snmpNotificationMIB| (|snmpModules| 13)
  (:type 'module-identity)
  (:description
   "This MIB module defines MIB objects which provide
         mechanisms to remotely configure the parameters
         used by an SNMP entity for the generation of
         notifications.

         Copyright (C) The Internet Society (2002). This
         version of this MIB module is part of RFC 3413;
         see the RFC itself for full legal notices.
        "))

(defoid |snmpNotifyObjects| (|snmpNotificationMIB| 1)
  (:type 'object-identity))

(defoid |snmpNotifyConformance| (|snmpNotificationMIB| 3)
  (:type 'object-identity))

(defoid |snmpNotifyTable| (|snmpNotifyObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is used to select management targets which should
         receive notifications, as well as the type of notification
         which should be sent to each selected management target."))

(defoid |snmpNotifyEntry| (|snmpNotifyTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpNotifyEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in this table selects a set of management targets
         which should receive notifications, as well as the type of

         notification which should be sent to each selected
         management target.

         Entries in the snmpNotifyTable are created and
         deleted using the snmpNotifyRowStatus object."))

(defclass |SnmpNotifyEntry| (sequence-type)
  ((|snmpNotifyName| :type |SnmpAdminString|)
   (|snmpNotifyTag| :type |SnmpTagValue|)
   (|snmpNotifyType| :type integer)
   (|snmpNotifyStorageType| :type |StorageType|)
   (|snmpNotifyRowStatus| :type |RowStatus|)))

(defoid |snmpNotifyName| (|snmpNotifyEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this snmpNotifyEntry."))

(defoid |snmpNotifyTag| (|snmpNotifyEntry| 2)
  (:type 'object-type)
  (:syntax '|SnmpTagValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object contains a single tag value which is used
         to select entries in the snmpTargetAddrTable.  Any entry
         in the snmpTargetAddrTable which contains a tag value
         which is equal to the value of an instance of this
         object is selected.  If this object contains a value
         of zero length, no entries are selected."))

(defoid |snmpNotifyType| (|snmpNotifyEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object determines the type of notification to

         be generated for entries in the snmpTargetAddrTable
         selected by the corresponding instance of
         snmpNotifyTag.  This value is only used when
         generating notifications, and is ignored when
         using the snmpTargetAddrTable for other purposes.

         If the value of this object is trap(1), then any
         messages generated for selected rows will contain
         Unconfirmed-Class PDUs.

         If the value of this object is inform(2), then any
         messages generated for selected rows will contain
         Confirmed-Class PDUs.

         Note that if an SNMP entity only supports
         generation of Unconfirmed-Class PDUs (and not
         Confirmed-Class PDUs), then this object may be
         read-only."))

(defoid |snmpNotifyStorageType| (|snmpNotifyEntry| 4)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
         Conceptual rows having the value 'permanent' need not
         allow write-access to any columnar objects in the row."))

(defoid |snmpNotifyRowStatus| (|snmpNotifyEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

         To create a row in this table, a manager must
         set this object to either createAndGo(4) or
         createAndWait(5)."))

(defoid |snmpNotifyFilterProfileTable| (|snmpNotifyObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is used to associate a notification filter
         profile with a particular set of target parameters."))

(defoid |snmpNotifyFilterProfileEntry|
        (|snmpNotifyFilterProfileTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpNotifyFilterProfileEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in this table indicates the name of the filter
         profile to be used when generating notifications using
         the corresponding entry in the snmpTargetParamsTable.

         Entries in the snmpNotifyFilterProfileTable are created
         and deleted using the snmpNotifyFilterProfileRowStatus
         object."))

(defclass |SnmpNotifyFilterProfileEntry| (sequence-type)
  ((|snmpNotifyFilterProfileName| :type |SnmpAdminString|)
   (|snmpNotifyFilterProfileStorType| :type |StorageType|)
   (|snmpNotifyFilterProfileRowStatus| :type |RowStatus|)))

(defoid |snmpNotifyFilterProfileName|
        (|snmpNotifyFilterProfileEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The name of the filter profile to be used when generating
         notifications using the corresponding entry in the
         snmpTargetAddrTable."))

(defoid |snmpNotifyFilterProfileStorType|
        (|snmpNotifyFilterProfileEntry| 2)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
         Conceptual rows having the value 'permanent' need not
         allow write-access to any columnar objects in the row."))

(defoid |snmpNotifyFilterProfileRowStatus|
        (|snmpNotifyFilterProfileEntry| 3)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

         To create a row in this table, a manager must
         set this object to either createAndGo(4) or
         createAndWait(5).

         Until instances of all corresponding columns are
         appropriately configured, the value of the
         corresponding instance of the
         snmpNotifyFilterProfileRowStatus column is 'notReady'.

         In particular, a newly created row cannot be made
         active until the corresponding instance of
         snmpNotifyFilterProfileName has been set."))

(defoid |snmpNotifyFilterTable| (|snmpNotifyObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of filter profiles.  Filter profiles are used
         to determine whether particular management targets should
         receive particular notifications.

         When a notification is generated, it must be compared
         with the filters associated with each management target
         which is configured to receive notifications, in order to
         determine whether it may be sent to each such management
         target.

         A more complete discussion of notification filtering
         can be found in section 6. of [SNMP-APPL]."))

(defoid |snmpNotifyFilterEntry| (|snmpNotifyFilterTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpNotifyFilterEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An element of a filter profile.

         Entries in the snmpNotifyFilterTable are created and
         deleted using the snmpNotifyFilterRowStatus object."))

(defclass |SnmpNotifyFilterEntry| (sequence-type)
  ((|snmpNotifyFilterSubtree| :type object-id)
   (|snmpNotifyFilterMask| :type t)
   (|snmpNotifyFilterType| :type integer)
   (|snmpNotifyFilterStorageType| :type |StorageType|)
   (|snmpNotifyFilterRowStatus| :type |RowStatus|)))

(defoid |snmpNotifyFilterSubtree| (|snmpNotifyFilterEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The MIB subtree which, when combined with the corresponding
         instance of snmpNotifyFilterMask, defines a family of
         subtrees which are included in or excluded from the
         filter profile."))

(defoid |snmpNotifyFilterMask| (|snmpNotifyFilterEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The bit mask which, in combination with the corresponding
         instance of snmpNotifyFilterSubtree, defines a family of
         subtrees which are included in or excluded from the
         filter profile.

         Each bit of this bit mask corresponds to a
         sub-identifier of snmpNotifyFilterSubtree, with the
         most significant bit of the i-th octet of this octet
         string value (extended if necessary, see below)
         corresponding to the (8*i - 7)-th sub-identifier, and
         the least significant bit of the i-th octet of this
         octet string corresponding to the (8*i)-th
         sub-identifier, where i is in the range 1 through 16.

         Each bit of this bit mask specifies whether or not
         the corresponding sub-identifiers must match when
         determining if an OBJECT IDENTIFIER matches this
         family of filter subtrees; a '1' indicates that an
         exact match must occur; a '0' indicates 'wild card',
         i.e., any sub-identifier value matches.

         Thus, the OBJECT IDENTIFIER X of an object instance
         is contained in a family of filter subtrees if, for
         each sub-identifier of the value of
         snmpNotifyFilterSubtree, either:

           the i-th bit of snmpNotifyFilterMask is 0, or

           the i-th sub-identifier of X is equal to the i-th
           sub-identifier of the value of
           snmpNotifyFilterSubtree.

         If the value of this bit mask is M bits long and
         there are more than M sub-identifiers in the
         corresponding instance of snmpNotifyFilterSubtree,
         then the bit mask is extended with 1's to be the
         required length.

         Note that when the value of this object is the
         zero-length string, this extension rule results in
         a mask of all-1's being used (i.e., no 'wild card'),
         and the family of filter subtrees is the one
         subtree uniquely identified by the corresponding
         instance of snmpNotifyFilterSubtree."))

(defoid |snmpNotifyFilterType| (|snmpNotifyFilterEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object indicates whether the family of filter subtrees
         defined by this entry are included in or excluded from a
         filter.  A more detailed discussion of the use of this
         object can be found in section 6. of [SNMP-APPL]."))

(defoid |snmpNotifyFilterStorageType| (|snmpNotifyFilterEntry| 4)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
         Conceptual rows having the value 'permanent' need not

         allow write-access to any columnar objects in the row."))

(defoid |snmpNotifyFilterRowStatus| (|snmpNotifyFilterEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

         To create a row in this table, a manager must
         set this object to either createAndGo(4) or
         createAndWait(5)."))

(defoid |snmpNotifyCompliances| (|snmpNotifyConformance| 1)
  (:type 'object-identity))

(defoid |snmpNotifyGroups| (|snmpNotifyConformance| 2)
  (:type 'object-identity))

(defoid |snmpNotifyBasicCompliance| (|snmpNotifyCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for minimal SNMP entities which
         implement only SNMP Unconfirmed-Class notifications and
         read-create operations on only the snmpTargetAddrTable."))

(defoid |snmpNotifyBasicFiltersCompliance| (|snmpNotifyCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which implement
         SNMP Unconfirmed-Class notifications with filtering, and
         read-create operations on all related tables."))

(defoid |snmpNotifyFullCompliance| (|snmpNotifyCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which either
         implement only SNMP Confirmed-Class notifications, or both
         SNMP Unconfirmed-Class and Confirmed-Class notifications,
         plus filtering and read-create operations on all related
         tables."))

(defoid |snmpNotifyGroup| (|snmpNotifyGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects for selecting which management
         targets are used for generating notifications, and the
         type of notification to be generated for each selected
         management target."))

(defoid |snmpNotifyFilterGroup| (|snmpNotifyGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing remote configuration
         of notification filters."))

(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-notification-mib *mib-modules*)
  (setf *current-module* nil))

