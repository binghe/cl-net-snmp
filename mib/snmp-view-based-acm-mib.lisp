;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-VIEW-BASED-ACM-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'snmp-view-based-acm-mib))

(defpackage :asn.1/snmp-view-based-acm-mib
  (:nicknames :snmp-view-based-acm-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |snmpModules|)
  (:import-from :|ASN.1/SNMPv2-TC| |TestAndIncr| |RowStatus|
                |StorageType|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|
                |SnmpSecurityLevel| |SnmpSecurityModel|))

(in-package :snmp-view-based-acm-mib)

(defoid |snmpVacmMIB| (|snmpModules| 16)
  (:type 'module-identity)
  (:description
   "The management information definitions for the
                  View-based Access Control Model for SNMP.

                  Copyright (C) The Internet Society (2002). This
                  version of this MIB module is part of RFC 3415;
                  see the RFC itself for full legal notices.
                 "))

(defoid |vacmMIBObjects| (|snmpVacmMIB| 1) (:type 'object-identity))

(defoid |vacmMIBConformance| (|snmpVacmMIB| 2) (:type 'object-identity))

(defoid |vacmContextTable| (|vacmMIBObjects| 1)
  (:type 'object-type)
  (:syntax '(vector |VacmContextEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of locally available contexts.

                 This table provides information to SNMP Command

                 Generator applications so that they can properly
                 configure the vacmAccessTable to control access to
                 all contexts at the SNMP entity.

                 This table may change dynamically if the SNMP entity
                 allows that contexts are added/deleted dynamically
                 (for instance when its configuration changes).  Such
                 changes would happen only if the management
                 instrumentation at that SNMP entity recognizes more
                 (or fewer) contexts.

                 The presence of entries in this table and of entries
                 in the vacmAccessTable are independent.  That is, a
                 context identified by an entry in this table is not
                 necessarily referenced by any entries in the
                 vacmAccessTable; and the context(s) referenced by an
                 entry in the vacmAccessTable does not necessarily
                 currently exist and thus need not be identified by an
                 entry in this table.

                 This table must be made accessible via the default
                 context so that Command Responder applications have
                 a standard way of retrieving the information.

                 This table is read-only.  It cannot be configured via
                 SNMP.
                "))

(defoid |vacmContextEntry| (|vacmContextTable| 1)
  (:type 'object-type)
  (:syntax '|VacmContextEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Information about a particular context."))

(defclass |VacmContextEntry| (sequence-type)
  ((|vacmContextName| :type |SnmpAdminString|)))

(defoid |vacmContextName| (|vacmContextEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A human readable name identifying a particular
                 context at a particular SNMP entity.

                 The empty contextName (zero length) represents the
                 default context.
                "))

(defoid |vacmSecurityToGroupTable| (|vacmMIBObjects| 2)
  (:type 'object-type)
  (:syntax '(vector |VacmSecurityToGroupEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table maps a combination of securityModel and
                 securityName into a groupName which is used to define
                 an access control policy for a group of principals.
                "))

(defoid |vacmSecurityToGroupEntry| (|vacmSecurityToGroupTable| 1)
  (:type 'object-type)
  (:syntax '|VacmSecurityToGroupEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in this table maps the combination of a
                 securityModel and securityName into a groupName.
                "))

(defclass |VacmSecurityToGroupEntry| (sequence-type)
  ((|vacmSecurityModel| :type |SnmpSecurityModel|)
   (|vacmSecurityName| :type |SnmpAdminString|)
   (|vacmGroupName| :type |SnmpAdminString|)
   (|vacmSecurityToGroupStorageType| :type |StorageType|)
   (|vacmSecurityToGroupStatus| :type |RowStatus|)))

(defoid |vacmSecurityModel| (|vacmSecurityToGroupEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The Security Model, by which the vacmSecurityName
                 referenced by this entry is provided.

                 Note, this object may not take the 'any' (0) value.
                "))

(defoid |vacmSecurityName| (|vacmSecurityToGroupEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The securityName for the principal, represented in a
                 Security Model independent format, which is mapped by
                 this entry to a groupName.
                "))

(defoid |vacmGroupName| (|vacmSecurityToGroupEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The name of the group to which this entry (e.g., the
                 combination of securityModel and securityName)
                 belongs.

                 This groupName is used as index into the
                 vacmAccessTable to select an access control policy.
                 However, a value in this table does not imply that an
                 instance with the value exists in table vacmAccesTable.
                "))

(defoid |vacmSecurityToGroupStorageType| (|vacmSecurityToGroupEntry| 4)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
                 Conceptual rows having the value 'permanent' need not
                 allow write-access to any columnar objects in the row.
                "))

(defoid |vacmSecurityToGroupStatus| (|vacmSecurityToGroupEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

                 Until instances of all corresponding columns are
                 appropriately configured, the value of the

                 corresponding instance of the vacmSecurityToGroupStatus
                 column is 'notReady'.

                 In particular, a newly created row cannot be made
                 active until a value has been set for vacmGroupName.

                 The  RowStatus TC [RFC2579] requires that this
                 DESCRIPTION clause states under which circumstances
                 other objects in this row can be modified:

                 The value of this object has no effect on whether
                 other objects in this conceptual row can be modified.
                "))

(defoid |vacmAccessTable| (|vacmMIBObjects| 4)
  (:type 'object-type)
  (:syntax '(vector |VacmAccessEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of access rights for groups.

                 Each entry is indexed by a groupName, a contextPrefix,
                 a securityModel and a securityLevel.  To determine
                 whether access is allowed, one entry from this table
                 needs to be selected and the proper viewName from that
                 entry must be used for access control checking.

                 To select the proper entry, follow these steps:

                 1) the set of possible matches is formed by the
                    intersection of the following sets of entries:

                      the set of entries with identical vacmGroupName
                      the union of these two sets:
                       - the set with identical vacmAccessContextPrefix
                       - the set of entries with vacmAccessContextMatch
                         value of 'prefix' and matching
                         vacmAccessContextPrefix
                      intersected with the union of these two sets:
                       - the set of entries with identical
                         vacmSecurityModel
                       - the set of entries with vacmSecurityModel
                         value of 'any'
                      intersected with the set of entries with
                      vacmAccessSecurityLevel value less than or equal
                      to the requested securityLevel

                 2) if this set has only one member, we're done
                    otherwise, it comes down to deciding how to weight
                    the preferences between ContextPrefixes,
                    SecurityModels, and SecurityLevels as follows:
                    a) if the subset of entries with securityModel
                       matching the securityModel in the message is
                       not empty, then discard the rest.
                    b) if the subset of entries with
                       vacmAccessContextPrefix matching the contextName
                       in the message is not empty,
                       then discard the rest
                    c) discard all entries with ContextPrefixes shorter
                       than the longest one remaining in the set
                    d) select the entry with the highest securityLevel

                 Please note that for securityLevel noAuthNoPriv, all
                 groups are really equivalent since the assumption that
                 the securityName has been authenticated does not hold.
                "))

(defoid |vacmAccessEntry| (|vacmAccessTable| 1)
  (:type 'object-type)
  (:syntax '|VacmAccessEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An access right configured in the Local Configuration
                 Datastore (LCD) authorizing access to an SNMP context.

                 Entries in this table can use an instance value for
                 object vacmGroupName even if no entry in table
                 vacmAccessSecurityToGroupTable has a corresponding
                 value for object vacmGroupName.
                "))

(defclass |VacmAccessEntry| (sequence-type)
  ((|vacmAccessContextPrefix| :type |SnmpAdminString|)
   (|vacmAccessSecurityModel| :type |SnmpSecurityModel|)
   (|vacmAccessSecurityLevel| :type |SnmpSecurityLevel|)
   (|vacmAccessContextMatch| :type integer)
   (|vacmAccessReadViewName| :type |SnmpAdminString|)
   (|vacmAccessWriteViewName| :type |SnmpAdminString|)
   (|vacmAccessNotifyViewName| :type |SnmpAdminString|)
   (|vacmAccessStorageType| :type |StorageType|)
   (|vacmAccessStatus| :type |RowStatus|)))

(defoid |vacmAccessContextPrefix| (|vacmAccessEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "In order to gain the access rights allowed by this
                 conceptual row, a contextName must match exactly
                 (if the value of vacmAccessContextMatch is 'exact')
                 or partially (if the value of vacmAccessContextMatch
                 is 'prefix') to the value of the instance of this
                 object.
                "))

(defoid |vacmAccessSecurityModel| (|vacmAccessEntry| 2)
  (:type 'object-type)
  (:syntax '|SnmpSecurityModel|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "In order to gain the access rights allowed by this
                 conceptual row, this securityModel must be in use.
                "))

(defoid |vacmAccessSecurityLevel| (|vacmAccessEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpSecurityLevel|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The minimum level of security required in order to
                 gain the access rights allowed by this conceptual
                 row.  A securityLevel of noAuthNoPriv is less than
                 authNoPriv which in turn is less than authPriv.

                 If multiple entries are equally indexed except for
                 this vacmAccessSecurityLevel index, then the entry
                 which has the highest value for
                 vacmAccessSecurityLevel is selected.
                "))

(defoid |vacmAccessContextMatch| (|vacmAccessEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "If the value of this object is exact(1), then all
                 rows where the contextName exactly matches
                 vacmAccessContextPrefix are selected.

                 If the value of this object is prefix(2), then all
                 rows where the contextName whose starting octets
                 exactly match vacmAccessContextPrefix are selected.
                 This allows for a simple form of wildcarding.
                "))

(defoid |vacmAccessReadViewName| (|vacmAccessEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of an instance of this object identifies
                 the MIB view of the SNMP context to which this
                 conceptual row authorizes read access.

                 The identified MIB view is that one for which the
                 vacmViewTreeFamilyViewName has the same value as the
                 instance of this object; if the value is the empty
                 string or if there is no active MIB view having this
                 value of vacmViewTreeFamilyViewName, then no access
                 is granted.
                "))

(defoid |vacmAccessWriteViewName| (|vacmAccessEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of an instance of this object identifies
                 the MIB view of the SNMP context to which this
                 conceptual row authorizes write access.

                 The identified MIB view is that one for which the
                 vacmViewTreeFamilyViewName has the same value as the
                 instance of this object; if the value is the empty
                 string or if there is no active MIB view having this
                 value of vacmViewTreeFamilyViewName, then no access
                 is granted.
                "))

(defoid |vacmAccessNotifyViewName| (|vacmAccessEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of an instance of this object identifies
                 the MIB view of the SNMP context to which this
                 conceptual row authorizes access for notifications.

                 The identified MIB view is that one for which the
                 vacmViewTreeFamilyViewName has the same value as the
                 instance of this object; if the value is the empty
                 string or if there is no active MIB view having this
                 value of vacmViewTreeFamilyViewName, then no access
                 is granted.
                "))

(defoid |vacmAccessStorageType| (|vacmAccessEntry| 8)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.

                 Conceptual rows having the value 'permanent' need not
                 allow write-access to any columnar objects in the row.
                "))

(defoid |vacmAccessStatus| (|vacmAccessEntry| 9)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

                 The  RowStatus TC [RFC2579] requires that this
                 DESCRIPTION clause states under which circumstances
                 other objects in this row can be modified:

                 The value of this object has no effect on whether
                 other objects in this conceptual row can be modified.
                "))

(defoid |vacmMIBViews| (|vacmMIBObjects| 5) (:type 'object-identity))

(defoid |vacmViewSpinLock| (|vacmMIBViews| 1)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "An advisory lock used to allow cooperating SNMP
                 Command Generator applications to coordinate their
                 use of the Set operation in creating or modifying
                 views.

                 When creating a new view or altering an existing
                 view, it is important to understand the potential
                 interactions with other uses of the view.  The
                 vacmViewSpinLock should be retrieved.  The name of
                 the view to be created should be determined to be
                 unique by the SNMP Command Generator application by
                 consulting the vacmViewTreeFamilyTable.  Finally,
                 the named view may be created (Set), including the
                 advisory lock.
                 If another SNMP Command Generator application has
                 altered the views in the meantime, then the spin
                 lock's value will have changed, and so this creation
                 will fail because it will specify the wrong value for
                 the spin lock.

                 Since this is an advisory lock, the use of this lock
                 is not enforced.
                "))

(defoid |vacmViewTreeFamilyTable| (|vacmMIBViews| 2)
  (:type 'object-type)
  (:syntax '(vector |VacmViewTreeFamilyEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Locally held information about families of subtrees
                 within MIB views.

                 Each MIB view is defined by two sets of view subtrees:
                   - the included view subtrees, and
                   - the excluded view subtrees.
                 Every such view subtree, both the included and the

                 excluded ones, is defined in this table.

                 To determine if a particular object instance is in
                 a particular MIB view, compare the object instance's
                 OBJECT IDENTIFIER with each of the MIB view's active
                 entries in this table.  If none match, then the
                 object instance is not in the MIB view.  If one or
                 more match, then the object instance is included in,
                 or excluded from, the MIB view according to the
                 value of vacmViewTreeFamilyType in the entry whose
                 value of vacmViewTreeFamilySubtree has the most
                 sub-identifiers.  If multiple entries match and have
                 the same number of sub-identifiers (when wildcarding
                 is specified with the value of vacmViewTreeFamilyMask),
                 then the lexicographically greatest instance of
                 vacmViewTreeFamilyType determines the inclusion or
                 exclusion.

                 An object instance's OBJECT IDENTIFIER X matches an
                 active entry in this table when the number of
                 sub-identifiers in X is at least as many as in the
                 value of vacmViewTreeFamilySubtree for the entry,
                 and each sub-identifier in the value of
                 vacmViewTreeFamilySubtree matches its corresponding
                 sub-identifier in X.  Two sub-identifiers match
                 either if the corresponding bit of the value of
                 vacmViewTreeFamilyMask for the entry is zero (the
                 'wild card' value), or if they are equal.

                 A 'family' of subtrees is the set of subtrees defined
                 by a particular combination of values of
                 vacmViewTreeFamilySubtree and vacmViewTreeFamilyMask.

                 In the case where no 'wild card' is defined in the
                 vacmViewTreeFamilyMask, the family of subtrees reduces
                 to a single subtree.

                 When creating or changing MIB views, an SNMP Command
                 Generator application should utilize the
                 vacmViewSpinLock to try to avoid collisions.  See
                 DESCRIPTION clause of vacmViewSpinLock.

                 When creating MIB views, it is strongly advised that
                 first the 'excluded' vacmViewTreeFamilyEntries are
                 created and then the 'included' entries.

                 When deleting MIB views, it is strongly advised that
                 first the 'included' vacmViewTreeFamilyEntries are

                 deleted and then the 'excluded' entries.

                 If a create for an entry for instance-level access
                 control is received and the implementation does not
                 support instance-level granularity, then an
                 inconsistentName error must be returned.
                "))

(defoid |vacmViewTreeFamilyEntry| (|vacmViewTreeFamilyTable| 1)
  (:type 'object-type)
  (:syntax '|VacmViewTreeFamilyEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information on a particular family of view subtrees
                 included in or excluded from a particular SNMP
                 context's MIB view.

                 Implementations must not restrict the number of
                 families of view subtrees for a given MIB view,
                 except as dictated by resource constraints on the
                 overall number of entries in the
                 vacmViewTreeFamilyTable.

                 If no conceptual rows exist in this table for a given
                 MIB view (viewName), that view may be thought of as
                 consisting of the empty set of view subtrees.
                "))

(defclass |VacmViewTreeFamilyEntry| (sequence-type)
  ((|vacmViewTreeFamilyViewName| :type |SnmpAdminString|)
   (|vacmViewTreeFamilySubtree| :type object-id)
   (|vacmViewTreeFamilyMask| :type octet-string)
   (|vacmViewTreeFamilyType| :type integer)
   (|vacmViewTreeFamilyStorageType| :type |StorageType|)
   (|vacmViewTreeFamilyStatus| :type |RowStatus|)))

(defoid |vacmViewTreeFamilyViewName| (|vacmViewTreeFamilyEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The human readable name for a family of view subtrees.
                "))

(defoid |vacmViewTreeFamilySubtree| (|vacmViewTreeFamilyEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The MIB subtree which when combined with the
                 corresponding instance of vacmViewTreeFamilyMask
                 defines a family of view subtrees.
                "))

(defoid |vacmViewTreeFamilyMask| (|vacmViewTreeFamilyEntry| 3)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The bit mask which, in combination with the
                 corresponding instance of vacmViewTreeFamilySubtree,
                 defines a family of view subtrees.

                 Each bit of this bit mask corresponds to a
                 sub-identifier of vacmViewTreeFamilySubtree, with the
                 most significant bit of the i-th octet of this octet
                 string value (extended if necessary, see below)
                 corresponding to the (8*i - 7)-th sub-identifier, and
                 the least significant bit of the i-th octet of this
                 octet string corresponding to the (8*i)-th
                 sub-identifier, where i is in the range 1 through 16.

                 Each bit of this bit mask specifies whether or not
                 the corresponding sub-identifiers must match when
                 determining if an OBJECT IDENTIFIER is in this
                 family of view subtrees; a '1' indicates that an
                 exact match must occur; a '0' indicates 'wild card',
                 i.e., any sub-identifier value matches.

                 Thus, the OBJECT IDENTIFIER X of an object instance
                 is contained in a family of view subtrees if, for
                 each sub-identifier of the value of
                 vacmViewTreeFamilySubtree, either:

                   the i-th bit of vacmViewTreeFamilyMask is 0, or

                   the i-th sub-identifier of X is equal to the i-th
                   sub-identifier of the value of
                   vacmViewTreeFamilySubtree.

                 If the value of this bit mask is M bits long and

                 there are more than M sub-identifiers in the
                 corresponding instance of vacmViewTreeFamilySubtree,
                 then the bit mask is extended with 1's to be the
                 required length.

                 Note that when the value of this object is the
                 zero-length string, this extension rule results in
                 a mask of all-1's being used (i.e., no 'wild card'),
                 and the family of view subtrees is the one view
                 subtree uniquely identified by the corresponding
                 instance of vacmViewTreeFamilySubtree.

                 Note that masks of length greater than zero length
                 do not need to be supported.  In this case this
                 object is made read-only.
                "))

(defoid |vacmViewTreeFamilyType| (|vacmViewTreeFamilyEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Indicates whether the corresponding instances of
                 vacmViewTreeFamilySubtree and vacmViewTreeFamilyMask
                 define a family of view subtrees which is included in
                 or excluded from the MIB view.
                "))

(defoid |vacmViewTreeFamilyStorageType| (|vacmViewTreeFamilyEntry| 5)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.

                 Conceptual rows having the value 'permanent' need not
                 allow write-access to any columnar objects in the row.
                "))

(defoid |vacmViewTreeFamilyStatus| (|vacmViewTreeFamilyEntry| 6)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

                 The  RowStatus TC [RFC2579] requires that this
                 DESCRIPTION clause states under which circumstances
                 other objects in this row can be modified:

                 The value of this object has no effect on whether
                 other objects in this conceptual row can be modified.
                "))

(defoid |vacmMIBCompliances| (|vacmMIBConformance| 1)
  (:type 'object-identity))

(defoid |vacmMIBGroups| (|vacmMIBConformance| 2)
  (:type 'object-identity))

(defoid |vacmMIBCompliance| (|vacmMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP engines which
                 implement the SNMP View-based Access Control Model
                 configuration MIB.
                "))

(defoid |vacmBasicGroup| (|vacmMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing for remote
                 configuration of an SNMP engine which implements

                 the SNMP View-based Access Control Model.
                "))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-view-based-acm-mib *mib-modules*)
  (setf *current-module* nil))

