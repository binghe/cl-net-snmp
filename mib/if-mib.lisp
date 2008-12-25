;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IF-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'if-mib *mib-modules*)
  (setf *current-module* 'if-mib))

(defpackage :asn.1/if-mib
  (:nicknames :if-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Counter32| |Gauge32| |Counter64| |Integer32|
                |TimeTicks| |mib-2| notification-type)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |DisplayString|
                |PhysAddress| |TruthValue| |RowStatus| |TimeStamp|
                |AutonomousType| |TestAndIncr|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :|ASN.1/SNMPv2-MIB| |snmpTraps|)
  (:import-from :|ASN.1/IANAifType-MIB| |IANAifType|))

(in-package :if-mib)

(defoid |ifMIB| (|mib-2| 31)
  (:type 'module-identity)
  (:description
   "The MIB module to describe generic objects for network
            interface sub-layers.  This MIB is an updated version of
            MIB-II's ifTable, and incorporates the extensions defined in
            RFC 1229."))

(defoid |ifMIBObjects| (|ifMIB| 1) (:type 'object-identity))

(defoid |interfaces| (|mib-2| 2) (:type 'object-identity))

(deftype |OwnerString| () 't)

(deftype |InterfaceIndex| () 't)

(deftype |InterfaceIndexOrZero| () 't)

(defoid |ifNumber| (|interfaces| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of network interfaces (regardless of their
            current state) present on this system."))

(defoid |ifTableLastChange| (|ifMIBObjects| 5)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time of the last creation or
            deletion of an entry in the ifTable.  If the number of
            entries has been unchanged since the last re-initialization
            of the local network management subsystem, then this object
            contains a zero value."))

(defoid |ifTable| (|interfaces| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of interface entries.  The number of entries is
            given by the value of ifNumber."))

(defoid |ifEntry| (|ifTable| 1)
  (:type 'object-type)
  (:syntax '|IfEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing management information applicable to a
            particular interface."))

(deftype |IfEntry| () 't)

(defoid |ifIndex| (|ifEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value, greater than zero, for each interface.  It
            is recommended that values are assigned contiguously
            starting from 1.  The value for each interface sub-layer
            must remain constant at least from one re-initialization of
            the entity's network management system to the next re-
            initialization."))

(defoid |ifDescr| (|ifEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual string containing information about the
            interface.  This string should include the name of the
            manufacturer, the product name and the version of the
            interface hardware/software."))

(defoid |ifType| (|ifEntry| 3)
  (:type 'object-type)
  (:syntax '|IANAifType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type of interface.  Additional values for ifType are
            assigned by the Internet Assigned Numbers Authority (IANA),
            through updating the syntax of the IANAifType textual
            convention."))

(defoid |ifMtu| (|ifEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The size of the largest packet which can be sent/received
            on the interface, specified in octets.  For interfaces that
            are used for transmitting network datagrams, this is the
            size of the largest network datagram that can be sent on the
            interface."))

(defoid |ifSpeed| (|ifEntry| 5)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An estimate of the interface's current bandwidth in bits
            per second.  For interfaces which do not vary in bandwidth
            or for those where no accurate estimation can be made, this
            object should contain the nominal bandwidth.  If the
            bandwidth of the interface is greater than the maximum value
            reportable by this object then this object should report its
            maximum value (4,294,967,295) and ifHighSpeed must be used
            to report the interace's speed.  For a sub-layer which has
            no concept of bandwidth, this object should be zero."))

(defoid |ifPhysAddress| (|ifEntry| 6)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The interface's address at its protocol sub-layer.  For
            example, for an 802.x interface, this object normally
            contains a MAC address.  The interface's media-specific MIB
            must define the bit and byte ordering and the format of the
            value of this object.  For interfaces which do not have such
            an address (e.g., a serial line), this object should contain
            an octet string of zero length."))

(defoid |ifAdminStatus| (|ifEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The desired state of the interface.  The testing(3) state
            indicates that no operational packets can be passed.  When a
            managed system initializes, all interfaces start with
            ifAdminStatus in the down(2) state.  As a result of either
            explicit management action or per configuration information
            retained by the managed system, ifAdminStatus is then
            changed to either the up(1) or testing(3) states (or remains
            in the down(2) state)."))

(defoid |ifOperStatus| (|ifEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current operational state of the interface.  The
            testing(3) state indicates that no operational packets can
            be passed.  If ifAdminStatus is down(2) then ifOperStatus
            should be down(2).  If ifAdminStatus is changed to up(1)
            then ifOperStatus should change to up(1) if the interface is
            ready to transmit and receive network traffic; it should
            change to dormant(5) if the interface is waiting for
            external actions (such as a serial line waiting for an
            incoming connection); it should remain in the down(2) state
            if and only if there is a fault that prevents it from going
            to the up(1) state; it should remain in the notPresent(6)
            state if the interface has missing (typically, hardware)
            components."))

(defoid |ifLastChange| (|ifEntry| 9)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time the interface entered
            its current operational state.  If the current state was
            entered prior to the last re-initialization of the local
            network management subsystem, then this object contains a
            zero value."))

(defoid |ifInOctets| (|ifEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received on the interface,
            including framing characters.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifInUcastPkts| (|ifEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were not addressed to a multicast
            or broadcast address at this sub-layer.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifInNUcastPkts| (|ifEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were addressed to a multicast or
            broadcast address at this sub-layer.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime.

            This object is deprecated in favour of ifInMulticastPkts and
            ifInBroadcastPkts."))

(defoid |ifInDiscards| (|ifEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of inbound packets which were chosen to be
            discarded even though no errors had been detected to prevent

            their being deliverable to a higher-layer protocol.  One
            possible reason for discarding such a packet could be to
            free up buffer space.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifInErrors| (|ifEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For packet-oriented interfaces, the number of inbound
            packets that contained errors preventing them from being
            deliverable to a higher-layer protocol.  For character-
            oriented or fixed-length interfaces, the number of inbound
            transmission units that contained errors preventing them
            from being deliverable to a higher-layer protocol.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifInUnknownProtos| (|ifEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For packet-oriented interfaces, the number of packets
            received via the interface which were discarded because of
            an unknown or unsupported protocol.  For character-oriented
            or fixed-length interfaces that support protocol
            multiplexing the number of transmission units received via
            the interface which were discarded because of an unknown or
            unsupported protocol.  For any interface that does not
            support protocol multiplexing, this counter will always be
            0.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutOctets| (|ifEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets transmitted out of the
            interface, including framing characters.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutUcastPkts| (|ifEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were not addressed to a
            multicast or broadcast address at this sub-layer, including
            those that were discarded or not sent.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutNUcastPkts| (|ifEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were addressed to a
            multicast or broadcast address at this sub-layer, including
            those that were discarded or not sent.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime.

            This object is deprecated in favour of ifOutMulticastPkts
            and ifOutBroadcastPkts."))

(defoid |ifOutDiscards| (|ifEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of outbound packets which were chosen to be
            discarded even though no errors had been detected to prevent
            their being transmitted.  One possible reason for discarding
            such a packet could be to free up buffer space.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutErrors| (|ifEntry| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For packet-oriented interfaces, the number of outbound
            packets that could not be transmitted because of errors.
            For character-oriented or fixed-length interfaces, the
            number of outbound transmission units that could not be
            transmitted because of errors.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutQLen| (|ifEntry| 21)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description "The length of the output packet queue (in packets)."))

(defoid |ifSpecific| (|ifEntry| 22)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "A reference to MIB definitions specific to the particular
            media being used to realize the interface.  It is

            recommended that this value point to an instance of a MIB
            object in the media-specific MIB, i.e., that this object
            have the semantics associated with the InstancePointer
            textual convention defined in RFC 2579.  In fact, it is
            recommended that the media-specific MIB specify what value
            ifSpecific should/can take for values of ifType.  If no MIB
            definitions specific to the particular media are available,
            the value should be set to the OBJECT IDENTIFIER { 0 0 }."))

(defoid |ifXTable| (|ifMIBObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of interface entries.  The number of entries is
            given by the value of ifNumber.  This table contains
            additional objects for the interface table."))

(defoid |ifXEntry| (|ifXTable| 1)
  (:type 'object-type)
  (:syntax '|IfXEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing additional management information
            applicable to a particular interface."))

(deftype |IfXEntry| () 't)

(defoid |ifName| (|ifXEntry| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The textual name of the interface.  The value of this
            object should be the name of the interface as assigned by
            the local device and should be suitable for use in commands
            entered at the device's `console'.  This might be a text
            name, such as `le0' or a simple port number, such as `1',
            depending on the interface naming syntax of the device.  If
            several entries in the ifTable together represent a single
            interface as named by the device, then each will have the
            same value of ifName.  Note that for an agent which responds
            to SNMP queries concerning an interface on some other
            (proxied) device, then the value of ifName for such an
            interface is the proxied device's local name for it.

            If there is no local name, or this object is otherwise not
            applicable, then this object contains a zero-length string."))

(defoid |ifInMulticastPkts| (|ifXEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were addressed to a multicast
            address at this sub-layer.  For a MAC layer protocol, this
            includes both Group and Functional addresses.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other

            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifInBroadcastPkts| (|ifXEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were addressed to a broadcast
            address at this sub-layer.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutMulticastPkts| (|ifXEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were addressed to a
            multicast address at this sub-layer, including those that
            were discarded or not sent.  For a MAC layer protocol, this
            includes both Group and Functional addresses.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifOutBroadcastPkts| (|ifXEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were addressed to a
            broadcast address at this sub-layer, including those that
            were discarded or not sent.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other

            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCInOctets| (|ifXEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received on the interface,
            including framing characters.  This object is a 64-bit
            version of ifInOctets.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCInUcastPkts| (|ifXEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were not addressed to a multicast
            or broadcast address at this sub-layer.  This object is a
            64-bit version of ifInUcastPkts.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCInMulticastPkts| (|ifXEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were addressed to a multicast
            address at this sub-layer.  For a MAC layer protocol, this
            includes both Group and Functional addresses.  This object
            is a 64-bit version of ifInMulticastPkts.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCInBroadcastPkts| (|ifXEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, delivered by this sub-layer to a
            higher (sub-)layer, which were addressed to a broadcast
            address at this sub-layer.  This object is a 64-bit version
            of ifInBroadcastPkts.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCOutOctets| (|ifXEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets transmitted out of the
            interface, including framing characters.  This object is a
            64-bit version of ifOutOctets.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCOutUcastPkts| (|ifXEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were not addressed to a
            multicast or broadcast address at this sub-layer, including
            those that were discarded or not sent.  This object is a
            64-bit version of ifOutUcastPkts.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCOutMulticastPkts| (|ifXEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were addressed to a
            multicast address at this sub-layer, including those that
            were discarded or not sent.  For a MAC layer protocol, this
            includes both Group and Functional addresses.  This object
            is a 64-bit version of ifOutMulticastPkts.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifHCOutBroadcastPkts| (|ifXEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets that higher-level protocols
            requested be transmitted, and which were addressed to a
            broadcast address at this sub-layer, including those that
            were discarded or not sent.  This object is a 64-bit version
            of ifOutBroadcastPkts.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ifCounterDiscontinuityTime."))

(defoid |ifLinkUpDownTrapEnable| (|ifXEntry| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Indicates whether linkUp/linkDown traps should be generated
            for this interface.

            By default, this object should have the value enabled(1) for
            interfaces which do not operate on 'top' of any other
            interface (as defined in the ifStackTable), and disabled(2)
            otherwise."))

(defoid |ifHighSpeed| (|ifXEntry| 15)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An estimate of the interface's current bandwidth in units
            of 1,000,000 bits per second.  If this object reports a
            value of `n' then the speed of the interface is somewhere in
            the range of `n-500,000' to `n+499,999'.  For interfaces
            which do not vary in bandwidth or for those where no
            accurate estimation can be made, this object should contain
            the nominal bandwidth.  For a sub-layer which has no concept
            of bandwidth, this object should be zero."))

(defoid |ifPromiscuousMode| (|ifXEntry| 16)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This object has a value of false(2) if this interface only
            accepts packets/frames that are addressed to this station.
            This object has a value of true(1) when the station accepts
            all packets/frames transmitted on the media.  The value
            true(1) is only legal on certain types of media.  If legal,
            setting this object to a value of true(1) may require the
            interface to be reset before becoming effective.

            The value of ifPromiscuousMode does not affect the reception
            of broadcast and multicast packets/frames by the interface."))

(defoid |ifConnectorPresent| (|ifXEntry| 17)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object has the value 'true(1)' if the interface
            sublayer has a physical connector and the value 'false(2)'
            otherwise."))

(defoid |ifAlias| (|ifXEntry| 18)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This object is an 'alias' name for the interface as
            specified by a network manager, and provides a non-volatile
            'handle' for the interface.

            On the first instantiation of an interface, the value of
            ifAlias associated with that interface is the zero-length
            string.  As and when a value is written into an instance of
            ifAlias through a network management set operation, then the
            agent must retain the supplied value in the ifAlias instance
            associated with the same interface for as long as that
            interface remains instantiated, including across all re-
            initializations/reboots of the network management system,
            including those which result in a change of the interface's
            ifIndex value.

            An example of the value which a network manager might store
            in this object for a WAN interface is the (Telco's) circuit
            number/identifier of the interface.

            Some agents may support write-access only for interfaces
            having particular values of ifType.  An agent which supports
            write access to this object is required to keep the value in
            non-volatile storage, but it may limit the length of new
            values depending on how much storage is already occupied by
            the current values for other interfaces."))

(defoid |ifCounterDiscontinuityTime| (|ifXEntry| 19)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
            any one or more of this interface's counters suffered a
            discontinuity.  The relevant counters are the specific
            instances associated with this interface of any Counter32 or

            Counter64 object contained in the ifTable or ifXTable.  If
            no such discontinuities have occurred since the last re-
            initialization of the local management subsystem, then this
            object contains a zero value."))

(defoid |ifStackTable| (|ifMIBObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table containing information on the relationships
            between the multiple sub-layers of network interfaces.  In
            particular, it contains information on which sub-layers run
            'on top of' which other sub-layers, where each sub-layer
            corresponds to a conceptual row in the ifTable.  For
            example, when the sub-layer with ifIndex value x runs over
            the sub-layer with ifIndex value y, then this table
            contains:

              ifStackStatus.x.y=active

            For each ifIndex value, I, which identifies an active
            interface, there are always at least two instantiated rows
            in this table associated with I.  For one of these rows, I
            is the value of ifStackHigherLayer; for the other, I is the
            value of ifStackLowerLayer.  (If I is not involved in
            multiplexing, then these are the only two rows associated
            with I.)

            For example, two rows exist even for an interface which has
            no others stacked on top or below it:

              ifStackStatus.0.x=active
              ifStackStatus.x.0=active "))

(defoid |ifStackEntry| (|ifStackTable| 1)
  (:type 'object-type)
  (:syntax '|IfStackEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information on a particular relationship between two sub-
            layers, specifying that one sub-layer runs on 'top' of the
            other sub-layer.  Each sub-layer corresponds to a conceptual
            row in the ifTable."))

(deftype |IfStackEntry| () 't)

(defoid |ifStackHigherLayer| (|ifStackEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The value of ifIndex corresponding to the higher sub-layer
            of the relationship, i.e., the sub-layer which runs on 'top'
            of the sub-layer identified by the corresponding instance of
            ifStackLowerLayer.  If there is no higher sub-layer (below
            the internetwork layer), then this object has the value 0."))

(defoid |ifStackLowerLayer| (|ifStackEntry| 2)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The value of ifIndex corresponding to the lower sub-layer
            of the relationship, i.e., the sub-layer which runs 'below'
            the sub-layer identified by the corresponding instance of
            ifStackHigherLayer.  If there is no lower sub-layer, then
            this object has the value 0."))

(defoid |ifStackStatus| (|ifStackEntry| 3)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of the relationship between two sub-layers.

            Changing the value of this object from 'active' to
            'notInService' or 'destroy' will likely have consequences up
            and down the interface stack.  Thus, write access to this
            object is likely to be inappropriate for some types of
            interfaces, and many implementations will choose not to
            support write-access for any type of interface."))

(defoid |ifStackLastChange| (|ifMIBObjects| 6)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time of the last change of
            the (whole) interface stack.  A change of the interface
            stack is defined to be any creation, deletion, or change in
            value of any instance of ifStackStatus.  If the interface
            stack has been unchanged since the last re-initialization of
            the local network management subsystem, then this object
            contains a zero value."))

(defoid |ifRcvAddressTable| (|ifMIBObjects| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table contains an entry for each address (broadcast,
            multicast, or uni-cast) for which the system will receive
            packets/frames on a particular interface, except as follows:

            - for an interface operating in promiscuous mode, entries
            are only required for those addresses for which the system
            would receive frames were it not operating in promiscuous
            mode.

            - for 802.5 functional addresses, only one entry is
            required, for the address which has the functional address
            bit ANDed with the bit mask of all functional addresses for
            which the interface will accept frames.

            A system is normally able to use any unicast address which
            corresponds to an entry in this table as a source address."))

(defoid |ifRcvAddressEntry| (|ifRcvAddressTable| 1)
  (:type 'object-type)
  (:syntax '|IfRcvAddressEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of objects identifying an address for which the
            system will accept packets/frames on the particular
            interface identified by the index value ifIndex."))

(deftype |IfRcvAddressEntry| () 't)

(defoid |ifRcvAddressAddress| (|ifRcvAddressEntry| 1)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An address for which the system will accept packets/frames
            on this entry's interface."))

(defoid |ifRcvAddressStatus| (|ifRcvAddressEntry| 2)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object is used to create and delete rows in the
            ifRcvAddressTable."))

(defoid |ifRcvAddressType| (|ifRcvAddressEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object has the value nonVolatile(3) for those entries
            in the table which are valid and will not be deleted by the
            next restart of the managed system.  Entries having the
            value volatile(2) are valid and exist, but have not been
            saved, so that will not exist after the next restart of the
            managed system.  Entries having the value other(1) are valid
            and exist but are not classified as to whether they will
            continue to exist after the next restart."))

(defoid |linkDown| (|snmpTraps| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "A linkDown trap signifies that the SNMP entity, acting in
            an agent role, has detected that the ifOperStatus object for
            one of its communication links is about to enter the down
            state from some other state (but not from the notPresent
            state).  This other state is indicated by the included value
            of ifOperStatus."))

(defoid |linkUp| (|snmpTraps| 4)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "A linkUp trap signifies that the SNMP entity, acting in an
            agent role, has detected that the ifOperStatus object for
            one of its communication links left the down state and
            transitioned into some other state (but not into the
            notPresent state).  This other state is indicated by the
            included value of ifOperStatus."))

(defoid |ifConformance| (|ifMIB| 2) (:type 'object-identity))

(defoid |ifGroups| (|ifConformance| 1) (:type 'object-identity))

(defoid |ifCompliances| (|ifConformance| 2) (:type 'object-identity))

(defoid |ifCompliance3| (|ifCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which have
            network interfaces."))

(defoid |ifGeneralInformationGroup| (|ifGroups| 10)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information applicable to
            all network interfaces."))

(defoid |ifFixedLengthGroup| (|ifGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information specific to
            non-high speed (non-high speed interfaces transmit and
            receive at speeds less than or equal to 20,000,000
            bits/second) character-oriented or fixed-length-transmission
            network interfaces."))

(defoid |ifHCFixedLengthGroup| (|ifGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information specific to
            high speed (greater than 20,000,000 bits/second) character-
            oriented or fixed-length-transmission network interfaces."))

(defoid |ifPacketGroup| (|ifGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information specific to
            non-high speed (non-high speed interfaces transmit and
            receive at speeds less than or equal to 20,000,000
            bits/second) packet-oriented network interfaces."))

(defoid |ifHCPacketGroup| (|ifGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information specific to
            high speed (greater than 20,000,000 bits/second but less
            than or equal to 650,000,000 bits/second) packet-oriented
            network interfaces."))

(defoid |ifVHCPacketGroup| (|ifGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information specific to
            higher speed (greater than 650,000,000 bits/second) packet-
            oriented network interfaces."))

(defoid |ifRcvAddressGroup| (|ifGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information on the
            multiple addresses which an interface receives."))

(defoid |ifStackGroup2| (|ifGroups| 11)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information on the
            layering of MIB-II interfaces."))

(defoid |ifCounterDiscontinuityGroup| (|ifGroups| 13)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information specific to
            interface counter discontinuities."))

(defoid |linkUpDownNotificationsGroup| (|ifGroups| 14)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "The notifications which indicate specific changes in the
            value of ifOperStatus."))

(defoid |ifTestTable| (|ifMIBObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "This table contains one entry per interface.  It defines
            objects which allow a network manager to instruct an agent
            to test an interface for various faults.  Tests for an
            interface are defined in the media-specific MIB for that
            interface.  After invoking a test, the object ifTestResult
            can be read to determine the outcome.  If an agent can not
            perform the test, ifTestResult is set to so indicate.  The
            object ifTestCode can be used to provide further test-
            specific or interface-specific (or even enterprise-specific)
            information concerning the outcome of the test.  Only one
            test can be in progress on each interface at any one time.
            If one test is in progress when another test is invoked, the
            second test is rejected.  Some agents may reject a test when
            a prior test is active on another interface.

            Before starting a test, a manager-station must first obtain
            'ownership' of the entry in the ifTestTable for the
            interface to be tested.  This is accomplished with the
            ifTestId and ifTestStatus objects as follows:

          try_again:
              get (ifTestId, ifTestStatus)
              while (ifTestStatus != notInUse)
                  /*
                   * Loop while a test is running or some other
                   * manager is configuring a test.
                   */
                  short delay
                  get (ifTestId, ifTestStatus)
              }

              /*
               * Is not being used right now -- let's compete
               * to see who gets it.
               */
              lock_value = ifTestId

              if ( set(ifTestId = lock_value, ifTestStatus = inUse,
                       ifTestOwner = 'my-IP-address') == FAILURE)
                  /*
                   * Another manager got the ifTestEntry -- go
                   * try again
                   */
                  goto try_again;

              /*
               * I have the lock
               */
              set up any test parameters.

              /*
               * This starts the test
               */
              set(ifTestType = test_to_run);

              wait for test completion by polling ifTestResult

              when test completes, agent sets ifTestResult
                   agent also sets ifTestStatus = 'notInUse'

              retrieve any additional test results, and ifTestId

              if (ifTestId == lock_value+1) results are valid

            A manager station first retrieves the value of the
            appropriate ifTestId and ifTestStatus objects, periodically
            repeating the retrieval if necessary, until the value of
            ifTestStatus is 'notInUse'.  The manager station then tries
            to set the same ifTestId object to the value it just
            retrieved, the same ifTestStatus object to 'inUse', and the
            corresponding ifTestOwner object to a value indicating
            itself.  If the set operation succeeds then the manager has
            obtained ownership of the ifTestEntry, and the value of the
            ifTestId object is incremented by the agent (per the
            semantics of TestAndIncr).  Failure of the set operation
            indicates that some other manager has obtained ownership of
            the ifTestEntry.

            Once ownership is obtained, any test parameters can be
            setup, and then the test is initiated by setting ifTestType.
            On completion of the test, the agent sets ifTestStatus to
            'notInUse'.  Once this occurs, the manager can retrieve the
            results.  In the (rare) event that the invocation of tests
            by two network managers were to overlap, then there would be
            a possibility that the first test's results might be
            overwritten by the second test's results prior to the first

            results being read.  This unlikely circumstance can be
            detected by a network manager retrieving ifTestId at the
            same time as retrieving the test results, and ensuring that
            the results are for the desired request.

            If ifTestType is not set within an abnormally long period of
            time after ownership is obtained, the agent should time-out
            the manager, and reset the value of the ifTestStatus object
            back to 'notInUse'.  It is suggested that this time-out
            period be 5 minutes.

            In general, a management station must not retransmit a
            request to invoke a test for which it does not receive a
            response; instead, it properly inspects an agent's MIB to
            determine if the invocation was successful.  Only if the
            invocation was unsuccessful, is the invocation request
            retransmitted.

            Some tests may require the interface to be taken off-line in
            order to execute them, or may even require the agent to
            reboot after completion of the test.  In these
            circumstances, communication with the management station
            invoking the test may be lost until after completion of the
            test.  An agent is not required to support such tests.
            However, if such tests are supported, then the agent should
            make every effort to transmit a response to the request
            which invoked the test prior to losing communication.  When
            the agent is restored to normal service, the results of the
            test are properly made available in the appropriate objects.
            Note that this requires that the ifIndex value assigned to
            an interface must be unchanged even if the test causes a
            reboot.  An agent must reject any test for which it cannot,
            perhaps due to resource constraints, make available at least
            the minimum amount of information after that test
            completes."))

(defoid |ifTestEntry| (|ifTestTable| 1)
  (:type 'object-type)
  (:syntax '|IfTestEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "An entry containing objects for invoking tests on an
            interface."))

(deftype |IfTestEntry| () 't)

(defoid |ifTestId| (|ifTestEntry| 1)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|deprecated|)
  (:description
   "This object identifies the current invocation of the
            interface's test."))

(defoid |ifTestStatus| (|ifTestEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|deprecated|)
  (:description
   "This object indicates whether or not some manager currently
            has the necessary 'ownership' required to invoke a test on
            this interface.  A write to this object is only successful
            when it changes its value from 'notInUse(1)' to 'inUse(2)'.
            After completion of a test, the agent resets the value back
            to 'notInUse(1)'."))

(defoid |ifTestType| (|ifTestEntry| 3)
  (:type 'object-type)
  (:syntax '|AutonomousType|)
  (:max-access '|read-write|)
  (:status '|deprecated|)
  (:description
   "A control variable used to start and stop operator-
            initiated interface tests.  Most OBJECT IDENTIFIER values
            assigned to tests are defined elsewhere, in association with
            specific types of interface.  However, this document assigns
            a value for a full-duplex loopback test, and defines the
            special meanings of the subject identifier:

                noTest  OBJECT IDENTIFIER ::= { 0 0 }

            When the value noTest is written to this object, no action
            is taken unless a test is in progress, in which case the
            test is aborted.  Writing any other value to this object is

            only valid when no test is currently in progress, in which
            case the indicated test is initiated.

            When read, this object always returns the most recent value
            that ifTestType was set to.  If it has not been set since
            the last initialization of the network management subsystem
            on the agent, a value of noTest is returned."))

(defoid |ifTestResult| (|ifTestEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "This object contains the result of the most recently
            requested test, or the value none(1) if no tests have been
            requested since the last reset.  Note that this facility
            provides no provision for saving the results of one test
            when starting another, as could be required if used by
            multiple managers concurrently."))

(defoid |ifTestCode| (|ifTestEntry| 5)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "This object contains a code which contains more specific
            information on the test result, for example an error-code
            after a failed test.  Error codes and other values this
            object may take are specific to the type of interface and/or
            test.  The value may have the semantics of either the
            AutonomousType or InstancePointer textual conventions as
            defined in RFC 2579.  The identifier:

                testCodeUnknown  OBJECT IDENTIFIER ::= { 0 0 }

            is defined for use if no additional result code is
            available."))

(defoid |ifTestOwner| (|ifTestEntry| 6)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-write|)
  (:status '|deprecated|)
  (:description
   "The entity which currently has the 'ownership' required to
            invoke a test on this interface."))

(defoid |ifGeneralGroup| (|ifGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects deprecated in favour of
            ifGeneralInformationGroup."))

(defoid |ifTestGroup| (|ifGroups| 8)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing the ability to invoke
            tests on an interface."))

(defoid |ifStackGroup| (|ifGroups| 9)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The previous collection of objects providing information on
            the layering of MIB-II interfaces."))

(defoid |ifOldObjectsGroup| (|ifGroups| 12)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The collection of objects deprecated from the original MIB-
            II interfaces group."))

(defoid |ifCompliance| (|ifCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "A compliance statement defined in a previous version of
            this MIB module, for SNMP entities which have network
            interfaces."))

(defoid |ifCompliance2| (|ifCompliances| 2)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "A compliance statement defined in a previous version of
            this MIB module, for SNMP entities which have network
            interfaces."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

