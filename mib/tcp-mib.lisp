;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;TCP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'tcp-mib))

(defpackage :asn.1/tcp-mib
  (:nicknames :tcp-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Unsigned32| |Gauge32| |Counter32|
                |Counter64| |IpAddress| |mib-2|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/inet-address-mib |InetAddress| |InetAddressType|
                |InetPortNumber|))

(in-package :tcp-mib)

(defoid |tcpMIB| (|mib-2| 49)
  (:type 'module-identity)
  (:description
   "The MIB module for managing TCP implementations.

            Copyright (C) The Internet Society (2005). This version
            of this MIB module is a part of RFC 4022; see the RFC
            itself for full legal notices."))

(defoid |tcp| (|mib-2| 6) (:type 'object-identity))

(defoid |tcpRtoAlgorithm| (|tcp| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The algorithm used to determine the timeout value used for
            retransmitting unacknowledged octets."))

(defoid |tcpRtoMin| (|tcp| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum value permitted by a TCP implementation for
            the retransmission timeout, measured in milliseconds.
            More refined semantics for objects of this type depend
            on the algorithm used to determine the retransmission
            timeout; in particular, the IETF standard algorithm
            rfc2988(5) provides a minimum value."))

(defoid |tcpRtoMax| (|tcp| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum value permitted by a TCP implementation for
            the retransmission timeout, measured in milliseconds.
            More refined semantics for objects of this type depend
            on the algorithm used to determine the retransmission
            timeout; in particular, the IETF standard algorithm
            rfc2988(5) provides an upper bound (as part of an
            adaptive backoff algorithm)."))

(defoid |tcpMaxConn| (|tcp| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The limit on the total number of TCP connections the entity
            can support.  In entities where the maximum number of
            connections is dynamic, this object should contain the
            value -1."))

(defoid |tcpActiveOpens| (|tcp| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that TCP connections have made a direct
            transition to the SYN-SENT state from the CLOSED state.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpPassiveOpens| (|tcp| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times TCP connections have made a direct
            transition to the SYN-RCVD state from the LISTEN state.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpAttemptFails| (|tcp| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that TCP connections have made a direct
            transition to the CLOSED state from either the SYN-SENT
            state or the SYN-RCVD state, plus the number of times that
            TCP connections have made a direct transition to the
            LISTEN state from the SYN-RCVD state.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpEstabResets| (|tcp| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that TCP connections have made a direct
            transition to the CLOSED state from either the ESTABLISHED
            state or the CLOSE-WAIT state.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpCurrEstab| (|tcp| 9)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of TCP connections for which the current state
            is either ESTABLISHED or CLOSE-WAIT."))

(defoid |tcpInSegs| (|tcp| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of segments received, including those
            received in error.  This count includes segments received
            on currently established connections.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpOutSegs| (|tcp| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of segments sent, including those on
            current connections but excluding those containing only
            retransmitted octets.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpRetransSegs| (|tcp| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of segments retransmitted; that is, the
            number of TCP segments transmitted containing one or more
            previously transmitted octets.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpInErrs| (|tcp| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of segments received in error (e.g., bad
            TCP checksums).

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpOutRsts| (|tcp| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of TCP segments sent containing the RST flag.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpHCInSegs| (|tcp| 17)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of segments received, including those
            received in error.  This count includes segments received

            on currently established connections.  This object is
            the 64-bit equivalent of tcpInSegs.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpHCOutSegs| (|tcp| 18)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of segments sent, including those on
            current connections but excluding those containing only
            retransmitted octets.  This object is the 64-bit
            equivalent of tcpOutSegs.

            Discontinuities in the value of this counter are
            indicated via discontinuities in the value of sysUpTime."))

(defoid |tcpConnectionTable| (|tcp| 19)
  (:type 'object-type)
  (:syntax '(vector |TcpConnectionEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information about existing TCP
            connections.  Note that unlike earlier TCP MIBs, there
            is a separate table for connections in the LISTEN state."))

(defoid |tcpConnectionEntry| (|tcpConnectionTable| 1)
  (:type 'object-type)
  (:syntax '|TcpConnectionEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A conceptual row of the tcpConnectionTable containing
            information about a particular current TCP connection.
            Each row of this table is transient in that it ceases to
            exist when (or soon after) the connection makes the
            transition to the CLOSED state."))

(defclass |TcpConnectionEntry| (sequence-type)
  ((|tcpConnectionLocalAddressType| :type |InetAddressType|)
   (|tcpConnectionLocalAddress| :type |InetAddress|)
   (|tcpConnectionLocalPort| :type |InetPortNumber|)
   (|tcpConnectionRemAddressType| :type |InetAddressType|)
   (|tcpConnectionRemAddress| :type |InetAddress|)
   (|tcpConnectionRemPort| :type |InetPortNumber|)
   (|tcpConnectionState| :type integer)
   (|tcpConnectionProcess| :type |Unsigned32|)))

(defoid |tcpConnectionLocalAddressType| (|tcpConnectionEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The address type of tcpConnectionLocalAddress."))

(defoid |tcpConnectionLocalAddress| (|tcpConnectionEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The local IP address for this TCP connection.  The type
            of this address is determined by the value of
            tcpConnectionLocalAddressType.

            As this object is used in the index for the
            tcpConnectionTable, implementors should be
            careful not to create entries that would result in OIDs
            with more than 128 subidentifiers; otherwise the information
            cannot be accessed by using SNMPv1, SNMPv2c, or SNMPv3."))

(defoid |tcpConnectionLocalPort| (|tcpConnectionEntry| 3)
  (:type 'object-type)
  (:syntax '|InetPortNumber|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The local port number for this TCP connection."))

(defoid |tcpConnectionRemAddressType| (|tcpConnectionEntry| 4)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The address type of tcpConnectionRemAddress."))

(defoid |tcpConnectionRemAddress| (|tcpConnectionEntry| 5)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The remote IP address for this TCP connection.  The type
            of this address is determined by the value of
            tcpConnectionRemAddressType.

            As this object is used in the index for the
            tcpConnectionTable, implementors should be
            careful not to create entries that would result in OIDs
            with more than 128 subidentifiers; otherwise the information
            cannot be accessed by using SNMPv1, SNMPv2c, or SNMPv3."))

(defoid |tcpConnectionRemPort| (|tcpConnectionEntry| 6)
  (:type 'object-type)
  (:syntax '|InetPortNumber|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The remote port number for this TCP connection."))

(defoid |tcpConnectionState| (|tcpConnectionEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The state of this TCP connection.

            The value listen(2) is included only for parallelism to the
            old tcpConnTable and should not be used.  A connection in
            LISTEN state should be present in the tcpListenerTable.

            The only value that may be set by a management station is
            deleteTCB(12).  Accordingly, it is appropriate for an agent
            to return a `badValue' response if a management station
            attempts to set this object to any other value.

            If a management station sets this object to the value
            deleteTCB(12), then the TCB (as defined in [RFC793]) of
            the corresponding connection on the managed node is
            deleted, resulting in immediate termination of the
            connection.

            As an implementation-specific option, a RST segment may be
            sent from the managed node to the other TCP endpoint (note,
            however, that RST segments are not sent reliably)."))

(defoid |tcpConnectionProcess| (|tcpConnectionEntry| 8)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The system's process ID for the process associated with
            this connection, or zero if there is no such process.  This
            value is expected to be the same as HOST-RESOURCES-MIB::
            hrSWRunIndex or SYSAPPL-MIB::sysApplElmtRunIndex for some
            row in the appropriate tables."))

(defoid |tcpListenerTable| (|tcp| 20)
  (:type 'object-type)
  (:syntax '(vector |TcpListenerEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information about TCP listeners.  A
            listening application can be represented in three
            possible ways:

            1. An application that is willing to accept both IPv4 and
               IPv6 datagrams is represented by

               a tcpListenerLocalAddressType of unknown (0) and
               a tcpListenerLocalAddress of ''h (a zero-length
               octet-string).

            2. An application that is willing to accept only IPv4 or
               IPv6 datagrams is represented by a
               tcpListenerLocalAddressType of the appropriate address
               type and a tcpListenerLocalAddress of '0.0.0.0' or '::'
               respectively.

            3. An application that is listening for data destined
               only to a specific IP address, but from any remote
               system, is represented by a tcpListenerLocalAddressType
               of an appropriate address type, with
               tcpListenerLocalAddress as the specific local address.

            NOTE: The address type in this table represents the
            address type used for the communication, irrespective
            of the higher-layer abstraction.  For example, an
            application using IPv6 'sockets' to communicate via
            IPv4 between ::ffff:10.0.0.1 and ::ffff:10.0.0.2 would
            use InetAddressType ipv4(1))."))

(defoid |tcpListenerEntry| (|tcpListenerTable| 1)
  (:type 'object-type)
  (:syntax '|TcpListenerEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A conceptual row of the tcpListenerTable containing
            information about a particular TCP listener."))

(defclass |TcpListenerEntry| (sequence-type)
  ((|tcpListenerLocalAddressType| :type |InetAddressType|)
   (|tcpListenerLocalAddress| :type |InetAddress|)
   (|tcpListenerLocalPort| :type |InetPortNumber|)
   (|tcpListenerProcess| :type |Unsigned32|)))

(defoid |tcpListenerLocalAddressType| (|tcpListenerEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The address type of tcpListenerLocalAddress.  The value
            should be unknown (0) if connection initiations to all
            local IP addresses are accepted."))

(defoid |tcpListenerLocalAddress| (|tcpListenerEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The local IP address for this TCP connection.

            The value of this object can be represented in three
            possible ways, depending on the characteristics of the
            listening application:

            1. For an application willing to accept both IPv4 and
               IPv6 datagrams, the value of this object must be
               ''h (a zero-length octet-string), with the value
               of the corresponding tcpListenerLocalAddressType
               object being unknown (0).

            2. For an application willing to accept only IPv4 or
               IPv6 datagrams, the value of this object must be
               '0.0.0.0' or '::' respectively, with
               tcpListenerLocalAddressType representing the
               appropriate address type.

            3. For an application which is listening for data
               destined only to a specific IP address, the value
               of this object is the specific local address, with
               tcpListenerLocalAddressType representing the
               appropriate address type.

            As this object is used in the index for the
            tcpListenerTable, implementors should be
            careful not to create entries that would result in OIDs
            with more than 128 subidentifiers; otherwise the information
            cannot be accessed, using SNMPv1, SNMPv2c, or SNMPv3."))

(defoid |tcpListenerLocalPort| (|tcpListenerEntry| 3)
  (:type 'object-type)
  (:syntax '|InetPortNumber|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The local port number for this TCP connection."))

(defoid |tcpListenerProcess| (|tcpListenerEntry| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The system's process ID for the process associated with
            this listener, or zero if there is no such process.  This
            value is expected to be the same as HOST-RESOURCES-MIB::
            hrSWRunIndex or SYSAPPL-MIB::sysApplElmtRunIndex for some
            row in the appropriate tables."))

(defoid |tcpConnTable| (|tcp| 13)
  (:type 'object-type)
  (:syntax '(vector |TcpConnEntry|))
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "A table containing information about existing IPv4-specific
            TCP connections or listeners.  This table has been
            deprecated in favor of the version neutral
            tcpConnectionTable."))

(defoid |tcpConnEntry| (|tcpConnTable| 1)
  (:type 'object-type)
  (:syntax '|TcpConnEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "A conceptual row of the tcpConnTable containing information
            about a particular current IPv4 TCP connection.  Each row
            of this table is transient in that it ceases to exist when
            (or soon after) the connection makes the transition to the
            CLOSED state."))

(defclass |TcpConnEntry| (sequence-type)
  ((|tcpConnState| :type integer)
   (|tcpConnLocalAddress| :type |IpAddress|)
   (|tcpConnLocalPort| :type |Integer32|)
   (|tcpConnRemAddress| :type |IpAddress|)
   (|tcpConnRemPort| :type |Integer32|)))

(defoid |tcpConnState| (|tcpConnEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|deprecated|)
  (:description
   "The state of this TCP connection.

            The only value that may be set by a management station is
            deleteTCB(12).  Accordingly, it is appropriate for an agent
            to return a `badValue' response if a management station
            attempts to set this object to any other value.

            If a management station sets this object to the value
            deleteTCB(12), then the TCB (as defined in [RFC793]) of
            the corresponding connection on the managed node is
            deleted, resulting in immediate termination of the
            connection.

            As an implementation-specific option, a RST segment may be
            sent from the managed node to the other TCP endpoint (note,
            however, that RST segments are not sent reliably)."))

(defoid |tcpConnLocalAddress| (|tcpConnEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The local IP address for this TCP connection.  In the case
            of a connection in the listen state willing to
            accept connections for any IP interface associated with the
            node, the value 0.0.0.0 is used."))

(defoid |tcpConnLocalPort| (|tcpConnEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description "The local port number for this TCP connection."))

(defoid |tcpConnRemAddress| (|tcpConnEntry| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description "The remote IP address for this TCP connection."))

(defoid |tcpConnRemPort| (|tcpConnEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description "The remote port number for this TCP connection."))

(defoid |tcpMIBConformance| (|tcpMIB| 2) (:type 'object-identity))

(defoid |tcpMIBCompliances| (|tcpMIBConformance| 1)
  (:type 'object-identity))

(defoid |tcpMIBGroups| (|tcpMIBConformance| 2) (:type 'object-identity))

(defoid |tcpMIBCompliance2| (|tcpMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for systems that implement TCP.

            A number of INDEX objects cannot be
            represented in the form of OBJECT clauses in SMIv2 but
            have the following compliance requirements,
            expressed in OBJECT clause form in this description
            clause:

            -- OBJECT      tcpConnectionLocalAddressType
            -- SYNTAX      InetAddressType { ipv4(1), ipv6(2) }
            -- DESCRIPTION
            --     This MIB requires support for only global IPv4

            --     and IPv6 address types.
            --
            -- OBJECT      tcpConnectionRemAddressType
            -- SYNTAX      InetAddressType { ipv4(1), ipv6(2) }
            -- DESCRIPTION
            --     This MIB requires support for only global IPv4
            --     and IPv6 address types.
            --
            -- OBJECT      tcpListenerLocalAddressType
            -- SYNTAX      InetAddressType { unknown(0), ipv4(1),
            --                               ipv6(2) }
            -- DESCRIPTION
            --     This MIB requires support for only global IPv4
            --     and IPv6 address types.  The type unknown also
            --     needs to be supported to identify a special
            --     case in the listener table: a listen using
            --     both IPv4 and IPv6 addresses on the device.
            --
           "))

(defoid |tcpMIBCompliance| (|tcpMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for IPv4-only systems that
            implement TCP.  In order to be IP version independent, this
            compliance statement is deprecated in favor of
            tcpMIBCompliance2.  However, agents are still encouraged
            to implement these objects in order to interoperate with
            the deployed base of managers."))

(defoid |tcpGroup| (|tcpMIBGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "The tcp group of objects providing for management of TCP
            entities."))

(defoid |tcpBaseGroup| (|tcpMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description "The group of counters common to TCP entities."))

(defoid |tcpConnectionGroup| (|tcpMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group provides general information about TCP
            connections."))

(defoid |tcpListenerGroup| (|tcpMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "This group has objects providing general information about
            TCP listeners."))

(defoid |tcpHCGroup| (|tcpMIBGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The group of objects providing for counters of high speed
            TCP implementations."))

(eval-when (:load-toplevel :execute)
  (pushnew 'tcp-mib *mib-modules*)
  (setf *current-module* nil))

