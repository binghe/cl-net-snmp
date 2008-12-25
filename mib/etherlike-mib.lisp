;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;ETHERLIKE-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|EtherLike-MIB| *mib-modules*)
  (setf *current-module* '|EtherLike-MIB|))

(defpackage :|ASN.1/EtherLike-MIB|
  (:nicknames :|EtherLike-MIB|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity |Integer32| |Counter32| |Counter64|
                |mib-2| |transmission|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-TC| |TruthValue|)
  (:import-from :asn.1/if-mib |ifIndex| |InterfaceIndex|))

(in-package :|EtherLike-MIB|)

(defoid |etherMIB| (|mib-2| 35)
  (:type 'module-identity)
  (:description
   "The MIB module to describe generic objects for
                    ethernet-like network interfaces.

                    The following reference is used throughout this
                    MIB module:

                    [IEEE 802.3 Std] refers to:
                       IEEE Std 802.3, 2002 Edition: 'IEEE Standard

                       for Information technology -
                       Telecommunications and information exchange
                       between systems - Local and metropolitan
                       area networks - Specific requirements -
                       Part 3: Carrier sense multiple access with
                       collision detection (CSMA/CD) access method
                       and physical layer specifications', as
                       amended by IEEE Std 802.3ae-2002:
                       'Amendment: Media Access Control (MAC)
                       Parameters, Physical Layer, and Management
                       Parameters for 10 Gb/s Operation', August,
                       2002.

                    Of particular interest is Clause 30, '10 Mb/s,
                    100 Mb/s, 1000 Mb/s, and 10 Gb/s Management'.

                    Copyright (C) The Internet Society (2003).  This
                    version of this MIB module is part of RFC 3635;
                    see the RFC itself for full legal notices."))

(defoid |etherMIBObjects| (|etherMIB| 1) (:type 'object-identity))

(defoid |dot3| (|transmission| 7) (:type 'object-identity))

(defoid |dot3StatsTable| (|dot3| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Statistics for a collection of ethernet-like
                    interfaces attached to a particular system.
                    There will be one row in this table for each
                    ethernet-like interface in the system."))

(defoid |dot3StatsEntry| (|dot3StatsTable| 1)
  (:type 'object-type)
  (:syntax '|Dot3StatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Statistics for a particular interface to an
                    ethernet-like medium."))

(deftype |Dot3StatsEntry| () 't)

(defoid |dot3StatsIndex| (|dot3StatsEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index value that uniquely identifies an
                    interface to an ethernet-like medium.  The
                    interface identified by a particular value of
                    this index is the same interface as identified
                    by the same value of ifIndex."))

(defoid |dot3StatsAlignmentErrors| (|dot3StatsEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames received on a particular
                    interface that are not an integral number of
                    octets in length and do not pass the FCS check.

                    The count represented by an instance of this
                    object is incremented when the alignmentError
                    status is returned by the MAC service to the
                    LLC (or other MAC user). Received frames for
                    which multiple error conditions pertain are,
                    according to the conventions of IEEE 802.3
                    Layer Management, counted exclusively according

                    to the error status presented to the LLC.

                    This counter does not increment for group
                    encoding schemes greater than 4 bits per group.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCStatsAlignmentErrors object for 10 Gb/s
                    or faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsFCSErrors| (|dot3StatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames received on a particular
                    interface that are an integral number of octets
                    in length but do not pass the FCS check.  This
                    count does not include frames received with
                    frame-too-long or frame-too-short error.

                    The count represented by an instance of this
                    object is incremented when the frameCheckError
                    status is returned by the MAC service to the
                    LLC (or other MAC user). Received frames for
                    which multiple error conditions pertain are,
                    according to the conventions of IEEE 802.3
                    Layer Management, counted exclusively according
                    to the error status presented to the LLC.

                    Note:  Coding errors detected by the physical
                    layer for speeds above 10 Mb/s will cause the
                    frame to fail the FCS check.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if

                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCStatsFCSErrors object for 10 Gb/s or
                    faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsSingleCollisionFrames| (|dot3StatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames that are involved in a single
                    collision, and are subsequently transmitted
                    successfully.

                    A frame that is counted by an instance of this
                    object is also counted by the corresponding
                    instance of either the ifOutUcastPkts,
                    ifOutMulticastPkts, or ifOutBroadcastPkts,
                    and is not counted by the corresponding
                    instance of the dot3StatsMultipleCollisionFrames
                    object.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsMultipleCollisionFrames| (|dot3StatsEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames that are involved in more

                    than one collision and are subsequently
                    transmitted successfully.

                    A frame that is counted by an instance of this
                    object is also counted by the corresponding
                    instance of either the ifOutUcastPkts,
                    ifOutMulticastPkts, or ifOutBroadcastPkts,
                    and is not counted by the corresponding
                    instance of the dot3StatsSingleCollisionFrames
                    object.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsSQETestErrors| (|dot3StatsEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of times that the SQE TEST ERROR
                    is received on a particular interface. The
                    SQE TEST ERROR is set in accordance with the
                    rules for verification of the SQE detection
                    mechanism in the PLS Carrier Sense Function as
                    described in IEEE Std. 802.3, 2000 Edition,
                    section 7.2.4.6.

                    This counter does not increment on interfaces
                    operating at speeds greater than 10 Mb/s, or on
                    interfaces operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsDeferredTransmissions| (|dot3StatsEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames for which the first
                    transmission attempt on a particular interface
                    is delayed because the medium is busy.

                    The count represented by an instance of this
                    object does not include frames involved in
                    collisions.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsLateCollisions| (|dot3StatsEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that a collision is
                    detected on a particular interface later than
                    one slotTime into the transmission of a packet.

                    A (late) collision included in a count
                    represented by an instance of this object is
                    also considered as a (generic) collision for
                    purposes of other collision-related
                    statistics.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsExcessiveCollisions| (|dot3StatsEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames for which transmission on a
                    particular interface fails due to excessive
                    collisions.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsInternalMacTransmitErrors| (|dot3StatsEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames for which transmission on a
                    particular interface fails due to an internal
                    MAC sublayer transmit error. A frame is only
                    counted by an instance of this object if it is
                    not counted by the corresponding instance of
                    either the dot3StatsLateCollisions object, the
                    dot3StatsExcessiveCollisions object, or the
                    dot3StatsCarrierSenseErrors object.

                    The precise meaning of the count represented by
                    an instance of this object is implementation-
                    specific.  In particular, an instance of this
                    object may represent a count of transmission
                    errors on a particular interface that are not
                    otherwise counted.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCStatsInternalMacTransmitErrors object for
                    10 Gb/s or faster interfaces.

                    Discontinuities in the value of this counter can

                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsCarrierSenseErrors| (|dot3StatsEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that the carrier sense
                    condition was lost or never asserted when
                    attempting to transmit a frame on a particular
                    interface.

                    The count represented by an instance of this
                    object is incremented at most once per
                    transmission attempt, even if the carrier sense
                    condition fluctuates during a transmission
                    attempt.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsFrameTooLongs| (|dot3StatsEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames received on a particular
                    interface that exceed the maximum permitted
                    frame size.

                    The count represented by an instance of this
                    object is incremented when the frameTooLong
                    status is returned by the MAC service to the
                    LLC (or other MAC user). Received frames for
                    which multiple error conditions pertain are,
                    according to the conventions of IEEE 802.3
                    Layer Management, counted exclusively according
                    to the error status presented to the LLC.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 80 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCStatsFrameTooLongs object for 10 Gb/s
                    or faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsInternalMacReceiveErrors| (|dot3StatsEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames for which reception on a
                    particular interface fails due to an internal
                    MAC sublayer receive error. A frame is only
                    counted by an instance of this object if it is
                    not counted by the corresponding instance of
                    either the dot3StatsFrameTooLongs object, the
                    dot3StatsAlignmentErrors object, or the
                    dot3StatsFCSErrors object.

                    The precise meaning of the count represented by
                    an instance of this object is implementation-
                    specific.  In particular, an instance of this
                    object may represent a count of receive errors
                    on a particular interface that are not
                    otherwise counted.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if

                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCStatsInternalMacReceiveErrors object for
                    10 Gb/s or faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsEtherChipSet| (|dot3StatsEntry| 17)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "******** THIS OBJECT IS DEPRECATED ********

                    This object contains an OBJECT IDENTIFIER
                    which identifies the chipset used to
                    realize the interface. Ethernet-like
                    interfaces are typically built out of
                    several different chips. The MIB implementor
                    is presented with a decision of which chip
                    to identify via this object. The implementor
                    should identify the chip which is usually
                    called the Medium Access Control chip.
                    If no such chip is easily identifiable,
                    the implementor should identify the chip
                    which actually gathers the transmit
                    and receive statistics and error
                    indications. This would allow a
                    manager station to correlate the
                    statistics and the chip generating
                    them, giving it the ability to take
                    into account any known anomalies
                    in the chip.

                    This object has been deprecated.  Implementation
                    feedback indicates that it is of limited use for
                    debugging network problems in the field, and
                    the administrative overhead involved in
                    maintaining a registry of chipset OIDs is not
                    justified."))

(defoid |dot3StatsSymbolErrors| (|dot3StatsEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For an interface operating at 100 Mb/s, the
                    number of times there was an invalid data symbol
                    when a valid carrier was present.

                    For an interface operating in half-duplex mode
                    at 1000 Mb/s, the number of times the receiving
                    media is non-idle (a carrier event) for a period
                    of time equal to or greater than slotTime, and
                    during which there was at least one occurrence
                    of an event that causes the PHY to indicate
                    'Data reception error' or 'carrier extend error'
                    on the GMII.

                    For an interface operating in full-duplex mode
                    at 1000 Mb/s, the number of times the receiving
                    media is non-idle (a carrier event) for a period
                    of time equal to or greater than minFrameSize,
                    and during which there was at least one
                    occurrence of an event that causes the PHY to
                    indicate 'Data reception error' on the GMII.

                    For an interface operating at 10 Gb/s, the
                    number of times the receiving media is non-idle
                    (a carrier event) for a period of time equal to
                    or greater than minFrameSize, and during which
                    there was at least one occurrence of an event
                    that causes the PHY to indicate 'Receive Error'
                    on the XGMII.

                    The count represented by an instance of this
                    object is incremented at most once per carrier
                    event, even if multiple symbol errors occur
                    during the carrier event.  This count does
                    not increment if a collision is present.

                    This counter does not increment when the
                    interface is operating at 10 Mb/s.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a

                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCStatsSymbolErrors object for 10 Gb/s
                    or faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3StatsDuplexStatus| (|dot3StatsEntry| 19)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current mode of operation of the MAC
                    entity.  'unknown' indicates that the current
                    duplex mode could not be determined.

                    Management control of the duplex mode is
                    accomplished through the MAU MIB.  When
                    an interface does not support autonegotiation,
                    or when autonegotiation is not enabled, the
                    duplex mode is controlled using
                    ifMauDefaultType.  When autonegotiation is
                    supported and enabled, duplex mode is controlled
                    using ifMauAutoNegAdvertisedBits.  In either
                    case, the currently operating duplex mode is
                    reflected both in this object and in ifMauType.

                    Note that this object provides redundant
                    information with ifMauType.  Normally, redundant
                    objects are discouraged.  However, in this
                    instance, it allows a management application to
                    determine the duplex status of an interface
                    without having to know every possible value of
                    ifMauType.  This was felt to be sufficiently
                    valuable to justify the redundancy."))

(defoid |dot3StatsRateControlAbility| (|dot3StatsEntry| 20)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "'true' for interfaces operating at speeds above
                    1000 Mb/s that support Rate Control through
                    lowering the average data rate of the MAC
                    sublayer, with frame granularity, and 'false'
                    otherwise."))

(defoid |dot3StatsRateControlStatus| (|dot3StatsEntry| 21)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current Rate Control mode of operation of
                    the MAC sublayer of this interface."))

(defoid |dot3CollTable| (|dot3| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A collection of collision histograms for a
                    particular set of interfaces."))

(defoid |dot3CollEntry| (|dot3CollTable| 1)
  (:type 'object-type)
  (:syntax '|Dot3CollEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A cell in the histogram of per-frame
                    collisions for a particular interface.  An

                    instance of this object represents the
                    frequency of individual MAC frames for which
                    the transmission (successful or otherwise) on a
                    particular interface is accompanied by a
                    particular number of media collisions."))

(deftype |Dot3CollEntry| () 't)

(defoid |dot3CollCount| (|dot3CollEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The number of per-frame media collisions for
                    which a particular collision histogram cell
                    represents the frequency on a particular
                    interface."))

(defoid |dot3CollFrequencies| (|dot3CollEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of individual MAC frames for which the
                    transmission (successful or otherwise) on a
                    particular interface occurs after the
                    frame has experienced exactly the number
                    of collisions in the associated
                    dot3CollCount object.

                    For example, a frame which is transmitted
                    on interface 77 after experiencing
                    exactly 4 collisions would be indicated
                    by incrementing only dot3CollFrequencies.77.4.
                    No other instance of dot3CollFrequencies would
                    be incremented in this example.

                    This counter does not increment when the
                    interface is operating in full-duplex mode.

                    Discontinuities in the value of this counter can

                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3ControlTable| (|dot3| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of descriptive and status information
                    about the MAC Control sublayer on the
                    ethernet-like interfaces attached to a
                    particular system.  There will be one row in
                    this table for each ethernet-like interface in
                    the system which implements the MAC Control
                    sublayer.  If some, but not all, of the
                    ethernet-like interfaces in the system implement
                    the MAC Control sublayer, there will be fewer
                    rows in this table than in the dot3StatsTable."))

(defoid |dot3ControlEntry| (|dot3ControlTable| 1)
  (:type 'object-type)
  (:syntax '|Dot3ControlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in the table, containing information
                    about the MAC Control sublayer on a single
                    ethernet-like interface."))

(deftype |Dot3ControlEntry| () 't)

(defoid |dot3ControlFunctionsSupported| (|dot3ControlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A list of the possible MAC Control functions
                    implemented for this interface."))

(defoid |dot3ControlInUnknownOpcodes| (|dot3ControlEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of MAC Control frames received on this
                    interface that contain an opcode that is not
                    supported by this device.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCControlInUnknownOpcodes object for 10 Gb/s
                    or faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCControlInUnknownOpcodes| (|dot3ControlEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of MAC Control frames received on this
                    interface that contain an opcode that is not
                    supported by this device.

                    This counter is a 64 bit version of
                    dot3ControlInUnknownOpcodes.  It should be used
                    on interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3PauseTable| (|dot3| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of descriptive and status information
                    about the MAC Control PAUSE function on the
                    ethernet-like interfaces attached to a
                    particular system. There will be one row in
                    this table for each ethernet-like interface in
                    the system which supports the MAC Control PAUSE
                    function (i.e., the 'pause' bit in the
                    corresponding instance of
                    dot3ControlFunctionsSupported is set).  If some,
                    but not all, of the ethernet-like interfaces in
                    the system implement the MAC Control PAUSE
                    function (for example, if some interfaces only
                    support half-duplex), there will be fewer rows
                    in this table than in the dot3StatsTable."))

(defoid |dot3PauseEntry| (|dot3PauseTable| 1)
  (:type 'object-type)
  (:syntax '|Dot3PauseEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry in the table, containing information
                    about the MAC Control PAUSE function on a single
                    ethernet-like interface."))

(deftype |Dot3PauseEntry| () 't)

(defoid |dot3PauseAdminMode| (|dot3PauseEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This object is used to configure the default
                    administrative PAUSE mode for this interface.

                    This object represents the
                    administratively-configured PAUSE mode for this
                    interface.  If auto-negotiation is not enabled
                    or is not implemented for the active MAU
                    attached to this interface, the value of this
                    object determines the operational PAUSE mode
                    of the interface whenever it is operating in
                    full-duplex mode.  In this case, a set to this
                    object will force the interface into the
                    specified mode.

                    If auto-negotiation is implemented and enabled
                    for the MAU attached to this interface, the
                    PAUSE mode for this interface is determined by
                    auto-negotiation, and the value of this object
                    denotes the mode to which the interface will
                    automatically revert if/when auto-negotiation is
                    later disabled.  Note that when auto-negotiation
                    is running, administrative control of the PAUSE
                    mode may be accomplished using the
                    ifMauAutoNegCapAdvertisedBits object in the
                    MAU-MIB.

                    Note that the value of this object is ignored
                    when the interface is not operating in
                    full-duplex mode.

                    An attempt to set this object to
                    'enabledXmit(2)' or 'enabledRcv(3)' will fail
                    on interfaces that do not support operation
                    at greater than 100 Mb/s."))

(defoid |dot3PauseOperMode| (|dot3PauseEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object reflects the PAUSE mode currently

                    in use on this interface, as determined by
                    either (1) the result of the auto-negotiation
                    function or (2) if auto-negotiation is not
                    enabled or is not implemented for the active MAU
                    attached to this interface, by the value of
                    dot3PauseAdminMode.  Interfaces operating at
                    100 Mb/s or less will never return
                    'enabledXmit(2)' or 'enabledRcv(3)'.  Interfaces
                    operating in half-duplex mode will always return
                    'disabled(1)'.  Interfaces on which
                    auto-negotiation is enabled but not yet
                    completed should return the value
                    'disabled(1)'."))

(defoid |dot3InPauseFrames| (|dot3PauseEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of MAC Control frames received on this
                    interface with an opcode indicating the PAUSE
                    operation.

                    This counter does not increment when the
                    interface is operating in half-duplex mode.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCInPauseFrames object for 10 Gb/s or
                    faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3OutPauseFrames| (|dot3PauseEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of MAC Control frames transmitted on
                    this interface with an opcode indicating the
                    PAUSE operation.

                    This counter does not increment when the
                    interface is operating in half-duplex mode.

                    For interfaces operating at 10 Gb/s, this
                    counter can roll over in less than 5 minutes if
                    it is incrementing at its maximum rate.  Since
                    that amount of time could be less than a
                    management station's poll cycle time, in order
                    to avoid a loss of information, a management
                    station is advised to poll the
                    dot3HCOutPauseFrames object for 10 Gb/s or
                    faster interfaces.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCInPauseFrames| (|dot3PauseEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of MAC Control frames received on this
                    interface with an opcode indicating the PAUSE
                    operation.

                    This counter does not increment when the
                    interface is operating in half-duplex mode.

                    This counter is a 64 bit version of
                    dot3InPauseFrames.  It should be used on
                    interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCOutPauseFrames| (|dot3PauseEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of MAC Control frames transmitted on
                    this interface with an opcode indicating the
                    PAUSE operation.

                    This counter does not increment when the
                    interface is operating in half-duplex mode.

                    This counter is a 64 bit version of
                    dot3OutPauseFrames.  It should be used on
                    interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCStatsTable| (|dot3| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing 64-bit versions of error
                    counters from the dot3StatsTable.  The 32-bit
                    versions of these counters may roll over quite
                    quickly on higher speed ethernet interfaces.
                    The counters that have 64-bit versions in this
                    table are the counters that apply to full-duplex
                    interfaces, since 10 Gb/s and faster
                    ethernet-like interfaces do not support
                    half-duplex, and very few 1000 Mb/s
                    ethernet-like interfaces support half-duplex.

                    Entries in this table are recommended for
                    interfaces capable of operating at 1000 Mb/s or
                    faster, and are required for interfaces capable
                    of operating at 10 Gb/s or faster.  Lower speed
                    ethernet-like interfaces do not need entries in
                    this table, in which case there may be fewer
                    entries in this table than in the
                    dot3StatsTable. However, implementations
                    containing interfaces with a mix of speeds may
                    choose to implement entries in this table for

                    all ethernet-like interfaces."))

(defoid |dot3HCStatsEntry| (|dot3HCStatsTable| 1)
  (:type 'object-type)
  (:syntax '|Dot3HCStatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing 64-bit statistics for a
                    single ethernet-like interface."))

(deftype |Dot3HCStatsEntry| () 't)

(defoid |dot3HCStatsAlignmentErrors| (|dot3HCStatsEntry| 1)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames received on a particular
                    interface that are not an integral number of
                    octets in length and do not pass the FCS check.

                    The count represented by an instance of this
                    object is incremented when the alignmentError
                    status is returned by the MAC service to the
                    LLC (or other MAC user). Received frames for
                    which multiple error conditions pertain are,
                    according to the conventions of IEEE 802.3
                    Layer Management, counted exclusively according
                    to the error status presented to the LLC.

                    This counter does not increment for group
                    encoding schemes greater than 4 bits per group.

                    This counter is a 64 bit version of
                    dot3StatsAlignmentErrors.  It should be used
                    on interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management

                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCStatsFCSErrors| (|dot3HCStatsEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames received on a particular
                    interface that are an integral number of octets
                    in length but do not pass the FCS check.  This
                    count does not include frames received with
                    frame-too-long or frame-too-short error.

                    The count represented by an instance of this
                    object is incremented when the frameCheckError
                    status is returned by the MAC service to the
                    LLC (or other MAC user). Received frames for
                    which multiple error conditions pertain are,
                    according to the conventions of IEEE 802.3
                    Layer Management, counted exclusively according
                    to the error status presented to the LLC.

                    Note:  Coding errors detected by the physical
                    layer for speeds above 10 Mb/s will cause the
                    frame to fail the FCS check.

                    This counter is a 64 bit version of
                    dot3StatsFCSErrors.  It should be used on
                    interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCStatsInternalMacTransmitErrors| (|dot3HCStatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames for which transmission on a
                    particular interface fails due to an internal
                    MAC sublayer transmit error. A frame is only

                    counted by an instance of this object if it is
                    not counted by the corresponding instance of
                    either the dot3StatsLateCollisions object, the
                    dot3StatsExcessiveCollisions object, or the
                    dot3StatsCarrierSenseErrors object.

                    The precise meaning of the count represented by
                    an instance of this object is implementation-
                    specific.  In particular, an instance of this
                    object may represent a count of transmission
                    errors on a particular interface that are not
                    otherwise counted.

                    This counter is a 64 bit version of
                    dot3StatsInternalMacTransmitErrors.  It should
                    be used on interfaces operating at 10 Gb/s or
                    faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCStatsFrameTooLongs| (|dot3HCStatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames received on a particular
                    interface that exceed the maximum permitted
                    frame size.

                    The count represented by an instance of this
                    object is incremented when the frameTooLong
                    status is returned by the MAC service to the
                    LLC (or other MAC user). Received frames for
                    which multiple error conditions pertain are,
                    according to the conventions of IEEE 802.3
                    Layer Management, counted exclusively according
                    to the error status presented to the LLC.

                    This counter is a 64 bit version of
                    dot3StatsFrameTooLongs.  It should be used on
                    interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can

                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCStatsInternalMacReceiveErrors| (|dot3HCStatsEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A count of frames for which reception on a
                    particular interface fails due to an internal
                    MAC sublayer receive error. A frame is only
                    counted by an instance of this object if it is
                    not counted by the corresponding instance of
                    either the dot3StatsFrameTooLongs object, the
                    dot3StatsAlignmentErrors object, or the
                    dot3StatsFCSErrors object.

                    The precise meaning of the count represented by
                    an instance of this object is implementation-
                    specific.  In particular, an instance of this
                    object may represent a count of receive errors
                    on a particular interface that are not
                    otherwise counted.

                    This counter is a 64 bit version of
                    dot3StatsInternalMacReceiveErrors.  It should be
                    used on interfaces operating at 10 Gb/s or
                    faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3HCStatsSymbolErrors| (|dot3HCStatsEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For an interface operating at 100 Mb/s, the
                    number of times there was an invalid data symbol
                    when a valid carrier was present.

                    For an interface operating in half-duplex mode
                    at 1000 Mb/s, the number of times the receiving
                    media is non-idle (a carrier event) for a period
                    of time equal to or greater than slotTime, and
                    during which there was at least one occurrence
                    of an event that causes the PHY to indicate
                    'Data reception error' or 'carrier extend error'
                    on the GMII.

                    For an interface operating in full-duplex mode
                    at 1000 Mb/s, the number of times the receiving
                    media is non-idle (a carrier event) for a period
                    of time equal to or greater than minFrameSize,
                    and during which there was at least one
                    occurrence of an event that causes the PHY to
                    indicate 'Data reception error' on the GMII.

                    For an interface operating at 10 Gb/s, the
                    number of times the receiving media is non-idle
                    (a carrier event) for a period of time equal to
                    or greater than minFrameSize, and during which
                    there was at least one occurrence of an event
                    that causes the PHY to indicate 'Receive Error'
                    on the XGMII.

                    The count represented by an instance of this
                    object is incremented at most once per carrier
                    event, even if multiple symbol errors occur
                    during the carrier event.  This count does
                    not increment if a collision is present.

                    This counter is a 64 bit version of
                    dot3StatsSymbolErrors.  It should be used on
                    interfaces operating at 10 Gb/s or faster.

                    Discontinuities in the value of this counter can
                    occur at re-initialization of the management
                    system, and at other times as indicated by the
                    value of ifCounterDiscontinuityTime."))

(defoid |dot3Tests| (|dot3| 6) (:type 'object-identity))

(defoid |dot3Errors| (|dot3| 7) (:type 'object-identity))

(defoid |dot3TestTdr| (|dot3Tests| 1)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description
   "******** THIS IDENTITY IS DEPRECATED *******

                    The Time-Domain Reflectometry (TDR) test is
                    specific to ethernet-like interfaces of type
                    10Base5 and 10Base2.  The TDR value may be
                    useful in determining the approximate distance
                    to a cable fault.  It is advisable to repeat
                    this test to check for a consistent resulting
                    TDR value, to verify that there is a fault.

                    A TDR test returns as its result the time
                    interval, measured in 10 MHz ticks or 100 nsec
                    units, between the start of TDR test
                    transmission and the subsequent detection of a
                    collision or deassertion of carrier.  On
                    successful completion of a TDR test, the result
                    is stored as the value of an appropriate
                    instance of an appropriate vendor specific MIB
                    object, and the OBJECT IDENTIFIER of that
                    instance is stored in the appropriate instance
                    of the appropriate test result code object
                    (thereby indicating where the result has been
                    stored).

                    This object identity has been deprecated, since
                    the ifTestTable in the IF-MIB was deprecated,
                    and there is no longer a standard mechanism for
                    initiating an interface test.  This left no
                    standard way of using this object identity."))

(defoid |dot3TestLoopBack| (|dot3Tests| 2)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description
   "******** THIS IDENTITY IS DEPRECATED *******

                    This test configures the MAC chip and executes
                    an internal loopback test of memory, data paths,
                    and the MAC chip logic.  This loopback test can
                    only be executed if the interface is offline.
                    Once the test has completed, the MAC chip should

                    be reinitialized for network operation, but it
                    should remain offline.

                    If an error occurs during a test, the
                    appropriate test result object will be set
                    to indicate a failure.  The two OBJECT
                    IDENTIFIER values dot3ErrorInitError and
                    dot3ErrorLoopbackError may be used to provided
                    more information as values for an appropriate
                    test result code object.

                    This object identity has been deprecated, since
                    the ifTestTable in the IF-MIB was deprecated,
                    and there is no longer a standard mechanism for
                    initiating an interface test.  This left no
                    standard way of using this object identity."))

(defoid |dot3ErrorInitError| (|dot3Errors| 1)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description
   "******** THIS IDENTITY IS DEPRECATED *******

                    Couldn't initialize MAC chip for test.

                    This object identity has been deprecated, since
                    the ifTestTable in the IF-MIB was deprecated,
                    and there is no longer a standard mechanism for
                    initiating an interface test.  This left no
                    standard way of using this object identity."))

(defoid |dot3ErrorLoopbackError| (|dot3Errors| 2)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description
   "******** THIS IDENTITY IS DEPRECATED *******

                    Expected data not received (or not received
                    correctly) in loopback test.

                    This object identity has been deprecated, since
                    the ifTestTable in the IF-MIB was deprecated,
                    and there is no longer a standard mechanism for
                    initiating an interface test.  This left no
                    standard way of using this object identity."))

(defoid |etherConformance| (|etherMIB| 2) (:type 'object-identity))

(defoid |etherGroups| (|etherConformance| 1) (:type 'object-identity))

(defoid |etherCompliances| (|etherConformance| 2)
  (:type 'object-identity))

(defoid |etherCompliance| (|etherCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "******** THIS COMPLIANCE IS DEPRECATED ********

                    The compliance statement for managed network
                    entities which have ethernet-like network
                    interfaces.

                    This compliance is deprecated and replaced by
                    dot3Compliance."))

(defoid |ether100MbsCompliance| (|etherCompliances| 2)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "******** THIS COMPLIANCE IS DEPRECATED ********

                    The compliance statement for managed network
                    entities which have 100 Mb/sec ethernet-like
                    network interfaces.

                    This compliance is deprecated and replaced by
                    dot3Compliance."))

(defoid |dot3Compliance| (|etherCompliances| 3)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "******** THIS COMPLIANCE IS DEPRECATED ********

                    The compliance statement for managed network
                    entities which have ethernet-like network
                    interfaces.

                    This compliance is deprecated and replaced by
                    dot3Compliance2."))

(defoid |dot3Compliance2| (|etherCompliances| 4)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for managed network
                        entities which have ethernet-like network
                        interfaces.

                        Note that compliance with this MIB module
                        requires compliance with the ifCompliance3
                        MODULE-COMPLIANCE statement of the IF-MIB
                        (RFC2863).  In addition, compliance with this
                        MIB module requires compliance  with the
                        mauModIfCompl3 MODULE-COMPLIANCE statement of
                        the MAU-MIB (RFC3636)."))

(defoid |etherStatsGroup| (|etherGroups| 1)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "********* THIS GROUP IS DEPRECATED **********

                    A collection of objects providing information
                    applicable to all ethernet-like network
                    interfaces.

                    This object group has been deprecated and
                    replaced by etherStatsBaseGroup and
                    etherStatsLowSpeedGroup."))

(defoid |etherCollisionTableGroup| (|etherGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing a histogram
                    of packets successfully transmitted after
                    experiencing exactly N collisions."))

(defoid |etherStats100MbsGroup| (|etherGroups| 3)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "********* THIS GROUP IS DEPRECATED **********

                    A collection of objects providing information
                    applicable to 100 Mb/sec ethernet-like network
                    interfaces.

                    This object group has been deprecated and
                    replaced by etherStatsBaseGroup and
                    etherStatsHighSpeedGroup."))

(defoid |etherStatsBaseGroup| (|etherGroups| 4)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "********* THIS GROUP IS DEPRECATED **********

                    A collection of objects providing information
                    applicable to all ethernet-like network
                    interfaces.

                    This object group has been deprecated and
                    replaced by etherStatsBaseGroup2 and
                    etherStatsHalfDuplexGroup, to separate
                    objects which must be implemented by all
                    ethernet-like network interfaces from
                    objects that need only be implemented on
                    ethernet-like network interfaces that are
                    capable of half-duplex operation."))

(defoid |etherStatsLowSpeedGroup| (|etherGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information

                    applicable to ethernet-like network interfaces
                    capable of operating at 10 Mb/s or slower in
                    half-duplex mode."))

(defoid |etherStatsHighSpeedGroup| (|etherGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    applicable to ethernet-like network interfaces
                    capable of operating at 100 Mb/s or faster."))

(defoid |etherDuplexGroup| (|etherGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    about the duplex mode of an ethernet-like
                    network interface."))

(defoid |etherControlGroup| (|etherGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    about the MAC Control sublayer on ethernet-like
                    network interfaces."))

(defoid |etherControlPauseGroup| (|etherGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    about and control of the MAC Control PAUSE
                    function on ethernet-like network interfaces."))

(defoid |etherStatsBaseGroup2| (|etherGroups| 10)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    applicable to all ethernet-like network
                    interfaces."))

(defoid |etherStatsHalfDuplexGroup| (|etherGroups| 11)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    applicable only to half-duplex ethernet-like
                    network interfaces."))

(defoid |etherHCStatsGroup| (|etherGroups| 12)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing high-capacity
                    statistics applicable to higher-speed
                    ethernet-like network interfaces."))

(defoid |etherHCControlGroup| (|etherGroups| 13)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing high-capacity
                    statistics for the MAC Control sublayer on
                    higher-speed ethernet-like network interfaces."))

(defoid |etherHCControlPauseGroup| (|etherGroups| 14)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing high-capacity
                    statistics for the MAC Control PAUSE function on
                    higher-speed ethernet-like network interfaces."))

(defoid |etherRateControlGroup| (|etherGroups| 15)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information
                    about the Rate Control function on ethernet-like
                    interfaces."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

