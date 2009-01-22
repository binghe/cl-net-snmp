;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;DISMAN-PING-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'disman-ping-mib))

(defpackage :asn.1/disman-ping-mib
  (:nicknames :disman-ping-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Unsigned32| |Gauge32| |mib-2|
                notification-type object-identity)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |RowStatus|
                |StorageType| |DateAndTime| |TruthValue|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :asn.1/if-mib |InterfaceIndexOrZero|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :asn.1/inet-address-mib |InetAddressType|
                |InetAddress|))

(in-package :disman-ping-mib)

(defoid |pingMIB| (|mib-2| 80)
  (:type 'module-identity)
  (:description
   "The Ping MIB (DISMAN-PING-MIB) provides the capability of
        controlling the use of the ping function at a remote
        host.

        Copyright (C) The Internet Society (2006).  This version of
        this MIB module is part of RFC 4560; see the RFC itself for
        full legal notices."))

(deftype |OperationResponseStatus| () 't)

(defoid |pingNotifications| (|pingMIB| 0) (:type 'object-identity))

(defoid |pingObjects| (|pingMIB| 1) (:type 'object-identity))

(defoid |pingConformance| (|pingMIB| 2) (:type 'object-identity))

(defoid |pingImplementationTypeDomains| (|pingMIB| 3)
  (:type 'object-identity))

(defoid |pingIcmpEcho| (|pingImplementationTypeDomains| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Indicates that an implementation is using the Internet
        Control Message Protocol (ICMP) 'ECHO' facility."))

(defoid |pingUdpEcho| (|pingImplementationTypeDomains| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Indicates that an implementation is using the UDP echo
        port (7)."))

(defoid |pingSnmpQuery| (|pingImplementationTypeDomains| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Indicates that an implementation is using an SNMP query
         to calculate a round trip time."))

(defoid |pingTcpConnectionAttempt| (|pingImplementationTypeDomains| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Indicates that an implementation is attempting to
        connect to a TCP port in order to calculate a round
        trip time."))

(defoid |pingMaxConcurrentRequests| (|pingObjects| 1)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The maximum number of concurrent active ping requests
       that are allowed within an agent implementation.  A value
       of 0 for this object implies that there is no limit for
       the number of concurrent active requests in effect.

       The limit applies only to new requests being activated.
       When a new value is set, the agent will continue processing
       all the requests already active, even if their number
       exceeds the limit just imposed."))

(defoid |pingCtlTable| (|pingObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the ping Control Table for providing, via SNMP,
        the capability of performing ping operations at
        a remote host.  The results of these operations are
        stored in the pingResultsTable and the
        pingProbeHistoryTable."))

(defoid |pingCtlEntry| (|pingCtlTable| 1)
  (:type 'object-type)
  (:syntax '|PingCtlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the pingCtlTable.  The first index
        element, pingCtlOwnerIndex, is of type SnmpAdminString,
        a textual convention that allows for use of the SNMPv3
        View-Based Access Control Model (RFC 3415, VACM)
        and that allows a management application to identify its
        entries.  The second index, pingCtlTestName (also an
        SnmpAdminString), enables the same management
        application to have multiple outstanding requests."))

(defclass |PingCtlEntry| (sequence-type)
  ((|pingCtlOwnerIndex| :type |SnmpAdminString|)
   (|pingCtlTestName| :type |SnmpAdminString|)
   (|pingCtlTargetAddressType| :type |InetAddressType|)
   (|pingCtlTargetAddress| :type |InetAddress|)
   (|pingCtlDataSize| :type |Unsigned32|)
   (|pingCtlTimeOut| :type |Unsigned32|)
   (|pingCtlProbeCount| :type |Unsigned32|)
   (|pingCtlAdminStatus| :type integer)
   (|pingCtlDataFill| :type t)
   (|pingCtlFrequency| :type |Unsigned32|)
   (|pingCtlMaxRows| :type |Unsigned32|)
   (|pingCtlStorageType| :type |StorageType|)
   (|pingCtlTrapGeneration| :type bits)
   (|pingCtlTrapProbeFailureFilter| :type |Unsigned32|)
   (|pingCtlTrapTestFailureFilter| :type |Unsigned32|)
   (|pingCtlType| :type object-id)
   (|pingCtlDescr| :type |SnmpAdminString|)
   (|pingCtlSourceAddressType| :type |InetAddressType|)
   (|pingCtlSourceAddress| :type |InetAddress|)
   (|pingCtlIfIndex| :type |InterfaceIndexOrZero|)
   (|pingCtlByPassRouteTable| :type |TruthValue|)
   (|pingCtlDSField| :type |Unsigned32|)
   (|pingCtlRowStatus| :type |RowStatus|)))

(defoid |pingCtlOwnerIndex| (|pingCtlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "To facilitate the provisioning of access control by a
       security administrator using the View-Based Access
       Control Model (RFC 2575, VACM) for tables in which
       multiple users may need to create or
       modify entries independently, the initial index is used
       as an 'owner index'.  Such an initial index has a syntax
       of SnmpAdminString and can thus be trivially mapped to a
       securityName or groupName defined in VACM, in
       accordance with a security policy.

       When used in conjunction with such a security policy, all
       entries in the table belonging to a particular user (or
       group) will have the same value for this initial index.
       For a given user's entries in a particular table, the
       object identifiers for the information in these entries
       will have the same subidentifiers (except for the 'column'
       subidentifier) up to the end of the encoded owner index.
       To configure VACM to permit access to this portion of the
       table, one would create vacmViewTreeFamilyTable entries
       with the value of vacmViewTreeFamilySubtree including
       the owner index portion, and vacmViewTreeFamilyMask
       'wildcarding' the column subidentifier.  More elaborate
       configurations are possible."))

(defoid |pingCtlTestName| (|pingCtlEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The name of the ping test.  This is locally unique, within
        the scope of a pingCtlOwnerIndex."))

(defoid |pingCtlTargetAddressType| (|pingCtlEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the type of host address to be used at a remote
        host for performing a ping operation."))

(defoid |pingCtlTargetAddress| (|pingCtlEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the host address to be used at a remote host for
        performing a ping operation.  The host address type is
        determined by the value of the corresponding
        pingCtlTargetAddressType.

        A value for this object MUST be set prior to transitioning
        its corresponding pingCtlEntry to active(1) via
        pingCtlRowStatus."))

(defoid |pingCtlDataSize| (|pingCtlEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the size of the data portion to be
        transmitted in a ping operation, in octets.  Whether this
        value can be applied depends on the selected
        implementation method for performing a ping operation,
        indicated by pingCtlType in the same conceptual row.
        If the method used allows applying the value contained

        in this object, then it MUST be applied.  If the specified
        size is not appropriate for the chosen ping method, the
        implementation SHOULD use whatever size (appropriate to
        the method) is closest to the specified size.

        The maximum value for this object was computed by
        subtracting the smallest possible IP header size of
        20 octets (IPv4 header with no options) and the UDP
        header size of 8 octets from the maximum IP packet size.
        An IP packet has a maximum size of 65535 octets
        (excluding IPv6 Jumbograms)."))

(defoid |pingCtlTimeOut| (|pingCtlEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the time-out value, in seconds, for a
        remote ping operation."))

(defoid |pingCtlProbeCount| (|pingCtlEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the number of times to perform a ping
        operation at a remote host as part of a single ping test."))

(defoid |pingCtlAdminStatus| (|pingCtlEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Reflects the desired state that a pingCtlEntry should be
        in:

           enabled(1)  - Attempt to activate the test as defined by
                         this pingCtlEntry.
           disabled(2) - Deactivate the test as defined by this
                         pingCtlEntry.

        Refer to the corresponding pingResultsOperStatus to
        determine the operational state of the test defined by
        this entry."))

(defoid |pingCtlDataFill| (|pingCtlEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The content of this object is used together with the
        corresponding pingCtlDataSize value to determine how to
        fill the data portion of a probe packet.  The option of
        selecting a data fill pattern can be useful when links
        are compressed or have data pattern sensitivities.  The
        contents of pingCtlDataFill should be repeated in a ping
        packet when the size of the data portion of the ping
        packet is greater than the size of pingCtlDataFill."))

(defoid |pingCtlFrequency| (|pingCtlEntry| 10)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds to wait before repeating a ping test
        as defined by the value of the various objects in the
        corresponding row.

        A single ping test consists of a series of ping probes.
        The number of probes is determined by the value of the
        corresponding pingCtlProbeCount object.  After a single
        test is completed the number of seconds as defined by the
        value of pingCtlFrequency MUST elapse before the
        next ping test is started.

        A value of 0 for this object implies that the test
        as defined by the corresponding entry will not be
        repeated."))

(defoid |pingCtlMaxRows| (|pingCtlEntry| 11)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of corresponding entries allowed
        in the pingProbeHistoryTable.  An implementation of this
        MIB will remove the oldest corresponding entry in the
        pingProbeHistoryTable to allow the addition of an
        new entry once the number of corresponding rows in the
        pingProbeHistoryTable reaches this value.

        Old entries are not removed when a new test is
        started.  Entries are added to the pingProbeHistoryTable
        until pingCtlMaxRows is reached before entries begin to
        be removed.

        A value of 0 for this object disables creation of
        pingProbeHistoryTable entries."))

(defoid |pingCtlStorageType| (|pingCtlEntry| 12)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
        Conceptual rows having the value 'permanent' need not
        allow write-access to any columnar objects in the row."))

(defoid |pingCtlTrapGeneration| (|pingCtlEntry| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object determines when and whether
        to generate a notification for this entry:

        probeFailure(0)   - Generate a pingProbeFailed
            notification subject to the value of
            pingCtlTrapProbeFailureFilter.  The object
            pingCtlTrapProbeFailureFilter can be used
            to specify the number of consecutive probe
            failures that are required before a
            pingProbeFailed notification can be generated.
        testFailure(1)    - Generate a pingTestFailed
            notification.  In this instance the object
            pingCtlTrapTestFailureFilter can be used to
            determine the number of probe failures that
            signal when a test fails.
        testCompletion(2) - Generate a pingTestCompleted
            notification.

        By default, no bits are set, indicating that
        none of the above options is selected."))

(defoid |pingCtlTrapProbeFailureFilter| (|pingCtlEntry| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object is used to determine when
        to generate a pingProbeFailed NOTIFICATION.

        Setting BIT probeFailure(0) of object
        pingCtlTrapGeneration to '1' implies that a
        pingProbeFailed NOTIFICATION is generated only when

        a number of consecutive ping probes equal to the
        value of pingCtlTrapProbeFailureFilter fail within
        a given ping test.  After triggering the notification,
        the probe failure counter is reset to zero."))

(defoid |pingCtlTrapTestFailureFilter| (|pingCtlEntry| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object is used to determine when
        to generate a pingTestFailed NOTIFICATION.

        Setting BIT testFailure(1) of object

        pingCtlTrapGeneration to '1' implies that a
        pingTestFailed NOTIFICATION is generated only when
        a number of consecutive ping tests equal to the
        value of pingCtlTrapProbeFailureFilter fail.
        After triggering the notification, the test failure
        counter is reset to zero."))

(defoid |pingCtlType| (|pingCtlEntry| 16)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object is used either to report or
        to select the implementation method to be used for
        calculating a ping response time.  The value of this
        object MAY be selected from pingImplementationTypeDomains.

        Additional implementation types SHOULD be allocated as
        required by implementers of the DISMAN-PING-MIB under
        their enterprise-specific registration point and not
        beneath pingImplementationTypeDomains."))

(defoid |pingCtlDescr| (|pingCtlEntry| 17)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The purpose of this object is to provide a
        descriptive name of the remote ping test."))

(defoid |pingCtlSourceAddressType| (|pingCtlEntry| 18)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the type of the source address,
        pingCtlSourceAddress, to be used at a remote host
        when a ping operation is performed."))

(defoid |pingCtlSourceAddress| (|pingCtlEntry| 19)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Use the specified IP address (which must be given in
        numeric form, not as a hostname) as the source address
        in outgoing probe packets.  On hosts with more than one
        IP address, this option can be used to select the address
        to be used.  If the IP address is not one of this
        machine's interface addresses, an error is returned and
        nothing is sent.  A zero-length octet string value for
        this object disables source address specification.

        The address type (InetAddressType) that relates to
        this object is specified by the corresponding value
        of pingCtlSourceAddressType."))

(defoid |pingCtlIfIndex| (|pingCtlEntry| 20)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Setting this object to an interface's ifIndex prior
        to starting a remote ping operation directs
        the ping probes to be transmitted over the
        specified interface.  A value of zero for this object
        means that this option is not enabled."))

(defoid |pingCtlByPassRouteTable| (|pingCtlEntry| 21)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The purpose of this object is to enable optional
       bypassing the route table.  If enabled, the remote
       host will bypass the normal routing tables and send
       directly to a host on an attached network.  If the
       host is not on a directly attached network, an
       error is returned.  This option can be used to perform
       the ping operation to a local host through an
       interface that has no route defined (e.g., after the
       interface was dropped by the routing daemon at the host)."))

(defoid |pingCtlDSField| (|pingCtlEntry| 22)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the value to store in the Type of Service
        (TOS) octet in the IPv4 header or in the Traffic
        Class octet in the IPv6 header, respectively, of the
        IP packet used to encapsulate the ping probe.

        The octet to be set in the IP header contains the
        Differentiated Services (DS) Field in the six most
        significant bits.

        This option can be used to determine what effect an
        explicit DS Field setting has on a ping response.
        Not all values are legal or meaningful.  A value of 0
        means that the function represented by this option is
        not supported.  DS Field usage is often not supported
        by IP implementations, and not all values are supported.
        Refer to RFC 2474 and RFC 3260 for guidance on usage of
        this field."))

(defoid |pingCtlRowStatus| (|pingCtlEntry| 23)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object allows entries to be created and deleted
        in the pingCtlTable.  Deletion of an entry in this
        table results in the deletion of all corresponding (same
        pingCtlOwnerIndex and pingCtlTestName index values)
        pingResultsTable and pingProbeHistoryTable entries.

        A value MUST be specified for pingCtlTargetAddress
        prior to acceptance of a transition to active(1) state.

        When a value for pingCtlTargetAddress is set,
        the value of object pingCtlRowStatus changes
        from notReady(3) to notInService(2).

        Activation of a remote ping operation is controlled
        via pingCtlAdminStatus, not by changing
        this object's value to active(1).

        Transitions in and out of active(1) state are not
        allowed while an entry's pingResultsOperStatus is
        active(1), with the exception that deletion of
        an entry in this table by setting its RowStatus
        object to destroy(6) will stop an active
        ping operation.

        The operational state of a ping operation
        can be determined by examination of its
        pingResultsOperStatus object."))

(defoid |pingResultsTable| (|pingObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Ping Results Table for providing
        the capability of performing ping operations at
        a remote host.  The results of these operations are
        stored in the pingResultsTable and the pingProbeHistoryTable.

        An entry is added to the pingResultsTable when an
        pingCtlEntry is started by successful transition
        of its pingCtlAdminStatus object to enabled(1).

        If the object pingCtlAdminStatus already has the value
        enabled(1), and if the corresponding pingResultsOperStatus
        object has the value completed(3), then successfully writing
        enabled(1) to object pingCtlAdminStatus re-initializes the
        already existing entry in the pingResultsTable.  The values
        of objects in the re-initialized entry are the same as the
        values of objects in a new entry would be.

        An entry is removed from the pingResultsTable when
        its corresponding pingCtlEntry is deleted."))

(defoid |pingResultsEntry| (|pingResultsTable| 1)
  (:type 'object-type)
  (:syntax '|PingResultsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the pingResultsTable.  The
        pingResultsTable has the same indexing as the
        pingCtlTable so that a pingResultsEntry
        corresponds to the pingCtlEntry that caused it to
        be created."))

(defclass |PingResultsEntry| (sequence-type)
  ((|pingResultsOperStatus| :type integer)
   (|pingResultsIpTargetAddressType| :type |InetAddressType|)
   (|pingResultsIpTargetAddress| :type |InetAddress|)
   (|pingResultsMinRtt| :type |Unsigned32|)
   (|pingResultsMaxRtt| :type |Unsigned32|)
   (|pingResultsAverageRtt| :type |Unsigned32|)
   (|pingResultsProbeResponses| :type |Gauge32|)
   (|pingResultsSentProbes| :type |Gauge32|)
   (|pingResultsRttSumOfSquares| :type |Unsigned32|)
   (|pingResultsLastGoodProbe| :type |DateAndTime|)))

(defoid |pingResultsOperStatus| (|pingResultsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reflects the operational state of a pingCtlEntry:

           enabled(1)    - Test is active.
           disabled(2)   - Test has stopped.
           completed(3)  - Test is completed."))

(defoid |pingResultsIpTargetAddressType| (|pingResultsEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object indicates the type of address stored
        in the corresponding pingResultsIpTargetAddress
        object."))

(defoid |pingResultsIpTargetAddress| (|pingResultsEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object reports the IP address associated
        with a pingCtlTargetAddress value when the destination
        address is specified as a DNS name.  The value of
        this object should be a zero-length octet string
        when a DNS name is not specified or when a
        specified DNS name fails to resolve.

        The address type (InetAddressType) that relates to
        this object is specified by the corresponding value
        of pingResultsIpTargetAddressType."))

(defoid |pingResultsMinRtt| (|pingResultsEntry| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum ping round-trip-time (RTT) received.  A value
        of 0 for this object implies that no RTT has been received."))

(defoid |pingResultsMaxRtt| (|pingResultsEntry| 5)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum ping round-trip-time (RTT) received.  A value
        of 0 for this object implies that no RTT has been received."))

(defoid |pingResultsAverageRtt| (|pingResultsEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The current average ping round-trip-time (RTT)."))

(defoid |pingResultsProbeResponses| (|pingResultsEntry| 7)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Number of responses received for the corresponding
        pingCtlEntry and pingResultsEntry.  The value of this object
        MUST be reported as 0 when no probe responses have been
        received."))

(defoid |pingResultsSentProbes| (|pingResultsEntry| 8)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object reflects the number of probes sent
        for the corresponding pingCtlEntry and pingResultsEntry.
        The value of this object MUST be reported as 0 when no probes
        have been sent."))

(defoid |pingResultsRttSumOfSquares| (|pingResultsEntry| 9)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object contains the sum of the squares for all ping
        responses received.  Its purpose is to enable standard
        deviation calculation.  The value of this object MUST
        be reported as 0 when no ping responses have been
        received."))

(defoid |pingResultsLastGoodProbe| (|pingResultsEntry| 10)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Date and time when the last response was received for
        a probe."))

(defoid |pingProbeHistoryTable| (|pingObjects| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines a table for storing the results of ping
        operations.  The number of entries in this table is
        limited per entry in the pingCtlTable by the value
        of the corresponding pingCtlMaxRows object.

        An entry in this table is created when the result of
        a ping probe is determined.  The initial 2 instance
        identifier index values identify the pingCtlEntry
        that a probe result (pingProbeHistoryEntry) belongs
        to.  An entry is removed from this table when
        its corresponding pingCtlEntry is deleted.

        An implementation of this MIB will remove the oldest
        entry in the pingProbeHistoryTable of the
        corresponding entry in the pingCtlTable to allow
        the addition of an new entry once the number of rows
        in the pingProbeHistoryTable reaches the value
        specified by pingCtlMaxRows for the corresponding
        entry in the pingCtlTable."))

(defoid |pingProbeHistoryEntry| (|pingProbeHistoryTable| 1)
  (:type 'object-type)
  (:syntax '|PingProbeHistoryEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the pingProbeHistoryTable.
        The first two index elements identify the
        pingCtlEntry that a pingProbeHistoryEntry belongs
        to.  The third index element selects a single
        probe result."))

(defclass |PingProbeHistoryEntry| (sequence-type)
  ((|pingProbeHistoryIndex| :type |Unsigned32|)
   (|pingProbeHistoryResponse| :type |Unsigned32|)
   (|pingProbeHistoryStatus| :type |OperationResponseStatus|)
   (|pingProbeHistoryLastRC| :type |Integer32|)
   (|pingProbeHistoryTime| :type |DateAndTime|)))

(defoid |pingProbeHistoryIndex| (|pingProbeHistoryEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in this table is created when the result of
        a ping probe is determined.  The initial 2 instance
        identifier index values identify the pingCtlEntry
        that a probe result (pingProbeHistoryEntry) belongs
        to.

        An implementation MUST start assigning
        pingProbeHistoryIndex values at 1 and wrap after
        exceeding the maximum possible value as defined by
        the limit of this object ('ffffffff'h)."))

(defoid |pingProbeHistoryResponse| (|pingProbeHistoryEntry| 2)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of time measured in milliseconds from when
        a probe was sent to when its response was received or
        when it timed out.  The value of this object is reported
        as 0 when it is not possible to transmit a probe."))

(defoid |pingProbeHistoryStatus| (|pingProbeHistoryEntry| 3)
  (:type 'object-type)
  (:syntax '|OperationResponseStatus|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The result of a particular probe done by a remote host."))

(defoid |pingProbeHistoryLastRC| (|pingProbeHistoryEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The last implementation-method-specific reply code received.
        If the ICMP Echo capability is being used, then a successful
        probe ends when an ICMP response is received that contains
        the code ICMP_ECHOREPLY(0).  The ICMP codes are maintained
        by IANA.  Standardized ICMP codes are listed at
        http://www.iana.org/assignments/icmp-parameters.
        The ICMPv6 codes are listed at
        http://www.iana.org/assignments/icmpv6-parameters."))

(defoid |pingProbeHistoryTime| (|pingProbeHistoryEntry| 5)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Timestamp for when this probe result was determined."))

(defoid |pingProbeFailed| (|pingNotifications| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Generated when a probe failure is detected, when the

          corresponding pingCtlTrapGeneration object is set to
          probeFailure(0), subject to the value of
          pingCtlTrapProbeFailureFilter.  The object
          pingCtlTrapProbeFailureFilter can be used to specify the
          number of consecutive probe failures that are required
          before this notification can be generated."))

(defoid |pingTestFailed| (|pingNotifications| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Generated when a ping test is determined to have failed,
          when the corresponding pingCtlTrapGeneration object is
          set to testFailure(1).  In this instance,
          pingCtlTrapTestFailureFilter should specify the number of
          probes in a test required to have failed in order to
          consider the test failed."))

(defoid |pingTestCompleted| (|pingNotifications| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "Generated at the completion of a ping test when the
          corresponding pingCtlTrapGeneration object has the
          testCompletion(2) bit set."))

(defoid |pingCompliances| (|pingConformance| 1)
  (:type 'object-identity))

(defoid |pingGroups| (|pingConformance| 2) (:type 'object-identity))

(defoid |pingFullCompliance| (|pingCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities that
            fully implement the DISMAN-PING-MIB."))

(defoid |pingMinimumCompliance| (|pingCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The minimum compliance statement for SNMP entities
            that implement the minimal subset of the
            DISMAN-PING-MIB.  Implementors might choose this
            subset for small devices with limited resources."))

(defoid |pingCompliance| (|pingCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for the DISMAN-PING-MIB.  This
            compliance statement has been deprecated because the
            group pingGroup and the pingTimeStampGroup have been
            split and deprecated.  The pingFullCompliance statement
            is semantically identical to the deprecated
            pingCompliance statement."))

(defoid |pingMinimumGroup| (|pingGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects that constitute the remote ping
       capability."))

(defoid |pingCtlRowStatusGroup| (|pingGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RowStatus object of the pingCtlTable."))

(defoid |pingHistoryGroup| (|pingGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects that constitute the history
       capability."))

(defoid |pingNotificationsGroup| (|pingGroups| 3)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "The notification that are required to be supported by
       implementations of this MIB."))

(defoid |pingGroup| (|pingGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The group of objects that constitute the remote ping
       capability."))

(defoid |pingTimeStampGroup| (|pingGroups| 2)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description "The group of DateAndTime objects."))

(eval-when (:load-toplevel :execute)
  (pushnew 'disman-ping-mib *mib-modules*)
  (setf *current-module* nil))

