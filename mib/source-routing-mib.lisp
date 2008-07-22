;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:SOURCE-ROUTING-MIB

(in-package :asn.1)
(setf *current-module* 'source-routing-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'source-routing-mib *mib-modules*))
(defoid |dot1dPortPair| (|dot1dBridge| 10) (:type 'object-identity))
(defoid |dot1dSrPortTable| (|dot1dSr| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table that contains information about every
            port that is associated with this source route
            bridge."))
(defoid |dot1dSrPortEntry| (|dot1dSrPortTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dSrPortEntry|)
  (:status '|mandatory|)
  (:description
   "A list of information for each port of a source
            route bridge."))
(deftype |Dot1dSrPortEntry| () 't)
(defoid |dot1dSrPort| (|dot1dSrPortEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port number of the port for which this entry

            contains Source Route management information."))
(defoid |dot1dSrPortHopCount| (|dot1dSrPortEntry| 2)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The maximum number of routing descriptors allowed
            in an All Paths or Spanning Tree Explorer frames."))
(defoid |dot1dSrPortLocalSegment| (|dot1dSrPortEntry| 3)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The segment number that uniquely identifies the
            segment to which this port is connected. Current
            source routing protocols limit this value to the
            range: 0 through 4095. (The value 0 is used by
            some management applications for special test
            cases.) A value of 65535 signifies that no segment
            number is assigned to this port."))
(defoid |dot1dSrPortBridgeNum| (|dot1dSrPortEntry| 4)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "A bridge number uniquely identifies a bridge when
            more than one bridge is used to span the same two
            segments.  Current source routing protocols limit
            this value to the range: 0 through 15. A value of
            65535 signifies that no bridge number is assigned
            to this bridge."))
(defoid |dot1dSrPortTargetSegment| (|dot1dSrPortEntry| 5)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The segment number that corresponds to the target
            segment this port is considered to be connected to
            by the bridge.  Current source routing protocols
            limit this value to the range: 0 through 4095.

            (The value 0 is used by some management
            applications for special test cases.) A value of
            65535 signifies that no target segment is assigned
            to this port."))
(defoid |dot1dSrPortLargestFrame| (|dot1dSrPortEntry| 6)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "The maximum size of the INFO field (LLC and
            above) that this port can send/receive.  It does
            not include any MAC level (framing) octets.  The
            value of this object is used by this bridge to
            determine whether a modification of the
            LargestFrame (LF, see [14]) field of the Routing
            Control field of the Routing Information Field is
            necessary.

            64 valid values are defined by the IEEE 802.5M SRT
            Addendum: 516, 635, 754, 873, 993, 1112, 1231,
            1350, 1470, 1542, 1615, 1688, 1761, 1833, 1906,
            1979, 2052, 2345, 2638, 2932, 3225, 3518, 3812,
            4105, 4399, 4865, 5331, 5798, 6264, 6730, 7197,
            7663, 8130, 8539, 8949, 9358, 9768, 10178, 10587,
            10997, 11407, 12199, 12992, 13785, 14578, 15370,
            16163, 16956, 17749, 20730, 23711, 26693, 29674,
            32655, 35637, 38618, 41600, 44591, 47583, 50575,
            53567, 56559, 59551, and 65535.

            An illegal value will not be accepted by the
            bridge."))
(defoid |dot1dSrPortSTESpanMode| (|dot1dSrPortEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "Determines how this port behaves when presented
            with a Spanning Tree Explorer frame.  The value
            'disabled(2)' indicates that the port will not
            accept or send Spanning Tree Explorer packets; any
            STE packets received will be silently discarded.
            The value 'forced(3)' indicates the port will
            always accept and propagate Spanning Tree Explorer
            frames.  This allows a manually configured
            Spanning Tree for this class of packet to be
            configured.  Note that unlike transparent
            bridging, this is not catastrophic to the network
            if there are loops.  The value 'auto-span(1)' can
            only be returned by a bridge that both implements
            the Spanning Tree Protocol and has use of the
            protocol enabled on this port. The behavior of the
            port for Spanning Tree Explorer frames is
            determined by the state of dot1dStpPortState.  If
            the port is in the 'forwarding' state, the frame
            will be accepted or propagated.  Otherwise, it
            will be silently discarded."))
(defoid |dot1dSrPortSpecInFrames| (|dot1dSrPortEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of Specifically Routed frames, also
            referred to as Source Routed Frames, that have
            been received from this port's segment."))
(defoid |dot1dSrPortSpecOutFrames| (|dot1dSrPortEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of Specifically Routed frames, also
            referred to as Source Routed Frames, that this
            port has transmitted on its segment."))
(defoid |dot1dSrPortApeInFrames| (|dot1dSrPortEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of All Paths Explorer frames, also
            referred to as All Routes Explorer frames, that
            have been received by this port from its segment."))
(defoid |dot1dSrPortApeOutFrames| (|dot1dSrPortEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of all Paths Explorer Frames, also
            referred to as All Routes Explorer frames, that
            have been transmitted by this port on its
            segment."))
(defoid |dot1dSrPortSteInFrames| (|dot1dSrPortEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of spanning tree explorer frames that
            have been received by this port from its segment."))
(defoid |dot1dSrPortSteOutFrames| (|dot1dSrPortEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of spanning tree explorer frames that
            have been transmitted by this port on its
            segment."))
(defoid |dot1dSrPortSegmentMismatchDiscards| (|dot1dSrPortEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of explorer frames that have been
            discarded by this port because the routing
            descriptor field contained an invalid adjacent
            segment value."))
(defoid |dot1dSrPortDuplicateSegmentDiscards| (|dot1dSrPortEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of frames that have been discarded by
            this port because the routing descriptor field
            contained a duplicate segment identifier."))
(defoid |dot1dSrPortHopCountExceededDiscards| (|dot1dSrPortEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of explorer frames that have been
            discarded by this port because the Routing
            Information Field has exceeded the maximum route
            descriptor length."))
(defoid |dot1dSrPortDupLanIdOrTreeErrors| (|dot1dSrPortEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of duplicate LAN IDs or Tree errors.
            This helps in detection of problems in networks
            containing older IBM Source Routing Bridges."))
(defoid |dot1dSrPortLanIdMismatches| (|dot1dSrPortEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter|)
  (:status '|mandatory|)
  (:description
   "The number of ARE and STE frames that were
            discarded because the last LAN ID in the routing
            information field did not equal the LAN-in ID.
            This error can occur in implementations which do
            only a LAN-in ID and Bridge Number check instead
            of a LAN-in ID, Bridge Number, and LAN-out ID
            check before they forward broadcast frames."))
(defoid |dot1dSrBridgeLfMode| (|dot1dSr| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "Indicates whether the bridge operates using older
            3 bit length negotiation fields or the newer 6 bit
            length field in its RIF."))
(defoid |dot1dPortPairTableSize| (|dot1dPortPair| 1)
  (:type 'object-type)
  (:syntax '|Gauge|)
  (:status '|mandatory|)
  (:description
   "The total number of entries in the Bridge Port
            Pair Database."))
(defoid |dot1dPortPairTable| (|dot1dPortPair| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "A table that contains information about every

            port pair database entity associated with this
            source routing bridge."))
(defoid |dot1dPortPairEntry| (|dot1dPortPairTable| 1)
  (:type 'object-type)
  (:syntax '|Dot1dPortPairEntry|)
  (:status '|mandatory|)
  (:description
   "A list of information for each port pair entity
            of a bridge."))
(deftype |Dot1dPortPairEntry| () 't)
(defoid |dot1dPortPairLowPort| (|dot1dPortPairEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port number of the lower numbered port for
            which this entry contains port pair database
            information."))
(defoid |dot1dPortPairHighPort| (|dot1dPortPairEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The port number of the higher numbered port for
            which this entry contains port pair database
            information."))
(defoid |dot1dPortPairBridgeNum| (|dot1dPortPairEntry| 3)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description
   "A bridge number that uniquely identifies the path
            provided by this source routing bridge between the
            segments connected to dot1dPortPairLowPort and
            dot1dPortPairHighPort.  The purpose of bridge
            number is to disambiguate between multiple paths
            connecting the same two LANs."))
(defoid |dot1dPortPairBridgeState| (|dot1dPortPairEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The state of dot1dPortPairBridgeNum.  Writing
            'invalid(3)' to this object removes the
            corresponding entry."))
