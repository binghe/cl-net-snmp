;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;UDP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'udp-mib))

(defpackage :asn.1/udp-mib
  (:nicknames :udp-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Counter32| |Counter64| |Unsigned32|
                |IpAddress| |mib-2|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/inet-address-mib |InetAddress| |InetAddressType|
                |InetPortNumber|))

(in-package :udp-mib)

(defoid |udpMIB| (|mib-2| 50)
  (:type 'module-identity)
  (:description
   "The MIB module for managing UDP implementations.
            Copyright (C) The Internet Society (2005).  This
            version of this MIB module is part of RFC 4113;
            see the RFC itself for full legal notices."))

(defoid |udp| (|mib-2| 7) (:type 'object-identity))

(defoid |udpInDatagrams| (|udp| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of UDP datagrams delivered to UDP
            users.

            Discontinuities in the value of this counter can occur
            at re-initialization of the management system, and at
            other times as indicated by discontinuities in the
            value of sysUpTime."))

(defoid |udpNoPorts| (|udp| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of received UDP datagrams for which
            there was no application at the destination port.

            Discontinuities in the value of this counter can occur
            at re-initialization of the management system, and at
            other times as indicated by discontinuities in the
            value of sysUpTime."))

(defoid |udpInErrors| (|udp| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of received UDP datagrams that could not be
            delivered for reasons other than the lack of an
            application at the destination port.

            Discontinuities in the value of this counter can occur
            at re-initialization of the management system, and at
            other times as indicated by discontinuities in the
            value of sysUpTime."))

(defoid |udpOutDatagrams| (|udp| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of UDP datagrams sent from this
            entity.

            Discontinuities in the value of this counter can occur
            at re-initialization of the management system, and at
            other times as indicated by discontinuities in the
            value of sysUpTime."))

(defoid |udpHCInDatagrams| (|udp| 8)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of UDP datagrams delivered to UDP
            users, for devices that can receive more than 1
            million UDP datagrams per second.

            Discontinuities in the value of this counter can occur
            at re-initialization of the management system, and at
            other times as indicated by discontinuities in the
            value of sysUpTime."))

(defoid |udpHCOutDatagrams| (|udp| 9)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of UDP datagrams sent from this
            entity, for devices that can transmit more than 1
            million UDP datagrams per second.

            Discontinuities in the value of this counter can occur
            at re-initialization of the management system, and at
            other times as indicated by discontinuities in the
            value of sysUpTime."))

(defoid |udpEndpointTable| (|udp| 7)
  (:type 'object-type)
  (:syntax '(vector |UdpEndpointEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information about this entity's UDP
            endpoints on which a local application is currently
            accepting or sending datagrams.

            The address type in this table represents the address
            type used for the communication, irrespective of the
            higher-layer abstraction.  For example, an application
            using IPv6 'sockets' to communicate via IPv4 between
            ::ffff:10.0.0.1 and ::ffff:10.0.0.2 would use
            InetAddressType ipv4(1).

            Unlike the udpTable in RFC 2013, this table also allows
            the representation of an application that completely
            specifies both local and remote addresses and ports.  A
            listening application is represented in three possible
            ways:

            1) An application that is willing to accept both IPv4
               and IPv6 datagrams is represented by a
               udpEndpointLocalAddressType of unknown(0) and a
               udpEndpointLocalAddress of ''h (a zero-length
               octet-string).

            2) An application that is willing to accept only IPv4
               or only IPv6 datagrams is represented by a
               udpEndpointLocalAddressType of the appropriate
               address type and a udpEndpointLocalAddress of
               '0.0.0.0' or '::' respectively.

            3) An application that is listening for datagrams only
               for a specific IP address but from any remote
               system is represented by a
               udpEndpointLocalAddressType of the appropriate
               address type, with udpEndpointLocalAddress
               specifying the local address.

            In all cases where the remote is a wildcard, the
            udpEndpointRemoteAddressType is unknown(0), the
            udpEndpointRemoteAddress is ''h (a zero-length
            octet-string), and the udpEndpointRemotePort is 0.

            If the operating system is demultiplexing UDP packets
            by remote address and port, or if the application has
            'connected' the socket specifying a default remote
            address and port, the udpEndpointRemote* values should
            be used to reflect this."))

(defoid |udpEndpointEntry| (|udpEndpointTable| 1)
  (:type 'object-type)
  (:syntax '|UdpEndpointEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a particular current UDP endpoint.

            Implementers need to be aware that if the total number
            of elements (octets or sub-identifiers) in
            udpEndpointLocalAddress and udpEndpointRemoteAddress
            exceeds 111, then OIDs of column instances in this table
            will have more than 128 sub-identifiers and cannot be
            accessed using SNMPv1, SNMPv2c, or SNMPv3."))

(defclass |UdpEndpointEntry| (sequence-type)
  ((|udpEndpointLocalAddressType| :type |InetAddressType|)
   (|udpEndpointLocalAddress| :type |InetAddress|)
   (|udpEndpointLocalPort| :type |InetPortNumber|)
   (|udpEndpointRemoteAddressType| :type |InetAddressType|)
   (|udpEndpointRemoteAddress| :type |InetAddress|)
   (|udpEndpointRemotePort| :type |InetPortNumber|)
   (|udpEndpointInstance| :type |Unsigned32|)
   (|udpEndpointProcess| :type |Unsigned32|)))

(defoid |udpEndpointLocalAddressType| (|udpEndpointEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The address type of udpEndpointLocalAddress.  Only
            IPv4, IPv4z, IPv6, and IPv6z addresses are expected, or
            unknown(0) if datagrams for all local IP addresses are
            accepted."))

(defoid |udpEndpointLocalAddress| (|udpEndpointEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The local IP address for this UDP endpoint.

            The value of this object can be represented in three

            possible ways, depending on the characteristics of the
            listening application:

            1. For an application that is willing to accept both
               IPv4 and IPv6 datagrams, the value of this object
               must be ''h (a zero-length octet-string), with
               the value of the corresponding instance of the
               udpEndpointLocalAddressType object being unknown(0).

            2. For an application that is willing to accept only IPv4
               or only IPv6 datagrams, the value of this object
               must be '0.0.0.0' or '::', respectively, while the
               corresponding instance of the
               udpEndpointLocalAddressType object represents the
               appropriate address type.

            3. For an application that is listening for data
               destined only to a specific IP address, the value
               of this object is the specific IP address for which
               this node is receiving packets, with the
               corresponding instance of the
               udpEndpointLocalAddressType object representing the
               appropriate address type.

            As this object is used in the index for the
            udpEndpointTable, implementors of this table should be
            careful not to create entries that would result in OIDs
            with more than 128 subidentifiers; else the information
            cannot be accessed using SNMPv1, SNMPv2c, or SNMPv3."))

(defoid |udpEndpointLocalPort| (|udpEndpointEntry| 3)
  (:type 'object-type)
  (:syntax '|InetPortNumber|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The local port number for this UDP endpoint."))

(defoid |udpEndpointRemoteAddressType| (|udpEndpointEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The address type of udpEndpointRemoteAddress.  Only
            IPv4, IPv4z, IPv6, and IPv6z addresses are expected, or
            unknown(0) if datagrams for all remote IP addresses are
            accepted.  Also, note that some combinations of

            udpEndpointLocalAdressType and
            udpEndpointRemoteAddressType are not supported.  In
            particular, if the value of this object is not
            unknown(0), it is expected to always refer to the
            same IP version as udpEndpointLocalAddressType."))

(defoid |udpEndpointRemoteAddress| (|udpEndpointEntry| 5)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The remote IP address for this UDP endpoint.  If
            datagrams from any remote system are to be accepted,
            this value is ''h (a zero-length octet-string).
            Otherwise, it has the type described by
            udpEndpointRemoteAddressType and is the address of the
            remote system from which datagrams are to be accepted
            (or to which all datagrams will be sent).

            As this object is used in the index for the
            udpEndpointTable, implementors of this table should be
            careful not to create entries that would result in OIDs
            with more than 128 subidentifiers; else the information
            cannot be accessed using SNMPv1, SNMPv2c, or SNMPv3."))

(defoid |udpEndpointRemotePort| (|udpEndpointEntry| 6)
  (:type 'object-type)
  (:syntax '|InetPortNumber|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The remote port number for this UDP endpoint.  If
            datagrams from any remote system are to be accepted,
            this value is zero."))

(defoid |udpEndpointInstance| (|udpEndpointEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The instance of this tuple.  This object is used to
            distinguish among multiple processes 'connected' to
            the same UDP endpoint.  For example, on a system
            implementing the BSD sockets interface, this would be
            used to support the SO_REUSEADDR and SO_REUSEPORT
            socket options."))

(defoid |udpEndpointProcess| (|udpEndpointEntry| 8)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The system's process ID for the process associated with
            this endpoint, or zero if there is no such process.
            This value is expected to be the same as
            HOST-RESOURCES-MIB::hrSWRunIndex or SYSAPPL-MIB::
            sysApplElmtRunIndex for some row in the appropriate
            tables."))

(defoid |udpTable| (|udp| 5)
  (:type 'object-type)
  (:syntax '(vector |UdpEntry|))
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "A table containing IPv4-specific UDP listener
            information.  It contains information about all local
            IPv4 UDP end-points on which an application is
            currently accepting datagrams.  This table has been
            deprecated in favor of the version neutral
            udpEndpointTable."))

(defoid |udpEntry| (|udpTable| 1)
  (:type 'object-type)
  (:syntax '|UdpEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description "Information about a particular current UDP listener."))

(defclass |UdpEntry| (sequence-type)
  ((|udpLocalAddress| :type |IpAddress|)
   (|udpLocalPort| :type |Integer32|)))

(defoid |udpLocalAddress| (|udpEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The local IP address for this UDP listener.  In the
            case of a UDP listener that is willing to accept
            datagrams for any IP interface associated with the
            node, the value 0.0.0.0 is used."))

(defoid |udpLocalPort| (|udpEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description "The local port number for this UDP listener."))

(defoid |udpMIBConformance| (|udpMIB| 2) (:type 'object-identity))

(defoid |udpMIBCompliances| (|udpMIBConformance| 1)
  (:type 'object-identity))

(defoid |udpMIBGroups| (|udpMIBConformance| 2) (:type 'object-identity))

(defoid |udpMIBCompliance2| (|udpMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for systems that implement
            UDP.

            There are a number of INDEX objects that cannot be
            represented in the form of OBJECT clauses in SMIv2, but
            for which we have the following compliance
            requirements, expressed in OBJECT clause form in this
            description clause:

            -- OBJECT      udpEndpointLocalAddressType
            -- SYNTAX      InetAddressType { unknown(0), ipv4(1),
            --                               ipv6(2), ipv4z(3),
            --                               ipv6z(4) }
            -- DESCRIPTION
            --     Support for dns(5) is not required.
            -- OBJECT      udpEndpointLocalAddress

            -- SYNTAX      InetAddress (SIZE(0|4|8|16|20))
            -- DESCRIPTION
            --     Support is only required for zero-length
            --     octet-strings, and for scoped and unscoped
            --     IPv4 and IPv6 addresses.
            -- OBJECT      udpEndpointRemoteAddressType
            -- SYNTAX      InetAddressType { unknown(0), ipv4(1),
            --                               ipv6(2), ipv4z(3),
            --                               ipv6z(4) }
            -- DESCRIPTION
            --     Support for dns(5) is not required.
            -- OBJECT      udpEndpointRemoteAddress
            -- SYNTAX      InetAddress (SIZE(0|4|8|16|20))
            -- DESCRIPTION
            --     Support is only required for zero-length
            --     octet-strings, and for scoped and unscoped
            --     IPv4 and IPv6 addresses.
           "))

(defoid |udpMIBCompliance| (|udpMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for IPv4-only systems that
            implement UDP.  For IP version independence, this
            compliance statement is deprecated in favor of
            udpMIBCompliance2.  However, agents are still
            encouraged to implement these objects in order to
            interoperate with the deployed base of managers."))

(defoid |udpGroup| (|udpMIBGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The deprecated group of objects providing for
            management of UDP over IPv4."))

(defoid |udpBaseGroup| (|udpMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects providing for counters of UDP
            statistics."))

(defoid |udpHCGroup| (|udpMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects providing for counters of high
            speed UDP implementations."))

(defoid |udpEndpointGroup| (|udpMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects providing for the IP version
            independent management of UDP 'endpoints'."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'udp-mib *mib-modules*)
  (setf *current-module* nil))

