;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;DISMAN-EVENT-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'disman-event-mib))

(defpackage :asn.1/disman-event-mib
  (:nicknames :disman-event-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Unsigned32| notification-type |Counter32|
                |Gauge32| |mib-2| |zeroDotZero|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |RowStatus|
                |TruthValue|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :|ASN.1/SNMPv2-MIB| |sysUpTime|)
  (:import-from :asn.1/snmp-target-mib |SnmpTagValue|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|))

(in-package :disman-event-mib)

(defoid |dismanEventMIB| (|mib-2| 88)
  (:type 'module-identity)
  (:description
   "The MIB module for defining event triggers and actions
     for network management purposes."))

(defoid |dismanEventMIBObjects| (|dismanEventMIB| 1)
  (:type 'object-identity))

(defoid |mteResource| (|dismanEventMIBObjects| 1)
  (:type 'object-identity))

(defoid |mteTrigger| (|dismanEventMIBObjects| 2)
  (:type 'object-identity))

(defoid |mteObjects| (|dismanEventMIBObjects| 3)
  (:type 'object-identity))

(defoid |mteEvent| (|dismanEventMIBObjects| 4) (:type 'object-identity))

(deftype |FailureReason| () 't)

(defoid |mteResourceSampleMinimum| (|mteResource| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The minimum mteTriggerFrequency this system will
        accept.  A system may use the larger values of this minimum to
        lessen the impact of constant sampling.  For larger
        sampling intervals the system samples less often and
        suffers less overhead.  This object provides a way to enforce
        such lower overhead for all triggers created after it is
        set.

        Unless explicitly resource limited, a system's value for
        this object SHOULD be 1, allowing as small as a 1 second
        interval for ongoing trigger sampling.

        Changing this value will not invalidate an existing setting
        of mteTriggerFrequency."))

(defoid |mteResourceSampleInstanceMaximum| (|mteResource| 2)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The maximum number of instance entries this system will
        support for sampling.

        These are the entries that maintain state, one for each
        instance of each sampled object as selected by
        mteTriggerValueID.  Note that wildcarded objects result
        in multiple instances of this state.

        A value of 0 indicates no preset limit, that is, the limit
        is dynamic based on system operation and resources.

        Unless explicitly resource limited, a system's value for
        this object SHOULD be 0.

        Changing this value will not eliminate or inhibit existing
        sample state but could prevent allocation of additional state
        information."))

(defoid |mteResourceSampleInstances| (|mteResource| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of currently active instance entries as
        defined for mteResourceSampleInstanceMaximum."))

(defoid |mteResourceSampleInstancesHigh| (|mteResource| 4)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The highest value of mteResourceSampleInstances that has
        occurred since initialization of the management system."))

(defoid |mteResourceSampleInstanceLacks| (|mteResource| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times this system could not take a new sample
        because that allocation would have exceeded the limit set by
        mteResourceSampleInstanceMaximum."))

(defoid |mteTriggerFailures| (|mteTrigger| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times an attempt to check for a trigger
        condition has failed.  This counts individually for each
        attempt in a group of targets or each attempt for a


        wildcarded object."))

(defoid |mteTriggerTable| (|mteTrigger| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of management event trigger information."))

(defoid |mteTriggerEntry| (|mteTriggerTable| 1)
  (:type 'object-type)
  (:syntax '|MteTriggerEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single trigger.  Applications create and
        delete entries using mteTriggerEntryStatus."))

(defclass |MteTriggerEntry| (sequence-type)
  ((|mteOwner| :type |SnmpAdminString|)
   (|mteTriggerName| :type |SnmpAdminString|)
   (|mteTriggerComment| :type |SnmpAdminString|)
   (|mteTriggerTest| :type bits)
   (|mteTriggerSampleType| :type integer)
   (|mteTriggerValueID| :type object-id)
   (|mteTriggerValueIDWildcard| :type |TruthValue|)
   (|mteTriggerTargetTag| :type |SnmpTagValue|)
   (|mteTriggerContextName| :type |SnmpAdminString|)
   (|mteTriggerContextNameWildcard| :type |TruthValue|)
   (|mteTriggerFrequency| :type |Unsigned32|)
   (|mteTriggerObjectsOwner| :type |SnmpAdminString|)
   (|mteTriggerObjects| :type |SnmpAdminString|)
   (|mteTriggerEnabled| :type |TruthValue|)
   (|mteTriggerEntryStatus| :type |RowStatus|)))

(defoid |mteOwner| (|mteTriggerEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The owner of this entry. The exact semantics of this
        string are subject to the security policy defined by the
        security administrator."))

(defoid |mteTriggerName| (|mteTriggerEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A locally-unique, administratively assigned name for the
        trigger within the scope of mteOwner."))

(defoid |mteTriggerComment| (|mteTriggerEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "A description of the trigger's function and use."))

(defoid |mteTriggerTest| (|mteTriggerEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of trigger test to perform.  For 'boolean' and
        'threshold'  tests, the object at mteTriggerValueID MUST
        evaluate to an integer, that is, anything that ends up encoded
        for transmission (that is, in BER, not ASN.1) as an integer.

        For 'existence', the specific test is as selected by
        mteTriggerExistenceTest.  When an object appears, vanishes
        or changes value, the trigger fires. If the object's
        appearance caused the trigger firing, the object MUST
        vanish before the trigger can be fired again for it, and
        vice versa. If the trigger fired due to a change in the
        object's value, it will be fired again on every successive
        value change for that object.

        For 'boolean', the specific test is as selected by
        mteTriggerBooleanTest.  If the test result is true the trigger
        fires.  The trigger will not fire again until the value has
        become false and come back to true.

        For 'threshold' the test works as described below for


        mteTriggerThresholdStartup, mteTriggerThresholdRising, and
        mteTriggerThresholdFalling.

        Note that combining 'boolean' and 'threshold' tests on the
        same object may be somewhat redundant."))

(defoid |mteTriggerSampleType| (|mteTriggerEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of sampling to perform.

        An 'absoluteValue' sample requires only a single sample to be
        meaningful, and is exactly the value of the object at
        mteTriggerValueID at the sample time.

        A 'deltaValue' requires two samples to be meaningful and is
        thus not available for testing until the second and subsequent
        samples after the object at mteTriggerValueID is first found
        to exist.  It is the difference between the two samples.  For
        unsigned values it is always positive, based on unsigned
        arithmetic.  For signed values it can be positive or negative.

        For SNMP counters to be meaningful they should be sampled as a
        'deltaValue'.

        For 'deltaValue' mteTriggerDeltaTable contains further
        parameters.

        If only 'existence' is set in mteTriggerTest this object has
        no meaning."))

(defoid |mteTriggerValueID| (|mteTriggerEntry| 6)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The object identifier of the MIB object to sample to see
        if the trigger should fire.

        This may be wildcarded by truncating all or part of the
        instance portion, in which case the value is obtained
        as if with a GetNext function, checking multiple values


        if they exist.  If such wildcarding is applied,
        mteTriggerValueIDWildcard must be 'true' and if not it must
        be 'false'.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteTriggerValueIDWildcard result
        in operation as one would expect when providing the wrong
        identifier to a Get or GetNext operation.  The Get will fail
        or get the wrong object.  The GetNext will indeed get whatever
        is next, proceeding until it runs past the initial part of the
        identifier and perhaps many unintended objects for confusing
        results.  If the value syntax of those objects is not usable,
        that results in a 'badType' error that terminates the scan.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time."))

(defoid |mteTriggerValueIDWildcard| (|mteTriggerEntry| 7)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Control for whether mteTriggerValueID is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard."))

(defoid |mteTriggerTargetTag| (|mteTriggerEntry| 8)
  (:type 'object-type)
  (:syntax '|SnmpTagValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The tag for the target(s) from which to obtain the condition
        for a trigger check.

        A length of 0 indicates the local system.  In this case,
        access to the objects indicated by mteTriggerValueID is under
        the security credentials of the requester that set
        mteTriggerEntryStatus to 'active'.  Those credentials are the
        input parameters for isAccessAllowed from the Architecture for
        Describing SNMP Management Frameworks.

        Otherwise access rights are checked according to the security


        parameters resulting from the tag."))

(defoid |mteTriggerContextName| (|mteTriggerEntry| 9)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The management context from which to obtain mteTriggerValueID.

        This may be wildcarded by leaving characters off the end.  For
        example use 'Repeater' to wildcard to 'Repeater1',
        'Repeater2', 'Repeater-999.87b', and so on.  To indicate such
        wildcarding is intended, mteTriggerContextNameWildcard must
        be 'true'.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time.

        Operation of this feature assumes that the local system has a
        list of available contexts against which to apply the
        wildcard.  If the objects are being read from the local
        system, this is clearly the system's own list of contexts.
        For a remote system a local version of such a list is not
        defined by any current standard and may not be available, so
        this function MAY not be supported."))

(defoid |mteTriggerContextNameWildcard| (|mteTriggerEntry| 10)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Control for whether mteTriggerContextName is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard."))

(defoid |mteTriggerFrequency| (|mteTriggerEntry| 11)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds to wait between trigger samples.  To
        encourage consistency in sampling, the interval is measured
        from the beginning of one check to the beginning of the next
        and the timer is restarted immediately when it expires, not
        when the check completes.

        If the next sample begins before the previous one completed the
        system may either attempt to make the check or treat this as an
        error condition with the error 'sampleOverrun'.

        A frequency of 0 indicates instantaneous recognition of the
        condition.  This is not possible in many cases, but may
        be supported in cases where it makes sense and the system is
        able to do so.  This feature allows the MIB to be used in
        implementations where such interrupt-driven behavior is
        possible and is not likely to be supported for all MIB objects
        even then since such sampling generally has to be tightly
        integrated into low-level code.

        Systems that can support this SHOULD document those cases
        where it can be used.  In cases where it can not, setting this
        object to 0 should be disallowed."))

(defoid |mteTriggerObjectsOwner| (|mteTriggerEntry| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "To go with mteTriggerObjects, the mteOwner of a group of
        objects from mteObjectsTable."))

(defoid |mteTriggerObjects| (|mteTriggerEntry| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger.

        A list of objects may also be added based on the event or on
        the value of mteTriggerTest.



        A length of 0 indicates no additional objects."))

(defoid |mteTriggerEnabled| (|mteTriggerEntry| 14)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A control to allow a trigger to be configured but not used.
        When the value is 'false' the trigger is not sampled."))

(defoid |mteTriggerEntryStatus| (|mteTriggerEntry| 15)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The control that allows creation and deletion of entries.
        Once made active an entry may not be modified except to
        delete it."))

(defoid |mteTriggerDeltaTable| (|mteTrigger| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of management event trigger information for delta
        sampling."))

(defoid |mteTriggerDeltaEntry| (|mteTriggerDeltaTable| 1)
  (:type 'object-type)
  (:syntax '|MteTriggerDeltaEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single trigger's delta sampling.  Entries
        automatically exist in this this table for each mteTriggerEntry
        that has mteTriggerSampleType set to 'deltaValue'."))

(defclass |MteTriggerDeltaEntry| (sequence-type)
  ((|mteTriggerDeltaDiscontinuityID| :type object-id)
   (|mteTriggerDeltaDiscontinuityIDWildcard| :type |TruthValue|)
   (|mteTriggerDeltaDiscontinuityIDType| :type integer)))

(defoid |sysUpTimeInstance| (|sysUpTime| 0) (:type 'object-identity))

(defoid |mteTriggerDeltaDiscontinuityID| (|mteTriggerDeltaEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The OBJECT IDENTIFIER (OID) of a TimeTicks, TimeStamp, or
        DateAndTime object that indicates a discontinuity in the value
        at mteTriggerValueID.

        The OID may be for a leaf object (e.g. sysUpTime.0) or may
        be wildcarded to match mteTriggerValueID.

        This object supports normal checking for a discontinuity in a
        counter.  Note that if this object does not point to sysUpTime
        discontinuity checking MUST still check sysUpTime for an overall
        discontinuity.

        If the object identified is not accessible the sample attempt
        is in error, with the error code as from an SNMP request.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteDeltaDiscontinuityIDWildcard
        result in operation as one would expect when providing the
        wrong identifier to a Get operation.  The Get will fail or get
        the wrong object.  If the value syntax of those objects is not
        usable, that results in an error that terminates the sample
        with a 'badType' error code."))

(defoid |mteTriggerDeltaDiscontinuityIDWildcard|
        (|mteTriggerDeltaEntry| 2)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Control for whether mteTriggerDeltaDiscontinuityID is to be
        treated as fully-specified or wildcarded, with 'true'
        indicating wildcard. Note that the value of this object will
        be the same as that of the corresponding instance of
        mteTriggerValueIDWildcard when the corresponding


        mteTriggerSampleType is 'deltaValue'."))

(defoid |mteTriggerDeltaDiscontinuityIDType| (|mteTriggerDeltaEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The value 'timeTicks' indicates the
        mteTriggerDeltaDiscontinuityID of this row is of syntax
        TimeTicks.  The value 'timeStamp' indicates syntax TimeStamp.
        The value 'dateAndTime' indicates syntax DateAndTime."))

(defoid |mteTriggerExistenceTable| (|mteTrigger| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of management event trigger information for existence
        triggers."))

(defoid |mteTriggerExistenceEntry| (|mteTriggerExistenceTable| 1)
  (:type 'object-type)
  (:syntax '|MteTriggerExistenceEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single existence trigger.  Entries
        automatically exist in this this table for each mteTriggerEntry
        that has 'existence' set in mteTriggerTest."))

(defclass |MteTriggerExistenceEntry| (sequence-type)
  ((|mteTriggerExistenceTest| :type bits)
   (|mteTriggerExistenceStartup| :type bits)
   (|mteTriggerExistenceObjectsOwner| :type |SnmpAdminString|)
   (|mteTriggerExistenceObjects| :type |SnmpAdminString|)
   (|mteTriggerExistenceEventOwner| :type |SnmpAdminString|)
   (|mteTriggerExistenceEvent| :type |SnmpAdminString|)))

(defoid |mteTriggerExistenceTest| (|mteTriggerExistenceEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The type of existence test to perform.  The trigger fires
        when the object at mteTriggerValueID is seen to go from
        present to absent, from absent to present, or to have it's
        value changed, depending on which tests are selected:

        present(0) - when this test is selected, the trigger fires
        when the mteTriggerValueID object goes from absent to present.

        absent(1)  - when this test is selected, the trigger fires
        when the mteTriggerValueID object goes from present to absent.
        changed(2) - when this test is selected, the trigger fires
        the mteTriggerValueID object value changes.

        Once the trigger has fired for either presence or absence it
        will not fire again for that state until the object has been
        to the other state. "))

(defoid |mteTriggerExistenceStartup| (|mteTriggerExistenceEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Control for whether an event may be triggered when this entry
        is first set to 'active' and the test specified by
        mteTriggerExistenceTest is true.  Setting an option causes
        that trigger to fire when its test is true."))

(defoid |mteTriggerExistenceObjectsOwner|
        (|mteTriggerExistenceEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerExistenceObjects, the mteOwner of a
        group of objects from mteObjectsTable."))

(defoid |mteTriggerExistenceObjects| (|mteTriggerExistenceEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger for
        this test.

        A list of objects may also be added based on the overall
        trigger, the event or other settings in mteTriggerTest.

        A length of 0 indicates no additional objects."))

(defoid |mteTriggerExistenceEventOwner| (|mteTriggerExistenceEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerExistenceEvent, the mteOwner of an event
        entry from the mteEventTable."))

(defoid |mteTriggerExistenceEvent| (|mteTriggerExistenceEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteEventName of the event to invoke when mteTriggerType is
        'existence' and this trigger fires.  A length of 0 indicates no
        event."))

(defoid |mteTriggerBooleanTable| (|mteTrigger| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of management event trigger information for boolean
        triggers."))

(defoid |mteTriggerBooleanEntry| (|mteTriggerBooleanTable| 1)
  (:type 'object-type)
  (:syntax '|MteTriggerBooleanEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single boolean trigger.  Entries
        automatically exist in this this table for each mteTriggerEntry
        that has 'boolean' set in mteTriggerTest."))

(defclass |MteTriggerBooleanEntry| (sequence-type)
  ((|mteTriggerBooleanComparison| :type integer)
   (|mteTriggerBooleanValue| :type |Integer32|)
   (|mteTriggerBooleanStartup| :type |TruthValue|)
   (|mteTriggerBooleanObjectsOwner| :type |SnmpAdminString|)
   (|mteTriggerBooleanObjects| :type |SnmpAdminString|)
   (|mteTriggerBooleanEventOwner| :type |SnmpAdminString|)
   (|mteTriggerBooleanEvent| :type |SnmpAdminString|)))

(defoid |mteTriggerBooleanComparison| (|mteTriggerBooleanEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The type of boolean comparison to perform.

        The value at mteTriggerValueID is compared to
        mteTriggerBooleanValue, so for example if
        mteTriggerBooleanComparison is 'less' the result would be true
        if the value at mteTriggerValueID is less than the value of
        mteTriggerBooleanValue."))

(defoid |mteTriggerBooleanValue| (|mteTriggerBooleanEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The value to use for the test specified by
        mteTriggerBooleanTest."))

(defoid |mteTriggerBooleanStartup| (|mteTriggerBooleanEntry| 3)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Control for whether an event may be triggered when this entry
        is first set to 'active' or a new instance of the object at
        mteTriggerValueID is found and the test specified by
        mteTriggerBooleanComparison is true.  In that case an event is
        triggered if mteTriggerBooleanStartup is 'true'."))

(defoid |mteTriggerBooleanObjectsOwner| (|mteTriggerBooleanEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerBooleanObjects, the mteOwner of a group
        of objects from mteObjectsTable."))

(defoid |mteTriggerBooleanObjects| (|mteTriggerBooleanEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger for
        this test.

        A list of objects may also be added based on the overall
        trigger, the event or other settings in mteTriggerTest.

        A length of 0 indicates no additional objects."))

(defoid |mteTriggerBooleanEventOwner| (|mteTriggerBooleanEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerBooleanEvent, the mteOwner of an event
        entry from mteEventTable."))

(defoid |mteTriggerBooleanEvent| (|mteTriggerBooleanEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteEventName of the event to invoke when mteTriggerType is
        'boolean' and this trigger fires.  A length of 0 indicates no
        event."))

(defoid |mteTriggerThresholdTable| (|mteTrigger| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of management event trigger information for threshold
        triggers."))

(defoid |mteTriggerThresholdEntry| (|mteTriggerThresholdTable| 1)
  (:type 'object-type)
  (:syntax '|MteTriggerThresholdEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single threshold trigger.  Entries
        automatically exist in this table for each mteTriggerEntry
        that has 'threshold' set in mteTriggerTest."))

(defclass |MteTriggerThresholdEntry| (sequence-type)
  ((|mteTriggerThresholdStartup| :type integer)
   (|mteTriggerThresholdRising| :type |Integer32|)
   (|mteTriggerThresholdFalling| :type |Integer32|)
   (|mteTriggerThresholdDeltaRising| :type |Integer32|)
   (|mteTriggerThresholdDeltaFalling| :type |Integer32|)
   (|mteTriggerThresholdObjectsOwner| :type |SnmpAdminString|)
   (|mteTriggerThresholdObjects| :type |SnmpAdminString|)
   (|mteTriggerThresholdRisingEventOwner| :type |SnmpAdminString|)
   (|mteTriggerThresholdRisingEvent| :type |SnmpAdminString|)
   (|mteTriggerThresholdFallingEventOwner| :type |SnmpAdminString|)
   (|mteTriggerThresholdFallingEvent| :type |SnmpAdminString|)
   (|mteTriggerThresholdDeltaRisingEventOwner| :type |SnmpAdminString|)
   (|mteTriggerThresholdDeltaRisingEvent| :type |SnmpAdminString|)
   (|mteTriggerThresholdDeltaFallingEventOwner|
    :type
    |SnmpAdminString|)
   (|mteTriggerThresholdDeltaFallingEvent| :type |SnmpAdminString|)))

(defoid |mteTriggerThresholdStartup| (|mteTriggerThresholdEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The event that may be triggered when this entry is first
        set to 'active' and a new instance of the object at
        mteTriggerValueID is found.  If the first sample after this
        instance becomes active is greater than or equal to
        mteTriggerThresholdRising and mteTriggerThresholdStartup is
        equal to 'rising' or 'risingOrFalling', then one
        mteTriggerThresholdRisingEvent is triggered for that instance.
        If the first sample after this entry becomes active is less
        than or equal to mteTriggerThresholdFalling and
        mteTriggerThresholdStartup is equal to 'falling' or
        'risingOrFalling', then one mteTriggerThresholdRisingEvent is
        triggered for that instance."))

(defoid |mteTriggerThresholdRising| (|mteTriggerThresholdEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A threshold value to check against if mteTriggerType is
        'threshold'.

        When the current sampled value is greater than or equal to
        this threshold, and the value at the last sampling interval
        was less than this threshold, one
        mteTriggerThresholdRisingEvent is triggered.  That event is
        also triggered if the first sample after this entry becomes
        active is greater than or equal to this threshold and
        mteTriggerThresholdStartup is equal to 'rising' or
        'risingOrFalling'.

        After a rising event is generated, another such event is not
        triggered until the sampled value falls below this threshold
        and reaches mteTriggerThresholdFalling."))

(defoid |mteTriggerThresholdFalling| (|mteTriggerThresholdEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A threshold value to check against if mteTriggerType is
        'threshold'.

        When the current sampled value is less than or equal to this
        threshold, and the value at the last sampling interval was
        greater than this threshold, one
        mteTriggerThresholdFallingEvent is triggered.  That event is
        also triggered if the first sample after this entry becomes
        active is less than or equal to this threshold and
        mteTriggerThresholdStartup is equal to 'falling' or
        'risingOrFalling'.

        After a falling event is generated, another such event is not
        triggered until the sampled value rises above this threshold
        and reaches mteTriggerThresholdRising."))

(defoid |mteTriggerThresholdDeltaRising| (|mteTriggerThresholdEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A threshold value to check against if mteTriggerType is
        'threshold'.

        When the delta value (difference) between the current sampled
        value (value(n)) and the previous sampled value (value(n-1))
        is greater than or equal to this threshold,
        and the delta value calculated at the last sampling interval
        (i.e. value(n-1) - value(n-2)) was less than this threshold,
        one mteTriggerThresholdDeltaRisingEvent is triggered. That event
        is also triggered if the first delta value calculated after this
        entry becomes active, i.e. value(2) - value(1), where value(1)
        is the first sample taken of that instance, is greater than or
        equal to this threshold.

        After a rising event is generated, another such event is not
        triggered until the delta value falls below this threshold and
        reaches mteTriggerThresholdDeltaFalling."))

(defoid |mteTriggerThresholdDeltaFalling|
        (|mteTriggerThresholdEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A threshold value to check against if mteTriggerType is
        'threshold'.

        When the delta value (difference) between the current sampled
        value (value(n)) and the previous sampled value (value(n-1))
        is less than or equal to this threshold,
        and the delta value calculated at the last sampling interval
        (i.e. value(n-1) - value(n-2)) was greater than this threshold,
        one mteTriggerThresholdDeltaFallingEvent is triggered. That event
        is also triggered if the first delta value calculated after this
        entry becomes active, i.e. value(2) - value(1), where value(1)
        is the first sample taken of that instance, is less than or
        equal to this threshold.

        After a falling event is generated, another such event is not
        triggered until the delta value falls below this threshold and
        reaches mteTriggerThresholdDeltaRising."))

(defoid |mteTriggerThresholdObjectsOwner|
        (|mteTriggerThresholdEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerThresholdObjects, the mteOwner of a group
        of objects from mteObjectsTable."))

(defoid |mteTriggerThresholdObjects| (|mteTriggerThresholdEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger for
        this test.

        A list of objects may also be added based on the overall


        trigger, the event or other settings in mteTriggerTest.

        A length of 0 indicates no additional objects."))

(defoid |mteTriggerThresholdRisingEventOwner|
        (|mteTriggerThresholdEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerThresholdRisingEvent, the mteOwner of an
        event entry from mteEventTable."))

(defoid |mteTriggerThresholdRisingEvent| (|mteTriggerThresholdEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdRising.  A length of 0 indicates no event."))

(defoid |mteTriggerThresholdFallingEventOwner|
        (|mteTriggerThresholdEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerThresholdFallingEvent, the mteOwner of an
        event entry from mteEventTable."))

(defoid |mteTriggerThresholdFallingEvent|
        (|mteTriggerThresholdEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdFalling.  A length of 0 indicates no event."))

(defoid |mteTriggerThresholdDeltaRisingEventOwner|
        (|mteTriggerThresholdEntry| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerThresholdDeltaRisingEvent, the mteOwner
        of an event entry from mteEventTable."))

(defoid |mteTriggerThresholdDeltaRisingEvent|
        (|mteTriggerThresholdEntry| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdDeltaRising. A length of 0 indicates
        no event."))

(defoid |mteTriggerThresholdDeltaFallingEventOwner|
        (|mteTriggerThresholdEntry| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteTriggerThresholdDeltaFallingEvent, the mteOwner
        of an event entry from mteEventTable."))

(defoid |mteTriggerThresholdDeltaFallingEvent|
        (|mteTriggerThresholdEntry| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdDeltaFalling.  A length of 0 indicates
        no event."))

(defoid |mteObjectsTable| (|mteObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of objects that can be added to notifications based
        on the trigger, trigger test, or event, as pointed to by
        entries in those tables."))

(defoid |mteObjectsEntry| (|mteObjectsTable| 1)
  (:type 'object-type)
  (:syntax '|MteObjectsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A group of objects.  Applications create and delete entries
        using mteObjectsEntryStatus.

        When adding objects to a notification they are added in the
        lexical order of their index in this table.  Those associated
        with a trigger come first, then trigger test, then event."))

(defclass |MteObjectsEntry| (sequence-type)
  ((|mteObjectsName| :type |SnmpAdminString|)
   (|mteObjectsIndex| :type |Unsigned32|)
   (|mteObjectsID| :type object-id)
   (|mteObjectsIDWildcard| :type |TruthValue|)
   (|mteObjectsEntryStatus| :type |RowStatus|)))

(defoid |mteObjectsName| (|mteObjectsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A locally-unique, administratively assigned name for a group
        of objects."))

(defoid |mteObjectsIndex| (|mteObjectsEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An arbitrary integer for the purpose of identifying
        individual objects within a mteObjectsName group.


        Objects within a group are placed in the notification in the
        numerical order of this index.

        Groups are placed in the notification in the order of the
        selections for overall trigger, trigger test, and event.
        Within trigger test they are in the same order as the
        numerical values of the bits defined for mteTriggerTest.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteDeltaDiscontinuityIDWildcard
        result in operation as one would expect when providing the
        wrong identifier to a Get operation.  The Get will fail or get
        the wrong object.  If the object is not available it is omitted
        from the notification."))

(defoid |mteObjectsID| (|mteObjectsEntry| 3)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The object identifier of a MIB object to add to a
        Notification that results from the firing of a trigger.

        This may be wildcarded by truncating all or part of the
        instance portion, in which case the instance portion of the
        OID for obtaining this object will be the same as that used
        in obtaining the mteTriggerValueID that fired.  If such
        wildcarding is applied, mteObjectsIDWildcard must be
        'true' and if not it must be 'false'.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time."))

(defoid |mteObjectsIDWildcard| (|mteObjectsEntry| 4)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Control for whether mteObjectsID is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard."))

(defoid |mteObjectsEntryStatus| (|mteObjectsEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The control that allows creation and deletion of entries.
        Once made active an entry MAY not be modified except to
        delete it."))

(defoid |mteEventFailures| (|mteEvent| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times an attempt to invoke an event
        has failed.  This counts individually for each
        attempt in a group of targets or each attempt for a
        wildcarded trigger object."))

(defoid |mteEventTable| (|mteEvent| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of management event action information."))

(defoid |mteEventEntry| (|mteEventTable| 1)
  (:type 'object-type)
  (:syntax '|MteEventEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single event.  Applications create and
        delete entries using mteEventEntryStatus."))

(defclass |MteEventEntry| (sequence-type)
  ((|mteEventName| :type |SnmpAdminString|)
   (|mteEventComment| :type |SnmpAdminString|)
   (|mteEventActions| :type bits)
   (|mteEventEnabled| :type |TruthValue|)
   (|mteEventEntryStatus| :type |RowStatus|)))

(defoid |mteEventName| (|mteEventEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A locally-unique, administratively assigned name for the
        event."))

(defoid |mteEventComment| (|mteEventEntry| 2)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "A description of the event's function and use."))

(defoid |mteEventActions| (|mteEventEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The actions to perform when this event occurs.

        For 'notification', Traps and/or Informs are sent according
        to the configuration in the SNMP Notification MIB.

        For 'set', an SNMP Set operation is performed according to
        control values in this entry."))

(defoid |mteEventEnabled| (|mteEventEntry| 4)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A control to allow an event to be configured but not used.
        When the value is 'false' the event does not execute even if


        triggered."))

(defoid |mteEventEntryStatus| (|mteEventEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The control that allows creation and deletion of entries.
        Once made active an entry MAY not be modified except to
        delete it."))

(defoid |mteEventNotificationTable| (|mteEvent| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of information about notifications to be sent as a
        consequence of management events."))

(defoid |mteEventNotificationEntry| (|mteEventNotificationTable| 1)
  (:type 'object-type)
  (:syntax '|MteEventNotificationEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single event's notification.  Entries
        automatically exist in this this table for each mteEventEntry
        that has 'notification' set in mteEventActions."))

(defclass |MteEventNotificationEntry| (sequence-type)
  ((|mteEventNotification| :type object-id)
   (|mteEventNotificationObjectsOwner| :type |SnmpAdminString|)
   (|mteEventNotificationObjects| :type |SnmpAdminString|)))

(defoid |mteEventNotification| (|mteEventNotificationEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The object identifier from the NOTIFICATION-TYPE for the
        notification to use if metEventActions has 'notification' set."))

(defoid |mteEventNotificationObjectsOwner|
        (|mteEventNotificationEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "To go with mteEventNotificationObjects, the mteOwner of a
        group of objects from mteObjectsTable."))

(defoid |mteEventNotificationObjects| (|mteEventNotificationEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The mteObjectsName of a group of objects from
        mteObjectsTable if mteEventActions has 'notification' set.
        These objects are to be added to any Notification generated by
        this event.

        Objects may also be added based on the trigger that stimulated
        the event.

        A length of 0 indicates no additional objects."))

(defoid |mteEventSetTable| (|mteEvent| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of management event action information."))

(defoid |mteEventSetEntry| (|mteEventSetTable| 1)
  (:type 'object-type)
  (:syntax '|MteEventSetEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single event's set option.  Entries
        automatically exist in this this table for each mteEventEntry
        that has 'set' set in mteEventActions."))

(defclass |MteEventSetEntry| (sequence-type)
  ((|mteEventSetObject| :type object-id)
   (|mteEventSetObjectWildcard| :type |TruthValue|)
   (|mteEventSetValue| :type |Integer32|)
   (|mteEventSetTargetTag| :type |SnmpTagValue|)
   (|mteEventSetContextName| :type |SnmpAdminString|)
   (|mteEventSetContextNameWildcard| :type |TruthValue|)))

(defoid |mteEventSetObject| (|mteEventSetEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The object identifier from the MIB object to set if
        mteEventActions has 'set' set.

        This object identifier may be wildcarded by leaving
        sub-identifiers off the end, in which case
        nteEventSetObjectWildCard must be 'true'.

        If mteEventSetObject is wildcarded the instance used to set the
        object to which it points is the same as the instance from the
        value of mteTriggerValueID that triggered the event.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteSetObjectWildcard
        result in operation as one would expect when providing the
        wrong identifier to a Set operation.  The Set will fail or set
        the wrong object.  If the value syntax of the destination
        object is not correct, the Set fails with the normal SNMP
        error code."))

(defoid |mteEventSetObjectWildcard| (|mteEventSetEntry| 2)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Control over whether mteEventSetObject is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard
        if mteEventActions has 'set' set."))

(defoid |mteEventSetValue| (|mteEventSetEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The value to which to set the object at mteEventSetObject
        if mteEventActions has 'set' set."))

(defoid |mteEventSetTargetTag| (|mteEventSetEntry| 4)
  (:type 'object-type)
  (:syntax '|SnmpTagValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The tag for the target(s) at which to set the object at
        mteEventSetObject to mteEventSetValue if mteEventActions
        has 'set' set.

        Systems limited to self management MAY reject a non-zero
        length for the value of this object.

        A length of 0 indicates the local system.  In this case,
        access to the objects indicated by mteEventSetObject is under
        the security credentials of the requester that set
        mteTriggerEntryStatus to 'active'.  Those credentials are the
        input parameters for isAccessAllowed from the Architecture for
        Describing SNMP Management Frameworks.

        Otherwise access rights are checked according to the security
        parameters resulting from the tag."))

(defoid |mteEventSetContextName| (|mteEventSetEntry| 5)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The management context in which to set mteEventObjectID.
        if mteEventActions has 'set' set.

        This may be wildcarded by leaving characters off the end.  To
        indicate such wildcarding mteEventSetContextNameWildcard must
        be 'true'.

        If this context name is wildcarded the value used to complete
        the wildcarding of mteTriggerContextName will be appended."))

(defoid |mteEventSetContextNameWildcard| (|mteEventSetEntry| 6)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Control for whether mteEventSetContextName is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard
        if mteEventActions has 'set' set."))

(defoid |dismanEventMIBNotificationPrefix| (|dismanEventMIB| 2)
  (:type 'object-identity))

(defoid |dismanEventMIBNotifications|
        (|dismanEventMIBNotificationPrefix| 0)
  (:type 'object-identity))

(defoid |dismanEventMIBNotificationObjects|
        (|dismanEventMIBNotificationPrefix| 1)
  (:type 'object-identity))

(defoid |mteHotTrigger| (|dismanEventMIBNotificationObjects| 1)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description "The name of the trigger causing the notification."))

(defoid |mteHotTargetName| (|dismanEventMIBNotificationObjects| 2)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The SNMP Target MIB's snmpTargetAddrName related to the
        notification."))

(defoid |mteHotContextName| (|dismanEventMIBNotificationObjects| 3)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The context name related to the notification.  This MUST be as
        fully-qualified as possible, including filling in wildcard
        information determined in processing."))

(defoid |mteHotOID| (|dismanEventMIBNotificationObjects| 4)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The object identifier of the destination object related to the
        notification.  This MUST be as fully-qualified as possible,
        including filling in wildcard information determined in
        processing.

        For a trigger-related notification this is from
        mteTriggerValueID.

        For a set failure this is from mteEventSetObject."))

(defoid |mteHotValue| (|dismanEventMIBNotificationObjects| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The value of the object at mteTriggerValueID when a
        trigger fired."))

(defoid |mteFailedReason| (|dismanEventMIBNotificationObjects| 6)
  (:type 'object-type)
  (:syntax '|FailureReason|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The reason for the failure of an attempt to check for a
        trigger condition or set an object in response to an event."))

(defoid |mteTriggerFired| (|dismanEventMIBNotifications| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Notification that the trigger indicated by the object
        instances has fired, for triggers with mteTriggerType
        'boolean' or 'existence'."))

(defoid |mteTriggerRising| (|dismanEventMIBNotifications| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Notification that the rising threshold was met for triggers
        with mteTriggerType 'threshold'."))

(defoid |mteTriggerFalling| (|dismanEventMIBNotifications| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Notification that the falling threshold was met for triggers
        with mteTriggerType 'threshold'."))

(defoid |mteTriggerFailure| (|dismanEventMIBNotifications| 4)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Notification that an attempt to check a trigger has failed.

        The network manager must enable this notification only with
        a certain fear and trembling, as it can easily crowd out more
        important information.  It should be used only to help diagnose
        a problem that has appeared in the error counters and can not
        be found otherwise."))

(defoid |mteEventSetFailure| (|dismanEventMIBNotifications| 5)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Notification that an attempt to do a set in response to an
        event has failed.

        The network manager must enable this notification only with
        a certain fear and trembling, as it can easily crowd out more
        important information.  It should be used only to help diagnose
        a problem that has appeared in the error counters and can not
        be found otherwise."))

(defoid |dismanEventMIBConformance| (|dismanEventMIB| 3)
  (:type 'object-identity))

(defoid |dismanEventMIBCompliances| (|dismanEventMIBConformance| 1)
  (:type 'object-identity))

(defoid |dismanEventMIBGroups| (|dismanEventMIBConformance| 2)
  (:type 'object-identity))

(defoid |dismanEventMIBCompliance| (|dismanEventMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement
                the Event MIB."))

(defoid |dismanEventResourceGroup| (|dismanEventMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "Event resource status and control objects."))

(defoid |dismanEventTriggerGroup| (|dismanEventMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description "Event triggers."))

(defoid |dismanEventObjectsGroup| (|dismanEventMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description "Supplemental objects."))

(defoid |dismanEventEventGroup| (|dismanEventMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description "Events."))

(defoid |dismanEventNotificationObjectGroup| (|dismanEventMIBGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description "Notification objects."))

(defoid |dismanEventNotificationGroup| (|dismanEventMIBGroups| 6)
  (:type 'notification-group)
  (:status '|current|)
  (:description "Notifications."))

(eval-when (:load-toplevel :execute)
  (pushnew 'disman-event-mib *mib-modules*)
  (setf *current-module* nil))

