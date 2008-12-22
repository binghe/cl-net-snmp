;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;DISMAN-NSLOOKUP-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'disman-nslookup-mib *mib-modules*))
(setf *current-module* 'disman-nslookup-mib)
(defpackage :asn.1/disman-nslookup-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Unsigned32| |mib-2| |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :asn.1/inet-address-mib |InetAddressType|
                |InetAddress|))
(in-package :asn.1/disman-nslookup-mib)
(defoid |lookupMIB| (|mib-2| 82)
  (:type 'module-identity)
  (:description
   "The Lookup MIB (DISMAN-NSLOOKUP-MIB) enables determination
        of either the name(s) corresponding to a host address or of
        the address(es) associated with a host name at a remote
        host.

        Copyright (C) The Internet Society (2006).  This version of
        this MIB module is part of RFC 4560; see the RFC itself for
        full legal notices."))
(defoid |lookupObjects| (|lookupMIB| 1) (:type 'object-identity))
(defoid |lookupConformance| (|lookupMIB| 2) (:type 'object-identity))
(defoid |lookupMaxConcurrentRequests| (|lookupObjects| 1)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The maximum number of concurrent active lookup requests
       that are allowed within an agent implementation.  A value
       of 0 for this object implies that there is no limit for
       the number of concurrent active requests in effect.

       The limit applies only to new requests being activated.
       When a new value is set, the agent will continue processing
       all the requests already active, even if their number
       exceed the limit just imposed."))
(defoid |lookupPurgeTime| (|lookupObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The amount of time to wait before automatically
       deleting an entry in the lookupCtlTable and any
       dependent lookupResultsTable entries
       after the lookup operation represented by a
       lookupCtlEntry has been completed.
       A lookupCtEntry is considered complete
       when its lookupCtlOperStatus object has a
       value of completed(3).

       A value of 0 indicates that automatic deletion
       of entries is disabled."))
(defoid |lookupCtlTable| (|lookupObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Lookup Control Table for providing
        the capability of performing a lookup operation
        for a symbolic host name or for a host address
        from a remote host."))
(defoid |lookupCtlEntry| (|lookupCtlTable| 1)
  (:type 'object-type)
  (:syntax '|LookupCtlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the lookupCtlTable.  A
        lookupCtlEntry is initially indexed by
        lookupCtlOwnerIndex, which is a type of SnmpAdminString,
        a textual convention that allows for the use of the SNMPv3
        View-Based Access Control Model (RFC 3415, VACM)
        and that also allows a management application to identify
        its entries.  The second index element,
        lookupCtlOperationName, enables the same
        lookupCtlOwnerIndex entity to have multiple outstanding
        requests.  The value of lookupCtlTargetAddressType
        determines which lookup function to perform."))
(deftype |LookupCtlEntry| () 't)
(defoid |lookupCtlOwnerIndex| (|lookupCtlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "To facilitate the provisioning of access control by a
       security administrator using the View-Based Access
       Control Model (RFC 2575, VACM) for tables in which
       multiple users may need to create or
       modify entries independently, the initial index is used as
       an 'owner index'.  Such an initial index has a syntax of
       SnmpAdminString and can thus be trivially mapped to a

       securityName or groupName defined in VACM, in
       accordance with a security policy.

       When used in conjunction with such a security policy all
       entries in the table belonging to a particular user (or
       group) will have the same value for this initial index.
       For a given user's entries in a particular table, the
       object identifiers for the information in these entries
       will have the same subidentifiers (except for the
       'column' subidentifier) up to the end of the encoded
       owner index.  To configure VACM to permit access to this
       portion of the table, one would create
       vacmViewTreeFamilyTable entries with the value of
       vacmViewTreeFamilySubtree including the owner index
       portion, and vacmViewTreeFamilyMask 'wildcarding' the
       column subidentifier.  More elaborate configurations
       are possible."))
(defoid |lookupCtlOperationName| (|lookupCtlEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The name of a lookup operation.  This is locally unique,
        within the scope of an lookupCtlOwnerIndex."))
(defoid |lookupCtlTargetAddressType| (|lookupCtlEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the type of address for performing a
        lookup operation for a symbolic host name or for a host
        address from a remote host.

        Specification of dns(16) as the value for this object
        means that a function such as, for example, getaddrinfo()
        or gethostbyname() should be performed to return one or
        more numeric addresses.  Use of a value of either ipv4(1)
        or ipv6(2) means that a functions such as, for example,
        getnameinfo() or gethostbyaddr() should be used to return
        the symbolic names associated with a host."))
(defoid |lookupCtlTargetAddress| (|lookupCtlEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Specifies the address used for a resolver lookup at a
        remote host.  The corresponding lookupCtlTargetAddressType
        objects determines its type, as well as the function
        that can be requested.

        A value for this object MUST be set prior to
        transitioning its corresponding lookupCtlEntry to
        active(1) via lookupCtlRowStatus."))
(defoid |lookupCtlOperStatus| (|lookupCtlEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reflects the operational state of an lookupCtlEntry:

           enabled(1)    - Operation is active.
           notStarted(2) - Operation has not been enabled.
           completed(3)  - Operation has been completed.

         An operation is automatically enabled(1) when its
         lookupCtlRowStatus object is transitioned to active(1)
         status.  Until this occurs, lookupCtlOperStatus MUST
         report a value of notStarted(2).  After the lookup
         operation is completed (success or failure), the value
         for lookupCtlOperStatus MUST be transitioned to
         completed(3)."))
(defoid |lookupCtlTime| (|lookupCtlEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reports the number of milliseconds that a lookup
        operation required to be completed at a remote host.
        Completed means operation failure as well as

        success."))
(defoid |lookupCtlRc| (|lookupCtlEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The system-specific return code from a lookup
        operation.  All implementations MUST return a value
        of 0 for this object when the remote lookup
        operation succeeds.  A non-zero value for this
        objects indicates failure.  It is recommended that
        implementations return the error codes that are
        generated by the lookup function used."))
(defoid |lookupCtlRowStatus| (|lookupCtlEntry| 8)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object allows entries to be created and deleted
        in the lookupCtlTable.

        A remote lookup operation is started when an
        entry in this table is created via an SNMP set
        request and the entry is activated.  This
        occurs by setting the value of this object
        to CreateAndGo(4) during row creation or
        by setting this object to active(1) after
        the row is created.

        A value MUST be specified for lookupCtlTargetAddress
        prior to the acceptance of a transition to active(1) state.
        A remote lookup operation starts when its entry
        first becomes active(1).  Transitions in and
        out of active(1) state have no effect on the
        operational behavior of a remote lookup
        operation, with the exception that deletion of
        an entry in this table by setting its RowStatus
        object to destroy(6) will stop an active
        remote lookup operation.

        The operational state of a remote lookup operation
        can be determined by examination of its
        lookupCtlOperStatus object."))
(defoid |lookupResultsTable| (|lookupObjects| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines the Lookup Results Table for providing
        the capability of determining the results of a
        operation at a remote host.

        One or more entries are added to the
        lookupResultsTable when a lookup operation,
        as reflected by an lookupCtlEntry, is completed
        successfully.  All entries related to a
        successful lookup operation MUST be added
        to the lookupResultsTable at the same time
        that the associating lookupCtlOperStatus
        object is transitioned to completed(2).

        The number of entries added depends on the
        results determined for a particular lookup
        operation.  All entries associated with an
        lookupCtlEntry are removed when the
        lookupCtlEntry is deleted.

        A remote host can be multi-homed and have more than one IP
        address associated with it (returned by lookup function),
        or it can have more than one symbolic name (returned
        by lookup function).

        A function such as, for example, getnameinfo() or
        gethostbyaddr() is called with a host address as its
        parameter and is used primarily to determine a symbolic
        name to associate with the host address.  Entries in the
        lookupResultsTable MUST be made for each host name
        returned.  If the function identifies an 'official host
        name,' then this symbolic name MUST be assigned a
        lookupResultsIndex of 1.

        A function such as, for example, getaddrinfo() or
        gethostbyname() is called with a symbolic host name and is
        used primarily to retrieve a host address.  The entries

        MUST be stored in the order that they are retrieved from
        the lookup function.  lookupResultsIndex 1 MUST be
        assigned to the first entry."))
(defoid |lookupResultsEntry| (|lookupResultsTable| 1)
  (:type 'object-type)
  (:syntax '|LookupResultsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Defines an entry in the lookupResultsTable.  The
        first two index elements identify the
        lookupCtlEntry that a lookupResultsEntry belongs
        to.  The third index element selects a single
        lookup operation result."))
(deftype |LookupResultsEntry| () 't)
(defoid |lookupResultsIndex| (|lookupResultsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Entries in the lookupResultsTable are created when
        the result of a lookup operation is determined.

        Entries MUST be stored in the lookupResultsTable in
        the order that they are retrieved.  Values assigned
        to lookupResultsIndex MUST start at 1 and increase
        consecutively."))
(defoid |lookupResultsAddressType| (|lookupResultsEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Indicates the type of result of a remote lookup
        operation.  A value of unknown(0) implies either that
        the operation hasn't been started or that
        it has failed."))
(defoid |lookupResultsAddress| (|lookupResultsEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reflects a result for a remote lookup operation
        as per the value of lookupResultsAddressType.

        The address type (InetAddressType) that relates to
        this object is specified by the corresponding value
        of lookupResultsAddress."))
(defoid |lookupCompliances| (|lookupConformance| 1)
  (:type 'object-identity))
(defoid |lookupGroups| (|lookupConformance| 2) (:type 'object-identity))
(defoid |lookupCompliance| (|lookupCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities that
            fully implement the DISMAN-NSLOOKUP-MIB."))
(defoid |lookupMinimumCompliance| (|lookupCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The minimum compliance statement for SNMP entities
            that implement the minimal subset of the
            DISMAN-NSLOOKUP-MIB.  Implementors might choose this
            subset for small devices with limited resources."))
(defoid |lookupGroup| (|lookupGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects that constitute the remote
       Lookup operation."))
