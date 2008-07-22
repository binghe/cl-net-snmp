;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:BRIDGE-MIB

(in-package :asn.1)
(setf *current-module* 'bridge-mib)
(deftype |MacAddress| () 't)
(deftype |BridgeId| () 't)
(deftype |Timeout| () ':integer)
(defoid |dot1dBridge| (|mib-2| 17) (:type 'object-identity))
(defoid |dot1dBase| (|dot1dBridge| 1) (:type 'object-identity))
(defoid |dot1dStp| (|dot1dBridge| 2) (:type 'object-identity))
(defoid |dot1dSr| (|dot1dBridge| 3) (:type 'object-identity))
(defoid |dot1dTp| (|dot1dBridge| 4) (:type 'object-identity))
(defoid |dot1dStatic| (|dot1dBridge| 5) (:type 'object-identity))
(defoid |dot1dBaseBridgeAddress| (|dot1dBase| 1)
  (:type 'object-type)
  (:syntax '|MacAddress|)
  (:status '|mandatory|)
  (:description
   "The MAC address used by this bridge when it must
            be referred to in a unique fashion.   It is
            recommended that this be the numerically smallest
            MAC address of all ports that belong to this
            bridge.  However it is only required to be unique.
            When concatenated with dot1dStpPriority a unique
            BridgeIdentifier is formed which is used in the
            Spanning Tree Protocol."))
(defoid |dot1dBaseNumPorts| (|dot1dBase| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The number of ports controlled by this bridging
            entity."))
(defoid |dot1dBaseType| (|dot1dBase| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "Indicates what type of bridging this bridge can
            perform.  If a bridge is actually performing a
            certain type of bridging this will be indicated by
            entries in the port table for the given type."))
(defoid |dot1dBasePortTable| (|dot1dBase| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table that contains generic information about
            every port that is associated with this bridge.
            Transparent, source-route, and srt ports are
            included."))
(defoid |dot1dBasePortEntry| (|dot1dBasePortTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dBasePortEntry|)
  (:status '|mandatory|)
  (:description
   "A list of information for each port of the
            bridge."))
(deftype |Dot1dBasePortEntry| () 't)
(defoid |dot1dBasePort| (|dot1dBasePortEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port number of the port for which this entry
            contains bridge management information."))
(defoid |dot1dBasePortIfIndex| (|dot1dBasePortEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The value of the instance of the ifIndex object,
            defined in MIB-II, for the interface corresponding
            to this port."))
(defoid |dot1dBasePortCircuit| (|dot1dBasePortEntry| 3)
  (:type 'object-type)
  (:syntax 'object-id)
  (:status '|mandatory|)
  (:description
   "For a port which (potentially) has the same value
            of dot1dBasePortIfIndex as another port on the
            same bridge, this object contains the name of an
            object instance unique to this port.  For example,
            in the case where multiple ports correspond one-
            to-one with multiple X.25 virtual circuits, this
            value might identify an (e.g., the first) object
            instance associated with the X.25 virtual circuit
            corresponding to this port.

            For a port which has a unique value of
            dot1dBasePortIfIndex, this object can have the
            value { 0 0 }."))
(defoid |dot1dBasePortDelayExceededDiscards| (|dot1dBasePortEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of frames discarded by this port due
            to excessive transit delay through the bridge.  It
            is incremented by both transparent and source
            route bridges."))
(defoid |dot1dBasePortMtuExceededDiscards| (|dot1dBasePortEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of frames discarded by this port due
            to an excessive size.  It is incremented by both
            transparent and source route bridges."))
(defoid |dot1dStpProtocolSpecification| (|dot1dStp| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "An indication of what version of the Spanning
            Tree Protocol is being run.  The value
            'decLb100(2)' indicates the DEC LANbridge 100
            Spanning Tree protocol.  IEEE 802.1d
            implementations will return 'ieee8021d(3)'.  If
            future versions of the IEEE Spanning Tree Protocol
            are released that are incompatible with the
            current version a new value will be defined."))
(defoid |dot1dStpPriority| (|dot1dStp| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The value of the write-able portion of the Bridge
            ID, i.e., the first two octets of the (8 octet
            long) Bridge ID.  The other (last) 6 octets of the
            Bridge ID are given by the value of
            dot1dBaseBridgeAddress."))
(defoid |dot1dStpTimeSinceTopologyChange| (|dot1dStp| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:status '|mandatory|)
  (:description
   "The time (in hundredths of a second) since the
            last time a topology change was detected by the
            bridge entity."))
(defoid |dot1dStpTopChanges| (|dot1dStp| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of topology changes detected by
            this bridge since the management entity was last
            reset or initialized."))
(defoid |dot1dStpDesignatedRoot| (|dot1dStp| 5)
  (:type 'object-type)
  (:syntax '|BridgeId|)
  (:status '|mandatory|)
  (:description
   "The bridge identifier of the root of the spanning
            tree as determined by the Spanning Tree Protocol
            as executed by this node.  This value is used as

            the Root Identifier parameter in all Configuration
            Bridge PDUs originated by this node."))
(defoid |dot1dStpRootCost| (|dot1dStp| 6)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The cost of the path to the root as seen from
            this bridge."))
(defoid |dot1dStpRootPort| (|dot1dStp| 7)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The port number of the port which offers the
            lowest cost path from this bridge to the root
            bridge."))
(defoid |dot1dStpMaxAge| (|dot1dStp| 8)
  (:type 'object-type)
  (:syntax '|Timeout|)
  (:status '|mandatory|)
  (:description
   "The maximum age of Spanning Tree Protocol
            information learned from the network on any port
            before it is discarded, in units of hundredths of
            a second.  This is the actual value that this
            bridge is currently using."))
(defoid |dot1dStpHelloTime| (|dot1dStp| 9)
  (:type 'object-type)
  (:syntax '|Timeout|)
  (:status '|mandatory|)
  (:description
   "The amount of time between the transmission of
            Configuration bridge PDUs by this node on any port
            when it is the root of the spanning tree or trying
            to become so, in units of hundredths of a second.
            This is the actual value that this bridge is
            currently using."))
(defoid |dot1dStpHoldTime| (|dot1dStp| 10)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "This time value determines the interval length
            during which no more than two Configuration bridge
            PDUs shall be transmitted by this node, in units
            of hundredths of a second."))
(defoid |dot1dStpForwardDelay| (|dot1dStp| 11)
  (:type 'object-type)
  (:syntax '|Timeout|)
  (:status '|mandatory|)
  (:description
   "This time value, measured in units of hundredths
            of a second, controls how fast a port changes its
            spanning state when moving towards the Forwarding
            state.  The value determines how long the port
            stays in each of the Listening and Learning
            states, which precede the Forwarding state.  This
            value is also used, when a topology change has
            been detected and is underway, to age all dynamic
            entries in the Forwarding Database.  [Note that
            this value is the one that this bridge is
            currently using, in contrast to
            dot1dStpBridgeForwardDelay which is the value that
            this bridge and all others would start using
            if/when this bridge were to become the root.]"))
(defoid |dot1dStpBridgeMaxAge| (|dot1dStp| 12)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The value that all bridges use for MaxAge when
            this bridge is acting as the root.  Note that
            802.1D-1990 specifies that the range for this
            parameter is related to the value of
            dot1dStpBridgeHelloTime. The granularity of this
            timer is specified by 802.1D-1990 to be 1 second.
            An agent may return a badValue error if a set is
            attempted to a value which is not a whole number
            of seconds."))
(defoid |dot1dStpBridgeHelloTime| (|dot1dStp| 13)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The value that all bridges use for HelloTime when
            this bridge is acting as the root.  The
            granularity of this timer is specified by 802.1D-
            1990 to be 1 second.  An agent may return a
            badValue error if a set is attempted to a value
            which is not a whole number of seconds."))
(defoid |dot1dStpBridgeForwardDelay| (|dot1dStp| 14)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The value that all bridges use for ForwardDelay
            when this bridge is acting as the root.  Note that
            802.1D-1990 specifies that the range for this
            parameter is related to the value of
            dot1dStpBridgeMaxAge.  The granularity of this
            timer is specified by 802.1D-1990 to be 1 second.
            An agent may return a badValue error if a set is
            attempted to a value which is not a whole number
            of seconds."))
(defoid |dot1dStpPortTable| (|dot1dStp| 15)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table that contains port-specific information
            for the Spanning Tree Protocol."))
(defoid |dot1dStpPortEntry| (|dot1dStpPortTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dStpPortEntry|)
  (:status '|mandatory|)
  (:description
   "A list of information maintained by every port
            about the Spanning Tree Protocol state for that
            port."))
(deftype |Dot1dStpPortEntry| () 't)
(defoid |dot1dStpPort| (|dot1dStpPortEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port number of the port for which this entry
            contains Spanning Tree Protocol management
            information."))
(defoid |dot1dStpPortPriority| (|dot1dStpPortEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The value of the priority field which is
            contained in the first (in network byte order)
            octet of the (2 octet long) Port ID.  The other
            octet of the Port ID is given by the value of
            dot1dStpPort."))
(defoid |dot1dStpPortState| (|dot1dStpPortEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port's current state as defined by
            application of the Spanning Tree Protocol.  This
            state controls what action a port takes on
            reception of a frame.  If the bridge has detected
            a port that is malfunctioning it will place that
            port into the broken(6) state.  For ports which
            are disabled (see dot1dStpPortEnable), this object
            will have a value of disabled(1)."))
(defoid |dot1dStpPortEnable| (|dot1dStpPortEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The enabled/disabled status of the port."))
(defoid |dot1dStpPortPathCost| (|dot1dStpPortEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The contribution of this port to the path cost of
            paths towards the spanning tree root which include
            this port.  802.1D-1990 recommends that the
            default value of this parameter be in inverse
            proportion to the speed of the attached LAN."))
(defoid |dot1dStpPortDesignatedRoot| (|dot1dStpPortEntry| 6)
  (:type 'object-type)
  (:syntax '|BridgeId|)
  (:status '|mandatory|)
  (:description
   "The unique Bridge Identifier of the Bridge
            recorded as the Root in the Configuration BPDUs
            transmitted by the Designated Bridge for the
            segment to which the port is attached."))
(defoid |dot1dStpPortDesignatedCost| (|dot1dStpPortEntry| 7)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The path cost of the Designated Port of the
            segment connected to this port.  This value is
            compared to the Root Path Cost field in received

            bridge PDUs."))
(defoid |dot1dStpPortDesignatedBridge| (|dot1dStpPortEntry| 8)
  (:type 'object-type)
  (:syntax '|BridgeId|)
  (:status '|mandatory|)
  (:description
   "The Bridge Identifier of the bridge which this
            port considers to be the Designated Bridge for
            this port's segment."))
(defoid |dot1dStpPortDesignatedPort| (|dot1dStpPortEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The Port Identifier of the port on the Designated
            Bridge for this port's segment."))
(defoid |dot1dStpPortForwardTransitions| (|dot1dStpPortEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of times this port has transitioned
            from the Learning state to the Forwarding state."))
(defoid |dot1dTpLearnedEntryDiscards| (|dot1dTp| 1)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The total number of Forwarding Database entries,
            which have been or would have been learnt, but
            have been discarded due to a lack of space to
            store them in the Forwarding Database.  If this
            counter is increasing, it indicates that the
            Forwarding Database is regularly becoming full (a
            condition which has unpleasant performance effects
            on the subnetwork).  If this counter has a
            significant value but is not presently increasing,
            it indicates that the problem has been occurring
            but is not persistent."))
(defoid |dot1dTpAgingTime| (|dot1dTp| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The timeout period in seconds for aging out
            dynamically learned forwarding information.
            802.1D-1990 recommends a default of 300 seconds."))
(defoid |dot1dTpFdbTable| (|dot1dTp| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table that contains information about unicast
            entries for which the bridge has forwarding and/or
            filtering information.  This information is used
            by the transparent bridging function in
            determining how to propagate a received frame."))
(defoid |dot1dTpFdbEntry| (|dot1dTpFdbTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dTpFdbEntry|)
  (:status '|mandatory|)
  (:description
   "Information about a specific unicast MAC address
            for which the bridge has some forwarding and/or
            filtering information."))
(deftype |Dot1dTpFdbEntry| () 't)
(defoid |dot1dTpFdbAddress| (|dot1dTpFdbEntry| 1)
  (:type 'object-type)
  (:syntax '|MacAddress|)
  (:status '|mandatory|)
  (:description
   "A unicast MAC address for which the bridge has
            forwarding and/or filtering information."))
(defoid |dot1dTpFdbPort| (|dot1dTpFdbEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "Either the value '0', or the port number of the
            port on which a frame having a source address
            equal to the value of the corresponding instance
            of dot1dTpFdbAddress has been seen.  A value of
            '0' indicates that the port number has not been
            learned but that the bridge does have some
            forwarding/filtering information about this
            address (e.g. in the dot1dStaticTable).
            Implementors are encouraged to assign the port
            value to this object whenever it is learned even
            for addresses for which the corresponding value of
            dot1dTpFdbStatus is not learned(3)."))
(defoid |dot1dTpFdbStatus| (|dot1dTpFdbEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The status of this entry.  The meanings of the
            values are:
              other(1)   : none of the following.  This would
                           include the case where some other
                           MIB object (not the corresponding
                           instance of dot1dTpFdbPort, nor an
                           entry in the dot1dStaticTable) is
                           being used to determine if and how
                           frames addressed to the value of
                           the corresponding instance of
                           dot1dTpFdbAddress are being
                           forwarded.
              invalid(2) : this entry is not longer valid
                           (e.g., it was learned but has since
                           aged-out), but has not yet been
                           flushed from the table.
              learned(3) : the value of the corresponding
                           instance of dot1dTpFdbPort was
                           learned, and is being used.
              self(4)    : the value of the corresponding
                           instance of dot1dTpFdbAddress
                           represents one of the bridge's
                           addresses.  The corresponding
                           instance of dot1dTpFdbPort
                           indicates which of the bridge's
                           ports has this address.
              mgmt(5)    : the value of the corresponding
                           instance of dot1dTpFdbAddress is
                           also the value of an existing
                           instance of dot1dStaticAddress."))
(defoid |dot1dTpPortTable| (|dot1dTp| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table that contains information about every
            port that is associated with this transparent
            bridge."))
(defoid |dot1dTpPortEntry| (|dot1dTpPortTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dTpPortEntry|)
  (:status '|mandatory|)
  (:description
   "A list of information for each port of a
            transparent bridge."))
(deftype |Dot1dTpPortEntry| () 't)
(defoid |dot1dTpPort| (|dot1dTpPortEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port number of the port for which this entry
            contains Transparent bridging management
            information."))
(defoid |dot1dTpPortMaxInfo| (|dot1dTpPortEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The maximum size of the INFO (non-MAC) field that
            this port will receive or transmit."))
(defoid |dot1dTpPortInFrames| (|dot1dTpPortEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of frames that have been received by
            this port from its segment. Note that a frame
            received on the interface corresponding to this
            port is only counted by this object if and only if
            it is for a protocol being processed by the local
            bridging function, including bridge management
            frames."))
(defoid |dot1dTpPortOutFrames| (|dot1dTpPortEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of frames that have been transmitted
            by this port to its segment.  Note that a frame
            transmitted on the interface corresponding to this
            port is only counted by this object if and only if
            it is for a protocol being processed by the local
            bridging function, including bridge management
            frames."))
(defoid |dot1dTpPortInDiscards| (|dot1dTpPortEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "Count of valid frames received which were
            discarded (i.e., filtered) by the Forwarding
            Process."))
(defoid |dot1dStaticTable| (|dot1dStatic| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table containing filtering information
            configured into the bridge by (local or network)
            management specifying the set of ports to which
            frames received from specific ports and containing
            specific destination addresses are allowed to be
            forwarded.  The value of zero in this table as the
            port number from which frames with a specific
            destination address are received, is used to
            specify all ports for which there is no specific
            entry in this table for that particular
            destination address.  Entries are valid for
            unicast and for group/broadcast addresses."))
(defoid |dot1dStaticEntry| (|dot1dStaticTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dStaticEntry|)
  (:status '|mandatory|)
  (:description
   "Filtering information configured into the bridge
            by (local or network) management specifying the
            set of ports to which frames received from a
            specific port and containing a specific
            destination address are allowed to be forwarded."))
(deftype |Dot1dStaticEntry| () 't)
(defoid |dot1dStaticAddress| (|dot1dStaticEntry| 1)
  (:type 'object-type)
  (:syntax '|MacAddress|)
  (:status '|mandatory|)
  (:description
   "The destination MAC address in a frame to which
            this entry's filtering information applies.  This
            object can take the value of a unicast address, a
            group address or the broadcast address."))
(defoid |dot1dStaticReceivePort| (|dot1dStaticEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "Either the value '0', or the port number of the
            port from which a frame must be received in order
            for this entry's filtering information to apply.
            A value of zero indicates that this entry applies
            on all ports of the bridge for which there is no
            other applicable entry."))
(defoid |dot1dStaticAllowedToGoTo| (|dot1dStaticEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The set of ports to which frames received from a
            specific port and destined for a specific MAC

            address, are allowed to be forwarded.  Each octet
            within the value of this object specifies a set of
            eight ports, with the first octet specifying ports
            1 through 8, the second octet specifying ports 9
            through 16, etc.  Within each octet, the most
            significant bit represents the lowest numbered
            port, and the least significant bit represents the
            highest numbered port.  Thus, each port of the
            bridge is represented by a single bit within the
            value of this object.  If that bit has a value of
            '1' then that port is included in the set of
            ports; the port is not included if its bit has a
            value of '0'.  (Note that the setting of the bit
            corresponding to the port from which a frame is
            received is irrelevant.)  The default value of
            this object is a string of ones of appropriate
            length."))
(defoid |dot1dStaticStatus| (|dot1dStaticEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "This object indicates the status of this entry.
            The default value is permanent(3).
                 other(1) - this entry is currently in use but
                      the conditions under which it will
                      remain so are different from each of the
                      following values.
                 invalid(2) - writing this value to the object
                      removes the corresponding entry.
                 permanent(3) - this entry is currently in use
                      and will remain so after the next reset
                      of the bridge.
                 deleteOnReset(4) - this entry is currently in
                      use and will remain so until the next
                      reset of the bridge.
                 deleteOnTimeout(5) - this entry is currently
                      in use and will remain so until it is
                      aged out."))
(defunknown :trap-type)
(defunknown :trap-type)
