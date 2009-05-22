;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'ip-mib))

(defpackage :asn.1/ip-mib
  (:nicknames :ip-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Counter32| |IpAddress| |mib-2| |Unsigned32|
                |Counter64| |zeroDotZero|)
  (:import-from :|ASN.1/SNMPv2-TC| |PhysAddress| |TruthValue|
                |TimeStamp| |RowPointer| textual-convention
                |TestAndIncr| |RowStatus| |StorageType|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/inet-address-mib |InetAddress| |InetAddressType|
                |InetAddressPrefixLength| |InetVersion|
                |InetZoneIndex|)
  (:import-from :asn.1/if-mib |InterfaceIndex|))

(in-package :ip-mib)

(defoid |ipMIB| (|mib-2| 48)
  (:type 'module-identity)
  (:description
   "The MIB module for managing IP and ICMP implementations, but
            excluding their management of IP routes.

            Copyright (C) The Internet Society (2006).  This version of
            this MIB module is part of RFC 4293; see the RFC itself for
            full legal notices."))

(define-textual-convention |IpAddressOriginTC|
                           t
                           (:status '|current|)
                           (:description
                            "The origin of the address.

            manual(2) indicates that the address was manually configured
            to a specified address, e.g., by user configuration.

            dhcp(4) indicates an address that was assigned to this
            system by a DHCP server.

            linklayer(5) indicates an address created by IPv6 stateless



            auto-configuration.

            random(6) indicates an address chosen by the system at
            random, e.g., an IPv4 address within 169.254/16, or an RFC
            3041 privacy address."))

(define-textual-convention |IpAddressStatusTC|
                           t
                           (:status '|current|)
                           (:description
                            "The status of an address.  Most of the states correspond to
            states from the IPv6 Stateless Address Autoconfiguration
            protocol.

            The preferred(1) state indicates that this is a valid
            address that can appear as the destination or source address
            of a packet.

            The deprecated(2) state indicates that this is a valid but
            deprecated address that should no longer be used as a source
            address in new communications, but packets addressed to such
            an address are processed as expected.

            The invalid(3) state indicates that this isn't a valid
            address and it shouldn't appear as the destination or source
            address of a packet.

            The inaccessible(4) state indicates that the address is not
            accessible because the interface to which this address is
            assigned is not operational.

            The unknown(5) state indicates that the status cannot be
            determined for some reason.

            The tentative(6) state indicates that the uniqueness of the
            address on the link is being verified.  Addresses in this
            state should not be used for general communication and
            should only be used to determine the uniqueness of the
            address.

            The duplicate(7) state indicates the address has been
            determined to be non-unique on the link and so must not be



            used.

            The optimistic(8) state indicates the address is available
            for use, subject to restrictions, while its uniqueness on
            a link is being verified.

            In the absence of other information, an IPv4 address is
            always preferred(1).")
                           (:reference "RFC 2462"))

(define-textual-convention |IpAddressPrefixOriginTC|
                           t
                           (:status '|current|)
                           (:description
                            "The origin of this prefix.

            manual(2) indicates a prefix that was manually configured.

            wellknown(3) indicates a well-known prefix, e.g., 169.254/16
            for IPv4 auto-configuration or fe80::/10 for IPv6 link-local
            addresses.  Well known prefixes may be assigned by IANA,
            the address registries, or by specification in a standards
            track RFC.

            dhcp(4) indicates a prefix that was assigned by a DHCP
            server.

            routeradv(5) indicates a prefix learned from a router
            advertisement.

            Note: while IpAddressOriginTC and IpAddressPrefixOriginTC
            are similar, they are not identical.  The first defines how
            an address was created, while the second defines how a
            prefix was found."))

(define-textual-convention |Ipv6AddressIfIdentifierTC|
                           octet-string
                           (:display-hint "2x:")
                           (:status '|current|)
                           (:description
                            "This data type is used to model IPv6 address
       interface identifiers.  This is a binary string
       of up to 8 octets in network byte-order."))

(defoid |ip| (|mib-2| 4) (:type 'object-identity))

(defoid |ipForwarding| (|ip| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The indication of whether this entity is acting as an IPv4
            router in respect to the forwarding of datagrams received
            by, but not addressed to, this entity.  IPv4 routers forward
            datagrams.  IPv4 hosts do not (except those source-routed
            via the host).

            When this object is written, the entity should save the
            change to non-volatile storage and restore the object from
            non-volatile storage upon re-initialization of the system.
            Note: a stronger requirement is not used because this object
            was previously defined."))

(defoid |ipDefaultTTL| (|ip| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The default value inserted into the Time-To-Live field of
            the IPv4 header of datagrams originated at this entity,
            whenever a TTL value is not supplied by the transport layer



            protocol.

            When this object is written, the entity should save the
            change to non-volatile storage and restore the object from
            non-volatile storage upon re-initialization of the system.
            Note: a stronger requirement is not used because this object
            was previously defined."))

(defoid |ipReasmTimeout| (|ip| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of seconds that received fragments are
            held while they are awaiting reassembly at this entity."))

(defoid |ipv6IpForwarding| (|ip| 25)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The indication of whether this entity is acting as an IPv6
            router on any interface in respect to the forwarding of
            datagrams received by, but not addressed to, this entity.
            IPv6 routers forward datagrams.  IPv6 hosts do not (except
            those source-routed via the host).

            When this object is written, the entity SHOULD save the
            change to non-volatile storage and restore the object from
            non-volatile storage upon re-initialization of the system."))

(defoid |ipv6IpDefaultHopLimit| (|ip| 26)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The default value inserted into the Hop Limit field of the
            IPv6 header of datagrams originated at this entity whenever
            a Hop Limit value is not supplied by the transport layer
            protocol.

            When this object is written, the entity SHOULD save the
            change to non-volatile storage and restore the object from
            non-volatile storage upon re-initialization of the system.")
  (:reference "RFC 2461 Section 6.3.2"))

(defoid |ipv4InterfaceTableLastChange| (|ip| 27)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
            a row in the ipv4InterfaceTable was added or deleted, or
            when an ipv4InterfaceReasmMaxSize or an
            ipv4InterfaceEnableStatus object was modified.

            If new objects are added to the ipv4InterfaceTable that
            require the ipv4InterfaceTableLastChange to be updated when
            they are modified, they must specify that requirement in
            their description clause."))

(defoid |ipv4InterfaceTable| (|ip| 28)
  (:type 'object-type)
  (:syntax '(vector |Ipv4InterfaceEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table containing per-interface IPv4-specific
            information."))

(defoid |ipv4InterfaceEntry| (|ipv4InterfaceTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv4InterfaceEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing IPv4-specific information for a specific
            interface."))

(defclass |Ipv4InterfaceEntry|
          (sequence-type)
          ((|ipv4InterfaceIfIndex| :type |InterfaceIndex|)
           (|ipv4InterfaceReasmMaxSize| :type |Integer32|)
           (|ipv4InterfaceEnableStatus| :type integer)
           (|ipv4InterfaceRetransmitTime| :type |Unsigned32|)))

(defoid |ipv4InterfaceIfIndex| (|ipv4InterfaceEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface to
            which this entry is applicable.  The interface identified by
            a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipv4InterfaceReasmMaxSize| (|ipv4InterfaceEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The size of the largest IPv4 datagram that this entity can
            re-assemble from incoming IPv4 fragmented datagrams received
            on this interface."))

(defoid |ipv4InterfaceEnableStatus| (|ipv4InterfaceEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The indication of whether IPv4 is enabled (up) or disabled
            (down) on this interface.  This object does not affect the
            state of the interface itself, only its connection to an
            IPv4 stack.  The IF-MIB should be used to control the state
            of the interface."))

(defoid |ipv4InterfaceRetransmitTime| (|ipv4InterfaceEntry| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time between retransmissions of ARP requests to a
            neighbor when resolving the address or when probing the
            reachability of a neighbor.")
  (:reference "RFC 1122"))

(defoid |ipv6InterfaceTableLastChange| (|ip| 29)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
            a row in the ipv6InterfaceTable was added or deleted or when
            an ipv6InterfaceReasmMaxSize, ipv6InterfaceIdentifier,
            ipv6InterfaceEnableStatus, ipv6InterfaceReachableTime,
            ipv6InterfaceRetransmitTime, or ipv6InterfaceForwarding
            object was modified.

            If new objects are added to the ipv6InterfaceTable that
            require the ipv6InterfaceTableLastChange to be updated when
            they are modified, they must specify that requirement in
            their description clause."))

(defoid |ipv6InterfaceTable| (|ip| 30)
  (:type 'object-type)
  (:syntax '(vector |Ipv6InterfaceEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table containing per-interface IPv6-specific
            information."))

(defoid |ipv6InterfaceEntry| (|ipv6InterfaceTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv6InterfaceEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing IPv6-specific information for a given
            interface."))

(defclass |Ipv6InterfaceEntry|
          (sequence-type)
          ((|ipv6InterfaceIfIndex| :type |InterfaceIndex|)
           (|ipv6InterfaceReasmMaxSize| :type |Unsigned32|)
           (|ipv6InterfaceIdentifier|
            :type
            |Ipv6AddressIfIdentifierTC|)
           (|ipv6InterfaceEnableStatus| :type integer)
           (|ipv6InterfaceReachableTime| :type |Unsigned32|)
           (|ipv6InterfaceRetransmitTime| :type |Unsigned32|)
           (|ipv6InterfaceForwarding| :type integer)))

(defoid |ipv6InterfaceIfIndex| (|ipv6InterfaceEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface to
            which this entry is applicable.  The interface identified by
            a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipv6InterfaceReasmMaxSize| (|ipv6InterfaceEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The size of the largest IPv6 datagram that this entity can
            re-assemble from incoming IPv6 fragmented datagrams received
            on this interface."))

(defoid |ipv6InterfaceIdentifier| (|ipv6InterfaceEntry| 3)
  (:type 'object-type)
  (:syntax '|Ipv6AddressIfIdentifierTC|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Interface Identifier for this interface.  The Interface
            Identifier is combined with an address prefix to form an
            interface address.

            By default, the Interface Identifier is auto-configured
            according to the rules of the link type to which this
            interface is attached.




            A zero length identifier may be used where appropriate.  One
            possible example is a loopback interface."))

(defoid |ipv6InterfaceEnableStatus| (|ipv6InterfaceEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The indication of whether IPv6 is enabled (up) or disabled
            (down) on this interface.  This object does not affect the
            state of the interface itself, only its connection to an
            IPv6 stack.  The IF-MIB should be used to control the state
            of the interface.

            When this object is written, the entity SHOULD save the
            change to non-volatile storage and restore the object from
            non-volatile storage upon re-initialization of the system."))

(defoid |ipv6InterfaceReachableTime| (|ipv6InterfaceEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time a neighbor is considered reachable after receiving
            a reachability confirmation.")
  (:reference "RFC 2461, Section 6.3.2"))

(defoid |ipv6InterfaceRetransmitTime| (|ipv6InterfaceEntry| 7)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time between retransmissions of Neighbor Solicitation
            messages to a neighbor when resolving the address or when
            probing the reachability of a neighbor.")
  (:reference "RFC 2461, Section 6.3.2"))

(defoid |ipv6InterfaceForwarding| (|ipv6InterfaceEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The indication of whether this entity is acting as an IPv6
            router on this interface with respect to the forwarding of
            datagrams received by, but not addressed to, this entity.
            IPv6 routers forward datagrams.  IPv6 hosts do not (except
            those source-routed via the host).

            This object is constrained by ipv6IpForwarding and is
            ignored if ipv6IpForwarding is set to notForwarding.  Those
            systems that do not provide per-interface control of the
            forwarding function should set this object to forwarding for
            all interfaces and allow the ipv6IpForwarding object to
            control the forwarding capability.

            When this object is written, the entity SHOULD save the
            change to non-volatile storage and restore the object from
            non-volatile storage upon re-initialization of the system."))

(defoid |ipTrafficStats| (|ip| 31) (:type 'object-identity))

(defoid |ipSystemStatsTable| (|ipTrafficStats| 1)
  (:type 'object-type)
  (:syntax '(vector |IpSystemStatsEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table containing system wide, IP version specific
            traffic statistics.  This table and the ipIfStatsTable
            contain similar objects whose difference is in their
            granularity.  Where this table contains system wide traffic
            statistics, the ipIfStatsTable contains the same statistics
            but counted on a per-interface basis."))

(defoid |ipSystemStatsEntry| (|ipSystemStatsTable| 1)
  (:type 'object-type)
  (:syntax '|IpSystemStatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A statistics entry containing system-wide objects for a
            particular IP version."))

(defclass |IpSystemStatsEntry|
          (sequence-type)
          ((|ipSystemStatsIPVersion| :type |InetVersion|)
           (|ipSystemStatsInReceives| :type |Counter32|)
           (|ipSystemStatsHCInReceives| :type |Counter64|)
           (|ipSystemStatsInOctets| :type |Counter32|)
           (|ipSystemStatsHCInOctets| :type |Counter64|)
           (|ipSystemStatsInHdrErrors| :type |Counter32|)
           (|ipSystemStatsInNoRoutes| :type |Counter32|)
           (|ipSystemStatsInAddrErrors| :type |Counter32|)
           (|ipSystemStatsInUnknownProtos| :type |Counter32|)
           (|ipSystemStatsInTruncatedPkts| :type |Counter32|)
           (|ipSystemStatsInForwDatagrams| :type |Counter32|)
           (|ipSystemStatsHCInForwDatagrams| :type |Counter64|)
           (|ipSystemStatsReasmReqds| :type |Counter32|)
           (|ipSystemStatsReasmOKs| :type |Counter32|)
           (|ipSystemStatsReasmFails| :type |Counter32|)
           (|ipSystemStatsInDiscards| :type |Counter32|)
           (|ipSystemStatsInDelivers| :type |Counter32|)
           (|ipSystemStatsHCInDelivers| :type |Counter64|)
           (|ipSystemStatsOutRequests| :type |Counter32|)
           (|ipSystemStatsHCOutRequests| :type |Counter64|)
           (|ipSystemStatsOutNoRoutes| :type |Counter32|)
           (|ipSystemStatsOutForwDatagrams| :type |Counter32|)
           (|ipSystemStatsHCOutForwDatagrams| :type |Counter64|)
           (|ipSystemStatsOutDiscards| :type |Counter32|)
           (|ipSystemStatsOutFragReqds| :type |Counter32|)
           (|ipSystemStatsOutFragOKs| :type |Counter32|)
           (|ipSystemStatsOutFragFails| :type |Counter32|)
           (|ipSystemStatsOutFragCreates| :type |Counter32|)
           (|ipSystemStatsOutTransmits| :type |Counter32|)
           (|ipSystemStatsHCOutTransmits| :type |Counter64|)
           (|ipSystemStatsOutOctets| :type |Counter32|)
           (|ipSystemStatsHCOutOctets| :type |Counter64|)
           (|ipSystemStatsInMcastPkts| :type |Counter32|)
           (|ipSystemStatsHCInMcastPkts| :type |Counter64|)
           (|ipSystemStatsInMcastOctets| :type |Counter32|)
           (|ipSystemStatsHCInMcastOctets| :type |Counter64|)
           (|ipSystemStatsOutMcastPkts| :type |Counter32|)
           (|ipSystemStatsHCOutMcastPkts| :type |Counter64|)
           (|ipSystemStatsOutMcastOctets| :type |Counter32|)
           (|ipSystemStatsHCOutMcastOctets| :type |Counter64|)
           (|ipSystemStatsInBcastPkts| :type |Counter32|)
           (|ipSystemStatsHCInBcastPkts| :type |Counter64|)
           (|ipSystemStatsOutBcastPkts| :type |Counter32|)
           (|ipSystemStatsHCOutBcastPkts| :type |Counter64|)
           (|ipSystemStatsDiscontinuityTime| :type |TimeStamp|)
           (|ipSystemStatsRefreshRate| :type |Unsigned32|)))

(defoid |ipSystemStatsIPVersion| (|ipSystemStatsEntry| 1)
  (:type 'object-type)
  (:syntax '|InetVersion|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The IP version of this row."))

(defoid |ipSystemStatsInReceives| (|ipSystemStatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of input IP datagrams received, including
            those received in error.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInReceives| (|ipSystemStatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of input IP datagrams received, including
            those received in error.  This object counts the same
            datagrams as ipSystemStatsInReceives, but allows for larger
            values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInOctets| (|ipSystemStatsEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in input IP datagrams,
            including those received in error.  Octets from datagrams
            counted in ipSystemStatsInReceives MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInOctets| (|ipSystemStatsEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in input IP datagrams,
            including those received in error.  This object counts the
            same octets as ipSystemStatsInOctets, but allows for larger



            values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInHdrErrors| (|ipSystemStatsEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded due to errors in
            their IP headers, including version number mismatch, other
            format errors, hop count exceeded, errors discovered in
            processing their IP options, etc.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInNoRoutes| (|ipSystemStatsEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded because no route
            could be found to transmit them to their destination.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInAddrErrors| (|ipSystemStatsEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded because the IP
            address in their IP header's destination field was not a
            valid address to be received at this entity.  This count
            includes invalid addresses (e.g., ::0).  For entities
            that are not IP routers and therefore do not forward



            datagrams, this counter includes datagrams discarded
            because the destination address was not a local address.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInUnknownProtos| (|ipSystemStatsEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of locally-addressed IP datagrams received
            successfully but discarded because of an unknown or
            unsupported protocol.

            When tracking interface statistics, the counter of the
            interface to which these datagrams were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the datagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInTruncatedPkts| (|ipSystemStatsEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded because the
            datagram frame didn't carry enough data.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInForwDatagrams| (|ipSystemStatsEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input datagrams for which this entity was not
            their final IP destination and for which this entity
            attempted to find a route to forward them to that final
            destination.  In entities that do not act as IP routers,
            this counter will include only those datagrams that were
            Source-Routed via this entity, and the Source-Route
            processing was successful.

            When tracking interface statistics, the counter of the
            incoming interface is incremented for each datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInForwDatagrams| (|ipSystemStatsEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input datagrams for which this entity was not
            their final IP destination and for which this entity
            attempted to find a route to forward them to that final
            destination.  This object counts the same packets as
            ipSystemStatsInForwDatagrams, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsReasmReqds| (|ipSystemStatsEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP fragments received that needed to be
            reassembled at this interface.

            When tracking interface statistics, the counter of the
            interface to which these fragments were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the fragments.

            Discontinuities in the value of this counter can occur at



            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsReasmOKs| (|ipSystemStatsEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams successfully reassembled.

            When tracking interface statistics, the counter of the
            interface to which these datagrams were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the datagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsReasmFails| (|ipSystemStatsEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of failures detected by the IP re-assembly
            algorithm (for whatever reason: timed out, errors, etc.).
            Note that this is not necessarily a count of discarded IP
            fragments since some algorithms (notably the algorithm in
            RFC 815) can lose track of the number of fragments by
            combining them as they are received.

            When tracking interface statistics, the counter of the
            interface to which these fragments were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the fragments.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInDiscards| (|ipSystemStatsEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams for which no problems were
            encountered to prevent their continued processing, but
            were discarded (e.g., for lack of buffer space).  Note that
            this counter does not include any datagrams discarded while
            awaiting re-assembly.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInDelivers| (|ipSystemStatsEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of datagrams successfully delivered to IP
            user-protocols (including ICMP).

            When tracking interface statistics, the counter of the
            interface to which these datagrams were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the datagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInDelivers| (|ipSystemStatsEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of datagrams successfully delivered to IP
            user-protocols (including ICMP).  This object counts the
            same packets as ipSystemStatsInDelivers, but allows for
            larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutRequests| (|ipSystemStatsEntry| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that local IP user-
            protocols (including ICMP) supplied to IP in requests for
            transmission.  Note that this counter does not include any
            datagrams counted in ipSystemStatsOutForwDatagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutRequests| (|ipSystemStatsEntry| 21)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that local IP user-
            protocols (including ICMP) supplied to IP in requests for
            transmission.  This object counts the same packets as
            ipSystemStatsOutRequests, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutNoRoutes| (|ipSystemStatsEntry| 22)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of locally generated IP datagrams discarded
            because no route could be found to transmit them to their
            destination.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutForwDatagrams| (|ipSystemStatsEntry| 23)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of datagrams for which this entity was not their
            final IP destination and for which it was successful in
            finding a path to their final destination.  In entities
            that do not act as IP routers, this counter will include
            only those datagrams that were Source-Routed via this
            entity, and the Source-Route processing was successful.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            forwarded datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutForwDatagrams| (|ipSystemStatsEntry| 24)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of datagrams for which this entity was not their
            final IP destination and for which it was successful in
            finding a path to their final destination.  This object
            counts the same packets as ipSystemStatsOutForwDatagrams,
            but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutDiscards| (|ipSystemStatsEntry| 25)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of output IP datagrams for which no problem was
            encountered to prevent their transmission to their
            destination, but were discarded (e.g., for lack of
            buffer space).  Note that this counter would include



            datagrams counted in ipSystemStatsOutForwDatagrams if any
            such datagrams met this (discretionary) discard criterion.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutFragReqds| (|ipSystemStatsEntry| 26)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams that would require fragmentation
            in order to be transmitted.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutFragOKs| (|ipSystemStatsEntry| 27)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams that have been successfully
            fragmented.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutFragFails| (|ipSystemStatsEntry| 28)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams that have been discarded because
            they needed to be fragmented but could not be.  This
            includes IPv4 packets that have the DF bit set and IPv6
            packets that are being forwarded and exceed the outgoing
            link MTU.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for an unsuccessfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutFragCreates| (|ipSystemStatsEntry| 29)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of output datagram fragments that have been
            generated as a result of IP fragmentation.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutTransmits| (|ipSystemStatsEntry| 30)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that this entity supplied
            to the lower layers for transmission.  This includes
            datagrams generated locally and those forwarded by this
            entity.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other



            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutTransmits| (|ipSystemStatsEntry| 31)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that this entity supplied
            to the lower layers for transmission.  This object counts
            the same datagrams as ipSystemStatsOutTransmits, but allows
            for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutOctets| (|ipSystemStatsEntry| 32)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets in IP datagrams delivered to the
            lower layers for transmission.  Octets from datagrams
            counted in ipSystemStatsOutTransmits MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutOctets| (|ipSystemStatsEntry| 33)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets in IP datagrams delivered to the
            lower layers for transmission.  This objects counts the same
            octets as ipSystemStatsOutOctets, but allows for larger
            values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of



            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInMcastPkts| (|ipSystemStatsEntry| 34)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams received.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInMcastPkts| (|ipSystemStatsEntry| 35)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams received.  This object
            counts the same datagrams as ipSystemStatsInMcastPkts but
            allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInMcastOctets| (|ipSystemStatsEntry| 36)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in IP multicast
            datagrams.  Octets from datagrams counted in
            ipSystemStatsInMcastPkts MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInMcastOctets| (|ipSystemStatsEntry| 37)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in IP multicast
            datagrams.  This object counts the same octets as
            ipSystemStatsInMcastOctets, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutMcastPkts| (|ipSystemStatsEntry| 38)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams transmitted.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutMcastPkts| (|ipSystemStatsEntry| 39)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams transmitted.  This
            object counts the same datagrams as
            ipSystemStatsOutMcastPkts, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutMcastOctets| (|ipSystemStatsEntry| 40)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets transmitted in IP multicast
            datagrams.  Octets from datagrams counted in



            ipSystemStatsOutMcastPkts MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutMcastOctets| (|ipSystemStatsEntry| 41)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets transmitted in IP multicast
            datagrams.  This object counts the same octets as
            ipSystemStatsOutMcastOctets, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsInBcastPkts| (|ipSystemStatsEntry| 42)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams received.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCInBcastPkts| (|ipSystemStatsEntry| 43)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams received.  This object
            counts the same datagrams as ipSystemStatsInBcastPkts but
            allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of



            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsOutBcastPkts| (|ipSystemStatsEntry| 44)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams transmitted.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsHCOutBcastPkts| (|ipSystemStatsEntry| 45)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams transmitted.  This
            object counts the same datagrams as
            ipSystemStatsOutBcastPkts, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipSystemStatsDiscontinuityTime."))

(defoid |ipSystemStatsDiscontinuityTime| (|ipSystemStatsEntry| 46)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
            any one or more of this entry's counters suffered a
            discontinuity.

            If no such discontinuities have occurred since the last re-
            initialization of the local management subsystem, then this
            object contains a zero value."))

(defoid |ipSystemStatsRefreshRate| (|ipSystemStatsEntry| 47)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum reasonable polling interval for this entry.
            This object provides an indication of the minimum amount of
            time required to update the counters in this entry."))

(defoid |ipIfStatsTableLastChange| (|ipTrafficStats| 2)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
            a row in the ipIfStatsTable was added or deleted.

            If new objects are added to the ipIfStatsTable that require
            the ipIfStatsTableLastChange to be updated when they are
            modified, they must specify that requirement in their
            description clause."))

(defoid |ipIfStatsTable| (|ipTrafficStats| 3)
  (:type 'object-type)
  (:syntax '(vector |IpIfStatsEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table containing per-interface traffic statistics.  This
            table and the ipSystemStatsTable contain similar objects
            whose difference is in their granularity.  Where this table
            contains per-interface statistics, the ipSystemStatsTable
            contains the same statistics, but counted on a system wide
            basis."))

(defoid |ipIfStatsEntry| (|ipIfStatsTable| 1)
  (:type 'object-type)
  (:syntax '|IpIfStatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An interface statistics entry containing objects for a
            particular interface and version of IP."))

(defclass |IpIfStatsEntry|
          (sequence-type)
          ((|ipIfStatsIPVersion| :type |InetVersion|)
           (|ipIfStatsIfIndex| :type |InterfaceIndex|)
           (|ipIfStatsInReceives| :type |Counter32|)
           (|ipIfStatsHCInReceives| :type |Counter64|)
           (|ipIfStatsInOctets| :type |Counter32|)
           (|ipIfStatsHCInOctets| :type |Counter64|)
           (|ipIfStatsInHdrErrors| :type |Counter32|)
           (|ipIfStatsInNoRoutes| :type |Counter32|)
           (|ipIfStatsInAddrErrors| :type |Counter32|)
           (|ipIfStatsInUnknownProtos| :type |Counter32|)
           (|ipIfStatsInTruncatedPkts| :type |Counter32|)
           (|ipIfStatsInForwDatagrams| :type |Counter32|)
           (|ipIfStatsHCInForwDatagrams| :type |Counter64|)
           (|ipIfStatsReasmReqds| :type |Counter32|)
           (|ipIfStatsReasmOKs| :type |Counter32|)
           (|ipIfStatsReasmFails| :type |Counter32|)
           (|ipIfStatsInDiscards| :type |Counter32|)
           (|ipIfStatsInDelivers| :type |Counter32|)
           (|ipIfStatsHCInDelivers| :type |Counter64|)
           (|ipIfStatsOutRequests| :type |Counter32|)
           (|ipIfStatsHCOutRequests| :type |Counter64|)
           (|ipIfStatsOutForwDatagrams| :type |Counter32|)
           (|ipIfStatsHCOutForwDatagrams| :type |Counter64|)
           (|ipIfStatsOutDiscards| :type |Counter32|)
           (|ipIfStatsOutFragReqds| :type |Counter32|)
           (|ipIfStatsOutFragOKs| :type |Counter32|)
           (|ipIfStatsOutFragFails| :type |Counter32|)
           (|ipIfStatsOutFragCreates| :type |Counter32|)
           (|ipIfStatsOutTransmits| :type |Counter32|)
           (|ipIfStatsHCOutTransmits| :type |Counter64|)
           (|ipIfStatsOutOctets| :type |Counter32|)
           (|ipIfStatsHCOutOctets| :type |Counter64|)
           (|ipIfStatsInMcastPkts| :type |Counter32|)
           (|ipIfStatsHCInMcastPkts| :type |Counter64|)
           (|ipIfStatsInMcastOctets| :type |Counter32|)
           (|ipIfStatsHCInMcastOctets| :type |Counter64|)
           (|ipIfStatsOutMcastPkts| :type |Counter32|)
           (|ipIfStatsHCOutMcastPkts| :type |Counter64|)
           (|ipIfStatsOutMcastOctets| :type |Counter32|)
           (|ipIfStatsHCOutMcastOctets| :type |Counter64|)
           (|ipIfStatsInBcastPkts| :type |Counter32|)
           (|ipIfStatsHCInBcastPkts| :type |Counter64|)
           (|ipIfStatsOutBcastPkts| :type |Counter32|)
           (|ipIfStatsHCOutBcastPkts| :type |Counter64|)
           (|ipIfStatsDiscontinuityTime| :type |TimeStamp|)
           (|ipIfStatsRefreshRate| :type |Unsigned32|)))

(defoid |ipIfStatsIPVersion| (|ipIfStatsEntry| 1)
  (:type 'object-type)
  (:syntax '|InetVersion|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The IP version of this row."))

(defoid |ipIfStatsIfIndex| (|ipIfStatsEntry| 2)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface to
            which this entry is applicable.  The interface identified by
            a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipIfStatsInReceives| (|ipIfStatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of input IP datagrams received, including
            those received in error.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInReceives| (|ipIfStatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of input IP datagrams received, including
            those received in error.  This object counts the same
            datagrams as ipIfStatsInReceives, but allows for larger
            values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInOctets| (|ipIfStatsEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in input IP datagrams,
            including those received in error.  Octets from datagrams
            counted in ipIfStatsInReceives MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInOctets| (|ipIfStatsEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in input IP datagrams,
            including those received in error.  This object counts the
            same octets as ipIfStatsInOctets, but allows for larger
            values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInHdrErrors| (|ipIfStatsEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded due to errors in
            their IP headers, including version number mismatch, other
            format errors, hop count exceeded, errors discovered in
            processing their IP options, etc.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInNoRoutes| (|ipIfStatsEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded because no route
            could be found to transmit them to their destination.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInAddrErrors| (|ipIfStatsEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded because the IP
            address in their IP header's destination field was not a
            valid address to be received at this entity.  This count
            includes invalid addresses (e.g., ::0).  For entities that
            are not IP routers and therefore do not forward datagrams,
            this counter includes datagrams discarded because the
            destination address was not a local address.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInUnknownProtos| (|ipIfStatsEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of locally-addressed IP datagrams received
            successfully but discarded because of an unknown or
            unsupported protocol.

            When tracking interface statistics, the counter of the
            interface to which these datagrams were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the datagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of



            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInTruncatedPkts| (|ipIfStatsEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams discarded because the
            datagram frame didn't carry enough data.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInForwDatagrams| (|ipIfStatsEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input datagrams for which this entity was not
            their final IP destination and for which this entity
            attempted to find a route to forward them to that final
            destination.  In entities that do not act as IP routers,
            this counter will include only those datagrams that were
            Source-Routed via this entity, and the Source-Route
            processing was successful.

            When tracking interface statistics, the counter of the
            incoming interface is incremented for each datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInForwDatagrams| (|ipIfStatsEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input datagrams for which this entity was not
            their final IP destination and for which this entity
            attempted to find a route to forward them to that final
            destination.  This object counts the same packets as



            ipIfStatsInForwDatagrams, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsReasmReqds| (|ipIfStatsEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP fragments received that needed to be
            reassembled at this interface.

            When tracking interface statistics, the counter of the
            interface to which these fragments were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the fragments.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsReasmOKs| (|ipIfStatsEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams successfully reassembled.

            When tracking interface statistics, the counter of the
            interface to which these datagrams were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the datagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsReasmFails| (|ipIfStatsEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of failures detected by the IP re-assembly
            algorithm (for whatever reason: timed out, errors, etc.).
            Note that this is not necessarily a count of discarded IP
            fragments since some algorithms (notably the algorithm in
            RFC 815) can lose track of the number of fragments by
            combining them as they are received.

            When tracking interface statistics, the counter of the
            interface to which these fragments were addressed is
            incremented.  This interface might not be the same as the
            input interface for some of the fragments.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInDiscards| (|ipIfStatsEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of input IP datagrams for which no problems were
            encountered to prevent their continued processing, but
            were discarded (e.g., for lack of buffer space).  Note that
            this counter does not include any datagrams discarded while
            awaiting re-assembly.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInDelivers| (|ipIfStatsEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of datagrams successfully delivered to IP
            user-protocols (including ICMP).

            When tracking interface statistics, the counter of the
            interface to which these datagrams were addressed is
            incremented.  This interface might not be the same as the



            input interface for some of the datagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInDelivers| (|ipIfStatsEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of datagrams successfully delivered to IP
            user-protocols (including ICMP).  This object counts the
            same packets as ipIfStatsInDelivers, but allows for larger
            values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutRequests| (|ipIfStatsEntry| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that local IP user-
            protocols (including ICMP) supplied to IP in requests for
            transmission.  Note that this counter does not include any
            datagrams counted in ipIfStatsOutForwDatagrams.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutRequests| (|ipIfStatsEntry| 21)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that local IP user-
            protocols (including ICMP) supplied to IP in requests for
            transmission.  This object counts the same packets as



            ipIfStatsOutRequests, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutForwDatagrams| (|ipIfStatsEntry| 23)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of datagrams for which this entity was not their
            final IP destination and for which it was successful in
            finding a path to their final destination.  In entities
            that do not act as IP routers, this counter will include
            only those datagrams that were Source-Routed via this
            entity, and the Source-Route processing was successful.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            forwarded datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutForwDatagrams| (|ipIfStatsEntry| 24)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of datagrams for which this entity was not their
            final IP destination and for which it was successful in
            finding a path to their final destination.  This object
            counts the same packets as ipIfStatsOutForwDatagrams, but
            allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of



            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutDiscards| (|ipIfStatsEntry| 25)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of output IP datagrams for which no problem was
            encountered to prevent their transmission to their
            destination, but were discarded (e.g., for lack of
            buffer space).  Note that this counter would include
            datagrams counted in ipIfStatsOutForwDatagrams if any such
            datagrams met this (discretionary) discard criterion.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutFragReqds| (|ipIfStatsEntry| 26)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams that would require fragmentation
            in order to be transmitted.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutFragOKs| (|ipIfStatsEntry| 27)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams that have been successfully
            fragmented.

            When tracking interface statistics, the counter of the



            outgoing interface is incremented for a successfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutFragFails| (|ipIfStatsEntry| 28)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP datagrams that have been discarded because
            they needed to be fragmented but could not be.  This
            includes IPv4 packets that have the DF bit set and IPv6
            packets that are being forwarded and exceed the outgoing
            link MTU.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for an unsuccessfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutFragCreates| (|ipIfStatsEntry| 29)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of output datagram fragments that have been
            generated as a result of IP fragmentation.

            When tracking interface statistics, the counter of the
            outgoing interface is incremented for a successfully
            fragmented datagram.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutTransmits| (|ipIfStatsEntry| 30)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that this entity supplied
            to the lower layers for transmission.  This includes
            datagrams generated locally and those forwarded by this
            entity.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutTransmits| (|ipIfStatsEntry| 31)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of IP datagrams that this entity supplied
            to the lower layers for transmission.  This object counts
            the same datagrams as ipIfStatsOutTransmits, but allows for
            larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutOctets| (|ipIfStatsEntry| 32)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets in IP datagrams delivered to the
            lower layers for transmission.  Octets from datagrams
            counted in ipIfStatsOutTransmits MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutOctets| (|ipIfStatsEntry| 33)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets in IP datagrams delivered to the
            lower layers for transmission.  This objects counts the same
            octets as ipIfStatsOutOctets, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInMcastPkts| (|ipIfStatsEntry| 34)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams received.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInMcastPkts| (|ipIfStatsEntry| 35)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams received.  This object
            counts the same datagrams as ipIfStatsInMcastPkts, but
            allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInMcastOctets| (|ipIfStatsEntry| 36)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in IP multicast



            datagrams.  Octets from datagrams counted in
            ipIfStatsInMcastPkts MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInMcastOctets| (|ipIfStatsEntry| 37)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets received in IP multicast
            datagrams.  This object counts the same octets as
            ipIfStatsInMcastOctets, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutMcastPkts| (|ipIfStatsEntry| 38)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams transmitted.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutMcastPkts| (|ipIfStatsEntry| 39)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP multicast datagrams transmitted.  This
            object counts the same datagrams as ipIfStatsOutMcastPkts,
            but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other



            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutMcastOctets| (|ipIfStatsEntry| 40)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets transmitted in IP multicast
            datagrams.  Octets from datagrams counted in
            ipIfStatsOutMcastPkts MUST be counted here.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutMcastOctets| (|ipIfStatsEntry| 41)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets transmitted in IP multicast
            datagrams.  This object counts the same octets as
            ipIfStatsOutMcastOctets, but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsInBcastPkts| (|ipIfStatsEntry| 42)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams received.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCInBcastPkts| (|ipIfStatsEntry| 43)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams received.  This object
            counts the same datagrams as ipIfStatsInBcastPkts, but
            allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsOutBcastPkts| (|ipIfStatsEntry| 44)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams transmitted.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsHCOutBcastPkts| (|ipIfStatsEntry| 45)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of IP broadcast datagrams transmitted.  This
            object counts the same datagrams as ipIfStatsOutBcastPkts,
            but allows for larger values.

            Discontinuities in the value of this counter can occur at
            re-initialization of the management system, and at other
            times as indicated by the value of
            ipIfStatsDiscontinuityTime."))

(defoid |ipIfStatsDiscontinuityTime| (|ipIfStatsEntry| 46)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which



            any one or more of this entry's counters suffered a
            discontinuity.

            If no such discontinuities have occurred since the last re-
            initialization of the local management subsystem, then this
            object contains a zero value."))

(defoid |ipIfStatsRefreshRate| (|ipIfStatsEntry| 47)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum reasonable polling interval for this entry.
            This object provides an indication of the minimum amount of
            time required to update the counters in this entry."))

(defoid |ipAddressPrefixTable| (|ip| 32)
  (:type 'object-type)
  (:syntax '(vector |IpAddressPrefixEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table allows the user to determine the source of an IP
            address or set of IP addresses, and allows other tables to
            share the information via pointer rather than by copying.

            For example, when the node configures both a unicast and
            anycast address for a prefix, the ipAddressPrefix objects
            for those addresses will point to a single row in this
            table.

            This table primarily provides support for IPv6 prefixes, and
            several of the objects are less meaningful for IPv4.  The
            table continues to allow IPv4 addresses to allow future
            flexibility.  In order to promote a common configuration,
            this document includes suggestions for default values for
            IPv4 prefixes.  Each of these values may be overridden if an
            object is meaningful to the node.

            All prefixes used by this entity should be included in this
            table independent of how the entity learned the prefix.
            (This table isn't limited to prefixes learned from router



            advertisements.)"))

(defoid |ipAddressPrefixEntry| (|ipAddressPrefixTable| 1)
  (:type 'object-type)
  (:syntax '|IpAddressPrefixEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry in the ipAddressPrefixTable."))

(defclass |IpAddressPrefixEntry|
          (sequence-type)
          ((|ipAddressPrefixIfIndex| :type |InterfaceIndex|)
           (|ipAddressPrefixType| :type |InetAddressType|)
           (|ipAddressPrefixPrefix| :type |InetAddress|)
           (|ipAddressPrefixLength| :type |InetAddressPrefixLength|)
           (|ipAddressPrefixOrigin| :type |IpAddressPrefixOriginTC|)
           (|ipAddressPrefixOnLinkFlag| :type |TruthValue|)
           (|ipAddressPrefixAutonomousFlag| :type |TruthValue|)
           (|ipAddressPrefixAdvPreferredLifetime| :type |Unsigned32|)
           (|ipAddressPrefixAdvValidLifetime| :type |Unsigned32|)))

(defoid |ipAddressPrefixIfIndex| (|ipAddressPrefixEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface on
            which this prefix is configured.  The interface identified
            by a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipAddressPrefixType| (|ipAddressPrefixEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The address type of ipAddressPrefix."))

(defoid |ipAddressPrefixPrefix| (|ipAddressPrefixEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The address prefix.  The address type of this object is
            specified in ipAddressPrefixType.  The length of this object
            is the standard length for objects of that type (4 or 16
            bytes).  Any bits after ipAddressPrefixLength must be zero.

            Implementors need to be aware that, if the size of
            ipAddressPrefixPrefix exceeds 114 octets, then OIDS of
            instances of columns in this row will have more than 128
            sub-identifiers and cannot be accessed using SNMPv1,
            SNMPv2c, or SNMPv3."))

(defoid |ipAddressPrefixLength| (|ipAddressPrefixEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddressPrefixLength|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The prefix length associated with this prefix.

            The value 0 has no special meaning for this object.  It
            simply refers to address '::/0'."))

(defoid |ipAddressPrefixOrigin| (|ipAddressPrefixEntry| 5)
  (:type 'object-type)
  (:syntax '|IpAddressPrefixOriginTC|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The origin of this prefix."))

(defoid |ipAddressPrefixOnLinkFlag| (|ipAddressPrefixEntry| 6)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object has the value 'true(1)', if this prefix can be
            used for on-link determination; otherwise, the value is
            'false(2)'.

            The default for IPv4 prefixes is 'true(1)'.")
  (:reference
   "For IPv6 RFC 2461, especially sections 2 and 4.6.2 and
               RFC 2462"))

(defoid |ipAddressPrefixAutonomousFlag| (|ipAddressPrefixEntry| 7)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Autonomous address configuration flag.  When true(1),
            indicates that this prefix can be used for autonomous
            address configuration (i.e., can be used to form a local
            interface address).  If false(2), it is not used to auto-
            configure a local interface address.

            The default for IPv4 prefixes is 'false(2)'.")
  (:reference
   "For IPv6 RFC 2461, especially sections 2 and 4.6.2 and
               RFC 2462"))

(defoid |ipAddressPrefixAdvPreferredLifetime|
        (|ipAddressPrefixEntry| 8)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The remaining length of time, in seconds, that this prefix
            will continue to be preferred, i.e., time until deprecation.

            A value of 4,294,967,295 represents infinity.

            The address generated from a deprecated prefix should no
            longer be used as a source address in new communications,
            but packets received on such an interface are processed as
            expected.

            The default for IPv4 prefixes is 4,294,967,295 (infinity).")
  (:reference
   "For IPv6 RFC 2461, especially sections 2 and 4.6.2 and
               RFC 2462"))

(defoid |ipAddressPrefixAdvValidLifetime| (|ipAddressPrefixEntry| 9)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The remaining length of time, in seconds, that this prefix
            will continue to be valid, i.e., time until invalidation.  A
            value of 4,294,967,295 represents infinity.

            The address generated from an invalidated prefix should not
            appear as the destination or source address of a packet.




            The default for IPv4 prefixes is 4,294,967,295 (infinity).")
  (:reference
   "For IPv6 RFC 2461, especially sections 2 and 4.6.2 and
               RFC 2462"))

(defoid |ipAddressSpinLock| (|ip| 33)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "An advisory lock used to allow cooperating SNMP managers to
            coordinate their use of the set operation in creating or
            modifying rows within this table.

            In order to use this lock to coordinate the use of set
            operations, managers should first retrieve
            ipAddressTableSpinLock.  They should then determine the
            appropriate row to create or modify.  Finally, they should
            issue the appropriate set command, including the retrieved
            value of ipAddressSpinLock.  If another manager has altered
            the table in the meantime, then the value of
            ipAddressSpinLock will have changed, and the creation will
            fail as it will be specifying an incorrect value for
            ipAddressSpinLock.  It is suggested, but not required, that
            the ipAddressSpinLock be the first var bind for each set of
            objects representing a 'row' in a PDU."))

(defoid |ipAddressTable| (|ip| 34)
  (:type 'object-type)
  (:syntax '(vector |IpAddressEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table contains addressing information relevant to the
            entity's interfaces.

            This table does not contain multicast address information.
            Tables for such information should be contained in multicast
            specific MIBs, such as RFC 3019.

            While this table is writable, the user will note that
            several objects, such as ipAddressOrigin, are not.  The
            intention in allowing a user to write to this table is to
            allow them to add or remove any entry that isn't



            permanent.  The user should be allowed to modify objects
            and entries when that would not cause inconsistencies
            within the table.  Allowing write access to objects, such
            as ipAddressOrigin, could allow a user to insert an entry
            and then label it incorrectly.

            Note well: When including IPv6 link-local addresses in this
            table, the entry must use an InetAddressType of 'ipv6z' in
            order to differentiate between the possible interfaces."))

(defoid |ipAddressEntry| (|ipAddressTable| 1)
  (:type 'object-type)
  (:syntax '|IpAddressEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An address mapping for a particular interface."))

(defclass |IpAddressEntry|
          (sequence-type)
          ((|ipAddressAddrType| :type |InetAddressType|)
           (|ipAddressAddr| :type |InetAddress|)
           (|ipAddressIfIndex| :type |InterfaceIndex|)
           (|ipAddressType| :type integer)
           (|ipAddressPrefix| :type |RowPointer|)
           (|ipAddressOrigin| :type |IpAddressOriginTC|)
           (|ipAddressStatus| :type |IpAddressStatusTC|)
           (|ipAddressCreated| :type |TimeStamp|)
           (|ipAddressLastChanged| :type |TimeStamp|)
           (|ipAddressRowStatus| :type |RowStatus|)
           (|ipAddressStorageType| :type |StorageType|)))

(defoid |ipAddressAddrType| (|ipAddressEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The address type of ipAddressAddr."))

(defoid |ipAddressAddr| (|ipAddressEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The IP address to which this entry's addressing information



            pertains.  The address type of this object is specified in
            ipAddressAddrType.

            Implementors need to be aware that if the size of
            ipAddressAddr exceeds 116 octets, then OIDS of instances of
            columns in this row will have more than 128 sub-identifiers
            and cannot be accessed using SNMPv1, SNMPv2c, or SNMPv3."))

(defoid |ipAddressIfIndex| (|ipAddressEntry| 3)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface to
            which this entry is applicable.  The interface identified by
            a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipAddressType| (|ipAddressEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of address.  broadcast(3) is not a valid value for
            IPv6 addresses (RFC 3513)."))

(defoid |ipAddressPrefix| (|ipAddressEntry| 5)
  (:type 'object-type)
  (:syntax '|RowPointer|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A pointer to the row in the prefix table to which this
            address belongs.  May be { 0 0 } if there is no such row."))

(defoid |ipAddressOrigin| (|ipAddressEntry| 6)
  (:type 'object-type)
  (:syntax '|IpAddressOriginTC|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The origin of the address."))

(defoid |ipAddressStatus| (|ipAddressEntry| 7)
  (:type 'object-type)
  (:syntax '|IpAddressStatusTC|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of the address, describing if the address can be
            used for communication.

            In the absence of other information, an IPv4 address is
            always preferred(1)."))

(defoid |ipAddressCreated| (|ipAddressEntry| 8)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this entry was created.
            If this entry was created prior to the last re-
            initialization of the local network management subsystem,
            then this object contains a zero value."))

(defoid |ipAddressLastChanged| (|ipAddressEntry| 9)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this entry was last
            updated.  If this entry was updated prior to the last re-
            initialization of the local network management subsystem,
            then this object contains a zero value."))

(defoid |ipAddressRowStatus| (|ipAddressEntry| 10)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

            The RowStatus TC requires that this DESCRIPTION clause
            states under which circumstances other objects in this row



            can be modified.  The value of this object has no effect on
            whether other objects in this conceptual row can be
            modified.

            A conceptual row can not be made active until the
            ipAddressIfIndex has been set to a valid index."))

(defoid |ipAddressStorageType| (|ipAddressEntry| 11)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.  If this object
            has a value of 'permanent', then no other objects are
            required to be able to be modified."))

(defoid |ipNetToPhysicalTable| (|ip| 35)
  (:type 'object-type)
  (:syntax '(vector |IpNetToPhysicalEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The IP Address Translation table used for mapping from IP
            addresses to physical addresses.

            The Address Translation tables contain the IP address to
            'physical' address equivalences.  Some interfaces do not use
            translation tables for determining address equivalences
            (e.g., DDN-X.25 has an algorithmic method); if all
            interfaces are of this type, then the Address Translation
            table is empty, i.e., has zero entries.

            While many protocols may be used to populate this table, ARP
            and Neighbor Discovery are the most likely
            options.")
  (:reference "RFC 826 and RFC 2461"))

(defoid |ipNetToPhysicalEntry| (|ipNetToPhysicalTable| 1)
  (:type 'object-type)
  (:syntax '|IpNetToPhysicalEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Each entry contains one IP address to `physical' address
            equivalence."))

(defclass |IpNetToPhysicalEntry|
          (sequence-type)
          ((|ipNetToPhysicalIfIndex| :type |InterfaceIndex|)
           (|ipNetToPhysicalNetAddressType| :type |InetAddressType|)
           (|ipNetToPhysicalNetAddress| :type |InetAddress|)
           (|ipNetToPhysicalPhysAddress| :type |PhysAddress|)
           (|ipNetToPhysicalLastUpdated| :type |TimeStamp|)
           (|ipNetToPhysicalType| :type integer)
           (|ipNetToPhysicalState| :type integer)
           (|ipNetToPhysicalRowStatus| :type |RowStatus|)))

(defoid |ipNetToPhysicalIfIndex| (|ipNetToPhysicalEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface to
            which this entry is applicable.  The interface identified by
            a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipNetToPhysicalNetAddressType| (|ipNetToPhysicalEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The type of ipNetToPhysicalNetAddress."))

(defoid |ipNetToPhysicalNetAddress| (|ipNetToPhysicalEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The IP Address corresponding to the media-dependent
            `physical' address.  The address type of this object is
            specified in ipNetToPhysicalAddressType.

            Implementors need to be aware that if the size of



            ipNetToPhysicalNetAddress exceeds 115 octets, then OIDS of
            instances of columns in this row will have more than 128
            sub-identifiers and cannot be accessed using SNMPv1,
            SNMPv2c, or SNMPv3."))

(defoid |ipNetToPhysicalPhysAddress| (|ipNetToPhysicalEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The media-dependent `physical' address.

            As the entries in this table are typically not persistent
            when this object is written the entity SHOULD NOT save the
            change to non-volatile storage."))

(defoid |ipNetToPhysicalLastUpdated| (|ipNetToPhysicalEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this entry was last
            updated.  If this entry was updated prior to the last re-
            initialization of the local network management subsystem,
            then this object contains a zero value."))

(defoid |ipNetToPhysicalType| (|ipNetToPhysicalEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of mapping.

            Setting this object to the value invalid(2) has the effect
            of invalidating the corresponding entry in the
            ipNetToPhysicalTable.  That is, it effectively dis-
            associates the interface identified with said entry from the
            mapping identified with said entry.  It is an
            implementation-specific matter as to whether the agent



            removes an invalidated entry from the table.  Accordingly,
            management stations must be prepared to receive tabular
            information from agents that corresponds to entries not
            currently in use.  Proper interpretation of such entries
            requires examination of the relevant ipNetToPhysicalType
            object.

            The 'dynamic(3)' type indicates that the IP address to
            physical addresses mapping has been dynamically resolved
            using e.g., IPv4 ARP or the IPv6 Neighbor Discovery
            protocol.

            The 'static(4)' type indicates that the mapping has been
            statically configured.  Both of these refer to entries that
            provide mappings for other entities addresses.

            The 'local(5)' type indicates that the mapping is provided
            for an entity's own interface address.

            As the entries in this table are typically not persistent
            when this object is written the entity SHOULD NOT save the
            change to non-volatile storage."))

(defoid |ipNetToPhysicalState| (|ipNetToPhysicalEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Neighbor Unreachability Detection state for the
            interface when the address mapping in this entry is used.
            If Neighbor Unreachability Detection is not in use (e.g. for
            IPv4), this object is always unknown(6).")
  (:reference "RFC 2461"))

(defoid |ipNetToPhysicalRowStatus| (|ipNetToPhysicalEntry| 8)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

            The RowStatus TC requires that this DESCRIPTION clause
            states under which circumstances other objects in this row
            can be modified.  The value of this object has no effect on
            whether other objects in this conceptual row can be
            modified.

            A conceptual row can not be made active until the
            ipNetToPhysicalPhysAddress object has been set.

            Note that if the ipNetToPhysicalType is set to 'invalid',
            the managed node may delete the entry independent of the
            state of this object."))

(defoid |ipv6ScopeZoneIndexTable| (|ip| 36)
  (:type 'object-type)
  (:syntax '(vector |Ipv6ScopeZoneIndexEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table used to describe IPv6 unicast and multicast scope
            zones.

            For those objects that have names rather than numbers, the
            names were chosen to coincide with the names used in the
            IPv6 address architecture document. ")
  (:reference "Section 2.7 of RFC 4291"))

(defoid |ipv6ScopeZoneIndexEntry| (|ipv6ScopeZoneIndexTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv6ScopeZoneIndexEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Each entry contains the list of scope identifiers on a given
            interface."))

(defclass |Ipv6ScopeZoneIndexEntry|
          (sequence-type)
          ((|ipv6ScopeZoneIndexIfIndex| :type |InterfaceIndex|)
           (|ipv6ScopeZoneIndexLinkLocal| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndex3| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexAdminLocal| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexSiteLocal| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndex6| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndex7| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexOrganizationLocal|
            :type
            |InetZoneIndex|)
           (|ipv6ScopeZoneIndex9| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexA| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexB| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexC| :type |InetZoneIndex|)
           (|ipv6ScopeZoneIndexD| :type |InetZoneIndex|)))

(defoid |ipv6ScopeZoneIndexIfIndex| (|ipv6ScopeZoneIndexEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface to
            which these scopes belong.  The interface identified by a
            particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipv6ScopeZoneIndexLinkLocal| (|ipv6ScopeZoneIndexEntry| 2)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The zone index for the link-local scope on this interface."))

(defoid |ipv6ScopeZoneIndex3| (|ipv6ScopeZoneIndexEntry| 3)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope 3 on this interface."))

(defoid |ipv6ScopeZoneIndexAdminLocal| (|ipv6ScopeZoneIndexEntry| 4)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The zone index for the admin-local scope on this interface."))

(defoid |ipv6ScopeZoneIndexSiteLocal| (|ipv6ScopeZoneIndexEntry| 5)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The zone index for the site-local scope on this interface."))

(defoid |ipv6ScopeZoneIndex6| (|ipv6ScopeZoneIndexEntry| 6)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope 6 on this interface."))

(defoid |ipv6ScopeZoneIndex7| (|ipv6ScopeZoneIndexEntry| 7)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope 7 on this interface."))

(defoid |ipv6ScopeZoneIndexOrganizationLocal|
        (|ipv6ScopeZoneIndexEntry| 8)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The zone index for the organization-local scope on this
            interface."))

(defoid |ipv6ScopeZoneIndex9| (|ipv6ScopeZoneIndexEntry| 9)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope 9 on this interface."))

(defoid |ipv6ScopeZoneIndexA| (|ipv6ScopeZoneIndexEntry| 10)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope A on this interface."))

(defoid |ipv6ScopeZoneIndexB| (|ipv6ScopeZoneIndexEntry| 11)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope B on this interface."))

(defoid |ipv6ScopeZoneIndexC| (|ipv6ScopeZoneIndexEntry| 12)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope C on this interface."))

(defoid |ipv6ScopeZoneIndexD| (|ipv6ScopeZoneIndexEntry| 13)
  (:type 'object-type)
  (:syntax '|InetZoneIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The zone index for scope D on this interface."))

(defoid |ipDefaultRouterTable| (|ip| 37)
  (:type 'object-type)
  (:syntax '(vector |IpDefaultRouterEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table used to describe the default routers known to this



            entity."))

(defoid |ipDefaultRouterEntry| (|ipDefaultRouterTable| 1)
  (:type 'object-type)
  (:syntax '|IpDefaultRouterEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Each entry contains information about a default router known
            to this entity."))

(defclass |IpDefaultRouterEntry|
          (sequence-type)
          ((|ipDefaultRouterAddressType| :type |InetAddressType|)
           (|ipDefaultRouterAddress| :type |InetAddress|)
           (|ipDefaultRouterIfIndex| :type |InterfaceIndex|)
           (|ipDefaultRouterLifetime| :type |Unsigned32|)
           (|ipDefaultRouterPreference| :type integer)))

(defoid |ipDefaultRouterAddressType| (|ipDefaultRouterEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The address type for this row."))

(defoid |ipDefaultRouterAddress| (|ipDefaultRouterEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The IP address of the default router represented by this
            row.  The address type of this object is specified in
            ipDefaultRouterAddressType.

            Implementers need to be aware that if the size of
            ipDefaultRouterAddress exceeds 115 octets, then OIDS of
            instances of columns in this row will have more than 128
            sub-identifiers and cannot be accessed using SNMPv1,
            SNMPv2c, or SNMPv3."))

(defoid |ipDefaultRouterIfIndex| (|ipDefaultRouterEntry| 3)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface by
            which the router can be reached.  The interface identified
            by a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipDefaultRouterLifetime| (|ipDefaultRouterEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The remaining length of time, in seconds, that this router
            will continue to be useful as a default router.  A value of
            zero indicates that it is no longer useful as a default
            router.  It is left to the implementer of the MIB as to
            whether a router with a lifetime of zero is removed from the
            list.

            For IPv6, this value should be extracted from the router
            advertisement messages.")
  (:reference "For IPv6 RFC 2462 sections 4.2 and 6.3.4"))

(defoid |ipDefaultRouterPreference| (|ipDefaultRouterEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An indication of preference given to this router as a
            default router as described in he Default Router
            Preferences document.  Treating the value as a
            2 bit signed integer allows for simple arithmetic
            comparisons.

            For IPv4 routers or IPv6 routers that are not using the
            updated router advertisement format, this object is set to
            medium (0).")
  (:reference "RFC 4291, section 2.1"))

(defoid |ipv6RouterAdvertSpinLock| (|ip| 38)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "An advisory lock used to allow cooperating SNMP managers to
            coordinate their use of the set operation in creating or
            modifying rows within this table.

            In order to use this lock to coordinate the use of set
            operations, managers should first retrieve
            ipv6RouterAdvertSpinLock.  They should then determine the
            appropriate row to create or modify.  Finally, they should
            issue the appropriate set command including the retrieved
            value of ipv6RouterAdvertSpinLock.  If another manager has
            altered the table in the meantime, then the value of
            ipv6RouterAdvertSpinLock will have changed and the creation
            will fail as it will be specifying an incorrect value for
            ipv6RouterAdvertSpinLock.  It is suggested, but not
            required, that the ipv6RouterAdvertSpinLock be the first var
            bind for each set of objects representing a 'row' in a PDU."))

(defoid |ipv6RouterAdvertTable| (|ip| 39)
  (:type 'object-type)
  (:syntax '(vector |Ipv6RouterAdvertEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table containing information used to construct router
            advertisements."))

(defoid |ipv6RouterAdvertEntry| (|ipv6RouterAdvertTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv6RouterAdvertEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing information used to construct router
            advertisements.

            Information in this table is persistent, and when this
            object is written, the entity SHOULD save the change to
            non-volatile storage."))

(defclass |Ipv6RouterAdvertEntry|
          (sequence-type)
          ((|ipv6RouterAdvertIfIndex| :type |InterfaceIndex|)
           (|ipv6RouterAdvertSendAdverts| :type |TruthValue|)
           (|ipv6RouterAdvertMaxInterval| :type |Unsigned32|)
           (|ipv6RouterAdvertMinInterval| :type |Unsigned32|)
           (|ipv6RouterAdvertManagedFlag| :type |TruthValue|)
           (|ipv6RouterAdvertOtherConfigFlag| :type |TruthValue|)
           (|ipv6RouterAdvertLinkMTU| :type |Unsigned32|)
           (|ipv6RouterAdvertReachableTime| :type |Unsigned32|)
           (|ipv6RouterAdvertRetransmitTime| :type |Unsigned32|)
           (|ipv6RouterAdvertCurHopLimit| :type |Unsigned32|)
           (|ipv6RouterAdvertDefaultLifetime| :type |Unsigned32|)
           (|ipv6RouterAdvertRowStatus| :type |RowStatus|)))

(defoid |ipv6RouterAdvertIfIndex| (|ipv6RouterAdvertEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index value that uniquely identifies the interface on
            which router advertisements constructed with this
            information will be transmitted.  The interface identified
            by a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipv6RouterAdvertSendAdverts| (|ipv6RouterAdvertEntry| 2)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A flag indicating whether the router sends periodic
            router advertisements and responds to router solicitations
            on this interface.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertMaxInterval| (|ipv6RouterAdvertEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum time allowed between sending unsolicited router



            advertisements from this interface.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertMinInterval| (|ipv6RouterAdvertEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The minimum time allowed between sending unsolicited router
            advertisements from this interface.

            The default is 0.33 * ipv6RouterAdvertMaxInterval, however,
            in the case of a low value for ipv6RouterAdvertMaxInterval,
            the minimum value for this object is restricted to 3.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertManagedFlag| (|ipv6RouterAdvertEntry| 5)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The true/false value to be placed into the 'managed address
            configuration' flag field in router advertisements sent from
            this interface.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertOtherConfigFlag| (|ipv6RouterAdvertEntry| 6)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The true/false value to be placed into the 'other stateful
            configuration' flag field in router advertisements sent from
            this interface.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertLinkMTU| (|ipv6RouterAdvertEntry| 7)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value to be placed in MTU options sent by the router on
            this interface.

            A value of zero indicates that no MTU options are sent.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertReachableTime| (|ipv6RouterAdvertEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value to be placed in the reachable time field in router
            advertisement messages sent from this interface.

            A value of zero in the router advertisement indicates that
            the advertisement isn't specifying a value for reachable
            time.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertRetransmitTime| (|ipv6RouterAdvertEntry| 9)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value to be placed in the retransmit timer field in
            router advertisements sent from this interface.

            A value of zero in the router advertisement indicates that
            the advertisement isn't specifying a value for retrans
            time.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertCurHopLimit| (|ipv6RouterAdvertEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The default value to be placed in the current hop limit
            field in router advertisements sent from this interface.



            The value should be set to the current diameter of the
            Internet.

            A value of zero in the router advertisement indicates that
            the advertisement isn't specifying a value for curHopLimit.

            The default should be set to the value specified in the IANA
            web pages (www.iana.org) at the time of implementation.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertDefaultLifetime| (|ipv6RouterAdvertEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value to be placed in the router lifetime field of
            router advertisements sent from this interface.  This value
            MUST be either 0 or between ipv6RouterAdvertMaxInterval and
            9000 seconds.

            A value of zero indicates that the router is not to be used
            as a default router.

            The default is 3 * ipv6RouterAdvertMaxInterval.")
  (:reference "RFC 2461 Section 6.2.1"))

(defoid |ipv6RouterAdvertRowStatus| (|ipv6RouterAdvertEntry| 12)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

            As all objects in this conceptual row have default values, a
            row can be created and made active by setting this object
            appropriately.

            The RowStatus TC requires that this DESCRIPTION clause
            states under which circumstances other objects in this row
            can be modified.  The value of this object has no effect on
            whether other objects in this conceptual row can be
            modified."))

(defoid |icmp| (|mib-2| 5) (:type 'object-identity))

(defoid |icmpStatsTable| (|icmp| 29)
  (:type 'object-type)
  (:syntax '(vector |IcmpStatsEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The table of generic system-wide ICMP counters."))

(defoid |icmpStatsEntry| (|icmpStatsTable| 1)
  (:type 'object-type)
  (:syntax '|IcmpStatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row in the icmpStatsTable."))

(defclass |IcmpStatsEntry|
          (sequence-type)
          ((|icmpStatsIPVersion| :type |InetVersion|)
           (|icmpStatsInMsgs| :type |Counter32|)
           (|icmpStatsInErrors| :type |Counter32|)
           (|icmpStatsOutMsgs| :type |Counter32|)
           (|icmpStatsOutErrors| :type |Counter32|)))

(defoid |icmpStatsIPVersion| (|icmpStatsEntry| 1)
  (:type 'object-type)
  (:syntax '|InetVersion|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The IP version of the statistics."))

(defoid |icmpStatsInMsgs| (|icmpStatsEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of ICMP messages that the entity received.
            Note that this counter includes all those counted by
            icmpStatsInErrors."))

(defoid |icmpStatsInErrors| (|icmpStatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP messages that the entity received but
            determined as having ICMP-specific errors (bad ICMP
            checksums, bad length, etc.)."))

(defoid |icmpStatsOutMsgs| (|icmpStatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of ICMP messages that the entity attempted
            to send.  Note that this counter includes all those counted
            by icmpStatsOutErrors."))

(defoid |icmpStatsOutErrors| (|icmpStatsEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP messages that this entity did not send
            due to problems discovered within ICMP, such as a lack of
            buffers.  This value should not include errors discovered
            outside the ICMP layer, such as the inability of IP to route
            the resultant datagram.  In some implementations, there may
            be no types of error that contribute to this counter's
            value."))

(defoid |icmpMsgStatsTable| (|icmp| 30)
  (:type 'object-type)
  (:syntax '(vector |IcmpMsgStatsEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of system-wide per-version, per-message type ICMP
            counters."))

(defoid |icmpMsgStatsEntry| (|icmpMsgStatsTable| 1)
  (:type 'object-type)
  (:syntax '|IcmpMsgStatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A conceptual row in the icmpMsgStatsTable.

            The system should track each ICMP type value, even if that
            ICMP type is not supported by the system.  However, a
            given row need not be instantiated unless a message of that
            type has been processed, i.e., the row for
            icmpMsgStatsType=X MAY be instantiated before but MUST be
            instantiated after the first message with Type=X is
            received or transmitted.  After receiving or transmitting
            any succeeding messages with Type=X, the relevant counter
            must be incremented."))

(defclass |IcmpMsgStatsEntry|
          (sequence-type)
          ((|icmpMsgStatsIPVersion| :type |InetVersion|)
           (|icmpMsgStatsType| :type |Integer32|)
           (|icmpMsgStatsInPkts| :type |Counter32|)
           (|icmpMsgStatsOutPkts| :type |Counter32|)))

(defoid |icmpMsgStatsIPVersion| (|icmpMsgStatsEntry| 1)
  (:type 'object-type)
  (:syntax '|InetVersion|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The IP version of the statistics."))

(defoid |icmpMsgStatsType| (|icmpMsgStatsEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The ICMP type field of the message type being counted by
            this row.

            Note that ICMP message types are scoped by the address type
            in use.")
  (:reference
   "http://www.iana.org/assignments/icmp-parameters and
               http://www.iana.org/assignments/icmpv6-parameters"))

(defoid |icmpMsgStatsInPkts| (|icmpMsgStatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The number of input packets for this AF and type."))

(defoid |icmpMsgStatsOutPkts| (|icmpMsgStatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The number of output packets for this AF and type."))

(defoid |ipMIBConformance| (|ipMIB| 2) (:type 'object-identity))

(defoid |ipMIBCompliances| (|ipMIBConformance| 1)
  (:type 'object-identity))

(defoid |ipMIBGroups| (|ipMIBConformance| 2) (:type 'object-identity))

(defoid |ipMIBCompliance2| (|ipMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for systems that implement IP -
             either IPv4 or IPv6.

            There are a number of INDEX objects that cannot be
            represented in the form of OBJECT clauses in SMIv2, but
            for which we have the following compliance requirements,
            expressed in OBJECT clause form in this description
            clause:




            -- OBJECT        ipSystemStatsIPVersion
            -- SYNTAX        InetVersion {ipv4(1), ipv6(2)}
            -- DESCRIPTION
            --     This MIB requires support for only IPv4 and IPv6
            --     versions.
            --
            -- OBJECT        ipIfStatsIPVersion
            -- SYNTAX        InetVersion {ipv4(1), ipv6(2)}
            -- DESCRIPTION
            --     This MIB requires support for only IPv4 and IPv6
            --     versions.
            --
            -- OBJECT        icmpStatsIPVersion
            -- SYNTAX        InetVersion {ipv4(1), ipv6(2)}
            -- DESCRIPTION
            --     This MIB requires support for only IPv4 and IPv6
            --     versions.
            --
            -- OBJECT        icmpMsgStatsIPVersion
            -- SYNTAX        InetVersion {ipv4(1), ipv6(2)}
            -- DESCRIPTION
            --     This MIB requires support for only IPv4 and IPv6
            --     versions.
            --
            -- OBJECT        ipAddressPrefixType
            -- SYNTAX        InetAddressType {ipv4(1), ipv6(2)}
            -- DESCRIPTION
            --     This MIB requires support for only global IPv4 and
            --     IPv6 address types.
            --
            -- OBJECT        ipAddressPrefixPrefix
            -- SYNTAX        InetAddress (Size(4 | 16))
            -- DESCRIPTION
            --     This MIB requires support for only global IPv4 and
            --     IPv6 addresses and so the size can be either 4 or
            --     16 bytes.
            --
            -- OBJECT        ipAddressAddrType
            -- SYNTAX        InetAddressType {ipv4(1), ipv6(2),
            --                                ipv4z(3), ipv6z(4)}
            -- DESCRIPTION
            --     This MIB requires support for only global and
            --     non-global IPv4 and IPv6 address types.
            --
            -- OBJECT        ipAddressAddr
            -- SYNTAX        InetAddress (Size(4 | 8 | 16 | 20))
            -- DESCRIPTION
            --     This MIB requires support for only global and



            --     non-global IPv4 and IPv6 addresses and so the size
            --     can be 4, 8, 16, or 20 bytes.
            --
            -- OBJECT        ipNetToPhysicalNetAddressType
            -- SYNTAX        InetAddressType {ipv4(1), ipv6(2),
            --                                ipv4z(3), ipv6z(4)}
            -- DESCRIPTION
            --     This MIB requires support for only global and
            --     non-global IPv4 and IPv6 address types.
            --
            -- OBJECT        ipNetToPhysicalNetAddress
            -- SYNTAX        InetAddress (Size(4 | 8 | 16 | 20))
            -- DESCRIPTION
            --     This MIB requires support for only global and
            --     non-global IPv4 and IPv6 addresses and so the size
            --     can be 4, 8, 16, or 20 bytes.
            --
            -- OBJECT        ipDefaultRouterAddressType
            -- SYNTAX        InetAddressType {ipv4(1), ipv6(2),
            --                                ipv4z(3), ipv6z(4)}
            -- DESCRIPTION
            --     This MIB requires support for only global and
            --     non-global IPv4 and IPv6 address types.
            --
            -- OBJECT        ipDefaultRouterAddress
            -- SYNTAX        InetAddress (Size(4 | 8 | 16 | 20))
            -- DESCRIPTION
            --     This MIB requires support for only global and
            --     non-global IPv4 and IPv6 addresses and so the size
            --     can be 4, 8, 16, or 20 bytes."))

(defoid |ipv4GeneralGroup| (|ipMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of IPv4-specific objects for basic management of
            IPv4 entities."))

(defoid |ipv4IfGroup| (|ipMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of IPv4-specific objects for basic management of
            IPv4 interfaces."))

(defoid |ipv6GeneralGroup2| (|ipMIBGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The IPv6 group of objects providing for basic management of
            IPv6 entities."))

(defoid |ipv6IfGroup| (|ipMIBGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of IPv6-specific objects for basic management of
            IPv6 interfaces."))

(defoid |ipLastChangeGroup| (|ipMIBGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The last change objects associated with this MIB.  These
            objects are optional for all agents.  They SHOULD be
            implemented on agents where it is possible to determine the
            proper values.  Where it is not possible to determine the
            proper values, for example when the tables are split amongst
            several sub-agents using AgentX, the agent MUST NOT
            implement these objects to return an incorrect or static
            value."))

(defoid |ipSystemStatsGroup| (|ipMIBGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description "IP system wide statistics."))

(defoid |ipv4SystemStatsGroup| (|ipMIBGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description "IPv4 only system wide statistics."))

(defoid |ipSystemStatsHCOctetGroup| (|ipMIBGroups| 10)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "IP system wide statistics for systems that may overflow the
            standard octet counters within 1 hour."))

(defoid |ipSystemStatsHCPacketGroup| (|ipMIBGroups| 11)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "IP system wide statistics for systems that may overflow the
            standard packet counters within 1 hour."))

(defoid |ipv4SystemStatsHCPacketGroup| (|ipMIBGroups| 12)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "IPv4 only system wide statistics for systems that may
            overflow the standard packet counters within 1 hour."))

(defoid |ipIfStatsGroup| (|ipMIBGroups| 13)
  (:type 'object-group)
  (:status '|current|)
  (:description "IP per-interface statistics."))

(defoid |ipv4IfStatsGroup| (|ipMIBGroups| 14)
  (:type 'object-group)
  (:status '|current|)
  (:description "IPv4 only per-interface statistics."))

(defoid |ipIfStatsHCOctetGroup| (|ipMIBGroups| 15)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "IP per-interfaces statistics for systems that include
            interfaces that may overflow the standard octet
            counters within 1 hour."))

(defoid |ipIfStatsHCPacketGroup| (|ipMIBGroups| 16)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "IP per-interfaces statistics for systems that include
            interfaces that may overflow the standard packet counters
            within 1 hour."))

(defoid |ipv4IfStatsHCPacketGroup| (|ipMIBGroups| 17)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "IPv4 only per-interface statistics for systems that include
            interfaces that may overflow the standard packet counters
            within 1 hour."))

(defoid |ipAddressPrefixGroup| (|ipMIBGroups| 18)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects for providing information about address
            prefixes used by this node."))

(defoid |ipAddressGroup| (|ipMIBGroups| 19)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects for providing information about the
            addresses relevant to this entity's interfaces."))

(defoid |ipNetToPhysicalGroup| (|ipMIBGroups| 20)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects for providing information about the
            mappings of network address to physical address known to
            this node."))

(defoid |ipv6ScopeGroup| (|ipMIBGroups| 21)
  (:type 'object-group)
  (:status '|current|)
  (:description "The group of objects for managing IPv6 scope zones."))

(defoid |ipDefaultRouterGroup| (|ipMIBGroups| 22)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects for providing information about default
            routers known to this node."))

(defoid |ipv6RouterAdvertGroup| (|ipMIBGroups| 23)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects for controlling information advertised
            by IPv6 routers."))

(defoid |icmpStatsGroup| (|ipMIBGroups| 24)
  (:type 'object-group)
  (:status '|current|)
  (:description "The group of objects providing ICMP statistics."))

(defoid |ipInReceives| (|ip| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The total number of input datagrams received from
            interfaces, including those received in error.

            This object has been deprecated, as a new IP version-neutral



            table has been added.  It is loosely replaced by
            ipSystemStatsInRecieves."))

(defoid |ipInHdrErrors| (|ip| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of input datagrams discarded due to errors in
            their IPv4 headers, including bad checksums, version number
            mismatch, other format errors, time-to-live exceeded, errors
            discovered in processing their IPv4 options, etc.

            This object has been deprecated as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsInHdrErrors."))

(defoid |ipInAddrErrors| (|ip| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of input datagrams discarded because the IPv4
            address in their IPv4 header's destination field was not a
            valid address to be received at this entity.  This count
            includes invalid addresses (e.g., 0.0.0.0) and addresses of
            unsupported Classes (e.g., Class E).  For entities which are
            not IPv4 routers, and therefore do not forward datagrams,
            this counter includes datagrams discarded because the
            destination address was not a local address.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsInAddrErrors."))

(defoid |ipForwDatagrams| (|ip| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of input datagrams for which this entity was not
            their final IPv4 destination, as a result of which an
            attempt was made to find a route to forward them to that
            final destination.  In entities which do not act as IPv4
            routers, this counter will include only those packets which



            were Source-Routed via this entity, and the Source-Route
            option processing was successful.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsInForwDatagrams."))

(defoid |ipInUnknownProtos| (|ip| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of locally-addressed datagrams received
            successfully but discarded because of an unknown or
            unsupported protocol.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsInUnknownProtos."))

(defoid |ipInDiscards| (|ip| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of input IPv4 datagrams for which no problems
            were encountered to prevent their continued processing, but
            which were discarded (e.g., for lack of buffer space).  Note
            that this counter does not include any datagrams discarded
            while awaiting re-assembly.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsInDiscards."))

(defoid |ipInDelivers| (|ip| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The total number of input datagrams successfully delivered
            to IPv4 user-protocols (including ICMP).

            This object has been deprecated as a new IP version neutral
            table has been added.  It is loosely replaced by



            ipSystemStatsIndelivers."))

(defoid |ipOutRequests| (|ip| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The total number of IPv4 datagrams which local IPv4 user
            protocols (including ICMP) supplied to IPv4 in requests for
            transmission.  Note that this counter does not include any
            datagrams counted in ipForwDatagrams.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsOutRequests."))

(defoid |ipOutDiscards| (|ip| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of output IPv4 datagrams for which no problem was
            encountered to prevent their transmission to their
            destination, but which were discarded (e.g., for lack of
            buffer space).  Note that this counter would include
            datagrams counted in ipForwDatagrams if any such packets met
            this (discretionary) discard criterion.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsOutDiscards."))

(defoid |ipOutNoRoutes| (|ip| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of IPv4 datagrams discarded because no route
            could be found to transmit them to their destination.  Note
            that this counter includes any packets counted in
            ipForwDatagrams which meet this `no-route' criterion.  Note
            that this includes any datagrams which a host cannot route
            because all of its default routers are down.

            This object has been deprecated, as a new IP version-neutral



            table has been added.  It is loosely replaced by
            ipSystemStatsOutNoRoutes."))

(defoid |ipReasmReqds| (|ip| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of IPv4 fragments received which needed to be
            reassembled at this entity.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsReasmReqds."))

(defoid |ipReasmOKs| (|ip| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of IPv4 datagrams successfully re-assembled.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsReasmOKs."))

(defoid |ipReasmFails| (|ip| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of failures detected by the IPv4 re-assembly
            algorithm (for whatever reason: timed out, errors, etc).
            Note that this is not necessarily a count of discarded IPv4
            fragments since some algorithms (notably the algorithm in
            RFC 815) can lose track of the number of fragments by
            combining them as they are received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsReasmFails."))

(defoid |ipFragOKs| (|ip| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of IPv4 datagrams that have been successfully
            fragmented at this entity.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsOutFragOKs."))

(defoid |ipFragFails| (|ip| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of IPv4 datagrams that have been discarded
            because they needed to be fragmented at this entity but
            could not be, e.g., because their Don't Fragment flag was
            set.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsOutFragFails."))

(defoid |ipFragCreates| (|ip| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of IPv4 datagram fragments that have been
            generated as a result of fragmentation at this entity.

            This object has been deprecated as a new IP version neutral
            table has been added.  It is loosely replaced by
            ipSystemStatsOutFragCreates."))

(defoid |ipRoutingDiscards| (|ip| 23)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of routing entries which were chosen to be
            discarded even though they are valid.  One possible reason
            for discarding such an entry could be to free-up buffer
            space for other routing entries.



            This object was defined in pre-IPv6 versions of the IP MIB.
            It was implicitly IPv4 only, but the original specifications
            did not indicate this protocol restriction.  In order to
            clarify the specifications, this object has been deprecated
            and a similar, but more thoroughly clarified, object has
            been added to the IP-FORWARD-MIB."))

(defoid |ipAddrTable| (|ip| 20)
  (:type 'object-type)
  (:syntax '(vector |IpAddrEntry|))
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The table of addressing information relevant to this
            entity's IPv4 addresses.

            This table has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by the
            ipAddressTable although several objects that weren't deemed
            useful weren't carried forward while another
            (ipAdEntReasmMaxSize) was moved to the ipv4InterfaceTable."))

(defoid |ipAddrEntry| (|ipAddrTable| 1)
  (:type 'object-type)
  (:syntax '|IpAddrEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The addressing information for one of this entity's IPv4
            addresses."))

(defclass |IpAddrEntry|
          (sequence-type)
          ((|ipAdEntAddr| :type |IpAddress|)
           (|ipAdEntIfIndex| :type integer)
           (|ipAdEntNetMask| :type |IpAddress|)
           (|ipAdEntBcastAddr| :type integer)
           (|ipAdEntReasmMaxSize| :type integer)))

(defoid |ipAdEntAddr| (|ipAddrEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The IPv4 address to which this entry's addressing
            information pertains."))

(defoid |ipAdEntIfIndex| (|ipAddrEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The index value which uniquely identifies the interface to
            which this entry is applicable.  The interface identified by
            a particular value of this index is the same interface as
            identified by the same value of the IF-MIB's ifIndex."))

(defoid |ipAdEntNetMask| (|ipAddrEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The subnet mask associated with the IPv4 address of this
            entry.  The value of the mask is an IPv4 address with all
            the network bits set to 1 and all the hosts bits set to 0."))

(defoid |ipAdEntBcastAddr| (|ipAddrEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The value of the least-significant bit in the IPv4 broadcast
            address used for sending datagrams on the (logical)
            interface associated with the IPv4 address of this entry.
            For example, when the Internet standard all-ones broadcast
            address is used, the value will be 1.  This value applies to
            both the subnet and network broadcast addresses used by the
            entity on this (logical) interface."))

(defoid |ipAdEntReasmMaxSize| (|ipAddrEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The size of the largest IPv4 datagram which this entity can
            re-assemble from incoming IPv4 fragmented datagrams received
            on this interface."))

(defoid |ipNetToMediaTable| (|ip| 22)
  (:type 'object-type)
  (:syntax '(vector |IpNetToMediaEntry|))
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The IPv4 Address Translation table used for mapping from
            IPv4 addresses to physical addresses.

            This table has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by the
            ipNetToPhysicalTable."))

(defoid |ipNetToMediaEntry| (|ipNetToMediaTable| 1)
  (:type 'object-type)
  (:syntax '|IpNetToMediaEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "Each entry contains one IpAddress to `physical' address
            equivalence."))

(defclass |IpNetToMediaEntry|
          (sequence-type)
          ((|ipNetToMediaIfIndex| :type integer)
           (|ipNetToMediaPhysAddress| :type |PhysAddress|)
           (|ipNetToMediaNetAddress| :type |IpAddress|)
           (|ipNetToMediaType| :type integer)))

(defoid |ipNetToMediaIfIndex| (|ipNetToMediaEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The interface on which this entry's equivalence is
            effective.  The interface identified by a particular value
            of this index is the same interface as identified by the



            same value of the IF-MIB's ifIndex.

            This object predates the rule limiting index objects to a
            max access value of 'not-accessible' and so continues to use
            a value of 'read-create'."))

(defoid |ipNetToMediaPhysAddress| (|ipNetToMediaEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The media-dependent `physical' address.  This object should
            return 0 when this entry is in the 'incomplete' state.

            As the entries in this table are typically not persistent
            when this object is written the entity should not save the
            change to non-volatile storage.  Note: a stronger
            requirement is not used because this object was previously
            defined."))

(defoid |ipNetToMediaNetAddress| (|ipNetToMediaEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The IpAddress corresponding to the media-dependent
            `physical' address.

            This object predates the rule limiting index objects to a
            max access value of 'not-accessible' and so continues to use
            a value of 'read-create'."))

(defoid |ipNetToMediaType| (|ipNetToMediaEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The type of mapping.

            Setting this object to the value invalid(2) has the effect



            of invalidating the corresponding entry in the
            ipNetToMediaTable.  That is, it effectively dis-associates
            the interface identified with said entry from the mapping
            identified with said entry.  It is an implementation-
            specific matter as to whether the agent removes an
            invalidated entry from the table.  Accordingly, management
            stations must be prepared to receive tabular information
            from agents that corresponds to entries not currently in
            use.  Proper interpretation of such entries requires
            examination of the relevant ipNetToMediaType object.

            As the entries in this table are typically not persistent
            when this object is written the entity should not save the
            change to non-volatile storage.  Note: a stronger
            requirement is not used because this object was previously
            defined."))

(defoid |icmpInMsgs| (|icmp| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The total number of ICMP messages which the entity received.
            Note that this counter includes all those counted by
            icmpInErrors.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            icmpStatsInMsgs."))

(defoid |icmpInErrors| (|icmp| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP messages which the entity received but
            determined as having ICMP-specific errors (bad ICMP
            checksums, bad length, etc.).

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            icmpStatsInErrors."))

(defoid |icmpInDestUnreachs| (|icmp| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Destination Unreachable messages
            received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInTimeExcds| (|icmp| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Time Exceeded messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInParmProbs| (|icmp| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Parameter Problem messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInSrcQuenchs| (|icmp| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Source Quench messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInRedirects| (|icmp| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Redirect messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInEchos| (|icmp| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Echo (request) messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInEchoReps| (|icmp| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Echo Reply messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInTimestamps| (|icmp| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Timestamp (request) messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInTimestampReps| (|icmp| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Timestamp Reply messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInAddrMasks| (|icmp| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Address Mask Request messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpInAddrMaskReps| (|icmp| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Address Mask Reply messages received.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutMsgs| (|icmp| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The total number of ICMP messages which this entity
            attempted to send.  Note that this counter includes all
            those counted by icmpOutErrors.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            icmpStatsOutMsgs."))

(defoid |icmpOutErrors| (|icmp| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP messages which this entity did not send
            due to problems discovered within ICMP, such as a lack of
            buffers.  This value should not include errors discovered
            outside the ICMP layer, such as the inability of IP to route
            the resultant datagram.  In some implementations, there may
            be no types of error which contribute to this counter's
            value.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by
            icmpStatsOutErrors."))

(defoid |icmpOutDestUnreachs| (|icmp| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Destination Unreachable messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutTimeExcds| (|icmp| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Time Exceeded messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutParmProbs| (|icmp| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Parameter Problem messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutSrcQuenchs| (|icmp| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Source Quench messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutRedirects| (|icmp| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Redirect messages sent.  For a host, this
            object will always be zero, since hosts do not send
            redirects.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutEchos| (|icmp| 21)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Echo (request) messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutEchoReps| (|icmp| 22)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Echo Reply messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutTimestamps| (|icmp| 23)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Timestamp (request) messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutTimestampReps| (|icmp| 24)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Timestamp Reply messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutAddrMasks| (|icmp| 25)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Address Mask Request messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |icmpOutAddrMaskReps| (|icmp| 26)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of ICMP Address Mask Reply messages sent.

            This object has been deprecated, as a new IP version-neutral
            table has been added.  It is loosely replaced by a column in
            the icmpMsgStatsTable."))

(defoid |ipMIBCompliance| (|ipMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for systems that implement only
            IPv4.  For version-independence, this compliance statement
            is deprecated in favor of ipMIBCompliance2."))

(defoid |ipGroup| (|ipMIBGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The ip group of objects providing for basic management of IP
            entities, exclusive of the management of IP routes.




            As part of the version independence, this group has been
            deprecated.  "))

(defoid |icmpGroup| (|ipMIBGroups| 2)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The icmp group of objects providing ICMP statistics.

            As part of the version independence, this group has been
            deprecated.  "))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ip-mib *mib-modules*)
  (setf *current-module* nil))

