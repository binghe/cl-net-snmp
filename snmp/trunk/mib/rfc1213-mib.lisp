;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;RFC1213-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'rfc1213-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'rfc1213-mib *mib-modules*))
(defoid |mib-2| (|mgmt| 1) (:type 'object-identity))
(deftype |DisplayString| () 't)
(deftype |PhysAddress| () 't)
(defoid |system| (|mib-2| 1) (:type 'object-identity))
(defoid |interfaces| (|mib-2| 2) (:type 'object-identity))
(defoid |at| (|mib-2| 3) (:type 'object-identity))
(defoid |ip| (|mib-2| 4) (:type 'object-identity))
(defoid |icmp| (|mib-2| 5) (:type 'object-identity))
(defoid |tcp| (|mib-2| 6) (:type 'object-identity))
(defoid |udp| (|mib-2| 7) (:type 'object-identity))
(defoid |egp| (|mib-2| 8) (:type 'object-identity))
(defoid |transmission| (|mib-2| 10) (:type 'object-identity))
(defoid |snmp| (|mib-2| 11) (:type 'object-identity))
(defoid |sysDescr| (|system| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A textual description of the entity.  This value
            should include the full name and version
            identification of the system's hardware type,
            software operating-system, and networking
            software.  It is mandatory that this only contain
            printable ASCII characters."))
(defoid |sysObjectID| (|system| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:status '|mandatory|)
  (:description
   "The vendor's authoritative identification of the
            network management subsystem contained in the
            entity.  This value is allocated within the SMI
            enterprises subtree (1.3.6.1.4.1) and provides an
            easy and unambiguous means for determining `what
            kind of box' is being managed.  For example, if
            vendor `Flintstones, Inc.' was assigned the
            subtree 1.3.6.1.4.1.4242, it could assign the
            identifier 1.3.6.1.4.1.4242.1.1 to its `Fred
            Router'."))
(defoid |sysUpTime| (|system| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:status '|mandatory|)
  (:description
   "The time (in hundredths of a second) since the
            network management portion of the system was last
            re-initialized."))
(defoid |sysContact| (|system| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The textual identification of the contact person
            for this managed node, together with information
            on how to contact this person."))
(defoid |sysName| (|system| 5)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "An administratively-assigned name for this
            managed node.  By convention, this is the node's
            fully-qualified domain name."))
(defoid |sysLocation| (|system| 6)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The physical location of this node (e.g.,
            `telephone closet, 3rd floor')."))
(defoid |sysServices| (|system| 7)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A value which indicates the set of services that
            this entity primarily offers.

            The value is a sum.  This sum initially takes the
            value zero, Then, for each layer, L, in the range
            1 through 7, that this node performs transactions
            for, 2 raised to (L - 1) is added to the sum.  For
            example, a node which performs primarily routing
            functions would have a value of 4 (2^(3-1)).  In
            contrast, a node which is a host offering
            application services would have a value of 72
            (2^(4-1) + 2^(7-1)).  Note that in the context of
            the Internet suite of protocols, values should be
            calculated accordingly:

                 layer  functionality
                     1  physical (e.g., repeaters)
                     2  datalink/subnetwork (e.g., bridges)
                     3  internet (e.g., IP gateways)
                     4  end-to-end  (e.g., IP hosts)
                     7  applications (e.g., mail relays)

            For systems including OSI protocols, layers 5 and
            6 may also be counted."))
(defoid |ifNumber| (|interfaces| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The number of network interfaces (regardless of
            their current state) present on this system."))
(defoid |ifTable| (|interfaces| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A list of interface entries.  The number of
            entries is given by the value of ifNumber."))
(defoid |ifEntry| (|ifTable| 1)
  (:type 'object-type)
  (:syntax '|IfEntry|)
  (:status '|mandatory|)
  (:description
   "An interface entry containing objects at the
            subnetwork layer and below for a particular
            interface."))
(deftype |IfEntry| () 't)
(defoid |ifIndex| (|ifEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "A unique value for each interface.  Its value
            ranges between 1 and the value of ifNumber.  The
            value for each interface must remain constant at
            least from one re-initialization of the entity's
            network management system to the next re-
            initialization."))
(defoid |ifDescr| (|ifEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A textual string containing information about the
            interface.  This string should include the name of
            the manufacturer, the product name and the version
            of the hardware interface."))
(defoid |ifType| (|ifEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The type of interface, distinguished according to
            the physical/link protocol(s) immediately `below'
            the network layer in the protocol stack."))
(defoid |ifMtu| (|ifEntry| 4)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The size of the largest datagram which can be
            sent/received on the interface, specified in
            octets.  For interfaces that are used for
            transmitting network datagrams, this is the size
            of the largest network datagram that can be sent
            on the interface."))
(defoid |ifSpeed| (|ifEntry| 5)
  (:type 'object-type)
  (:syntax '|Gauge|)
  (:status '|mandatory|)
  (:description
   "An estimate of the interface's current bandwidth
            in bits per second.  For interfaces which do not
            vary in bandwidth or for those where no accurate
            estimation can be made, this object should contain
            the nominal bandwidth."))
(defoid |ifPhysAddress| (|ifEntry| 6)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:status '|mandatory|)
  (:description
   "The interface's address at the protocol layer
            immediately `below' the network layer in the
            protocol stack.  For interfaces which do not have

            such an address (e.g., a serial line), this object
            should contain an octet string of zero length."))
(defoid |ifAdminStatus| (|ifEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The desired state of the interface.  The
            testing(3) state indicates that no operational
            packets can be passed."))
(defoid |ifOperStatus| (|ifEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The current operational state of the interface.
            The testing(3) state indicates that no operational
            packets can be passed."))
(defoid |ifLastChange| (|ifEntry| 9)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:status '|mandatory|)
  (:description
   "The value of sysUpTime at the time the interface
            entered its current operational state.  If the
            current state was entered prior to the last re-
            initialization of the local network management
            subsystem, then this object contains a zero
            value."))
(defoid |ifInOctets| (|ifEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of octets received on the
            interface, including framing characters."))
(defoid |ifInUcastPkts| (|ifEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of subnetwork-unicast packets
            delivered to a higher-layer protocol."))
(defoid |ifInNUcastPkts| (|ifEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of non-unicast (i.e., subnetwork-
            broadcast or subnetwork-multicast) packets
            delivered to a higher-layer protocol."))
(defoid |ifInDiscards| (|ifEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of inbound packets which were chosen
            to be discarded even though no errors had been
            detected to prevent their being deliverable to a
            higher-layer protocol.  One possible reason for
            discarding such a packet could be to free up
            buffer space."))
(defoid |ifInErrors| (|ifEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of inbound packets that contained
            errors preventing them from being deliverable to a
            higher-layer protocol."))
(defoid |ifInUnknownProtos| (|ifEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of packets received via the interface
            which were discarded because of an unknown or
            unsupported protocol."))
(defoid |ifOutOctets| (|ifEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of octets transmitted out of the
            interface, including framing characters."))
(defoid |ifOutUcastPkts| (|ifEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of packets that higher-level
            protocols requested be transmitted to a
            subnetwork-unicast address, including those that
            were discarded or not sent."))
(defoid |ifOutNUcastPkts| (|ifEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of packets that higher-level
            protocols requested be transmitted to a non-
            unicast (i.e., a subnetwork-broadcast or
            subnetwork-multicast) address, including those
            that were discarded or not sent."))
(defoid |ifOutDiscards| (|ifEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of outbound packets which were chosen

            to be discarded even though no errors had been
            detected to prevent their being transmitted.  One
            possible reason for discarding such a packet could
            be to free up buffer space."))
(defoid |ifOutErrors| (|ifEntry| 20)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of outbound packets that could not be
            transmitted because of errors."))
(defoid |ifOutQLen| (|ifEntry| 21)
  (:type 'object-type)
  (:syntax '|Gauge|)
  (:status '|mandatory|)
  (:description
   "The length of the output packet queue (in
            packets)."))
(defoid |ifSpecific| (|ifEntry| 22)
  (:type 'object-type)
  (:syntax 'object-id)
  (:status '|mandatory|)
  (:description
   "A reference to MIB definitions specific to the
            particular media being used to realize the
            interface.  For example, if the interface is
            realized by an ethernet, then the value of this
            object refers to a document defining objects
            specific to ethernet.  If this information is not
            present, its value should be set to the OBJECT
            IDENTIFIER { 0 0 }, which is a syntatically valid
            object identifier, and any conformant
            implementation of ASN.1 and BER must be able to
            generate and recognize this value."))
(defoid |atTable| (|at| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|deprecated|)
  (:description
   "The Address Translation tables contain the
            NetworkAddress to `physical' address equivalences.
            Some interfaces do not use translation tables for
            determining address equivalences (e.g., DDN-X.25
            has an algorithmic method); if all interfaces are
            of this type, then the Address Translation table
            is empty, i.e., has zero entries."))
(defoid |atEntry| (|atTable| 1)
  (:type 'object-type)
  (:syntax '|AtEntry|)
  (:status '|deprecated|)
  (:description
   "Each entry contains one NetworkAddress to
            `physical' address equivalence."))
(deftype |AtEntry| () 't)
(defoid |atIfIndex| (|atEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|deprecated|)
  (:description
   "The interface on which this entry's equivalence
            is effective.  The interface identified by a
            particular value of this index is the same
            interface as identified by the same value of
            ifIndex."))
(defoid |atPhysAddress| (|atEntry| 2)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:status '|deprecated|)
  (:description
   "The media-dependent `physical' address.

            Setting this object to a null string (one of zero
            length) has the effect of invaliding the
            corresponding entry in the atTable object.  That
            is, it effectively dissasociates the interface
            identified with said entry from the mapping
            identified with said entry.  It is an
            implementation-specific matter as to whether the
            agent removes an invalidated entry from the table.
            Accordingly, management stations must be prepared
            to receive tabular information from agents that
            corresponds to entries not currently in use.
            Proper interpretation of such entries requires
            examination of the relevant atPhysAddress object."))
(defoid |atNetAddress| (|atEntry| 3)
  (:type 'object-type)
  (:syntax '|NetworkAddress|)
  (:status '|deprecated|)
  (:description
   "The NetworkAddress (e.g., the IP address)
            corresponding to the media-dependent `physical'
            address."))
(defoid |ipForwarding| (|ip| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The indication of whether this entity is acting
            as an IP gateway in respect to the forwarding of
            datagrams received by, but not addressed to, this
            entity.  IP gateways forward datagrams.  IP hosts
            do not (except those source-routed via the host).

            Note that for some managed nodes, this object may
            take on only a subset of the values possible.
            Accordingly, it is appropriate for an agent to
            return a `badValue' response if a management
            station attempts to change this object to an
            inappropriate value."))
(defoid |ipDefaultTTL| (|ip| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The default value inserted into the Time-To-Live
            field of the IP header of datagrams originated at
            this entity, whenever a TTL value is not supplied
            by the transport layer protocol."))
(defoid |ipInReceives| (|ip| 3)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of input datagrams received from
            interfaces, including those received in error."))
(defoid |ipInHdrErrors| (|ip| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of input datagrams discarded due to
            errors in their IP headers, including bad
            checksums, version number mismatch, other format
            errors, time-to-live exceeded, errors discovered
            in processing their IP options, etc."))
(defoid |ipInAddrErrors| (|ip| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of input datagrams discarded because
            the IP address in their IP header's destination
            field was not a valid address to be received at
            this entity.  This count includes invalid
            addresses (e.g., 0.0.0.0) and addresses of
            unsupported Classes (e.g., Class E).  For entities
            which are not IP Gateways and therefore do not
            forward datagrams, this counter includes datagrams
            discarded because the destination address was not
            a local address."))
(defoid |ipForwDatagrams| (|ip| 6)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of input datagrams for which this
            entity was not their final IP destination, as a
            result of which an attempt was made to find a
            route to forward them to that final destination.
            In entities which do not act as IP Gateways, this
            counter will include only those packets which were
            Source-Routed via this entity, and the Source-
            Route option processing was successful."))
(defoid |ipInUnknownProtos| (|ip| 7)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of locally-addressed datagrams
            received successfully but discarded because of an
            unknown or unsupported protocol."))
(defoid |ipInDiscards| (|ip| 8)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of input IP datagrams for which no
            problems were encountered to prevent their
            continued processing, but which were discarded
            (e.g., for lack of buffer space).  Note that this
            counter does not include any datagrams discarded
            while awaiting re-assembly."))
(defoid |ipInDelivers| (|ip| 9)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of input datagrams successfully
            delivered to IP user-protocols (including ICMP)."))
(defoid |ipOutRequests| (|ip| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of IP datagrams which local IP
            user-protocols (including ICMP) supplied to IP in
            requests for transmission.  Note that this counter
            does not include any datagrams counted in
            ipForwDatagrams."))
(defoid |ipOutDiscards| (|ip| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of output IP datagrams for which no

            problem was encountered to prevent their
            transmission to their destination, but which were
            discarded (e.g., for lack of buffer space).  Note
            that this counter would include datagrams counted
            in ipForwDatagrams if any such packets met this
            (discretionary) discard criterion."))
(defoid |ipOutNoRoutes| (|ip| 12)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of IP datagrams discarded because no
            route could be found to transmit them to their
            destination.  Note that this counter includes any
            packets counted in ipForwDatagrams which meet this
            `no-route' criterion.  Note that this includes any
            datagarms which a host cannot route because all of
            its default gateways are down."))
(defoid |ipReasmTimeout| (|ip| 13)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The maximum number of seconds which received
            fragments are held while they are awaiting
            reassembly at this entity."))
(defoid |ipReasmReqds| (|ip| 14)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of IP fragments received which needed
            to be reassembled at this entity."))
(defoid |ipReasmOKs| (|ip| 15)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of IP datagrams successfully re-
            assembled."))
(defoid |ipReasmFails| (|ip| 16)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of failures detected by the IP re-
            assembly algorithm (for whatever reason: timed
            out, errors, etc).  Note that this is not
            necessarily a count of discarded IP fragments
            since some algorithms (notably the algorithm in
            RFC 815) can lose track of the number of fragments
            by combining them as they are received."))
(defoid |ipFragOKs| (|ip| 17)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of IP datagrams that have been
            successfully fragmented at this entity."))
(defoid |ipFragFails| (|ip| 18)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of IP datagrams that have been
            discarded because they needed to be fragmented at
            this entity but could not be, e.g., because their
            Don't Fragment flag was set."))
(defoid |ipFragCreates| (|ip| 19)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of IP datagram fragments that have
            been generated as a result of fragmentation at
            this entity."))
(defoid |ipAddrTable| (|ip| 20)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The table of addressing information relevant to
            this entity's IP addresses."))
(defoid |ipAddrEntry| (|ipAddrTable| 1)
  (:type 'object-type)
  (:syntax '|IpAddrEntry|)
  (:status '|mandatory|)
  (:description
   "The addressing information for one of this
            entity's IP addresses."))
(deftype |IpAddrEntry| () 't)
(defoid |ipAdEntAddr| (|ipAddrEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The IP address to which this entry's addressing
            information pertains."))
(defoid |ipAdEntIfIndex| (|ipAddrEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The index value which uniquely identifies the
            interface to which this entry is applicable.  The
            interface identified by a particular value of this
            index is the same interface as identified by the
            same value of ifIndex."))
(defoid |ipAdEntNetMask| (|ipAddrEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The subnet mask associated with the IP address of
            this entry.  The value of the mask is an IP
            address with all the network bits set to 1 and all
            the hosts bits set to 0."))
(defoid |ipAdEntBcastAddr| (|ipAddrEntry| 4)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The value of the least-significant bit in the IP
            broadcast address used for sending datagrams on
            the (logical) interface associated with the IP
            address of this entry.  For example, when the
            Internet standard all-ones broadcast address is
            used, the value will be 1.  This value applies to
            both the subnet and network broadcasts addresses
            used by the entity on this (logical) interface."))
(defoid |ipAdEntReasmMaxSize| (|ipAddrEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The size of the largest IP datagram which this
            entity can re-assemble from incoming IP fragmented
            datagrams received on this interface."))
(defoid |ipRouteTable| (|ip| 21)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "This entity's IP Routing table."))
(defoid |ipRouteEntry| (|ipRouteTable| 1)
  (:type 'object-type)
  (:syntax '|IpRouteEntry|)
  (:status '|mandatory|)
  (:description "A route to a particular destination."))
(deftype |IpRouteEntry| () 't)
(defoid |ipRouteDest| (|ipRouteEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The destination IP address of this route.  An
            entry with a value of 0.0.0.0 is considered a
            default route.  Multiple routes to a single
            destination can appear in the table, but access to
            such multiple entries is dependent on the table-
            access mechanisms defined by the network
            management protocol in use."))
(defoid |ipRouteIfIndex| (|ipRouteEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The index value which uniquely identifies the
            local interface through which the next hop of this
            route should be reached.  The interface identified
            by a particular value of this index is the same
            interface as identified by the same value of
            ifIndex."))
(defoid |ipRouteMetric1| (|ipRouteEntry| 3)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The primary routing metric for this route.  The
            semantics of this metric are determined by the
            routing-protocol specified in the route's
            ipRouteProto value.  If this metric is not used,
            its value should be set to -1."))
(defoid |ipRouteMetric2| (|ipRouteEntry| 4)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the
            routing-protocol specified in the route's
            ipRouteProto value.  If this metric is not used,
            its value should be set to -1."))
(defoid |ipRouteMetric3| (|ipRouteEntry| 5)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the
            routing-protocol specified in the route's
            ipRouteProto value.  If this metric is not used,
            its value should be set to -1."))
(defoid |ipRouteMetric4| (|ipRouteEntry| 6)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the
            routing-protocol specified in the route's
            ipRouteProto value.  If this metric is not used,
            its value should be set to -1."))
(defoid |ipRouteNextHop| (|ipRouteEntry| 7)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The IP address of the next hop of this route.
            (In the case of a route bound to an interface
            which is realized via a broadcast media, the value
            of this field is the agent's IP address on that
            interface.)"))
(defoid |ipRouteType| (|ipRouteEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The type of route.  Note that the values
            direct(3) and indirect(4) refer to the notion of
            direct and indirect routing in the IP
            architecture.

            Setting this object to the value invalid(2) has
            the effect of invalidating the corresponding entry
            in the ipRouteTable object.  That is, it
            effectively dissasociates the destination
            identified with said entry from the route
            identified with said entry.  It is an
            implementation-specific matter as to whether the
            agent removes an invalidated entry from the table.
            Accordingly, management stations must be prepared
            to receive tabular information from agents that
            corresponds to entries not currently in use.
            Proper interpretation of such entries requires
            examination of the relevant ipRouteType object."))
(defoid |ipRouteProto| (|ipRouteEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The routing mechanism via which this route was
            learned.  Inclusion of values for gateway routing
            protocols is not intended to imply that hosts
            should support those protocols."))
(defoid |ipRouteAge| (|ipRouteEntry| 10)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The number of seconds since this route was last
            updated or otherwise determined to be correct.
            Note that no semantics of `too old' can be implied
            except through knowledge of the routing protocol
            by which the route was learned."))
(defoid |ipRouteMask| (|ipRouteEntry| 11)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "Indicate the mask to be logical-ANDed with the
            destination address before being compared to the
            value in the ipRouteDest field.  For those systems
            that do not support arbitrary subnet masks, an
            agent constructs the value of the ipRouteMask by
            determining whether the value of the correspondent
            ipRouteDest field belong to a class-A, B, or C
            network, and then using one of:

                 mask           network
                 255.0.0.0      class-A
                 255.255.0.0    class-B
                 255.255.255.0  class-C

            If the value of the ipRouteDest is 0.0.0.0 (a
            default route), then the mask value is also
            0.0.0.0.  It should be noted that all IP routing
            subsystems implicitly use this mechanism."))
(defoid |ipRouteMetric5| (|ipRouteEntry| 12)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the
            routing-protocol specified in the route's
            ipRouteProto value.  If this metric is not used,
            its value should be set to -1."))
(defoid |ipRouteInfo| (|ipRouteEntry| 13)
  (:type 'object-type)
  (:syntax 'object-id)
  (:status '|mandatory|)
  (:description
   "A reference to MIB definitions specific to the
            particular routing protocol which is responsible
            for this route, as determined by the value
            specified in the route's ipRouteProto value.  If
            this information is not present, its value should
            be set to the OBJECT IDENTIFIER { 0 0 }, which is
            a syntatically valid object identifier, and any
            conformant implementation of ASN.1 and BER must be
            able to generate and recognize this value."))
(defoid |ipNetToMediaTable| (|ip| 22)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The IP Address Translation table used for mapping
            from IP addresses to physical addresses."))
(defoid |ipNetToMediaEntry| (|ipNetToMediaTable| 1)
  (:type 'object-type)
  (:syntax '|IpNetToMediaEntry|)
  (:status '|mandatory|)
  (:description
   "Each entry contains one IpAddress to `physical'
            address equivalence."))
(deftype |IpNetToMediaEntry| () 't)
(defoid |ipNetToMediaIfIndex| (|ipNetToMediaEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The interface on which this entry's equivalence
            is effective.  The interface identified by a
            particular value of this index is the same
            interface as identified by the same value of
            ifIndex."))
(defoid |ipNetToMediaPhysAddress| (|ipNetToMediaEntry| 2)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:status '|mandatory|)
  (:description "The media-dependent `physical' address."))
(defoid |ipNetToMediaNetAddress| (|ipNetToMediaEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The IpAddress corresponding to the media-
            dependent `physical' address."))
(defoid |ipNetToMediaType| (|ipNetToMediaEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The type of mapping.

            Setting this object to the value invalid(2) has
            the effect of invalidating the corresponding entry
            in the ipNetToMediaTable.  That is, it effectively
            dissasociates the interface identified with said
            entry from the mapping identified with said entry.
            It is an implementation-specific matter as to
            whether the agent removes an invalidated entry
            from the table.  Accordingly, management stations
            must be prepared to receive tabular information
            from agents that corresponds to entries not
            currently in use.  Proper interpretation of such
            entries requires examination of the relevant
            ipNetToMediaType object."))
(defoid |ipRoutingDiscards| (|ip| 23)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of routing entries which were chosen
            to be discarded even though they are valid.  One
            possible reason for discarding such an entry could
            be to free-up buffer space for other routing

            entries."))
(defoid |icmpInMsgs| (|icmp| 1)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of ICMP messages which the
            entity received.  Note that this counter includes
            all those counted by icmpInErrors."))
(defoid |icmpInErrors| (|icmp| 2)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP messages which the entity
            received but determined as having ICMP-specific
            errors (bad ICMP checksums, bad length, etc.)."))
(defoid |icmpInDestUnreachs| (|icmp| 3)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Destination Unreachable
            messages received."))
(defoid |icmpInTimeExcds| (|icmp| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Time Exceeded messages
            received."))
(defoid |icmpInParmProbs| (|icmp| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Parameter Problem messages
            received."))
(defoid |icmpInSrcQuenchs| (|icmp| 6)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Source Quench messages
            received."))
(defoid |icmpInRedirects| (|icmp| 7)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description "The number of ICMP Redirect messages received."))
(defoid |icmpInEchos| (|icmp| 8)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Echo (request) messages
            received."))
(defoid |icmpInEchoReps| (|icmp| 9)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description "The number of ICMP Echo Reply messages received."))
(defoid |icmpInTimestamps| (|icmp| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Timestamp (request) messages
            received."))
(defoid |icmpInTimestampReps| (|icmp| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Timestamp Reply messages
            received."))
(defoid |icmpInAddrMasks| (|icmp| 12)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Address Mask Request messages
            received."))
(defoid |icmpInAddrMaskReps| (|icmp| 13)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Address Mask Reply messages
            received."))
(defoid |icmpOutMsgs| (|icmp| 14)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of ICMP messages which this
            entity attempted to send.  Note that this counter
            includes all those counted by icmpOutErrors."))
(defoid |icmpOutErrors| (|icmp| 15)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP messages which this entity did
            not send due to problems discovered within ICMP

            such as a lack of buffers.  This value should not
            include errors discovered outside the ICMP layer
            such as the inability of IP to route the resultant
            datagram.  In some implementations there may be no
            types of error which contribute to this counter's
            value."))
(defoid |icmpOutDestUnreachs| (|icmp| 16)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Destination Unreachable
            messages sent."))
(defoid |icmpOutTimeExcds| (|icmp| 17)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description "The number of ICMP Time Exceeded messages sent."))
(defoid |icmpOutParmProbs| (|icmp| 18)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Parameter Problem messages
            sent."))
(defoid |icmpOutSrcQuenchs| (|icmp| 19)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description "The number of ICMP Source Quench messages sent."))
(defoid |icmpOutRedirects| (|icmp| 20)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Redirect messages sent.  For a

            host, this object will always be zero, since hosts
            do not send redirects."))
(defoid |icmpOutEchos| (|icmp| 21)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description "The number of ICMP Echo (request) messages sent."))
(defoid |icmpOutEchoReps| (|icmp| 22)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description "The number of ICMP Echo Reply messages sent."))
(defoid |icmpOutTimestamps| (|icmp| 23)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Timestamp (request) messages
            sent."))
(defoid |icmpOutTimestampReps| (|icmp| 24)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Timestamp Reply messages
            sent."))
(defoid |icmpOutAddrMasks| (|icmp| 25)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Address Mask Request messages
            sent."))
(defoid |icmpOutAddrMaskReps| (|icmp| 26)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ICMP Address Mask Reply messages
            sent."))
(defoid |tcpRtoAlgorithm| (|tcp| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The algorithm used to determine the timeout value
            used for retransmitting unacknowledged octets."))
(defoid |tcpRtoMin| (|tcp| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The minimum value permitted by a TCP
            implementation for the retransmission timeout,
            measured in milliseconds.  More refined semantics
            for objects of this type depend upon the algorithm
            used to determine the retransmission timeout.  In
            particular, when the timeout algorithm is rsre(3),
            an object of this type has the semantics of the
            LBOUND quantity described in RFC 793."))
(defoid |tcpRtoMax| (|tcp| 3)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The maximum value permitted by a TCP
            implementation for the retransmission timeout,
            measured in milliseconds.  More refined semantics
            for objects of this type depend upon the algorithm
            used to determine the retransmission timeout.  In
            particular, when the timeout algorithm is rsre(3),
            an object of this type has the semantics of the
            UBOUND quantity described in RFC 793."))
(defoid |tcpMaxConn| (|tcp| 4)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The limit on the total number of TCP connections
            the entity can support.  In entities where the
            maximum number of connections is dynamic, this
            object should contain the value -1."))
(defoid |tcpActiveOpens| (|tcp| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of times TCP connections have made a
            direct transition to the SYN-SENT state from the
            CLOSED state."))
(defoid |tcpPassiveOpens| (|tcp| 6)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of times TCP connections have made a
            direct transition to the SYN-RCVD state from the
            LISTEN state."))
(defoid |tcpAttemptFails| (|tcp| 7)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of times TCP connections have made a
            direct transition to the CLOSED state from either
            the SYN-SENT state or the SYN-RCVD state, plus the
            number of times TCP connections have made a direct
            transition to the LISTEN state from the SYN-RCVD
            state."))
(defoid |tcpEstabResets| (|tcp| 8)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of times TCP connections have made a
            direct transition to the CLOSED state from either
            the ESTABLISHED state or the CLOSE-WAIT state."))
(defoid |tcpCurrEstab| (|tcp| 9)
  (:type 'object-type)
  (:syntax '|Gauge|)
  (:status '|mandatory|)
  (:description
   "The number of TCP connections for which the
            current state is either ESTABLISHED or CLOSE-
            WAIT."))
(defoid |tcpInSegs| (|tcp| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of segments received, including
            those received in error.  This count includes
            segments received on currently established
            connections."))
(defoid |tcpOutSegs| (|tcp| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of segments sent, including
            those on current connections but excluding those
            containing only retransmitted octets."))
(defoid |tcpRetransSegs| (|tcp| 12)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of segments retransmitted - that
            is, the number of TCP segments transmitted
            containing one or more previously transmitted
            octets."))
(defoid |tcpConnTable| (|tcp| 13)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table containing TCP connection-specific
            information."))
(defoid |tcpConnEntry| (|tcpConnTable| 1)
  (:type 'object-type)
  (:syntax '|TcpConnEntry|)
  (:status '|mandatory|)
  (:description
   "Information about a particular current TCP
            connection.  An object of this type is transient,
            in that it ceases to exist when (or soon after)
            the connection makes the transition to the CLOSED
            state."))
(deftype |TcpConnEntry| () 't)
(defoid |tcpConnState| (|tcpConnEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The state of this TCP connection.

            The only value which may be set by a management
            station is deleteTCB(12).  Accordingly, it is
            appropriate for an agent to return a `badValue'
            response if a management station attempts to set
            this object to any other value.

            If a management station sets this object to the
            value deleteTCB(12), then this has the effect of
            deleting the TCB (as defined in RFC 793) of the
            corresponding connection on the managed node,
            resulting in immediate termination of the
            connection.

            As an implementation-specific option, a RST

            segment may be sent from the managed node to the
            other TCP endpoint (note however that RST segments
            are not sent reliably)."))
(defoid |tcpConnLocalAddress| (|tcpConnEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The local IP address for this TCP connection.  In
            the case of a connection in the listen state which
            is willing to accept connections for any IP
            interface associated with the node, the value
            0.0.0.0 is used."))
(defoid |tcpConnLocalPort| (|tcpConnEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The local port number for this TCP connection."))
(defoid |tcpConnRemAddress| (|tcpConnEntry| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description "The remote IP address for this TCP connection."))
(defoid |tcpConnRemPort| (|tcpConnEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The remote port number for this TCP connection."))
(defoid |tcpInErrs| (|tcp| 14)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of segments received in error
            (e.g., bad TCP checksums)."))
(defoid |tcpOutRsts| (|tcp| 15)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of TCP segments sent containing the
            RST flag."))
(defoid |udpInDatagrams| (|udp| 1)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of UDP datagrams delivered to
            UDP users."))
(defoid |udpNoPorts| (|udp| 2)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of received UDP datagrams for
            which there was no application at the destination
            port."))
(defoid |udpInErrors| (|udp| 3)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of received UDP datagrams that could
            not be delivered for reasons other than the lack
            of an application at the destination port."))
(defoid |udpOutDatagrams| (|udp| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of UDP datagrams sent from this
            entity."))
(defoid |udpTable| (|udp| 5)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "A table containing UDP listener information."))
(defoid |udpEntry| (|udpTable| 1)
  (:type 'object-type)
  (:syntax '|UdpEntry|)
  (:status '|mandatory|)
  (:description
   "Information about a particular current UDP
            listener."))
(deftype |UdpEntry| () 't)
(defoid |udpLocalAddress| (|udpEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description
   "The local IP address for this UDP listener.  In

            the case of a UDP listener which is willing to
            accept datagrams for any IP interface associated
            with the node, the value 0.0.0.0 is used."))
(defoid |udpLocalPort| (|udpEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The local port number for this UDP listener."))
(defoid |egpInMsgs| (|egp| 1)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP messages received without
            error."))
(defoid |egpInErrors| (|egp| 2)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP messages received that proved
            to be in error."))
(defoid |egpOutMsgs| (|egp| 3)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of locally generated EGP
            messages."))
(defoid |egpOutErrors| (|egp| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of locally generated EGP messages not
            sent due to resource limitations within an EGP
            entity."))
(defoid |egpNeighTable| (|egp| 5)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The EGP neighbor table."))
(defoid |egpNeighEntry| (|egpNeighTable| 1)
  (:type 'object-type)
  (:syntax '|EgpNeighEntry|)
  (:status '|mandatory|)
  (:description
   "Information about this entity's relationship with
            a particular EGP neighbor."))
(deftype |EgpNeighEntry| () 't)
(defoid |egpNeighState| (|egpNeighEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The EGP state of the local system with respect to
            this entry's EGP neighbor.  Each EGP state is
            represented by a value that is one greater than
            the numerical value associated with said state in
            RFC 904."))
(defoid |egpNeighAddr| (|egpNeighEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:status '|mandatory|)
  (:description "The IP address of this entry's EGP neighbor."))
(defoid |egpNeighAs| (|egpNeighEntry| 3)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The autonomous system of this EGP peer.  Zero
            should be specified if the autonomous system
            number of the neighbor is not yet known."))
(defoid |egpNeighInMsgs| (|egpNeighEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP messages received without error
            from this EGP peer."))
(defoid |egpNeighInErrs| (|egpNeighEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP messages received from this EGP
            peer that proved to be in error (e.g., bad EGP
            checksum)."))
(defoid |egpNeighOutMsgs| (|egpNeighEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of locally generated EGP messages to
            this EGP peer."))
(defoid |egpNeighOutErrs| (|egpNeighEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of locally generated EGP messages not
            sent to this EGP peer due to resource limitations
            within an EGP entity."))
(defoid |egpNeighInErrMsgs| (|egpNeighEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP-defined error messages received
            from this EGP peer."))
(defoid |egpNeighOutErrMsgs| (|egpNeighEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP-defined error messages sent to
            this EGP peer."))
(defoid |egpNeighStateUps| (|egpNeighEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP state transitions to the UP
            state with this EGP peer."))
(defoid |egpNeighStateDowns| (|egpNeighEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of EGP state transitions from the UP
            state to any other state with this EGP peer."))
(defoid |egpNeighIntervalHello| (|egpNeighEntry| 12)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The interval between EGP Hello command
            retransmissions (in hundredths of a second).  This
            represents the t1 timer as defined in RFC 904."))
(defoid |egpNeighIntervalPoll| (|egpNeighEntry| 13)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The interval between EGP poll command

            retransmissions (in hundredths of a second).  This
            represents the t3 timer as defined in RFC 904."))
(defoid |egpNeighMode| (|egpNeighEntry| 14)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The polling mode of this EGP entity, either
            passive or active."))
(defoid |egpNeighEventTrigger| (|egpNeighEntry| 15)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A control variable used to trigger operator-
            initiated Start and Stop events.  When read, this
            variable always returns the most recent value that
            egpNeighEventTrigger was set to.  If it has not
            been set since the last initialization of the
            network management subsystem on the node, it
            returns a value of `stop'.

            When set, this variable causes a Start or Stop
            event on the specified neighbor, as specified on
            pages 8-10 of RFC 904.  Briefly, a Start event
            causes an Idle peer to begin neighbor acquisition
            and a non-Idle peer to reinitiate neighbor
            acquisition.  A stop event causes a non-Idle peer
            to return to the Idle state until a Start event
            occurs, either via egpNeighEventTrigger or
            otherwise."))
(defoid |egpAs| (|egp| 6)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description "The autonomous system number of this EGP entity."))
(defoid |snmpInPkts| (|snmp| 1)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of Messages delivered to the
            SNMP entity from the transport service."))
(defoid |snmpOutPkts| (|snmp| 2)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Messages which were
            passed from the SNMP protocol entity to the
            transport service."))
(defoid |snmpInBadVersions| (|snmp| 3)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Messages which were
            delivered to the SNMP protocol entity and were for
            an unsupported SNMP version."))
(defoid |snmpInBadCommunityNames| (|snmp| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Messages delivered to
            the SNMP protocol entity which used a SNMP
            community name not known to said entity."))
(defoid |snmpInBadCommunityUses| (|snmp| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Messages delivered to
            the SNMP protocol entity which represented an SNMP
            operation which was not allowed by the SNMP
            community named in the Message."))
(defoid |snmpInASNParseErrs| (|snmp| 6)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of ASN.1 or BER errors
            encountered by the SNMP protocol entity when
            decoding received SNMP Messages."))
(defoid |snmpInTooBigs| (|snmp| 8)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field is
            `tooBig'."))
(defoid |snmpInNoSuchNames| (|snmp| 9)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field is
            `noSuchName'."))
(defoid |snmpInBadValues| (|snmp| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field is
            `badValue'."))
(defoid |snmpInReadOnlys| (|snmp| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number valid SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field is
            `readOnly'.  It should be noted that it is a
            protocol error to generate an SNMP PDU which
            contains the value `readOnly' in the error-status
            field, as such this object is provided as a means
            of detecting incorrect implementations of the

            SNMP."))
(defoid |snmpInGenErrs| (|snmp| 12)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field is
            `genErr'."))
(defoid |snmpInTotalReqVars| (|snmp| 13)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of MIB objects which have been
            retrieved successfully by the SNMP protocol entity
            as the result of receiving valid SNMP Get-Request
            and Get-Next PDUs."))
(defoid |snmpInTotalSetVars| (|snmp| 14)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of MIB objects which have been
            altered successfully by the SNMP protocol entity
            as the result of receiving valid SNMP Set-Request
            PDUs."))
(defoid |snmpInGetRequests| (|snmp| 15)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Get-Request PDUs which
            have been accepted and processed by the SNMP
            protocol entity."))
(defoid |snmpInGetNexts| (|snmp| 16)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Get-Next PDUs which have
            been accepted and processed by the SNMP protocol
            entity."))
(defoid |snmpInSetRequests| (|snmp| 17)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Set-Request PDUs which
            have been accepted and processed by the SNMP
            protocol entity."))
(defoid |snmpInGetResponses| (|snmp| 18)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Get-Response PDUs which
            have been accepted and processed by the SNMP
            protocol entity."))
(defoid |snmpInTraps| (|snmp| 19)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Trap PDUs which have
            been accepted and processed by the SNMP protocol
            entity."))
(defoid |snmpOutTooBigs| (|snmp| 20)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            generated by the SNMP protocol entity and for
            which the value of the error-status field is
            `tooBig.'"))
(defoid |snmpOutNoSuchNames| (|snmp| 21)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            generated by the SNMP protocol entity and for
            which the value of the error-status is
            `noSuchName'."))
(defoid |snmpOutBadValues| (|snmp| 22)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            generated by the SNMP protocol entity and for
            which the value of the error-status field is
            `badValue'."))
(defoid |snmpOutGenErrs| (|snmp| 24)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP PDUs which were
            generated by the SNMP protocol entity and for
            which the value of the error-status field is
            `genErr'."))
(defoid |snmpOutGetRequests| (|snmp| 25)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Get-Request PDUs which
            have been generated by the SNMP protocol entity."))
(defoid |snmpOutGetNexts| (|snmp| 26)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Get-Next PDUs which have
            been generated by the SNMP protocol entity."))
(defoid |snmpOutSetRequests| (|snmp| 27)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Set-Request PDUs which
            have been generated by the SNMP protocol entity."))
(defoid |snmpOutGetResponses| (|snmp| 28)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Get-Response PDUs which
            have been generated by the SNMP protocol entity."))
(defoid |snmpOutTraps| (|snmp| 29)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of SNMP Trap PDUs which have
            been generated by the SNMP protocol entity."))
(defoid |snmpEnableAuthenTraps| (|snmp| 30)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "Indicates whether the SNMP agent process is
            permitted to generate authentication-failure
            traps.  The value of this object overrides any
            configuration information; as such, it provides a
            means whereby all authentication-failure traps may
            be disabled.

            Note that it is strongly recommended that this
            object be stored in non-volatile memory so that it
            remains constant between re-initializations of the
            network management system."))
