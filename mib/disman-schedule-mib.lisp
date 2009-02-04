;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;DISMAN-SCHEDULE-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'disman-schedule-mib))

(defpackage :asn.1/disman-schedule-mib
  (:nicknames :disman-schedule-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                notification-type |Integer32| |Unsigned32| |Counter32|
                |mib-2| |zeroDotZero|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |DateAndTime|
                |RowStatus| |StorageType| |VariablePointer|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|))

(in-package :disman-schedule-mib)

(defoid |schedMIB| (|mib-2| 63)
  (:type 'module-identity)
  (:description
   "This MIB module defines a MIB which provides mechanisms to
         schedule SNMP set operations periodically or at specific
         points in time."))

(defoid |schedObjects| (|schedMIB| 1) (:type 'object-identity))

(defoid |schedNotifications| (|schedMIB| 2) (:type 'object-identity))

(defoid |schedConformance| (|schedMIB| 3) (:type 'object-identity))

(define-textual-convention |SnmpPduErrorStatus|
                           t
                           (:status '|current|)
                           (:description
                            "This TC enumerates the SNMPv1 and SNMPv2 PDU error status
         codes as defined in RFC 1157 and RFC 1905.  It also adds a
         pseudo error status code `noResponse' which indicates a
         timeout condition."))

(defoid |schedLocalTime| (|schedObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The local time used by the scheduler.  Schedules which
         refer to calendar time will use the local time indicated
         by this object.  An implementation MUST return all 11 bytes
         of the DateAndTime textual-convention so that a manager
         may retrieve the offset from GMT time."))

(defoid |schedTable| (|schedObjects| 2)
  (:type 'object-type)
  (:syntax '(vector |SchedEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table defines scheduled actions triggered by
         SNMP set operations."))

(defoid |schedEntry| (|schedTable| 1)
  (:type 'object-type)
  (:syntax '|SchedEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry describing a particular scheduled action.

         Unless noted otherwise, writable objects of this row
         can be modified independent of the current value of
         schedRowStatus, schedAdminStatus and schedOperStatus.
         In particular, it is legal to modify schedInterval
         and the objects in the schedCalendarGroup when
         schedRowStatus is active and schedAdminStatus and
         schedOperStatus are both enabled."))

(defclass |SchedEntry| (sequence-type)
  ((|schedOwner| :type |SnmpAdminString|)
   (|schedName| :type |SnmpAdminString|)
   (|schedDescr| :type |SnmpAdminString|)
   (|schedInterval| :type |Unsigned32|)
   (|schedWeekDay| :type bits)
   (|schedMonth| :type bits)
   (|schedDay| :type bits)
   (|schedHour| :type bits)
   (|schedMinute| :type bits)
   (|schedContextName| :type |SnmpAdminString|)
   (|schedVariable| :type |VariablePointer|)
   (|schedValue| :type |Integer32|)
   (|schedType| :type integer)
   (|schedAdminStatus| :type integer)
   (|schedOperStatus| :type integer)
   (|schedFailures| :type |Counter32|)
   (|schedLastFailure| :type |SnmpPduErrorStatus|)
   (|schedLastFailed| :type |DateAndTime|)
   (|schedStorageType| :type |StorageType|)
   (|schedRowStatus| :type |RowStatus|)
   (|schedTriggers| :type |Counter32|)))

(defoid |schedOwner| (|schedEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The owner of this scheduling entry.  The exact semantics of
         this string are subject to the security policy defined by

         the security administrator."))

(defoid |schedName| (|schedEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally-unique, administratively assigned name for this
         scheduling entry.  This object allows a schedOwner to have
         multiple entries in the schedTable."))

(defoid |schedDescr| (|schedEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The human readable description of the purpose of this
         scheduling entry."))

(defoid |schedInterval| (|schedEntry| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds between two action invocations of
         a periodic scheduler.  Implementations must guarantee
         that action invocations will not occur before at least
         schedInterval seconds have passed.

         The scheduler must ignore all periodic schedules that
         have a schedInterval value of 0.  A periodic schedule
         with a scheduling interval of 0 seconds will therefore
         never invoke an action.

         Implementations may be forced to delay invocations in the
         face of local constraints.  A scheduled management function
         should therefore not rely on the accuracy provided by the
         scheduler implementation.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedWeekDay| (|schedEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The set of weekdays on which the scheduled action should
         take place.  Setting multiple bits will include several
         weekdays in the set of possible weekdays for this schedule.
         Setting all bits will cause the scheduler to ignore the
         weekday.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedMonth| (|schedEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The set of months during which the scheduled action should
         take place.  Setting multiple bits will include several
         months in the set of possible months for this schedule.

         Setting all bits will cause the scheduler to ignore the
         month.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedDay| (|schedEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The set of days in a month on which a scheduled action
         should take place.  There are two sets of bits one can
         use to define the day within a month:

         Enumerations starting with the letter 'd' indicate a
         day in a month relative to the first day of a month.
         The first day of the month can therefore be specified
         by setting the bit d1(0) and d31(30) means the last
         day of a month with 31 days.

         Enumerations starting with the letter 'r' indicate a
         day in a month in reverse order, relative to the last
         day of a month.  The last day in the month can therefore
         be specified by setting the bit r1(31) and r31(61) means
         the first day of a month with 31 days.

         Setting multiple bits will include several days in the set
         of possible days for this schedule.  Setting all bits will
         cause the scheduler to ignore the day within a month.

         Setting all bits starting with the letter 'd' or the
         letter 'r' will also cause the scheduler to ignore the
         day within a month.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedHour| (|schedEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The set of hours within a day during which the scheduled
         action should take place.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedMinute| (|schedEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The set of minutes within an hour when the scheduled action
         should take place.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedContextName| (|schedEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The context which contains the local MIB variable pointed
         to by schedVariable."))

(defoid |schedVariable| (|schedEntry| 11)
  (:type 'object-type)
  (:syntax '|VariablePointer|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An object identifier pointing to a local MIB variable
         which resolves to an ASN.1 primitive type of INTEGER."))

(defoid |schedValue| (|schedEntry| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value which is written to the MIB object pointed to by
         schedVariable when the scheduler invokes an action.  The
         implementation shall enforce the use of access control
         rules when performing the set operation on schedVariable.
         This is accomplished by calling the isAccessAllowed abstract
         service interface as defined in RFC 2571.

         Note that an implementation may choose to issue an SNMP Set
         message to the SNMP engine and leave the access control
         decision to the normal message processing procedure."))

(defoid |schedType| (|schedEntry| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of this schedule.  The value periodic(1) indicates
         that this entry specifies a periodic schedule.  A periodic
         schedule is defined by the value of schedInterval.  The
         values of schedWeekDay, schedMonth, schedDay, schedHour
         and schedMinute are ignored.

         The value calendar(2) indicates that this entry describes a
         calendar schedule.  A calendar schedule is defined by the
         values of schedWeekDay, schedMonth, schedDay, schedHour and
         schedMinute.  The value of schedInterval is ignored.  A
         calendar schedule will trigger on all local times that
         satisfy the bits set in schedWeekDay, schedMonth, schedDay,
         schedHour and schedMinute.

         The value oneshot(3) indicates that this entry describes a
         one-shot schedule.  A one-shot schedule is similar to a
         calendar schedule with the additional feature that it
         disables itself by changing in the `finished'
         schedOperStatus once the schedule triggers an action.

         Note that implementations which maintain a list of pending
         activations must re-calculate them when this object is
         changed."))

(defoid |schedAdminStatus| (|schedEntry| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The desired state of the schedule."))

(defoid |schedOperStatus| (|schedEntry| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current operational state of this schedule.  The state
         enabled(1) indicates this entry is active and that the
         scheduler will invoke actions at appropriate times.  The
         disabled(2) state indicates that this entry is currently
         inactive and ignored by the scheduler.  The finished(3)
         state indicates that the schedule has ended.  Schedules
         in the finished(3) state are ignored by the scheduler.
         A one-shot schedule enters the finished(3) state when it
         deactivates itself.

         Note that the operational state must not be enabled(1)
         when the schedRowStatus is not active."))

(defoid |schedFailures| (|schedEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This variable counts the number of failures while invoking
         the scheduled action.  This counter at most increments once
         for a triggered action."))

(defoid |schedLastFailure| (|schedEntry| 17)
  (:type 'object-type)
  (:syntax '|SnmpPduErrorStatus|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The most recent error that occurred during the invocation of
         a scheduled action.  The value noError(0) is returned
         if no errors have occurred yet."))

(defoid |schedLastFailed| (|schedEntry| 18)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when the most recent failure occurred.

         The value '0000000000000000'H is returned if no failure
         occurred since the last re-initialization of the scheduler."))

(defoid |schedStorageType| (|schedEntry| 19)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object defines whether this scheduled action is kept
         in volatile storage and lost upon reboot or if this row is
         backed up by non-volatile or permanent storage.

         Conceptual rows having the value `permanent' must allow
         write access to the columnar objects schedDescr,
         schedInterval, schedContextName, schedVariable, schedValue,
         and schedAdminStatus.  If an implementation supports the
         schedCalendarGroup, write access must be also allowed to
         the columnar objects schedWeekDay, schedMonth, schedDay,
         schedHour, schedMinute."))

(defoid |schedRowStatus| (|schedEntry| 20)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this scheduled action.  A control that allows
         entries to be added and removed from this table.

         Note that the operational state must change to enabled
         when the administrative state is enabled and the row
         status changes to active(1).

         Attempts to destroy(6) a row or to set a row
         notInService(2) while the operational state is enabled
         result in inconsistentValue errors.

         The value of this object has no effect on whether other
         objects in this conceptual row can be modified."))

(defoid |schedTriggers| (|schedEntry| 21)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This variable counts the number of attempts (either
         successful or failed) to invoke the scheduled action."))

(defoid |schedTraps| (|schedNotifications| 0) (:type 'object-identity))

(defoid |schedActionFailure| (|schedTraps| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification is generated whenever the invocation of a
         scheduled action fails."))

(defoid |schedCompliances| (|schedConformance| 1)
  (:type 'object-identity))

(defoid |schedGroups| (|schedConformance| 2) (:type 'object-identity))

(defoid |schedCompliance2| (|schedCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which implement
         the scheduling MIB."))

(defoid |schedGroup2| (|schedGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing scheduling capabilities."))

(defoid |schedCalendarGroup| (|schedGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing calendar based schedules."))

(defoid |schedNotificationsGroup| (|schedGroups| 3)
  (:type 'notification-group)
  (:status '|current|)
  (:description "The notifications emitted by the scheduler."))

(defoid |schedCompliance| (|schedCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for SNMP entities which implement
         the scheduling MIB."))

(defoid |schedGroup| (|schedGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing scheduling capabilities."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'disman-schedule-mib *mib-modules*)
  (setf *current-module* nil))

