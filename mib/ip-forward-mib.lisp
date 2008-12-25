;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IP-FORWARD-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ip-forward-mib *mib-modules*)
  (setf *current-module* 'ip-forward-mib))

(defpackage :asn.1/ip-forward-mib
  (:nicknames :ip-forward-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |IpAddress| |Integer32| |Gauge32| |Counter32|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/if-mib |InterfaceIndexOrZero|)
  (:import-from :asn.1/ip-mib |ip|)
  (:import-from :asn.1/iana-rtproto-mib |IANAipRouteProtocol|)
  (:import-from :asn.1/inet-address-mib |InetAddress| |InetAddressType|
                |InetAddressPrefixLength| |InetAutonomousSystemNumber|))

(in-package :ip-forward-mib)

(defoid |ipForward| (|ip| 24)
  (:type 'module-identity)
  (:description
   "The MIB module for the management of CIDR multipath IP
            Routes.

            Copyright (C) The Internet Society (2006).  This version
            of this MIB module is a part of RFC 4292; see the RFC
            itself for full legal notices."))

(defoid |inetCidrRouteNumber| (|ipForward| 6)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of current inetCidrRouteTable entries that
            are not invalid."))

(defoid |inetCidrRouteDiscards| (|ipForward| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of valid route entries discarded from the
            inetCidrRouteTable.  Discarded route entries do not
            appear in the inetCidrRouteTable.  One possible reason
            for discarding an entry would be to free-up buffer space
            for other route table entries."))

(defoid |inetCidrRouteTable| (|ipForward| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This entity's IP Routing table."))

(defoid |inetCidrRouteEntry| (|inetCidrRouteTable| 1)
  (:type 'object-type)
  (:syntax '|InetCidrRouteEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A particular route to a particular destination, under a
            particular policy (as reflected in the
            inetCidrRoutePolicy object).

            Dynamically created rows will survive an agent reboot.

            Implementers need to be aware that if the total number
            of elements (octets or sub-identifiers) in
            inetCidrRouteDest, inetCidrRoutePolicy, and
            inetCidrRouteNextHop exceeds 111, then OIDs of column
            instances in this table will have more than 128 sub-
            identifiers and cannot be accessed using SNMPv1,
            SNMPv2c, or SNMPv3."))

(deftype |InetCidrRouteEntry| () 't)

(defoid |inetCidrRouteDestType| (|inetCidrRouteEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The type of the inetCidrRouteDest address, as defined
            in the InetAddress MIB.

            Only those address types that may appear in an actual
            routing table are allowed as values of this object."))

(defoid |inetCidrRouteDest| (|inetCidrRouteEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The destination IP address of this route.

            The type of this address is determined by the value of
            the inetCidrRouteDestType object.

            The values for the index objects inetCidrRouteDest and
            inetCidrRoutePfxLen must be consistent.  When the value
            of inetCidrRouteDest (excluding the zone index, if one
            is present) is x, then the bitwise logical-AND
            of x with the value of the mask formed from the
            corresponding index object inetCidrRoutePfxLen MUST be
            equal to x.  If not, then the index pair is not
            consistent and an inconsistentName error must be
            returned on SET or CREATE requests."))

(defoid |inetCidrRoutePfxLen| (|inetCidrRouteEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddressPrefixLength|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Indicates the number of leading one bits that form the
            mask to be logical-ANDed with the destination address
            before being compared to the value in the



            inetCidrRouteDest field.

            The values for the index objects inetCidrRouteDest and
            inetCidrRoutePfxLen must be consistent.  When the value
            of inetCidrRouteDest (excluding the zone index, if one
            is present) is x, then the bitwise logical-AND
            of x with the value of the mask formed from the
            corresponding index object inetCidrRoutePfxLen MUST be
            equal to x.  If not, then the index pair is not
            consistent and an inconsistentName error must be
            returned on SET or CREATE requests."))

(defoid |inetCidrRoutePolicy| (|inetCidrRouteEntry| 4)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This object is an opaque object without any defined
            semantics.  Its purpose is to serve as an additional
            index that may delineate between multiple entries to
            the same destination.  The value { 0 0 } shall be used
            as the default value for this object."))

(defoid |inetCidrRouteNextHopType| (|inetCidrRouteEntry| 5)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The type of the inetCidrRouteNextHop address, as
            defined in the InetAddress MIB.

            Value should be set to unknown(0) for non-remote
            routes.

            Only those address types that may appear in an actual
            routing table are allowed as values of this object."))

(defoid |inetCidrRouteNextHop| (|inetCidrRouteEntry| 6)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "On remote routes, the address of the next system en



            route.  For non-remote routes, a zero length string.

            The type of this address is determined by the value of
            the inetCidrRouteNextHopType object."))

(defoid |inetCidrRouteIfIndex| (|inetCidrRouteEntry| 7)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The ifIndex value that identifies the local interface
            through which the next hop of this route should be
            reached.  A value of 0 is valid and represents the
            scenario where no interface is specified."))

(defoid |inetCidrRouteType| (|inetCidrRouteEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of route.  Note that local(3) refers to a
            route for which the next hop is the final destination;
            remote(4) refers to a route for which the next hop is
            not the final destination.

            Routes that do not result in traffic forwarding or
            rejection should not be displayed, even if the
            implementation keeps them stored internally.

            reject(2) refers to a route that, if matched, discards
            the message as unreachable and returns a notification
            (e.g., ICMP error) to the message sender.  This is used
            in some protocols as a means of correctly aggregating
            routes.

            blackhole(5) refers to a route that, if matched,
            discards the message silently."))

(defoid |inetCidrRouteProto| (|inetCidrRouteEntry| 9)
  (:type 'object-type)
  (:syntax '|IANAipRouteProtocol|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The routing mechanism via which this route was learned.
            Inclusion of values for gateway routing protocols is
            not intended to imply that hosts should support those
            protocols."))

(defoid |inetCidrRouteAge| (|inetCidrRouteEntry| 10)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of seconds since this route was last updated
            or otherwise determined to be correct.  Note that no
            semantics of 'too old' can be implied, except through
            knowledge of the routing protocol by which the route
            was learned."))

(defoid |inetCidrRouteNextHopAS| (|inetCidrRouteEntry| 11)
  (:type 'object-type)
  (:syntax '|InetAutonomousSystemNumber|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The Autonomous System Number of the Next Hop.  The
            semantics of this object are determined by the routing-
            protocol specified in the route's inetCidrRouteProto
            value.  When this object is unknown or not relevant, its
            value should be set to zero."))

(defoid |inetCidrRouteMetric1| (|inetCidrRouteEntry| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The primary routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's inetCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |inetCidrRouteMetric2| (|inetCidrRouteEntry| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's inetCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |inetCidrRouteMetric3| (|inetCidrRouteEntry| 14)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's inetCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |inetCidrRouteMetric4| (|inetCidrRouteEntry| 15)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's inetCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |inetCidrRouteMetric5| (|inetCidrRouteEntry| 16)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-



            protocol specified in the route's inetCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |inetCidrRouteStatus| (|inetCidrRouteEntry| 17)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The row status variable, used according to row
            installation and removal conventions.

            A row entry cannot be modified when the status is
            marked as active(1)."))

(defoid |ipForwardConformance| (|ipForward| 5) (:type 'object-identity))

(defoid |ipForwardGroups| (|ipForwardConformance| 1)
  (:type 'object-identity))

(defoid |ipForwardCompliances| (|ipForwardConformance| 2)
  (:type 'object-identity))

(defoid |ipForwardFullCompliance| (|ipForwardCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "When this MIB is implemented for read-create, the
            implementation can claim full compliance.

            There are a number of INDEX objects that cannot be
            represented in the form of OBJECT clauses in SMIv2,
            but for which there are compliance requirements,
            expressed in OBJECT clause form in this description:

            -- OBJECT      inetCidrRouteDestType
            -- SYNTAX      InetAddressType (ipv4(1), ipv6(2),
            --                              ipv4z(3), ipv6z(4))
            -- DESCRIPTION
            --     This MIB requires support for global and
            --     non-global ipv4 and ipv6 addresses.



            --
            -- OBJECT      inetCidrRouteDest
            -- SYNTAX      InetAddress (SIZE (4 | 8 | 16 | 20))
            -- DESCRIPTION
            --     This MIB requires support for global and
            --     non-global IPv4 and IPv6 addresses.
            --
            -- OBJECT      inetCidrRouteNextHopType
            -- SYNTAX      InetAddressType (unknown(0), ipv4(1),
            --                              ipv6(2), ipv4z(3)
            --                              ipv6z(4))
            -- DESCRIPTION
            --     This MIB requires support for global and
            --     non-global ipv4 and ipv6 addresses.
            --
            -- OBJECT      inetCidrRouteNextHop
            -- SYNTAX      InetAddress (SIZE (0 | 4 | 8 | 16 | 20))
            -- DESCRIPTION
            --     This MIB requires support for global and
            --     non-global IPv4 and IPv6 addresses.
            "))

(defoid |ipForwardReadOnlyCompliance| (|ipForwardCompliances| 4)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "When this MIB is implemented without support for read-
            create (i.e., in read-only mode), the implementation can
            claim read-only compliance."))

(defoid |inetForwardCidrRouteGroup| (|ipForwardGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description "The IP version-independent CIDR Route Table."))

(defoid |ipCidrRouteNumber| (|ipForward| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of current ipCidrRouteTable entries that are
            not invalid.  This object is deprecated in favor of
            inetCidrRouteNumber and the inetCidrRouteTable."))

(defoid |ipCidrRouteTable| (|ipForward| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "This entity's IP Routing table.  This table has been
            deprecated in favor of the IP version neutral
            inetCidrRouteTable."))

(defoid |ipCidrRouteEntry| (|ipCidrRouteTable| 1)
  (:type 'object-type)
  (:syntax '|IpCidrRouteEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "A particular route to a particular destination, under a



            particular policy."))

(deftype |IpCidrRouteEntry| () 't)

(defoid |ipCidrRouteDest| (|ipCidrRouteEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The destination IP address of this route.

            This object may not take a Multicast (Class D) address
            value.

            Any assignment (implicit or otherwise) of an instance
            of this object to a value x must be rejected if the
            bitwise logical-AND of x with the value of the
            corresponding instance of the ipCidrRouteMask object is
            not equal to x."))

(defoid |ipCidrRouteMask| (|ipCidrRouteEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "Indicate the mask to be logical-ANDed with the
            destination address before being compared to the value
            in the ipCidrRouteDest field.  For those systems that
            do not support arbitrary subnet masks, an agent
            constructs the value of the ipCidrRouteMask by
            reference to the IP Address Class.

            Any assignment (implicit or otherwise) of an instance
            of this object to a value x must be rejected if the
            bitwise logical-AND of x with the value of the
            corresponding instance of the ipCidrRouteDest object is
            not equal to ipCidrRouteDest."))

(defoid |ipCidrRouteTos| (|ipCidrRouteEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The policy specifier is the IP TOS Field.  The encoding
            of IP TOS is as specified by the following convention.
            Zero indicates the default path if no more specific
            policy applies.

            +-----+-----+-----+-----+-----+-----+-----+-----+
            |                 |                       |     |
            |   PRECEDENCE    |    TYPE OF SERVICE    |  0  |
            |                 |                       |     |
            +-----+-----+-----+-----+-----+-----+-----+-----+

                         IP TOS                IP TOS
               Field     Policy      Field     Policy
               Contents    Code      Contents    Code
               0 0 0 0  ==>   0      0 0 0 1  ==>   2
               0 0 1 0  ==>   4      0 0 1 1  ==>   6
               0 1 0 0  ==>   8      0 1 0 1  ==>  10
               0 1 1 0  ==>  12      0 1 1 1  ==>  14
               1 0 0 0  ==>  16      1 0 0 1  ==>  18
               1 0 1 0  ==>  20      1 0 1 1  ==>  22



               1 1 0 0  ==>  24      1 1 0 1  ==>  26
               1 1 1 0  ==>  28      1 1 1 1  ==>  30"))

(defoid |ipCidrRouteNextHop| (|ipCidrRouteEntry| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "On remote routes, the address of the next system en
            route; Otherwise, 0.0.0.0."))

(defoid |ipCidrRouteIfIndex| (|ipCidrRouteEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The ifIndex value that identifies the local interface
            through which the next hop of this route should be
            reached."))

(defoid |ipCidrRouteType| (|ipCidrRouteEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The type of route.  Note that local(3) refers to a
            route for which the next hop is the final destination;
            remote(4) refers to a route for which the next hop is
            not the final destination.

            Routes that do not result in traffic forwarding or
            rejection should not be displayed, even if the
            implementation keeps them stored internally.

            reject (2) refers to a route that, if matched,
            discards the message as unreachable.  This is used in
            some protocols as a means of correctly aggregating
            routes."))

(defoid |ipCidrRouteProto| (|ipCidrRouteEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The routing mechanism via which this route was learned.
            Inclusion of values for gateway routing protocols is
            not intended to imply that hosts should support those
            protocols."))

(defoid |ipCidrRouteAge| (|ipCidrRouteEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The number of seconds since this route was last updated
            or otherwise determined to be correct.  Note that no
            semantics of `too old' can be implied, except through
            knowledge of the routing protocol by which the route
            was learned."))

(defoid |ipCidrRouteInfo| (|ipCidrRouteEntry| 9)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "A reference to MIB definitions specific to the
            particular routing protocol that is responsible for
            this route, as determined by the value specified in the
            route's ipCidrRouteProto value.  If this information is
            not present, its value should be set to the OBJECT
            IDENTIFIER { 0 0 }, which is a syntactically valid
            object identifier, and any implementation conforming to
            ASN.1 and the Basic Encoding Rules must be able to
            generate and recognize this value."))

(defoid |ipCidrRouteNextHopAS| (|ipCidrRouteEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The Autonomous System Number of the Next Hop.  The
            semantics of this object are determined by the routing-
            protocol specified in the route's ipCidrRouteProto
            value.  When this object is unknown or not relevant, its
            value should be set to zero."))

(defoid |ipCidrRouteMetric1| (|ipCidrRouteEntry| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The primary routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |ipCidrRouteMetric2| (|ipCidrRouteEntry| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipCidrRouteProto
            value.  If this metric is not used, its value should be



            set to -1."))

(defoid |ipCidrRouteMetric3| (|ipCidrRouteEntry| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |ipCidrRouteMetric4| (|ipCidrRouteEntry| 14)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |ipCidrRouteMetric5| (|ipCidrRouteEntry| 15)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipCidrRouteProto
            value.  If this metric is not used, its value should be
            set to -1."))

(defoid |ipCidrRouteStatus| (|ipCidrRouteEntry| 16)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The row status variable, used according to row
            installation and removal conventions."))

(defoid |ipForwardCompliance| (|ipForwardCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for SNMPv2 entities that
            implement the ipForward MIB.

            This compliance statement has been deprecated and
            replaced with ipForwardFullCompliance and
            ipForwardReadOnlyCompliance."))

(defoid |ipForwardCidrRouteGroup| (|ipForwardGroups| 3)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The CIDR Route Table.

            This group has been deprecated and replaced with
            inetForwardCidrRouteGroup."))

(defoid |ipForwardNumber| (|ipForward| 1)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The number of current ipForwardTable entries that are
            not invalid."))

(defoid |ipForwardTable| (|ipForward| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|obsolete|)
  (:description "This entity's IP Routing table."))

(defoid |ipForwardEntry| (|ipForwardTable| 1)
  (:type 'object-type)
  (:syntax '|IpForwardEntry|)
  (:max-access '|not-accessible|)
  (:status '|obsolete|)
  (:description
   "A particular route to a particular destination, under a
            particular policy."))

(deftype |IpForwardEntry| () 't)

(defoid |ipForwardDest| (|ipForwardEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The destination IP address of this route.  An entry
            with a value of 0.0.0.0 is considered a default route.

            This object may not take a Multicast (Class D) address
            value.

            Any assignment (implicit or otherwise) of an instance
            of this object to a value x must be rejected if the
            bitwise logical-AND of x with the value of the
            corresponding instance of the ipForwardMask object is
            not equal to x."))

(defoid |ipForwardMask| (|ipForwardEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "Indicate the mask to be logical-ANDed with the
            destination address before being compared to the value
            in the ipForwardDest field.  For those systems that do
            not support arbitrary subnet masks, an agent constructs
            the value of the ipForwardMask by reference to the IP
            Address Class.

            Any assignment (implicit or otherwise) of an instance
            of this object to a value x must be rejected if the
            bitwise logical-AND of x with the value of the
            corresponding instance of the ipForwardDest object is
            not equal to ipForwardDest."))

(defoid |ipForwardPolicy| (|ipForwardEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The general set of conditions that would cause
            the selection of one multipath route (set of
            next hops for a given destination) is referred
            to as 'policy'.

            Unless the mechanism indicated by ipForwardProto
            specifies otherwise, the policy specifier is
            the IP TOS Field.  The encoding of IP TOS is as
            specified by the following convention.  Zero
            indicates the default path if no more specific
            policy applies.

            +-----+-----+-----+-----+-----+-----+-----+-----+
            |                 |                       |     |
            |   PRECEDENCE    |    TYPE OF SERVICE    |  0  |
            |                 |                       |     |
            +-----+-----+-----+-----+-----+-----+-----+-----+



                         IP TOS                IP TOS
               Field     Policy      Field     Policy
               Contents    Code      Contents    Code
               0 0 0 0  ==>   0      0 0 0 1  ==>   2
               0 0 1 0  ==>   4      0 0 1 1  ==>   6
               0 1 0 0  ==>   8      0 1 0 1  ==>  10
               0 1 1 0  ==>  12      0 1 1 1  ==>  14
               1 0 0 0  ==>  16      1 0 0 1  ==>  18
               1 0 1 0  ==>  20      1 0 1 1  ==>  22
               1 1 0 0  ==>  24      1 1 0 1  ==>  26
               1 1 1 0  ==>  28      1 1 1 1  ==>  30

            Protocols defining 'policy' otherwise must either
            define a set of values that are valid for
            this object or must implement an integer-instanced
            policy table for which this object's
            value acts as an index."))

(defoid |ipForwardNextHop| (|ipForwardEntry| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "On remote routes, the address of the next system en
            route; otherwise, 0.0.0.0."))

(defoid |ipForwardIfIndex| (|ipForwardEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "The ifIndex value that identifies the local interface
            through which the next hop of this route should be
            reached."))

(defoid |ipForwardType| (|ipForwardEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "The type of route.  Note that local(3) refers to a
            route for which the next hop is the final destination;
            remote(4) refers to a route for which the next hop is
            not the final destination.

            Setting this object to the value invalid(2) has the
            effect of invalidating the corresponding entry in the
            ipForwardTable object.  That is, it effectively
            disassociates the destination identified with said
            entry from the route identified with said entry.  It is
            an implementation-specific matter as to whether the
            agent removes an invalidated entry from the table.
            Accordingly, management stations must be prepared to
            receive tabular information from agents that
            corresponds to entries not currently in use.  Proper
            interpretation of such entries requires examination of
            the relevant ipForwardType object."))

(defoid |ipForwardProto| (|ipForwardEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The routing mechanism via which this route was learned.
            Inclusion of values for gateway routing protocols is
            not intended to imply that hosts should support those
            protocols."))

(defoid |ipForwardAge| (|ipForwardEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The number of seconds since this route was last updated
            or otherwise determined to be correct.  Note that no
            semantics of `too old' can be implied except through
            knowledge of the routing protocol by which the route
            was learned."))

(defoid |ipForwardInfo| (|ipForwardEntry| 9)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "A reference to MIB definitions specific to the
            particular routing protocol that is responsible for
            this route, as determined by the value specified in the
            route's ipForwardProto value.  If this information is
            not present, its value should be set to the OBJECT
            IDENTIFIER { 0 0 }, which is a syntactically valid
            object identifier, and any implementation conforming to
            ASN.1 and the Basic Encoding Rules must be able to
            generate and recognize this value."))

(defoid |ipForwardNextHopAS| (|ipForwardEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "The Autonomous System Number of the Next Hop.  When
            this is unknown or not relevant to the protocol
            indicated by ipForwardProto, zero."))

(defoid |ipForwardMetric1| (|ipForwardEntry| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "The primary routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipForwardProto value.
            If this metric is not used, its value should be set to
            -1."))

(defoid |ipForwardMetric2| (|ipForwardEntry| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipForwardProto value.
            If this metric is not used, its value should be set to
            -1."))

(defoid |ipForwardMetric3| (|ipForwardEntry| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipForwardProto value.
            If this metric is not used, its value should be set to
            -1."))

(defoid |ipForwardMetric4| (|ipForwardEntry| 14)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipForwardProto value.
            If this metric is not used, its value should be set to
            -1."))

(defoid |ipForwardMetric5| (|ipForwardEntry| 15)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "An alternate routing metric for this route.  The
            semantics of this metric are determined by the routing-
            protocol specified in the route's ipForwardProto value.
            If this metric is not used, its value should be set to
            -1."))

(defoid |ipForwardOldCompliance| (|ipForwardCompliances| 2)
  (:type 'module-compliance)
  (:status '|obsolete|)
  (:description
   "The compliance statement for SNMP entities that
            implement the ipForward MIB."))

(defoid |ipForwardMultiPathGroup| (|ipForwardGroups| 2)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description "IP Multipath Route Table."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

