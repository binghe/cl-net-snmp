;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;TUNNEL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'tunnel-mib *mib-modules*)
  (setf *current-module* 'tunnel-mib))

(defpackage :asn.1/tunnel-mib
  (:nicknames :tunnel-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |transmission| |Integer32| |IpAddress|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus| |StorageType|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/inet-address-mib |InetAddressType|
                |InetAddress|)
  (:import-from :asn.1/ipv6-flow-label-mib |IPv6FlowLabelOrAny|)
  (:import-from :asn.1/if-mib |ifIndex| |InterfaceIndexOrZero|)
  (:import-from :|ASN.1/IANAifType-MIB| |IANAtunnelType|))

(in-package :tunnel-mib)

(defoid |tunnelMIB| (|transmission| 131)
  (:type 'module-identity)
  (:description
   "The MIB module for management of IP Tunnels,
            independent of the specific encapsulation scheme in
            use.

            Copyright (C) The Internet Society (2005).  This
            version of this MIB module is part of RFC 4087;  see
            the RFC itself for full legal notices."))

(defoid |tunnelMIBObjects| (|tunnelMIB| 1) (:type 'object-identity))

(defoid |tunnel| (|tunnelMIBObjects| 1) (:type 'object-identity))

(defoid |tunnelIfTable| (|tunnel| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table containing information on
            configured tunnels."))

(defoid |tunnelIfEntry| (|tunnelIfTable| 1)
  (:type 'object-type)
  (:syntax '|TunnelIfEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry (conceptual row) containing the information
            on a particular configured tunnel."))

(deftype |TunnelIfEntry| () 't)

(defoid |tunnelIfLocalAddress| (|tunnelIfEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The address of the local endpoint of the tunnel
            (i.e., the source address used in the outer IP
            header), or 0.0.0.0 if unknown or if the tunnel is
            over IPv6.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelIfLocalInetAddress."))

(defoid |tunnelIfRemoteAddress| (|tunnelIfEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The address of the remote endpoint of the tunnel
            (i.e., the destination address used in the outer IP
            header), or 0.0.0.0 if unknown, or an IPv6 address, or



            the tunnel is not a point-to-point link (e.g., if it
            is a 6to4 tunnel).

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelIfRemoteInetAddress."))

(defoid |tunnelIfEncapsMethod| (|tunnelIfEntry| 3)
  (:type 'object-type)
  (:syntax '|IANAtunnelType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The encapsulation method used by the tunnel."))

(defoid |tunnelIfHopLimit| (|tunnelIfEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The IPv4 TTL or IPv6 Hop Limit to use in the outer IP
            header.  A value of 0 indicates that the value is
            copied from the payload's header."))

(defoid |tunnelIfSecurity| (|tunnelIfEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The method used by the tunnel to secure the outer IP
            header.  The value ipsec indicates that IPsec is used
            between the tunnel endpoints for authentication or
            encryption or both.  More specific security-related
            information may be available in a MIB module for the
            security protocol in use."))

(defoid |tunnelIfTOS| (|tunnelIfEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The method used to set the high 6 bits (the



            differentiated services codepoint) of the IPv4 TOS or
            IPv6 Traffic Class in the outer IP header.  A value of
            -1 indicates that the bits are copied from the
            payload's header.  A value of -2 indicates that a
            traffic conditioner is invoked and more information
            may be available in a traffic conditioner MIB module.
            A value between 0 and 63 inclusive indicates that the
            bit field is set to the indicated value.

            Note: instead of the name tunnelIfTOS, a better name
            would have been tunnelIfDSCPMethod, but the existing
            name appeared in RFC 2667 and existing objects cannot
            be renamed."))

(defoid |tunnelIfFlowLabel| (|tunnelIfEntry| 7)
  (:type 'object-type)
  (:syntax '|IPv6FlowLabelOrAny|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The method used to set the IPv6 Flow Label value.
            This object need not be present in rows where
            tunnelIfAddressType indicates the tunnel is not over
            IPv6.  A value of -1 indicates that a traffic
            conditioner is invoked and more information may be
            available in a traffic conditioner MIB.  Any other
            value indicates that the Flow Label field is set to
            the indicated value."))

(defoid |tunnelIfAddressType| (|tunnelIfEntry| 8)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The type of address in the corresponding
            tunnelIfLocalInetAddress and tunnelIfRemoteInetAddress
            objects."))

(defoid |tunnelIfLocalInetAddress| (|tunnelIfEntry| 9)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The address of the local endpoint of the tunnel
            (i.e., the source address used in the outer IP
            header).  If the address is unknown, the value is



            0.0.0.0 for IPv4 or :: for IPv6.  The type of this
            object is given by tunnelIfAddressType."))

(defoid |tunnelIfRemoteInetAddress| (|tunnelIfEntry| 10)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The address of the remote endpoint of the tunnel
            (i.e., the destination address used in the outer IP
            header).  If the address is unknown or the tunnel is
            not a point-to-point link (e.g., if it is a 6to4
            tunnel), the value is 0.0.0.0 for tunnels over IPv4 or
            :: for tunnels over IPv6.  The type of this object is
            given by tunnelIfAddressType."))

(defoid |tunnelIfEncapsLimit| (|tunnelIfEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The maximum number of additional encapsulations
            permitted for packets undergoing encapsulation at this
            node.  A value of -1 indicates that no limit is
            present (except as a result of the packet size)."))

(defoid |tunnelConfigTable| (|tunnel| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The (conceptual) table containing information on
            configured tunnels.  This table can be used to map a
            set of tunnel endpoints to the associated ifIndex
            value.  It can also be used for row creation.  Note
            that every row in the tunnelIfTable with a fixed IPv4
            destination address should have a corresponding row in
            the tunnelConfigTable, regardless of whether it was
            created via SNMP.

            Since this table does not support IPv6, it is
            deprecated in favor of tunnelInetConfigTable."))

(defoid |tunnelConfigEntry| (|tunnelConfigTable| 1)
  (:type 'object-type)
  (:syntax '|TunnelConfigEntry|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "An entry (conceptual row) containing the information
            on a particular configured tunnel.

            Since this entry does not support IPv6, it is
            deprecated in favor of tunnelInetConfigEntry."))

(deftype |TunnelConfigEntry| () 't)

(defoid |tunnelConfigLocalAddress| (|tunnelConfigEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The address of the local endpoint of the tunnel, or
            0.0.0.0 if the device is free to choose any of its
            addresses at tunnel establishment time.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelInetConfigLocalAddress."))

(defoid |tunnelConfigRemoteAddress| (|tunnelConfigEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The address of the remote endpoint of the tunnel.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelInetConfigRemoteAddress."))

(defoid |tunnelConfigEncapsMethod| (|tunnelConfigEntry| 3)
  (:type 'object-type)
  (:syntax '|IANAtunnelType|)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "The encapsulation method used by the tunnel.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelInetConfigEncapsMethod."))

(defoid |tunnelConfigID| (|tunnelConfigEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|deprecated|)
  (:description
   "An identifier used to distinguish between multiple
            tunnels of the same encapsulation method, with the
            same endpoints.  If the encapsulation protocol only
            allows one tunnel per set of endpoint addresses (such
            as for GRE or IP-in-IP), the value of this object is
            1.  For encapsulation methods (such as L2F) which
            allow multiple parallel tunnels, the manager is
            responsible for choosing any ID which does not
            conflict with an existing row, such as choosing a
            random number.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelInetConfigID."))

(defoid |tunnelConfigIfIndex| (|tunnelConfigEntry| 5)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "If the value of tunnelConfigStatus for this row is
            active, then this object contains the value of ifIndex
            corresponding to the tunnel interface.  A value of 0
            is not legal in the active state, and means that the
            interface index has not yet been assigned.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelInetConfigIfIndex."))

(defoid |tunnelConfigStatus| (|tunnelConfigEntry| 6)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|deprecated|)
  (:description
   "The status of this row, by which new entries may be
            created, or old entries deleted from this table.  The
            agent need not support setting this object to
            createAndWait or notInService since there are no other
            writable objects in this table, and writable objects
            in rows of corresponding tables such as the
            tunnelIfTable may be modified while this row is
            active.

            To create a row in this table for an encapsulation
            method which does not support multiple parallel
            tunnels with the same endpoints, the management
            station should simply use a tunnelConfigID of 1, and
            set tunnelConfigStatus to createAndGo.  For
            encapsulation methods such as L2F which allow multiple
            parallel tunnels, the management station may select a
            pseudo-random number to use as the tunnelConfigID and
            set tunnelConfigStatus to createAndGo.  In the event
            that this ID is already in use and an
            inconsistentValue is returned in response to the set
            operation, the management station should simply select
            a new pseudo-random number and retry the operation.

            Creating a row in this table will cause an interface
            index to be assigned by the agent in an
            implementation-dependent manner, and corresponding
            rows will be instantiated in the ifTable and the
            tunnelIfTable.  The status of this row will become
            active as soon as the agent assigns the interface
            index, regardless of whether the interface is
            operationally up.

            Deleting a row in this table will likewise delete the
            corresponding row in the ifTable and in the
            tunnelIfTable.

            Since this object does not support IPv6, it is
            deprecated in favor of tunnelInetConfigStatus."))

(defoid |tunnelInetConfigTable| (|tunnel| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table containing information on
            configured tunnels.  This table can be used to map a
            set of tunnel endpoints to the associated ifIndex
            value.  It can also be used for row creation.  Note
            that every row in the tunnelIfTable with a fixed
            destination address should have a corresponding row in
            the tunnelInetConfigTable, regardless of whether it
            was created via SNMP."))

(defoid |tunnelInetConfigEntry| (|tunnelInetConfigTable| 1)
  (:type 'object-type)
  (:syntax '|TunnelInetConfigEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry (conceptual row) containing the information
            on a particular configured tunnel.  Note that there is
            a 128 subid maximum for object OIDs.  Implementers
            need to be aware that if the total number of octets in
            tunnelInetConfigLocalAddress and
            tunnelInetConfigRemoteAddress exceeds 110 then OIDs of
            column instances in this table will have more than 128
            sub-identifiers and cannot be accessed using SNMPv1,
            SNMPv2c, or SNMPv3.  In practice this is not expected
            to be a problem since IPv4 and IPv6 addresses will not
            cause the limit to be reached, but if other types are
            supported by an agent, care must be taken to ensure
            that the sum of the lengths do not cause the limit to
            be exceeded."))

(deftype |TunnelInetConfigEntry| () 't)

(defoid |tunnelInetConfigAddressType| (|tunnelInetConfigEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The address type over which the tunnel encapsulates
            packets."))

(defoid |tunnelInetConfigLocalAddress| (|tunnelInetConfigEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The address of the local endpoint of the tunnel, or
            0.0.0.0 (for IPv4) or :: (for IPv6) if the device is
            free to choose any of its addresses at tunnel
            establishment time."))

(defoid |tunnelInetConfigRemoteAddress| (|tunnelInetConfigEntry| 3)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The address of the remote endpoint of the tunnel."))

(defoid |tunnelInetConfigEncapsMethod| (|tunnelInetConfigEntry| 4)
  (:type 'object-type)
  (:syntax '|IANAtunnelType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The encapsulation method used by the tunnel."))

(defoid |tunnelInetConfigID| (|tunnelInetConfigEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An identifier used to distinguish between multiple
            tunnels of the same encapsulation method, with the
            same endpoints.  If the encapsulation protocol only
            allows one tunnel per set of endpoint addresses (such
            as for GRE or IP-in-IP), the value of this object is
            1.  For encapsulation methods (such as L2F) which
            allow multiple parallel tunnels, the manager is
            responsible for choosing any ID which does not



            conflict with an existing row, such as choosing a
            random number."))

(defoid |tunnelInetConfigIfIndex| (|tunnelInetConfigEntry| 6)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "If the value of tunnelInetConfigStatus for this row
            is active, then this object contains the value of
            ifIndex corresponding to the tunnel interface.  A
            value of 0 is not legal in the active state, and means
            that the interface index has not yet been assigned."))

(defoid |tunnelInetConfigStatus| (|tunnelInetConfigEntry| 7)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this row, by which new entries may be
            created, or old entries deleted from this table.  The
            agent need not support setting this object to
            createAndWait or notInService since there are no other
            writable objects in this table, and writable objects
            in rows of corresponding tables such as the
            tunnelIfTable may be modified while this row is
            active.

            To create a row in this table for an encapsulation
            method which does not support multiple parallel
            tunnels with the same endpoints, the management
            station should simply use a tunnelInetConfigID of 1,
            and set tunnelInetConfigStatus to createAndGo.  For
            encapsulation methods such as L2F which allow multiple
            parallel tunnels, the management station may select a
            pseudo-random number to use as the tunnelInetConfigID
            and set tunnelInetConfigStatus to createAndGo.  In the
            event that this ID is already in use and an
            inconsistentValue is returned in response to the set
            operation, the management station should simply select
            a new pseudo-random number and retry the operation.

            Creating a row in this table will cause an interface
            index to be assigned by the agent in an
            implementation-dependent manner, and corresponding
            rows will be instantiated in the ifTable and the



            tunnelIfTable.  The status of this row will become
            active as soon as the agent assigns the interface
            index, regardless of whether the interface is
            operationally up.

            Deleting a row in this table will likewise delete the
            corresponding row in the ifTable and in the
            tunnelIfTable."))

(defoid |tunnelInetConfigStorageType| (|tunnelInetConfigEntry| 8)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type of this row.  If the row is
            permanent(4), no objects in the row need be writable."))

(defoid |tunnelMIBConformance| (|tunnelMIB| 2) (:type 'object-identity))

(defoid |tunnelMIBCompliances| (|tunnelMIBConformance| 1)
  (:type 'object-identity))

(defoid |tunnelMIBGroups| (|tunnelMIBConformance| 2)
  (:type 'object-identity))

(defoid |tunnelMIBCompliance| (|tunnelMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The (deprecated) IPv4-only compliance statement for
            the IP Tunnel MIB.

            This is deprecated in favor of
            tunnelMIBInetFullCompliance and
            tunnelMIBInetReadOnlyCompliance."))

(defoid |tunnelMIBInetFullCompliance| (|tunnelMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description "The full compliance statement for the IP Tunnel MIB."))

(defoid |tunnelMIBInetReadOnlyCompliance| (|tunnelMIBCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The read-only compliance statement for the IP Tunnel
            MIB."))

(defoid |tunnelMIBBasicGroup| (|tunnelMIBGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects to support basic management



            of IPv4 Tunnels.  Since this group cannot support
            IPv6, it is deprecated in favor of
            tunnelMIBInetGroup."))

(defoid |tunnelMIBInetGroup| (|tunnelMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects to support basic management
            of IPv4 and IPv6 Tunnels."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

