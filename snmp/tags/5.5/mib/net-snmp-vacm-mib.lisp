;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-VACM-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'net-snmp-vacm-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-vacm-mib *mib-modules*))
(defoid |netSnmpVacmMIB| (|netSnmpObjects| 9)
  (:type 'module-identity)
  (:description
   "Defines Net-SNMP extensions to the standard VACM view table."))
(defoid |nsVacmAccessTable| (|netSnmpVacmMIB| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Net-SNMP extensions to vacmAccessTable."))
(defoid |nsVacmAccessEntry| (|nsVacmAccessTable| 1)
  (:type 'object-type)
  (:syntax '|NsVacmAccessEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Net-SNMP extensions to vacmAccessTable."))
(deftype |NsVacmAccessEntry| () 't)
(defoid |nsVacmAuthType| (|nsVacmAccessEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The type of processing that the specified view
                 should be applied to.   See 'snmpd.conf(5)' and
                 'snmptrapd.conf(5)' for details."))
(defoid |nsVacmContextMatch| (|nsVacmAccessEntry| 2)
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

                 The value of this object should be consistent across
                 all nsVacmAccessEntries corresponding to a single
                 row of the vacmAccessTable.
                "))
(defoid |nsVacmViewName| (|nsVacmAccessEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The MIB view authorised for the appropriate style
                 of processing (as indicated by nsVacmToken).

                 The interpretation of this value is the same as for
                 the standard VACM ViewName objects."))
(defoid |nsVacmStorageType| (|nsVacmAccessEntry| 4)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this (group of) conceptual rows.

                 Conceptual rows having the value 'permanent' need not
                 allow write-access to any columnar objects in the row.

                 The value of this object should be consistent across
                 all nsVacmAccessEntries corresponding to a single
                 row of the vacmAccessTable.
                "))
(defoid |nsVacmStatus| (|nsVacmAccessEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this (group of) conceptual rows.

                 The  RowStatus TC [RFC2579] requires that this
                 DESCRIPTION clause states under which circumstances
                 other objects in this row can be modified:

                 The value of this object has no effect on whether
                 other objects in this conceptual row can be modified.

                 The value of this object should be consistent across
                 all nsVacmAccessEntries corresponding to a single
                 row of the vacmAccessTable.
                "))