;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;DISMAN-TRACEROUTE-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'disman-traceroute-mib))

(defpackage :asn.1/disman-traceroute-mib
  (:nicknames :disman-traceroute-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Gauge32| |Unsigned32| |mib-2|
                notification-type object-identity)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus| |StorageType|
                |TruthValue| |DateAndTime|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :asn.1/if-mib |InterfaceIndexOrZero|)
  (:import-from :asn.1/inet-address-mib |InetAddressType|
                |InetAddress|)
  (:import-from :asn.1/disman-ping-mib |OperationResponseStatus|))

(in-package :disman-traceroute-mib)

(defoid |traceRouteMIB| (|mib-2| 81)
  (:type 'module-identity)
  (:description
   "The Traceroute MIB (DISMAN-TRACEROUTE-MIB) provides
        access to the traceroute capability at a remote host.

        Copyright (C) The Internet Society (2006). This version of
        this MIB module is part of RFC 4560; see the RFC itself for
        full legal notices."))

(defoid |traceRouteNotifications| (|traceRouteMIB| 0)
  (:type 'object-identity))

(defoid |traceRouteObjects| (|traceRouteMIB| 1)
  (:type 'object-identity))

(defoid |traceRouteConformance| (|traceRouteMIB| 2)
  (:type 'object-identity))

(defoid |traceRouteImplementationTypeDomains| (|traceRouteMIB| 3)
  (:type 'object-identity))

(defoid |traceRouteUsingUdpProbes|
        (|traceRouteImplementationTypeDomains| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Indicates that an implementation is using UDP probes to
        perform the traceroute operation."))

(defoid |traceRouteMaxConcurrentRequests| (|traceRouteObjects| 1)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The maximum number of concurrent active traceroute requests
       that are allowed within an agent implementation.  A value
       of 0 for this object implies that there is no limit for
       the number of concurrent active requests in effect.

       The limit applies only to new requests being activated.
       When a new value is set, the agent will continue processing
       all the requests already active, even if their number
       exceeds the limit just imposed."))

(defoid |traceRouteCtlTable| (|traceRouteObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Remote Operations Traceroute Control Table for
        providing the capability of invoking traceroute from a remote
        host.  The results of traceroute operations can be stored in
        the traceRouteResultsTable, traceRouteProbeHistoryTable, and
        the traceRouteHopsTable."))

(defoid |traceRouteCtlEntry| (|traceRouteCtlTable| 1)
  (:type 'object-type)
  (:syntax '|TraceRouteCtlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the traceRouteCtlTable.  The first
        index element, traceRouteCtlOwnerIndex, is of type
        SnmpAdminString, a textual convention that allows for
        use of the SNMPv3 View-Based Access Control Model
        (RFC 3415, VACM) and that allows a management
        application to identify its entries.  The second index,
        traceRouteCtlTestName (also an SnmpAdminString),
        enables the same management application to have
        multiple requests outstanding."))

(defclass |TraceRouteCtlEntry|
          (asn.1-type)
          ((|traceRouteCtlOwnerIndex| :type |SnmpAdminString|)
           (|traceRouteCtlTestName| :type |SnmpAdminString|)
           (|traceRouteCtlTargetAddressType| :type |InetAddressType|)
           (|traceRouteCtlTargetAddress| :type |InetAddress|)
           (|traceRouteCtlByPassRouteTable| :type |TruthValue|)
           (|traceRouteCtlDataSize| :type |Unsigned32|)
           (|traceRouteCtlTimeOut| :type |Unsigned32|)
           (|traceRouteCtlProbesPerHop| :type |Unsigned32|)
           (|traceRouteCtlPort| :type |Unsigned32|)
           (|traceRouteCtlMaxTtl| :type |Unsigned32|)
           (|traceRouteCtlDSField| :type |Unsigned32|)
           (|traceRouteCtlSourceAddressType| :type |InetAddressType|)
           (|traceRouteCtlSourceAddress| :type |InetAddress|)
           (|traceRouteCtlIfIndex| :type |InterfaceIndexOrZero|)
           (|traceRouteCtlMiscOptions| :type |SnmpAdminString|)
           (|traceRouteCtlMaxFailures| :type |Unsigned32|)
           (|traceRouteCtlDontFragment| :type |TruthValue|)
           (|traceRouteCtlInitialTtl| :type |Unsigned32|)
           (|traceRouteCtlFrequency| :type |Unsigned32|)
           (|traceRouteCtlStorageType| :type |StorageType|)
           (|traceRouteCtlAdminStatus| :type integer)
           (|traceRouteCtlDescr| :type |SnmpAdminString|)
           (|traceRouteCtlMaxRows| :type |Unsigned32|)
           (|traceRouteCtlTrapGeneration| :type bits)
           (|traceRouteCtlCreateHopsEntries| :type |TruthValue|)
           (|traceRouteCtlType| :type object-id)
           (|traceRouteCtlRowStatus| :type |RowStatus|)))

(defoid |traceRouteCtlOwnerIndex| (|traceRouteCtlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "To facilitate the provisioning of access control by a
       security administrator using the View-Based Access
       Control Model (RFC 3415, VACM) for tables in which
       multiple users may need to create or
       modify entries independently, the initial index is used as
       an 'owner index'.  Such an initial index has a syntax of
       SnmpAdminString and can thus be trivially mapped to a
       securityName or groupName defined in VACM, in
       accordance with a security policy.

       When used in conjunction with such a security policy,
       all entries in the table belonging to a particular user
       (or group) will have the same value for this initial
       index.  For a given user's entries in a particular
       table, the object identifiers for the information in
       these entries will have the same subidentifiers (except
       for the 'column' subidentifier) up to the end of the
       encoded owner index. To configure VACM to permit access
       to this portion of the table, one would create
       vacmViewTreeFamilyTable entries with the value of
       vacmViewTreeFamilySubtree including the owner index
       portion, and vacmViewTreeFamilyMask 'wildcarding' the
       column subidentifier.  More elaborate configurations
       are possible."))

(defoid |traceRouteCtlTestName| (|traceRouteCtlEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The name of a traceroute test.  This is locally unique,
        within the scope of a traceRouteCtlOwnerIndex."))

(defoid |traceRouteCtlTargetAddressType| (|traceRouteCtlEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the type of host address to be used on the
        traceroute request at the remote host."))

(defoid |traceRouteCtlTargetAddress| (|traceRouteCtlEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the host address used on the
        traceroute request at the remote host.  The
        host address type can be determined by
        examining the value of the corresponding
        traceRouteCtlTargetAddressType.

        A value for this object MUST be set prior to
        transitioning its corresponding traceRouteCtlEntry to
        active(1) via traceRouteCtlRowStatus."))

(defoid |traceRouteCtlByPassRouteTable| (|traceRouteCtlEntry| 5)
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
       the traceroute operation to a local host through an
       interface that has no route defined (e.g., after the
       interface was dropped by the routing daemon at the host)."))

(defoid |traceRouteCtlDataSize| (|traceRouteCtlEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the size of the data portion of a traceroute
        request, in octets.  If the RECOMMENDED traceroute method
        (UDP datagrams as probes) is used, then the value
        contained in this object MUST be applied.  If another
        traceroute method is used for which the specified size
        is not appropriate, then the implementation SHOULD use
        whatever size (appropriate to the method) is closest to
        the specified size.

        The maximum value for this object was computed by
        subtracting the smallest possible IP header size of
        20 octets (IPv4 header with no options) and the UDP
        header size of 8 octets from the maximum IP packet size.
        An IP packet has a maximum size of 65535 octets
        (excluding IPv6 Jumbograms)."))

(defoid |traceRouteCtlTimeOut| (|traceRouteCtlEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the time-out value, in seconds, for
        a traceroute request."))

(defoid |traceRouteCtlProbesPerHop| (|traceRouteCtlEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the number of times to reissue a traceroute
        request with the same time-to-live (TTL) value."))

(defoid |traceRouteCtlPort| (|traceRouteCtlEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the (initial) UDP port to send the traceroute
        request to.  A port needs to be specified that is not in
        use at the destination (target) host.  The default
        value for this object is the IANA assigned port,
        33434, for the traceroute function."))

(defoid |traceRouteCtlMaxTtl| (|traceRouteCtlEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "Specifies the maximum time-to-live value."))

(defoid |traceRouteCtlDSField| (|traceRouteCtlEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the value to store in the Type of Service
        (TOS) octet in the IPv4 header or in the Traffic
        Class octet in the IPv6 header, respectively, of the
        IP packet used to encapsulate the traceroute probe.

        The octet to be set in the IP header contains the
        Differentiated Services (DS) Field in the six most
        significant bits.

        This option can be used to determine what effect an
        explicit DS Field setting has on a traceroute response.
        Not all values are legal or meaningful.  A value of 0
        means that the function represented by this option is
        not supported.  DS Field usage is often not supported
        by IP implementations, and not all values are supported.
        Refer to RFC 2474 and RFC 3260 for guidance on usage of
        this field."))

(defoid |traceRouteCtlSourceAddressType| (|traceRouteCtlEntry| 12)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the type of the source address,
        traceRouteCtlSourceAddress, to be used at a remote host
        when a traceroute operation is performed."))

(defoid |traceRouteCtlSourceAddress| (|traceRouteCtlEntry| 13)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Use the specified IP address (which must be given as an
        IP number, not a hostname) as the source address in
        outgoing probe packets.  On hosts with more than one IP
        address, this option can be used to select the address
        to be used.  If the IP address is not one of this
        machine's interface addresses, an error is returned, and
        nothing is sent.  A zero-length octet string value for
        this object disables source address specification.
        The address type (InetAddressType) that relates to
        this object is specified by the corresponding value
        of traceRouteCtlSourceAddressType."))

(defoid |traceRouteCtlIfIndex| (|traceRouteCtlEntry| 14)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Setting this object to an interface's ifIndex prior
        to starting a remote traceroute operation directs
        the traceroute probes to be transmitted over the
        specified interface.  A value of zero for this object
        implies that this option is not enabled."))

(defoid |traceRouteCtlMiscOptions| (|traceRouteCtlEntry| 15)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Enables an application to specify implementation-dependent
        options."))

(defoid |traceRouteCtlMaxFailures| (|traceRouteCtlEntry| 16)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object indicates the maximum number
        of consecutive timeouts allowed before a remote traceroute
        request is terminated.  A value of either 255 (maximum
        hop count/possible TTL value) or 0 indicates that the
        function of terminating a remote traceroute request when a
        specific number of consecutive timeouts are detected is
        disabled."))

(defoid |traceRouteCtlDontFragment| (|traceRouteCtlEntry| 17)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object enables setting of the don't fragment flag (DF)
        in the IP header for a probe.  Use of this object enables
        a manual PATH MTU test is performed."))

(defoid |traceRouteCtlInitialTtl| (|traceRouteCtlEntry| 18)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object specifies the initial TTL value to
        use.  This enables bypassing the initial (often well known)
        portion of a path."))

(defoid |traceRouteCtlFrequency| (|traceRouteCtlEntry| 19)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds to wait before repeating a
        traceroute test, as defined by the value of the
        various objects in the corresponding row.

        After a single test is completed the number of seconds
        as defined by the value of traceRouteCtlFrequency MUST
        elapse before the next traceroute test is started.

        A value of 0 for this object implies that the test
        as defined by the corresponding entry will not be

        repeated."))

(defoid |traceRouteCtlStorageType| (|traceRouteCtlEntry| 20)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
        Conceptual rows having the value 'permanent' need not
        allow write-access to any columnar objects in the row."))

(defoid |traceRouteCtlAdminStatus| (|traceRouteCtlEntry| 21)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Reflects the desired state that an traceRouteCtlEntry
        should be in:

           enabled(1)  - Attempt to activate the test as defined by
                         this traceRouteCtlEntry.
           disabled(2) - Deactivate the test as defined by this
                         traceRouteCtlEntry.

        Refer to the corresponding traceRouteResultsOperStatus to
        determine the operational state of the test defined by
        this entry."))

(defoid |traceRouteCtlDescr| (|traceRouteCtlEntry| 22)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The purpose of this object is to provide a
        descriptive name of the remote traceroute
        test."))

(defoid |traceRouteCtlMaxRows| (|traceRouteCtlEntry| 23)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of corresponding entries allowed
        in the traceRouteProbeHistoryTable.  An implementation
        of this MIB will remove the oldest corresponding entry
        in the traceRouteProbeHistoryTable to allow the
        addition of an new entry once the number of
        corresponding rows in the traceRouteProbeHistoryTable
        reaches this value.

        Old entries are not removed when a new test is
        started.  Entries are added to the
        traceRouteProbeHistoryTable until traceRouteCtlMaxRows
        is reached before entries begin to be removed.
        A value of 0 for this object disables creation of
        traceRouteProbeHistoryTable entries."))

(defoid |traceRouteCtlTrapGeneration| (|traceRouteCtlEntry| 24)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object determines when and whether to
        generate a notification for this entry:

        pathChange(0)     - Generate a traceRoutePathChange
            notification when the current path varies from a
            previously determined path.
        testFailure(1)    - Generate a traceRouteTestFailed
            notification when the full path to a target
            can't be determined.
        testCompletion(2) - Generate a traceRouteTestCompleted
            notification when the path to a target has been
            determined.

        The value of this object defaults to an empty set,
        indicating that none of the above options has been
        selected."))

(defoid |traceRouteCtlCreateHopsEntries| (|traceRouteCtlEntry| 25)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The current path for a traceroute test is kept in the
        traceRouteHopsTable on a per-hop basis when the value of
        this object is true(1)."))

(defoid |traceRouteCtlType| (|traceRouteCtlEntry| 26)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object is used either to report or to
        select the implementation method to be used for
        performing a traceroute operation.  The value of this
        object may be selected from
        traceRouteImplementationTypeDomains.

        Additional implementation types should be allocated as
        required by implementers of the DISMAN-TRACEROUTE-MIB
        under their enterprise specific registration point,
        not beneath traceRouteImplementationTypeDomains."))

(defoid |traceRouteCtlRowStatus| (|traceRouteCtlEntry| 27)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object allows entries to be created and deleted
        in the traceRouteCtlTable.  Deletion of an entry in
        this table results in a deletion of all corresponding (same
        traceRouteCtlOwnerIndex and traceRouteCtlTestName
        index values) traceRouteResultsTable,
        traceRouteProbeHistoryTable, and traceRouteHopsTable
        entries.

        A value MUST be specified for traceRouteCtlTargetAddress
        prior to acceptance of a transition to active(1) state.

        When a value for pingCtlTargetAddress is set,
        the value of object pingCtlRowStatus changes
        from notReady(3) to notInService(2).

        Activation of a remote traceroute operation is
        controlled via traceRouteCtlAdminStatus, and not
        by transitioning of this object's value to active(1).

        Transitions in and out of active(1) state are not
        allowed while an entry's traceRouteResultsOperStatus
        is active(1), with the exception that deletion of
        an entry in this table by setting its RowStatus
        object to destroy(6) will stop an active
        traceroute operation.

        The operational state of an traceroute operation
        can be determined by examination of the corresponding
        traceRouteResultsOperStatus object."))

(defoid |traceRouteResultsTable| (|traceRouteObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Remote Operations Traceroute Results Table for
        keeping track of the status of a traceRouteCtlEntry.

        An entry is added to the traceRouteResultsTable when an
        traceRouteCtlEntry is started by successful transition
        of its traceRouteCtlAdminStatus object to enabled(1).

        If the object traceRouteCtlAdminStatus already has the value
        enabled(1), and if the corresponding
        traceRouteResultsOperStatus object has the value
        completed(3), then successfully writing enabled(1) to the
        object traceRouteCtlAdminStatus re-initializes the already
        existing entry in the traceRouteResultsTable.  The values of
        objects in the re-initialized entry are the same as
        the values of objects in a new entry would be.

        An entry is removed from the traceRouteResultsTable when

        its corresponding traceRouteCtlEntry is deleted."))

(defoid |traceRouteResultsEntry| (|traceRouteResultsTable| 1)
  (:type 'object-type)
  (:syntax '|TraceRouteResultsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the traceRouteResultsTable.  The
        traceRouteResultsTable has the same indexing as the
        traceRouteCtlTable so that a traceRouteResultsEntry
        corresponds to the traceRouteCtlEntry that caused it to
        be created."))

(defclass |TraceRouteResultsEntry|
          (asn.1-type)
          ((|traceRouteResultsOperStatus| :type integer)
           (|traceRouteResultsCurHopCount| :type |Gauge32|)
           (|traceRouteResultsCurProbeCount| :type |Gauge32|)
           (|traceRouteResultsIpTgtAddrType| :type |InetAddressType|)
           (|traceRouteResultsIpTgtAddr| :type |InetAddress|)
           (|traceRouteResultsTestAttempts| :type |Gauge32|)
           (|traceRouteResultsTestSuccesses| :type |Gauge32|)
           (|traceRouteResultsLastGoodPath| :type |DateAndTime|)))

(defoid |traceRouteResultsOperStatus| (|traceRouteResultsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reflects the operational state of an traceRouteCtlEntry:

           enabled(1)   - Test is active.
           disabled(2)  - Test has stopped.
           completed(3) - Test is completed."))

(defoid |traceRouteResultsCurHopCount| (|traceRouteResultsEntry| 2)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reflects the current TTL value (from 1 to
        255) for a remote traceroute operation.
        Maximum TTL value is determined by
        traceRouteCtlMaxTtl."))

(defoid |traceRouteResultsCurProbeCount| (|traceRouteResultsEntry| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reflects the current probe count (1..10) for
        a remote traceroute operation.  The maximum
        probe count is determined by
        traceRouteCtlProbesPerHop."))

(defoid |traceRouteResultsIpTgtAddrType| (|traceRouteResultsEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object indicates the type of address stored
        in the corresponding traceRouteResultsIpTgtAddr
        object."))

(defoid |traceRouteResultsIpTgtAddr| (|traceRouteResultsEntry| 5)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object reports the IP address associated
        with a traceRouteCtlTargetAddress value when the
        destination address is specified as a DNS name.
        The value of this object should be a zero-length
        octet string when a DNS name is not specified or
        when a specified DNS name fails to resolve."))

(defoid |traceRouteResultsTestAttempts| (|traceRouteResultsEntry| 6)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current number of attempts to determine a path
        to a target.  The value of this object MUST be started
        at 0."))

(defoid |traceRouteResultsTestSuccesses| (|traceRouteResultsEntry| 7)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current number of attempts to determine a path
        to a target that have succeeded.  The value of this
        object MUST be reported as 0 when no attempts have
        succeeded."))

(defoid |traceRouteResultsLastGoodPath| (|traceRouteResultsEntry| 8)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when the last complete path
        was determined.  A path is complete if responses
        were received or timeout occurred for each hop on
        the path; i.e., for each TTL value from the value
        of the corresponding traceRouteCtlInitialTtl object
        up to the end of the path or (if no reply from the
        target IP address was received) up to the value of
        the corresponding traceRouteCtlMaxTtl object."))

(defoid |traceRouteProbeHistoryTable| (|traceRouteObjects| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Remote Operations Traceroute Results Table
        for storing the results of a traceroute operation.

        An implementation of this MIB will remove the oldest

        entry in the traceRouteProbeHistoryTable of the
        corresponding entry in the traceRouteCtlTable to allow
        the addition of a new entry once the number of rows in
        the traceRouteProbeHistoryTable reaches the value specified
        by traceRouteCtlMaxRows for the corresponding entry in the
        traceRouteCtlTable."))

(defoid |traceRouteProbeHistoryEntry| (|traceRouteProbeHistoryTable| 1)
  (:type 'object-type)
  (:syntax '|TraceRouteProbeHistoryEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines a table for storing the results of a traceroute
        operation.  Entries in this table are limited by
        the value of the corresponding traceRouteCtlMaxRows
        object.

        The first two index elements identify the
        traceRouteCtlEntry that a traceRouteProbeHistoryEntry
        belongs to.  The third index element selects a single
        traceroute operation result.  The fourth and fifth indexes
        select the hop and the probe for a particular
        traceroute operation."))

(defclass |TraceRouteProbeHistoryEntry|
          (asn.1-type)
          ((|traceRouteProbeHistoryIndex| :type |Unsigned32|)
           (|traceRouteProbeHistoryHopIndex| :type |Unsigned32|)
           (|traceRouteProbeHistoryProbeIndex| :type |Unsigned32|)
           (|traceRouteProbeHistoryHAddrType| :type |InetAddressType|)
           (|traceRouteProbeHistoryHAddr| :type |InetAddress|)
           (|traceRouteProbeHistoryResponse| :type |Unsigned32|)
           (|traceRouteProbeHistoryStatus|
            :type
            |OperationResponseStatus|)
           (|traceRouteProbeHistoryLastRC| :type |Integer32|)
           (|traceRouteProbeHistoryTime| :type |DateAndTime|)))

(defoid |traceRouteProbeHistoryIndex| (|traceRouteProbeHistoryEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in this table is created when the result of
        a traceroute probe is determined.  The initial 2 instance
        identifier index values identify the traceRouteCtlEntry
        that a probe result (traceRouteProbeHistoryEntry) belongs
        to.  An entry is removed from this table when
        its corresponding traceRouteCtlEntry is deleted.

        An implementation MUST start assigning
        traceRouteProbeHistoryIndex values at 1 and wrap after
        exceeding the maximum possible value, as defined by the
        limit of this object ('ffffffff'h)."))

(defoid |traceRouteProbeHistoryHopIndex|
        (|traceRouteProbeHistoryEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Indicates which hop in a traceroute path the probe's
       results are for.  The value of this object is initially
       determined by the value of traceRouteCtlInitialTtl."))

(defoid |traceRouteProbeHistoryProbeIndex|
        (|traceRouteProbeHistoryEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Indicates the index of a probe for a particular
       hop in a traceroute path.  The number of probes per
       hop is determined by the value of the corresponding
       traceRouteCtlProbesPerHop object."))

(defoid |traceRouteProbeHistoryHAddrType|
        (|traceRouteProbeHistoryEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This objects indicates the type of address stored
        in the corresponding traceRouteProbeHistoryHAddr
        object."))

(defoid |traceRouteProbeHistoryHAddr| (|traceRouteProbeHistoryEntry| 5)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The address of a hop in a traceroute path.  This object
       is not allowed to be a DNS name.  The value of the
       corresponding object, traceRouteProbeHistoryHAddrType,
       indicates this object's IP address type."))

(defoid |traceRouteProbeHistoryResponse|
        (|traceRouteProbeHistoryEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of time measured in milliseconds from when
        a probe was sent to when its response was received or
        when it timed out.  The value of this object is reported
        as 0 when it is not possible to transmit a probe."))

(defoid |traceRouteProbeHistoryStatus|
        (|traceRouteProbeHistoryEntry| 7)
  (:type 'object-type)
  (:syntax '|OperationResponseStatus|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The result of a traceroute operation made by a remote
        host for a particular probe."))

(defoid |traceRouteProbeHistoryLastRC|
        (|traceRouteProbeHistoryEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The last implementation-method-specific reply code received.

        Traceroute is usually implemented by transmitting a series of
        probe packets with increasing time-to-live values.  A probe
        packet is a UDP datagram encapsulated into an IP packet.
        Each hop in a path to the target (destination) host rejects
        the probe packets (probe's TTL too small, ICMP reply) until
        either the maximum TTL is exceeded or the target host is
        received."))

(defoid |traceRouteProbeHistoryTime| (|traceRouteProbeHistoryEntry| 9)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Timestamp for when this probe's results were determined."))

(defoid |traceRouteHopsTable| (|traceRouteObjects| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Remote Operations Traceroute Hop Table for
        keeping track of the results of traceroute tests on a
        per-hop basis."))

(defoid |traceRouteHopsEntry| (|traceRouteHopsTable| 1)
  (:type 'object-type)
  (:syntax '|TraceRouteHopsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the traceRouteHopsTable.
        The first two index elements identify the
        traceRouteCtlEntry that a traceRouteHopsEntry
        belongs to.  The third index element,
        traceRouteHopsHopIndex, selects a
        hop in a traceroute path."))

(defclass |TraceRouteHopsEntry|
          (asn.1-type)
          ((|traceRouteHopsHopIndex| :type |Unsigned32|)
           (|traceRouteHopsIpTgtAddressType| :type |InetAddressType|)
           (|traceRouteHopsIpTgtAddress| :type |InetAddress|)
           (|traceRouteHopsMinRtt| :type |Unsigned32|)
           (|traceRouteHopsMaxRtt| :type |Unsigned32|)
           (|traceRouteHopsAverageRtt| :type |Unsigned32|)
           (|traceRouteHopsRttSumOfSquares| :type |Unsigned32|)
           (|traceRouteHopsSentProbes| :type |Unsigned32|)
           (|traceRouteHopsProbeResponses| :type |Unsigned32|)
           (|traceRouteHopsLastGoodProbe| :type |DateAndTime|)))

(defoid |traceRouteHopsHopIndex| (|traceRouteHopsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Specifies the hop index for a traceroute hop.  Values
        for this object with respect to the same
        traceRouteCtlOwnerIndex and traceRouteCtlTestName
        MUST start at 1 and be given increasing values for
        subsequent hops.  The value of traceRouteHopsHopIndex is not
        necessarily the number of the hop on the traced path.

        The traceRouteHopsTable keeps the current traceroute
        path per traceRouteCtlEntry if enabled by
        setting the corresponding traceRouteCtlCreateHopsEntries
        to true(1).

        All hops (traceRouteHopsTable entries) in a traceroute
        path MUST be updated at the same time when a traceroute
        operation is completed.  Care needs to be applied when a path
        either changes or can't be determined.  The initial portion
        of the path, up to the first hop change, MUST retain the
        same traceRouteHopsHopIndex values.  The remaining portion
        of the path SHOULD be assigned new traceRouteHopsHopIndex
        values."))

(defoid |traceRouteHopsIpTgtAddressType| (|traceRouteHopsEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object indicates the type of address stored
        in the corresponding traceRouteHopsIpTgtAddress
        object."))

(defoid |traceRouteHopsIpTgtAddress| (|traceRouteHopsEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object reports the IP address associated with

        the hop.  A value for this object should be reported
        as a numeric IP address, not as a DNS name.

        The address type (InetAddressType) that relates to
        this object is specified by the corresponding value
        of pingCtlSourceAddressType."))

(defoid |traceRouteHopsMinRtt| (|traceRouteHopsEntry| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum traceroute round-trip-time (RTT) received for
        this hop.  A value of 0 for this object implies that no
        RTT has been received."))

(defoid |traceRouteHopsMaxRtt| (|traceRouteHopsEntry| 5)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum traceroute round-trip-time (RTT) received for
        this hop.  A value of 0 for this object implies that no
        RTT has been received."))

(defoid |traceRouteHopsAverageRtt| (|traceRouteHopsEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current average traceroute round-trip-time (RTT) for
        this hop."))

(defoid |traceRouteHopsRttSumOfSquares| (|traceRouteHopsEntry| 7)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object contains the sum of the squares of all
        round-trip-times received for this hop.  Its purpose is
        to enable standard deviation calculation."))

(defoid |traceRouteHopsSentProbes| (|traceRouteHopsEntry| 8)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object reflects the number of probes sent
        for this hop during this traceroute test.  The value of this
        object should start at 0."))

(defoid |traceRouteHopsProbeResponses| (|traceRouteHopsEntry| 9)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Number of responses received for this hop during this
        traceroute test.  This value of this object should start
        at 0."))

(defoid |traceRouteHopsLastGoodProbe| (|traceRouteHopsEntry| 10)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Date and time at which the last response was received for a
         probe for this hop during this traceroute test."))

(defoid |traceRoutePathChange| (|traceRouteNotifications| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description "The path to a target has changed."))

(defoid |traceRouteTestFailed| (|traceRouteNotifications| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description "Could not determine the path to a target."))

(defoid |traceRouteTestCompleted| (|traceRouteNotifications| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description "The path to a target has just been determined."))

(defoid |traceRouteCompliances| (|traceRouteConformance| 1)
  (:type 'object-identity))

(defoid |traceRouteGroups| (|traceRouteConformance| 2)
  (:type 'object-identity))

(defoid |traceRouteFullCompliance| (|traceRouteCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities that
            fully implement the DISMAN-TRACEROUTE-MIB."))

(defoid |traceRouteMinimumCompliance| (|traceRouteCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The minimum compliance statement for SNMP entities
            which implement the minimal subset of the
            DISMAN-TRACEROUTE-MIB.  Implementors might choose this
            subset for small devices with limited resources."))

(defoid |traceRouteCompliance| (|traceRouteCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for the DISMAN-TRACEROUTE-MIB.
            This compliance statement has been deprecated because
            the traceRouteGroup and the traceRouteTimeStampGroup
            have been split and deprecated. The
            traceRouteFullCompliance is semantically identical to the
            deprecated traceRouteCompliance statement."))

(defoid |traceRouteMinimumGroup| (|traceRouteGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects that constitute the remote traceroute
       operation."))

(defoid |traceRouteCtlRowStatusGroup| (|traceRouteGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RowStatus object of the traceRouteCtlTable."))

(defoid |traceRouteHistoryGroup| (|traceRouteGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects that constitute the history
       capability."))

(defoid |traceRouteNotificationsGroup| (|traceRouteGroups| 3)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "The notifications that are required to be supported by
       implementations of this MIB."))

(defoid |traceRouteHopsTableGroup| (|traceRouteGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects that constitute the
        traceRouteHopsTable."))

(defoid |traceRouteGroup| (|traceRouteGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The group of objects that constitute the remote traceroute
       operation."))

(defoid |traceRouteTimeStampGroup| (|traceRouteGroups| 2)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description "The group of DateAndTime objects."))

(eval-when (:load-toplevel :execute)
  (pushnew 'disman-traceroute-mib *mib-modules*)
  (setf *current-module* nil))

