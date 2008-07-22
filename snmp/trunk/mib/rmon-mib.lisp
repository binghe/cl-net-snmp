;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:RMON-MIB

(in-package :asn.1)
(setf *current-module* 'rmon-mib)
(defoid |rmon| (|mib-2| 16) (:type 'object-identity))
(deftype |OwnerString| () 't)
(deftype |EntryStatus| () 't)
(defoid |statistics| (|rmon| 1) (:type 'object-identity))
(defoid |history| (|rmon| 2) (:type 'object-identity))
(defoid |alarm| (|rmon| 3) (:type 'object-identity))
(defoid |hosts| (|rmon| 4) (:type 'object-identity))
(defoid |hostTopN| (|rmon| 5) (:type 'object-identity))
(defoid |matrix| (|rmon| 6) (:type 'object-identity))
(defoid |filter| (|rmon| 7) (:type 'object-identity))
(defoid |capture| (|rmon| 8) (:type 'object-identity))
(defoid |event| (|rmon| 9) (:type 'object-identity))
(defoid |rmonConformance| (|rmon| 20) (:type 'object-identity))
(defoid |rmonMibModule| (|rmonConformance| 8)
  (:type 'module-identity)
  (:description
   "Remote network monitoring devices, often called
        monitors or probes, are instruments that exist for
        the purpose of managing a network. This MIB defines
        objects for managing remote network monitoring devices."))
(defoid |etherStatsTable| (|statistics| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of Ethernet statistics entries."))
(defoid |etherStatsEntry| (|etherStatsTable| 1)
  (:type 'object-type)
  (:syntax '|EtherStatsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A collection of statistics kept for a particular
        Ethernet interface.  As an example, an instance of the
        etherStatsPkts object might be named etherStatsPkts.1"))
(deftype |EtherStatsEntry| () 't)
(defoid |etherStatsIndex| (|etherStatsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object uniquely identifies this
        etherStats entry."))
(defoid |etherStatsDataSource| (|etherStatsEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object identifies the source of the data that
        this etherStats entry is configured to analyze.  This
        source can be any ethernet interface on this device.
        In order to identify a particular interface, this object
        shall identify the instance of the ifIndex object,
        defined in RFC 2233 [17], for the desired interface.
        For example, if an entry were to receive data from
        interface #1, this object would be set to ifIndex.1.

        The statistics in this group reflect all packets
        on the local network segment attached to the identified
        interface.

        An agent may or may not be able to tell if fundamental
        changes to the media of the interface have occurred and
        necessitate an invalidation of this entry.  For example, a
        hot-pluggable ethernet card could be pulled out and replaced
        by a token-ring card.  In such a case, if the agent has such
        knowledge of the change, it is recommended that it
        invalidate this entry.

        This object may not be modified if the associated
        etherStatsStatus object is equal to valid(1)."))
(defoid |etherStatsDropEvents| (|etherStatsEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of events in which packets
        were dropped by the probe due to lack of resources.
        Note that this number is not necessarily the number of
        packets dropped; it is just the number of times this
        condition has been detected."))
(defoid |etherStatsOctets| (|etherStatsEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets of data (including
        those in bad packets) received on the
        network (excluding framing bits but including
        FCS octets).

        This object can be used as a reasonable estimate of
        10-Megabit ethernet utilization.  If greater precision is
        desired, the etherStatsPkts and etherStatsOctets objects
        should be sampled before and after a common interval.  The
        differences in the sampled values are Pkts and Octets,
        respectively, and the number of seconds in the interval is
        Interval.  These values are used to calculate the Utilization
        as follows:

                         Pkts * (9.6 + 6.4) + (Octets * .8)
         Utilization = -------------------------------------
                                 Interval * 10,000

        The result of this equation is the value Utilization which
        is the percent utilization of the ethernet segment on a
        scale of 0 to 100 percent."))
(defoid |etherStatsPkts| (|etherStatsEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad packets,
        broadcast packets, and multicast packets) received."))
(defoid |etherStatsBroadcastPkts| (|etherStatsEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of good packets received that were
        directed to the broadcast address.  Note that this
        does not include multicast packets."))
(defoid |etherStatsMulticastPkts| (|etherStatsEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of good packets received that were
        directed to a multicast address.  Note that this number
        does not include packets directed to the broadcast

        address."))
(defoid |etherStatsCRCAlignErrors| (|etherStatsEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received that
        had a length (excluding framing bits, but
        including FCS octets) of between 64 and 1518
        octets, inclusive, but had either a bad
        Frame Check Sequence (FCS) with an integral
        number of octets (FCS Error) or a bad FCS with
        a non-integral number of octets (Alignment Error)."))
(defoid |etherStatsUndersizePkts| (|etherStatsEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received that were
        less than 64 octets long (excluding framing bits,
        but including FCS octets) and were otherwise well
        formed."))
(defoid |etherStatsOversizePkts| (|etherStatsEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received that were
        longer than 1518 octets (excluding framing bits,
        but including FCS octets) and were otherwise
        well formed."))
(defoid |etherStatsFragments| (|etherStatsEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received that were less than
        64 octets in length (excluding framing bits but including
        FCS octets) and had either a bad Frame Check Sequence
        (FCS) with an integral number of octets (FCS Error) or a
        bad FCS with a non-integral number of octets (Alignment
        Error).

        Note that it is entirely normal for etherStatsFragments to
        increment.  This is because it counts both runts (which are
        normal occurrences due to collisions) and noise hits."))
(defoid |etherStatsJabbers| (|etherStatsEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received that were
        longer than 1518 octets (excluding framing bits,
        but including FCS octets), and had either a bad
        Frame Check Sequence (FCS) with an integral number
        of octets (FCS Error) or a bad FCS with a non-integral
        number of octets (Alignment Error).

        Note that this definition of jabber is different
        than the definition in IEEE-802.3 section 8.2.1.5
        (10BASE5) and section 10.3.1.4 (10BASE2).  These
        documents define jabber as the condition where any
        packet exceeds 20 ms.  The allowed range to detect
        jabber is between 20 ms and 150 ms."))
(defoid |etherStatsCollisions| (|etherStatsEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The best estimate of the total number of collisions
        on this Ethernet segment.

        The value returned will depend on the location of the
        RMON probe. Section 8.2.1.3 (10BASE-5) and section
        10.3.1.3 (10BASE-2) of IEEE standard 802.3 states that a
        station must detect a collision, in the receive mode, if
        three or more stations are transmitting simultaneously.  A
        repeater port must detect a collision when two or more

        stations are transmitting simultaneously.  Thus a probe
        placed on a repeater port could record more collisions
        than a probe connected to a station on the same segment
        would.

        Probe location plays a much smaller role when considering
        10BASE-T.  14.2.1.4 (10BASE-T) of IEEE standard 802.3
        defines a collision as the simultaneous presence of signals
        on the DO and RD circuits (transmitting and receiving
        at the same time).  A 10BASE-T station can only detect
        collisions when it is transmitting.  Thus probes placed on
        a station and a repeater, should report the same number of
        collisions.

        Note also that an RMON probe inside a repeater should
        ideally report collisions between the repeater and one or
        more other hosts (transmit collisions as defined by IEEE
        802.3k) plus receiver collisions observed on any coax
        segments to which the repeater is connected."))
(defoid |etherStatsPkts64Octets| (|etherStatsEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad
        packets) received that were 64 octets in length
        (excluding framing bits but including FCS octets)."))
(defoid |etherStatsPkts65to127Octets| (|etherStatsEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad
        packets) received that were between
        65 and 127 octets in length inclusive
        (excluding framing bits but including FCS octets)."))
(defoid |etherStatsPkts128to255Octets| (|etherStatsEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad
        packets) received that were between
        128 and 255 octets in length inclusive
        (excluding framing bits but including FCS octets)."))
(defoid |etherStatsPkts256to511Octets| (|etherStatsEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad
        packets) received that were between
        256 and 511 octets in length inclusive
        (excluding framing bits but including FCS octets)."))
(defoid |etherStatsPkts512to1023Octets| (|etherStatsEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad
        packets) received that were between
        512 and 1023 octets in length inclusive
        (excluding framing bits but including FCS octets)."))
(defoid |etherStatsPkts1024to1518Octets| (|etherStatsEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets (including bad
        packets) received that were between
        1024 and 1518 octets in length inclusive
        (excluding framing bits but including FCS octets)."))
(defoid |etherStatsOwner| (|etherStatsEntry| 20)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |etherStatsStatus| (|etherStatsEntry| 21)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The status of this etherStats entry."))
(defoid |historyControlTable| (|history| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of history control entries."))
(defoid |historyControlEntry| (|historyControlTable| 1)
  (:type 'object-type)
  (:syntax '|HistoryControlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of parameters that set up a periodic sampling of
        statistics.  As an example, an instance of the
        historyControlInterval object might be named
        historyControlInterval.2"))
(deftype |HistoryControlEntry| () 't)
(defoid |historyControlIndex| (|historyControlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in the
        historyControl table.  Each such entry defines a
        set of samples at a particular interval for an
        interface on the device."))
(defoid |historyControlDataSource| (|historyControlEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object identifies the source of the data for
        which historical data was collected and
        placed in a media-specific table on behalf of this
        historyControlEntry.  This source can be any
        interface on this device.  In order to identify

        a particular interface, this object shall identify
        the instance of the ifIndex object, defined
        in  RFC 2233 [17], for the desired interface.
        For example, if an entry were to receive data from
        interface #1, this object would be set to ifIndex.1.

        The statistics in this group reflect all packets
        on the local network segment attached to the identified
        interface.

        An agent may or may not be able to tell if fundamental
        changes to the media of the interface have occurred and
        necessitate an invalidation of this entry.  For example, a
        hot-pluggable ethernet card could be pulled out and replaced
        by a token-ring card.  In such a case, if the agent has such
        knowledge of the change, it is recommended that it
        invalidate this entry.

        This object may not be modified if the associated
        historyControlStatus object is equal to valid(1)."))
(defoid |historyControlBucketsRequested| (|historyControlEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The requested number of discrete time intervals
        over which data is to be saved in the part of the
        media-specific table associated with this
        historyControlEntry.

        When this object is created or modified, the probe
        should set historyControlBucketsGranted as closely to
        this object as is possible for the particular probe
        implementation and available resources."))
(defoid |historyControlBucketsGranted| (|historyControlEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of discrete sampling intervals
        over which data shall be saved in the part of
        the media-specific table associated with this
        historyControlEntry.

        When the associated historyControlBucketsRequested
        object is created or modified, the probe
        should set this object as closely to the requested
        value as is possible for the particular
        probe implementation and available resources.  The
        probe must not lower this value except as a result
        of a modification to the associated
        historyControlBucketsRequested object.

        There will be times when the actual number of
        buckets associated with this entry is less than
        the value of this object.  In this case, at the
        end of each sampling interval, a new bucket will
        be added to the media-specific table.

        When the number of buckets reaches the value of
        this object and a new bucket is to be added to the
        media-specific table, the oldest bucket associated
        with this historyControlEntry shall be deleted by
        the agent so that the new bucket can be added.

        When the value of this object changes to a value less
        than the current value, entries are deleted
        from the media-specific table associated with this
        historyControlEntry.  Enough of the oldest of these
        entries shall be deleted by the agent so that their
        number remains less than or equal to the new value of
        this object.

        When the value of this object changes to a value greater
        than the current value, the number of associated media-
        specific entries may be allowed to grow."))
(defoid |historyControlInterval| (|historyControlEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The interval in seconds over which the data is
        sampled for each bucket in the part of the
        media-specific table associated with this
        historyControlEntry.  This interval can
        be set to any number of seconds between 1 and
        3600 (1 hour).

        Because the counters in a bucket may overflow at their

        maximum value with no indication, a prudent manager will
        take into account the possibility of overflow in any of
        the associated counters.  It is important to consider the
        minimum time in which any counter could overflow on a
        particular media type and set the historyControlInterval
        object to a value less than this interval.  This is
        typically most important for the 'octets' counter in any
        media-specific table.  For example, on an Ethernet
        network, the etherHistoryOctets counter could overflow
        in about one hour at the Ethernet's maximum
        utilization.

        This object may not be modified if the associated
        historyControlStatus object is equal to valid(1)."))
(defoid |historyControlOwner| (|historyControlEntry| 6)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |historyControlStatus| (|historyControlEntry| 7)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this historyControl entry.

        Each instance of the media-specific table associated
        with this historyControlEntry will be deleted by the agent
        if this historyControlEntry is not equal to valid(1)."))
(defoid |etherHistoryTable| (|history| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of Ethernet history entries."))
(defoid |etherHistoryEntry| (|etherHistoryTable| 1)
  (:type 'object-type)
  (:syntax '|EtherHistoryEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An historical sample of Ethernet statistics on a particular
        Ethernet interface.  This sample is associated with the
        historyControlEntry which set up the parameters for
        a regular collection of these samples.  As an example, an
        instance of the etherHistoryPkts object might be named
        etherHistoryPkts.2.89"))
(deftype |EtherHistoryEntry| () 't)
(defoid |etherHistoryIndex| (|etherHistoryEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The history of which this entry is a part.  The
        history identified by a particular value of this
        index is the same history as identified
        by the same value of historyControlIndex."))
(defoid |etherHistorySampleIndex| (|etherHistoryEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies the particular
        sample this entry represents among all samples
        associated with the same historyControlEntry.
        This index starts at 1 and increases by one
        as each new sample is taken."))
(defoid |etherHistoryIntervalStart| (|etherHistoryEntry| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the start of the interval
        over which this sample was measured.  If the probe
        keeps track of the time of day, it should start
        the first sample of the history at a time such that
        when the next hour of the day begins, a sample is
        started at that instant.  Note that following this
        rule may require the probe to delay collecting the
        first sample of the history, as each sample must be
        of the same interval.  Also note that the sample which
        is currently being collected is not accessible in this
        table until the end of its interval."))
(defoid |etherHistoryDropEvents| (|etherHistoryEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of events in which packets
        were dropped by the probe due to lack of resources
        during this sampling interval.  Note that this number
        is not necessarily the number of packets dropped, it
        is just the number of times this condition has been

        detected."))
(defoid |etherHistoryOctets| (|etherHistoryEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of octets of data (including
        those in bad packets) received on the
        network (excluding framing bits but including
        FCS octets)."))
(defoid |etherHistoryPkts| (|etherHistoryEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets (including bad packets)
        received during this sampling interval."))
(defoid |etherHistoryBroadcastPkts| (|etherHistoryEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets received during this
        sampling interval that were directed to the
        broadcast address."))
(defoid |etherHistoryMulticastPkts| (|etherHistoryEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets received during this
        sampling interval that were directed to a
        multicast address.  Note that this number does not
        include packets addressed to the broadcast address."))
(defoid |etherHistoryCRCAlignErrors| (|etherHistoryEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets received during this
        sampling interval that had a length (excluding
        framing bits but including FCS octets) between
        64 and 1518 octets, inclusive, but had either a bad Frame
        Check Sequence (FCS) with an integral number of octets
        (FCS Error) or a bad FCS with a non-integral number
        of octets (Alignment Error)."))
(defoid |etherHistoryUndersizePkts| (|etherHistoryEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets received during this
        sampling interval that were less than 64 octets
        long (excluding framing bits but including FCS
        octets) and were otherwise well formed."))
(defoid |etherHistoryOversizePkts| (|etherHistoryEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets received during this
        sampling interval that were longer than 1518
        octets (excluding framing bits but including
        FCS octets) but were otherwise well formed."))
(defoid |etherHistoryFragments| (|etherHistoryEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received during this
        sampling interval that were less than 64 octets in
        length (excluding framing bits but including FCS

        octets) had either a bad Frame Check Sequence (FCS)
        with an integral number of octets (FCS Error) or a bad
        FCS with a non-integral number of octets (Alignment
        Error).

        Note that it is entirely normal for etherHistoryFragments to
        increment.  This is because it counts both runts (which are
        normal occurrences due to collisions) and noise hits."))
(defoid |etherHistoryJabbers| (|etherHistoryEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets received during this
        sampling interval that were longer than 1518 octets
        (excluding framing bits but including FCS octets),
        and  had either a bad Frame Check Sequence (FCS)
        with an integral number of octets (FCS Error) or
        a bad FCS with a non-integral number of octets
        (Alignment Error).

        Note that this definition of jabber is different
        than the definition in IEEE-802.3 section 8.2.1.5
        (10BASE5) and section 10.3.1.4 (10BASE2).  These
        documents define jabber as the condition where any
        packet exceeds 20 ms.  The allowed range to detect
        jabber is between 20 ms and 150 ms."))
(defoid |etherHistoryCollisions| (|etherHistoryEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The best estimate of the total number of collisions
        on this Ethernet segment during this sampling
        interval.

        The value returned will depend on the location of the
        RMON probe. Section 8.2.1.3 (10BASE-5) and section
        10.3.1.3 (10BASE-2) of IEEE standard 802.3 states that a
        station must detect a collision, in the receive mode, if
        three or more stations are transmitting simultaneously.  A
        repeater port must detect a collision when two or more

        stations are transmitting simultaneously.  Thus a probe
        placed on a repeater port could record more collisions
        than a probe connected to a station on the same segment
        would.

        Probe location plays a much smaller role when considering
        10BASE-T.  14.2.1.4 (10BASE-T) of IEEE standard 802.3
        defines a collision as the simultaneous presence of signals
        on the DO and RD circuits (transmitting and receiving
        at the same time).  A 10BASE-T station can only detect
        collisions when it is transmitting.  Thus probes placed on
        a station and a repeater, should report the same number of
        collisions.

        Note also that an RMON probe inside a repeater should
        ideally report collisions between the repeater and one or
        more other hosts (transmit collisions as defined by IEEE
        802.3k) plus receiver collisions observed on any coax
        segments to which the repeater is connected."))
(defoid |etherHistoryUtilization| (|etherHistoryEntry| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The best estimate of the mean physical layer
        network utilization on this interface during this
        sampling interval, in hundredths of a percent."))
(defoid |alarmTable| (|alarm| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of alarm entries."))
(defoid |alarmEntry| (|alarmTable| 1)
  (:type 'object-type)
  (:syntax '|AlarmEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of parameters that set up a periodic checking
        for alarm conditions.  For example, an instance of the
        alarmValue object might be named alarmValue.8"))
(deftype |AlarmEntry| () 't)
(defoid |alarmIndex| (|alarmEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in the
        alarm table.  Each such entry defines a
        diagnostic sample at a particular interval
        for an object on the device."))
(defoid |alarmInterval| (|alarmEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The interval in seconds over which the data is
        sampled and compared with the rising and falling
        thresholds.  When setting this variable, care
        should be taken in the case of deltaValue
        sampling - the interval should be set short enough
        that the sampled variable is very unlikely to
        increase or decrease by more than 2^31 - 1 during
        a single sampling interval.

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmVariable| (|alarmEntry| 3)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The object identifier of the particular variable to be
        sampled.  Only variables that resolve to an ASN.1 primitive
        type of INTEGER (INTEGER, Integer32, Counter32, Counter64,
        Gauge, or TimeTicks) may be sampled.

        Because SNMP access control is articulated entirely
        in terms of the contents of MIB views, no access
        control mechanism exists that can restrict the value of
        this object to identify only those objects that exist
        in a particular MIB view.  Because there is thus no
        acceptable means of restricting the read access that
        could be obtained through the alarm mechanism, the
        probe must only grant write access to this object in

        those views that have read access to all objects on
        the probe.

        During a set operation, if the supplied variable name is
        not available in the selected MIB view, a badValue error
        must be returned.  If at any time the variable name of
        an established alarmEntry is no longer available in the
        selected MIB view, the probe must change the status of
        this alarmEntry to invalid(4).

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmSampleType| (|alarmEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The method of sampling the selected variable and
        calculating the value to be compared against the
        thresholds.  If the value of this object is
        absoluteValue(1), the value of the selected variable
        will be compared directly with the thresholds at the
        end of the sampling interval.  If the value of this
        object is deltaValue(2), the value of the selected
        variable at the last sample will be subtracted from
        the current value, and the difference compared with
        the thresholds.

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmValue| (|alarmEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of the statistic during the last sampling
        period.  For example, if the sample type is deltaValue,
        this value will be the difference between the samples
        at the beginning and end of the period.  If the sample
        type is absoluteValue, this value will be the sampled
        value at the end of the period.

        This is the value that is compared with the rising and
        falling thresholds.

        The value during the current sampling period is not
        made available until the period is completed and will
        remain available until the next period completes."))
(defoid |alarmStartupAlarm| (|alarmEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The alarm that may be sent when this entry is first
        set to valid.  If the first sample after this entry
        becomes valid is greater than or equal to the
        risingThreshold and alarmStartupAlarm is equal to
        risingAlarm(1) or risingOrFallingAlarm(3), then a single
        rising alarm will be generated.  If the first sample
        after this entry becomes valid is less than or equal
        to the fallingThreshold and alarmStartupAlarm is equal
        to fallingAlarm(2) or risingOrFallingAlarm(3), then a
        single falling alarm will be generated.

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmRisingThreshold| (|alarmEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A threshold for the sampled statistic.  When the current
        sampled value is greater than or equal to this threshold,
        and the value at the last sampling interval was less than
        this threshold, a single event will be generated.
        A single event will also be generated if the first
        sample after this entry becomes valid is greater than or
        equal to this threshold and the associated
        alarmStartupAlarm is equal to risingAlarm(1) or
        risingOrFallingAlarm(3).

        After a rising event is generated, another such event

        will not be generated until the sampled value
        falls below this threshold and reaches the
        alarmFallingThreshold.

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmFallingThreshold| (|alarmEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A threshold for the sampled statistic.  When the current
        sampled value is less than or equal to this threshold,
        and the value at the last sampling interval was greater than
        this threshold, a single event will be generated.
        A single event will also be generated if the first
        sample after this entry becomes valid is less than or
        equal to this threshold and the associated
        alarmStartupAlarm is equal to fallingAlarm(2) or
        risingOrFallingAlarm(3).

        After a falling event is generated, another such event
        will not be generated until the sampled value
        rises above this threshold and reaches the
        alarmRisingThreshold.

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmRisingEventIndex| (|alarmEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The index of the eventEntry that is
        used when a rising threshold is crossed.  The
        eventEntry identified by a particular value of
        this index is the same as identified by the same value
        of the eventIndex object.  If there is no
        corresponding entry in the eventTable, then
        no association exists.  In particular, if this value
        is zero, no associated event will be generated, as
        zero is not a valid event index.

        This object may not be modified if the associated

        alarmStatus object is equal to valid(1)."))
(defoid |alarmFallingEventIndex| (|alarmEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The index of the eventEntry that is
        used when a falling threshold is crossed.  The
        eventEntry identified by a particular value of
        this index is the same as identified by the same value
        of the eventIndex object.  If there is no
        corresponding entry in the eventTable, then
        no association exists.  In particular, if this value
        is zero, no associated event will be generated, as
        zero is not a valid event index.

        This object may not be modified if the associated
        alarmStatus object is equal to valid(1)."))
(defoid |alarmOwner| (|alarmEntry| 11)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |alarmStatus| (|alarmEntry| 12)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The status of this alarm entry."))
(defoid |hostControlTable| (|hosts| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of host table control entries."))
(defoid |hostControlEntry| (|hostControlTable| 1)
  (:type 'object-type)
  (:syntax '|HostControlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of parameters that set up the discovery of hosts
        on a particular interface and the collection of statistics
        about these hosts.  For example, an instance of the
        hostControlTableSize object might be named
        hostControlTableSize.1"))
(deftype |HostControlEntry| () 't)
(defoid |hostControlIndex| (|hostControlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in the

        hostControl table.  Each such entry defines
        a function that discovers hosts on a particular interface
        and places statistics about them in the hostTable and
        the hostTimeTable on behalf of this hostControlEntry."))
(defoid |hostControlDataSource| (|hostControlEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object identifies the source of the data for
        this instance of the host function.  This source
        can be any interface on this device.  In order
        to identify a particular interface, this object shall
        identify the instance of the ifIndex object, defined
        in RFC 2233 [17], for the desired interface.
        For example, if an entry were to receive data from
        interface #1, this object would be set to ifIndex.1.

        The statistics in this group reflect all packets
        on the local network segment attached to the identified
        interface.

        An agent may or may not be able to tell if fundamental
        changes to the media of the interface have occurred and
        necessitate an invalidation of this entry.  For example, a
        hot-pluggable ethernet card could be pulled out and replaced
        by a token-ring card.  In such a case, if the agent has such
        knowledge of the change, it is recommended that it
        invalidate this entry.

        This object may not be modified if the associated
        hostControlStatus object is equal to valid(1)."))
(defoid |hostControlTableSize| (|hostControlEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of hostEntries in the hostTable and the
        hostTimeTable associated with this hostControlEntry."))
(defoid |hostControlLastDeleteTime| (|hostControlEntry| 4)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the last entry
        was deleted from the portion of the hostTable
        associated with this hostControlEntry.  If no
        deletions have occurred, this value shall be zero."))
(defoid |hostControlOwner| (|hostControlEntry| 5)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |hostControlStatus| (|hostControlEntry| 6)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this hostControl entry.

        If this object is not equal to valid(1), all associated
        entries in the hostTable, hostTimeTable, and the
        hostTopNTable shall be deleted by the agent."))
(defoid |hostTable| (|hosts| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of host entries."))
(defoid |hostEntry| (|hostTable| 1)
  (:type 'object-type)
  (:syntax '|HostEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A collection of statistics for a particular host that has
        been discovered on an interface of this device.  For example,
        an instance of the hostOutBroadcastPkts object might be
        named hostOutBroadcastPkts.1.6.8.0.32.27.3.176"))
(deftype |HostEntry| () 't)
(defoid |hostAddress| (|hostEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The physical address of this host."))
(defoid |hostCreationOrder| (|hostEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that defines the relative ordering of
        the creation time of hosts captured for a
        particular hostControlEntry.  This index shall
        be between 1 and N, where N is the value of
        the associated hostControlTableSize.  The ordering
        of the indexes is based on the order of each entry's
        insertion into the table, in which entries added earlier
        have a lower index value than entries added later.

        It is important to note that the order for a
        particular entry may change as an (earlier) entry
        is deleted from the table.  Because this order may
        change, management stations should make use of the
        hostControlLastDeleteTime variable in the
        hostControlEntry associated with the relevant
        portion of the hostTable.  By observing
        this variable, the management station may detect
        the circumstances where a previous association
        between a value of hostCreationOrder
        and a hostEntry may no longer hold."))
(defoid |hostIndex| (|hostEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The set of collected host statistics of which
        this entry is a part.  The set of hosts
        identified by a particular value of this
        index is associated with the hostControlEntry
        as identified by the same value of hostControlIndex."))
(defoid |hostInPkts| (|hostEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets transmitted to this
        address since it was added to the hostTable."))
(defoid |hostOutPkts| (|hostEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, including bad packets, transmitted
        by this address since it was added to the hostTable."))
(defoid |hostInOctets| (|hostEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of octets transmitted to this address since
        it was added to the hostTable (excluding framing
        bits but including FCS octets), except for those
        octets in bad packets."))
(defoid |hostOutOctets| (|hostEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of octets transmitted by this address since
        it was added to the hostTable (excluding framing
        bits but including FCS octets), including those
        octets in bad packets."))
(defoid |hostOutErrors| (|hostEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bad packets transmitted by this address
        since this host was added to the hostTable."))
(defoid |hostOutBroadcastPkts| (|hostEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets transmitted by this
        address that were directed to the broadcast address
        since this host was added to the hostTable."))
(defoid |hostOutMulticastPkts| (|hostEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets transmitted by this
        address that were directed to a multicast address
        since this host was added to the hostTable.
        Note that this number does not include packets
        directed to the broadcast address."))
(defoid |hostTimeTable| (|hosts| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of time-ordered host table entries."))
(defoid |hostTimeEntry| (|hostTimeTable| 1)
  (:type 'object-type)
  (:syntax '|HostTimeEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A collection of statistics for a particular host that has
        been discovered on an interface of this device.  This
        collection includes the relative ordering of the creation
        time of this object.  For example, an instance of the
        hostTimeOutBroadcastPkts object might be named
        hostTimeOutBroadcastPkts.1.687"))
(deftype |HostTimeEntry| () 't)
(defoid |hostTimeAddress| (|hostTimeEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The physical address of this host."))
(defoid |hostTimeCreationOrder| (|hostTimeEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in
        the hostTime table among those entries associated
        with the same hostControlEntry.  This index shall
        be between 1 and N, where N is the value of

        the associated hostControlTableSize.  The ordering
        of the indexes is based on the order of each entry's
        insertion into the table, in which entries added earlier
        have a lower index value than entries added later.
        Thus the management station has the ability to
        learn of new entries added to this table without
        downloading the entire table.

        It is important to note that the index for a
        particular entry may change as an (earlier) entry
        is deleted from the table.  Because this order may
        change, management stations should make use of the
        hostControlLastDeleteTime variable in the
        hostControlEntry associated with the relevant
        portion of the hostTimeTable.  By observing
        this variable, the management station may detect
        the circumstances where a download of the table
        may have missed entries, and where a previous
        association between a value of hostTimeCreationOrder
        and a hostTimeEntry may no longer hold."))
(defoid |hostTimeIndex| (|hostTimeEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The set of collected host statistics of which
        this entry is a part.  The set of hosts
        identified by a particular value of this
        index is associated with the hostControlEntry
        as identified by the same value of hostControlIndex."))
(defoid |hostTimeInPkts| (|hostTimeEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets transmitted to this
        address since it was added to the hostTimeTable."))
(defoid |hostTimeOutPkts| (|hostTimeEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets, including bad packets, transmitted
        by this address since it was added to the hostTimeTable."))
(defoid |hostTimeInOctets| (|hostTimeEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of octets transmitted to this address since
        it was added to the hostTimeTable (excluding framing
        bits but including FCS octets), except for those
        octets in bad packets."))
(defoid |hostTimeOutOctets| (|hostTimeEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of octets transmitted by this address since
        it was added to the hostTimeTable (excluding framing
        bits but including FCS octets), including those
        octets in bad packets."))
(defoid |hostTimeOutErrors| (|hostTimeEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bad packets transmitted by this address
        since this host was added to the hostTimeTable."))
(defoid |hostTimeOutBroadcastPkts| (|hostTimeEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets transmitted by this
        address that were directed to the broadcast address

        since this host was added to the hostTimeTable."))
(defoid |hostTimeOutMulticastPkts| (|hostTimeEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of good packets transmitted by this
        address that were directed to a multicast address
        since this host was added to the hostTimeTable.
        Note that this number does not include packets directed
        to the broadcast address."))
(defoid |hostTopNControlTable| (|hostTopN| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of top N host control entries."))
(defoid |hostTopNControlEntry| (|hostTopNControlTable| 1)
  (:type 'object-type)
  (:syntax '|HostTopNControlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of parameters that control the creation of a report
        of the top N hosts according to several metrics.  For
        example, an instance of the hostTopNDuration object might
        be named hostTopNDuration.3"))
(deftype |HostTopNControlEntry| () 't)
(defoid |hostTopNControlIndex| (|hostTopNControlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry
        in the hostTopNControl table.  Each such
        entry defines one top N report prepared for
        one interface."))
(defoid |hostTopNHostIndex| (|hostTopNControlEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The host table for which a top N report will be prepared
        on behalf of this entry.  The host table identified by a
        particular value of this index is associated with the same
        host table as identified by the same value of
        hostIndex.

        This object may not be modified if the associated
        hostTopNStatus object is equal to valid(1)."))
(defoid |hostTopNRateBase| (|hostTopNControlEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The variable for each host that the hostTopNRate
        variable is based upon.

        This object may not be modified if the associated
        hostTopNStatus object is equal to valid(1)."))
(defoid |hostTopNTimeRemaining| (|hostTopNControlEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds left in the report currently being
        collected.  When this object is modified by the management
        station, a new collection is started, possibly aborting
        a currently running report.  The new value is used
        as the requested duration of this report, which is
        loaded into the associated hostTopNDuration object.

        When this object is set to a non-zero value, any
        associated hostTopNEntries shall be made
        inaccessible by the monitor.  While the value of this
        object is non-zero, it decrements by one per second until
        it reaches zero.  During this time, all associated
        hostTopNEntries shall remain inaccessible.  At the time
        that this object decrements to zero, the report is made
        accessible in the hostTopNTable.  Thus, the hostTopN
        table needs to be created only at the end of the collection
        interval."))
(defoid |hostTopNDuration| (|hostTopNControlEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of seconds that this report has collected
        during the last sampling interval, or if this
        report is currently being collected, the number
        of seconds that this report is being collected
        during this sampling interval.

        When the associated hostTopNTimeRemaining object is set,
        this object shall be set by the probe to the same value
        and shall not be modified until the next time
        the hostTopNTimeRemaining is set.

        This value shall be zero if no reports have been
        requested for this hostTopNControlEntry."))
(defoid |hostTopNRequestedSize| (|hostTopNControlEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of hosts requested for the top N
        table.

        When this object is created or modified, the probe
        should set hostTopNGrantedSize as closely to this
        object as is possible for the particular probe
        implementation and available resources."))
(defoid |hostTopNGrantedSize| (|hostTopNControlEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of hosts in the top N table.

        When the associated hostTopNRequestedSize object is
        created or modified, the probe should set this
        object as closely to the requested value as is possible
        for the particular implementation and available

        resources. The probe must not lower this value except
        as a result of a set to the associated
        hostTopNRequestedSize object.

        Hosts with the highest value of hostTopNRate shall be
        placed in this table in decreasing order of this rate
        until there is no more room or until there are no more
        hosts."))
(defoid |hostTopNStartTime| (|hostTopNControlEntry| 8)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when this top N report was
        last started.  In other words, this is the time that
        the associated hostTopNTimeRemaining object was
        modified to start the requested report."))
(defoid |hostTopNOwner| (|hostTopNControlEntry| 9)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |hostTopNStatus| (|hostTopNControlEntry| 10)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this hostTopNControl entry.

        If this object is not equal to valid(1), all associated
        hostTopNEntries shall be deleted by the agent."))
(defoid |hostTopNTable| (|hostTopN| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of top N host entries."))
(defoid |hostTopNEntry| (|hostTopNTable| 1)
  (:type 'object-type)
  (:syntax '|HostTopNEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of statistics for a host that is part of a top N
        report.  For example, an instance of the hostTopNRate
        object might be named hostTopNRate.3.10"))
(deftype |HostTopNEntry| () 't)
(defoid |hostTopNReport| (|hostTopNEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object identifies the top N report of which
        this entry is a part.  The set of hosts
        identified by a particular value of this
        object is part of the same report as identified
        by the same value of the hostTopNControlIndex object."))
(defoid |hostTopNIndex| (|hostTopNEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in
        the hostTopN table among those in the same report.
        This index is between 1 and N, where N is the
        number of entries in this table.  Increasing values
        of hostTopNIndex shall be assigned to entries with
        decreasing values of hostTopNRate until index N
        is assigned to the entry with the lowest value of
        hostTopNRate or there are no more hostTopNEntries."))
(defoid |hostTopNAddress| (|hostTopNEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The physical address of this host."))
(defoid |hostTopNRate| (|hostTopNEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of change in the selected variable
        during this sampling interval.  The selected
        variable is this host's instance of the object
        selected by hostTopNRateBase."))
(defoid |matrixControlTable| (|matrix| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of information entries for the
        traffic matrix on each interface."))
(defoid |matrixControlEntry| (|matrixControlTable| 1)
  (:type 'object-type)
  (:syntax '|MatrixControlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a traffic matrix on a particular

        interface.  For example, an instance of the
        matrixControlLastDeleteTime object might be named
        matrixControlLastDeleteTime.1"))
(deftype |MatrixControlEntry| () 't)
(defoid |matrixControlIndex| (|matrixControlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in the
        matrixControl table.  Each such entry defines
        a function that discovers conversations on a particular
        interface and places statistics about them in the
        matrixSDTable and the matrixDSTable on behalf of this
        matrixControlEntry."))
(defoid |matrixControlDataSource| (|matrixControlEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object identifies the source of
        the data from which this entry creates a traffic matrix.
        This source can be any interface on this device.  In
        order to identify a particular interface, this object
        shall identify the instance of the ifIndex object,
        defined in RFC 2233 [17], for the desired
        interface.  For example, if an entry were to receive data
        from interface #1, this object would be set to ifIndex.1.

        The statistics in this group reflect all packets
        on the local network segment attached to the identified
        interface.

        An agent may or may not be able to tell if fundamental
        changes to the media of the interface have occurred and

        necessitate an invalidation of this entry.  For example, a
        hot-pluggable ethernet card could be pulled out and replaced
        by a token-ring card.  In such a case, if the agent has such
        knowledge of the change, it is recommended that it
        invalidate this entry.

        This object may not be modified if the associated
        matrixControlStatus object is equal to valid(1)."))
(defoid |matrixControlTableSize| (|matrixControlEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of matrixSDEntries in the matrixSDTable
        for this interface.  This must also be the value of
        the number of entries in the matrixDSTable for this
        interface."))
(defoid |matrixControlLastDeleteTime| (|matrixControlEntry| 4)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the last entry
        was deleted from the portion of the matrixSDTable
        or matrixDSTable associated with this matrixControlEntry.
        If no deletions have occurred, this value shall be
        zero."))
(defoid |matrixControlOwner| (|matrixControlEntry| 5)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |matrixControlStatus| (|matrixControlEntry| 6)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this matrixControl entry.

        If this object is not equal to valid(1), all associated
        entries in the matrixSDTable and the matrixDSTable
        shall be deleted by the agent."))
(defoid |matrixSDTable| (|matrix| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of traffic matrix entries indexed by
        source and destination MAC address."))
(defoid |matrixSDEntry| (|matrixSDTable| 1)
  (:type 'object-type)
  (:syntax '|MatrixSDEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A collection of statistics for communications between
        two addresses on a particular interface.  For example,
        an instance of the matrixSDPkts object might be named
        matrixSDPkts.1.6.8.0.32.27.3.176.6.8.0.32.10.8.113"))
(deftype |MatrixSDEntry| () 't)
(defoid |matrixSDSourceAddress| (|matrixSDEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The source physical address."))
(defoid |matrixSDDestAddress| (|matrixSDEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The destination physical address."))
(defoid |matrixSDIndex| (|matrixSDEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The set of collected matrix statistics of which
        this entry is a part.  The set of matrix statistics
        identified by a particular value of this index
        is associated with the same matrixControlEntry
        as identified by the same value of matrixControlIndex."))
(defoid |matrixSDPkts| (|matrixSDEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets transmitted from the source
        address to the destination address (this number includes
        bad packets)."))
(defoid |matrixSDOctets| (|matrixSDEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of octets (excluding framing bits but
        including FCS octets) contained in all packets
        transmitted from the source address to the
        destination address."))
(defoid |matrixSDErrors| (|matrixSDEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bad packets transmitted from
        the source address to the destination address."))
(defoid |matrixDSTable| (|matrix| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A list of traffic matrix entries indexed by
        destination and source MAC address."))
(defoid |matrixDSEntry| (|matrixDSTable| 1)
  (:type 'object-type)
  (:syntax '|MatrixDSEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A collection of statistics for communications between
        two addresses on a particular interface.  For example,
        an instance of the matrixSDPkts object might be named
        matrixSDPkts.1.6.8.0.32.10.8.113.6.8.0.32.27.3.176"))
(deftype |MatrixDSEntry| () 't)
(defoid |matrixDSSourceAddress| (|matrixDSEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The source physical address."))
(defoid |matrixDSDestAddress| (|matrixDSEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The destination physical address."))
(defoid |matrixDSIndex| (|matrixDSEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The set of collected matrix statistics of which
        this entry is a part.  The set of matrix statistics
        identified by a particular value of this index
        is associated with the same matrixControlEntry
        as identified by the same value of matrixControlIndex."))
(defoid |matrixDSPkts| (|matrixDSEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets transmitted from the source
        address to the destination address (this number includes
        bad packets)."))
(defoid |matrixDSOctets| (|matrixDSEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of octets (excluding framing bits
        but including FCS octets) contained in all packets
        transmitted from the source address to the
        destination address."))
(defoid |matrixDSErrors| (|matrixDSEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bad packets transmitted from
        the source address to the destination address."))
(defoid |filterTable| (|filter| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of packet filter entries."))
(defoid |filterEntry| (|filterTable| 1)
  (:type 'object-type)
  (:syntax '|FilterEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of parameters for a packet filter applied on a
        particular interface.  As an example, an instance of the
        filterPktData object might be named filterPktData.12"))
(deftype |FilterEntry| () 't)
(defoid |filterIndex| (|filterEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry
        in the filter table.  Each such entry defines
        one filter that is to be applied to every packet
        received on an interface."))
(defoid |filterChannelIndex| (|filterEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object identifies the channel of which this filter
        is a part.  The filters identified by a particular value
        of this object are associated with the same channel as
        identified by the same value of the channelIndex object."))
(defoid |filterPktDataOffset| (|filterEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The offset from the beginning of each packet where
        a match of packet data will be attempted.  This offset
        is measured from the point in the physical layer
        packet after the framing bits, if any.  For example,
        in an Ethernet frame, this point is at the beginning of
        the destination MAC address.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterPktData| (|filterEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The data that is to be matched with the input packet.
        For each packet received, this filter and the accompanying
        filterPktDataMask and filterPktDataNotMask will be
        adjusted for the offset.  The only bits relevant to this
        match algorithm are those that have the corresponding
        filterPktDataMask bit equal to one.  The following three
        rules are then applied to every packet:

        (1) If the packet is too short and does not have data
            corresponding to part of the filterPktData, the packet
            will fail this data match.

        (2) For each relevant bit from the packet with the
            corresponding filterPktDataNotMask bit set to zero, if
            the bit from the packet is not equal to the corresponding
            bit from the filterPktData, then the packet will fail
            this data match.

        (3) If for every relevant bit from the packet with the
            corresponding filterPktDataNotMask bit set to one, the
            bit from the packet is equal to the corresponding bit
            from the filterPktData, then the packet will fail this
            data match.

        Any packets that have not failed any of the three matches
        above have passed this data match.  In particular, a zero
        length filter will match any packet.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterPktDataMask| (|filterEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The mask that is applied to the match process.
        After adjusting this mask for the offset, only those
        bits in the received packet that correspond to bits set
        in this mask are relevant for further processing by the

        match algorithm.  The offset is applied to filterPktDataMask
        in the same way it is applied to the filter.  For the
        purposes of the matching algorithm, if the associated
        filterPktData object is longer than this mask, this mask is
        conceptually extended with '1' bits until it reaches the
        length of the filterPktData object.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterPktDataNotMask| (|filterEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The inversion mask that is applied to the match
        process.  After adjusting this mask for the offset,
        those relevant bits in the received packet that correspond
        to bits cleared in this mask must all be equal to their
        corresponding bits in the filterPktData object for the packet
        to be accepted.  In addition, at least one of those relevant
        bits in the received packet that correspond to bits set in
        this mask must be different to its corresponding bit in the
        filterPktData object.

        For the purposes of the matching algorithm, if the associated
        filterPktData object is longer than this mask, this mask is
        conceptually extended with '0' bits until it reaches the
        length of the filterPktData object.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterPktStatus| (|filterEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status that is to be matched with the input packet.
        The only bits relevant to this match algorithm are those that
        have the corresponding filterPktStatusMask bit equal to one.
        The following two rules are then applied to every packet:

        (1) For each relevant bit from the packet status with the
            corresponding filterPktStatusNotMask bit set to zero, if
            the bit from the packet status is not equal to the

            corresponding bit from the filterPktStatus, then the
            packet will fail this status match.

        (2) If for every relevant bit from the packet status with the
            corresponding filterPktStatusNotMask bit set to one, the
            bit from the packet status is equal to the corresponding
            bit from the filterPktStatus, then the packet will fail
            this status match.

        Any packets that have not failed either of the two matches
        above have passed this status match.  In particular, a zero
        length status filter will match any packet's status.

        The value of the packet status is a sum.  This sum
        initially takes the value zero.  Then, for each
        error, E, that has been discovered in this packet,
        2 raised to a value representing E is added to the sum.
        The errors and the bits that represent them are dependent
        on the media type of the interface that this channel
        is receiving packets from.

        The errors defined for a packet captured off of an
        Ethernet interface are as follows:

            bit #    Error
                0    Packet is longer than 1518 octets
                1    Packet is shorter than 64 octets
                2    Packet experienced a CRC or Alignment error

        For example, an Ethernet fragment would have a
        value of 6 (2^1 + 2^2).

        As this MIB is expanded to new media types, this object
        will have other media-specific errors defined.

        For the purposes of this status matching algorithm, if the
        packet status is longer than this filterPktStatus object,
        this object is conceptually extended with '0' bits until it
        reaches the size of the packet status.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterPktStatusMask| (|filterEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The mask that is applied to the status match process.
        Only those bits in the received packet that correspond to
        bits set in this mask are relevant for further processing
        by the status match algorithm.  For the purposes
        of the matching algorithm, if the associated filterPktStatus
        object is longer than this mask, this mask is conceptually
        extended with '1' bits until it reaches the size of the
        filterPktStatus.  In addition, if a packet status is longer
        than this mask, this mask is conceptually extended with '0'
        bits until it reaches the size of the packet status.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterPktStatusNotMask| (|filterEntry| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The inversion mask that is applied to the status match
        process.  Those relevant bits in the received packet status
        that correspond to bits cleared in this mask must all be
        equal to their corresponding bits in the filterPktStatus
        object for the packet to be accepted.  In addition, at least
        one of those relevant bits in the received packet status
        that correspond to bits set in this mask must be different
        to its corresponding bit in the filterPktStatus object for
        the packet to be accepted.

        For the purposes of the matching algorithm, if the associated
        filterPktStatus object or a packet status is longer than this
        mask, this mask is conceptually extended with '0' bits until
        it reaches the longer of the lengths of the filterPktStatus
        object and the packet status.

        This object may not be modified if the associated
        filterStatus object is equal to valid(1)."))
(defoid |filterOwner| (|filterEntry| 10)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |filterStatus| (|filterEntry| 11)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The status of this filter entry."))
(defoid |channelTable| (|filter| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of packet channel entries."))
(defoid |channelEntry| (|channelTable| 1)
  (:type 'object-type)
  (:syntax '|ChannelEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of parameters for a packet channel applied on a
        particular interface.  As an example, an instance of the
        channelMatches object might be named channelMatches.3"))
(deftype |ChannelEntry| () 't)
(defoid |channelIndex| (|channelEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in the channel
        table.  Each such entry defines one channel, a logical
        data and event stream.

        It is suggested that before creating a channel, an
        application should scan all instances of the
        filterChannelIndex object to make sure that there are no
        pre-existing filters that would be inadvertently be linked
        to the channel."))
(defoid |channelIfIndex| (|channelEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object uniquely identifies the
        interface on this remote network monitoring device to which
        the associated filters are applied to allow data into this
        channel.  The interface identified by a particular value
        of this object is the same interface as identified by the
        same value of the ifIndex object, defined in RFC 2233 [17].

        The filters in this group are applied to all packets on
        the local network segment attached to the identified
        interface.

        An agent may or may not be able to tell if fundamental
        changes to the media of the interface have occurred and
        necessitate an invalidation of this entry.  For example, a
        hot-pluggable ethernet card could be pulled out and replaced
        by a token-ring card.  In such a case, if the agent has such
        knowledge of the change, it is recommended that it
        invalidate this entry.

        This object may not be modified if the associated
        channelStatus object is equal to valid(1)."))
(defoid |channelAcceptType| (|channelEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object controls the action of the filters
        associated with this channel.  If this object is equal
        to acceptMatched(1), packets will be accepted to this
        channel if they are accepted by both the packet data and
        packet status matches of an associated filter.  If
        this object is equal to acceptFailed(2), packets will
        be accepted to this channel only if they fail either
        the packet data match or the packet status match of
        each of the associated filters.

        In particular, a channel with no associated filters will
        match no packets if set to acceptMatched(1) case and will
        match all packets in the acceptFailed(2) case.

        This object may not be modified if the associated
        channelStatus object is equal to valid(1)."))
(defoid |channelDataControl| (|channelEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object controls the flow of data through this channel.
        If this object is on(1), data, status and events flow
        through this channel.  If this object is off(2), data,
        status and events will not flow through this channel."))
(defoid |channelTurnOnEventIndex| (|channelEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object identifies the event
        that is configured to turn the associated
        channelDataControl from off to on when the event is
        generated.  The event identified by a particular value
        of this object is the same event as identified by the
        same value of the eventIndex object.  If there is no
        corresponding entry in the eventTable, then no
        association exists.  In fact, if no event is intended
        for this channel, channelTurnOnEventIndex must be
        set to zero, a non-existent event index.

        This object may not be modified if the associated
        channelStatus object is equal to valid(1)."))
(defoid |channelTurnOffEventIndex| (|channelEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object identifies the event
        that is configured to turn the associated
        channelDataControl from on to off when the event is
        generated.  The event identified by a particular value
        of this object is the same event as identified by the
        same value of the eventIndex object.  If there is no
        corresponding entry in the eventTable, then no
        association exists.  In fact, if no event is intended
        for this channel, channelTurnOffEventIndex must be
        set to zero, a non-existent event index.

        This object may not be modified if the associated
        channelStatus object is equal to valid(1)."))
(defoid |channelEventIndex| (|channelEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object identifies the event
        that is configured to be generated when the
        associated channelDataControl is on and a packet
        is matched.  The event identified by a particular value
        of this object is the same event as identified by the
        same value of the eventIndex object.  If there is no
        corresponding entry in the eventTable, then no
        association exists.  In fact, if no event is intended
        for this channel, channelEventIndex must be
        set to zero, a non-existent event index.

        This object may not be modified if the associated
        channelStatus object is equal to valid(1)."))
(defoid |channelEventStatus| (|channelEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The event status of this channel.

        If this channel is configured to generate events
        when packets are matched, a means of controlling
        the flow of those events is often needed.  When
        this object is equal to eventReady(1), a single
        event may be generated, after which this object
        will be set by the probe to eventFired(2).  While
        in the eventFired(2) state, no events will be
        generated until the object is modified to
        eventReady(1) (or eventAlwaysReady(3)).  The
        management station can thus easily respond to a
        notification of an event by re-enabling this object.

        If the management station wishes to disable this
        flow control and allow events to be generated
        at will, this object may be set to
        eventAlwaysReady(3).  Disabling the flow control
        is discouraged as it can result in high network
        traffic or other performance problems."))
(defoid |channelMatches| (|channelEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times this channel has matched a packet.
        Note that this object is updated even when
        channelDataControl is set to off."))
(defoid |channelDescription| (|channelEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "A comment describing this channel."))
(defoid |channelOwner| (|channelEntry| 11)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |channelStatus| (|channelEntry| 12)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The status of this channel entry."))
(defoid |bufferControlTable| (|capture| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of buffers control entries."))
(defoid |bufferControlEntry| (|bufferControlTable| 1)
  (:type 'object-type)
  (:syntax '|BufferControlEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of parameters that control the collection of a stream
        of packets that have matched filters.  As an example, an
        instance of the bufferControlCaptureSliceSize object might
        be named bufferControlCaptureSliceSize.3"))
(deftype |BufferControlEntry| () 't)
(defoid |bufferControlIndex| (|bufferControlEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry
        in the bufferControl table.  The value of this
        index shall never be zero.  Each such
        entry defines one set of packets that is
        captured and controlled by one or more filters."))
(defoid |bufferControlChannelIndex| (|bufferControlEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An index that identifies the channel that is the
        source of packets for this bufferControl table.
        The channel identified by a particular value of this
        index is the same as identified by the same value of
        the channelIndex object.

        This object may not be modified if the associated
        bufferControlStatus object is equal to valid(1)."))
(defoid |bufferControlFullStatus| (|bufferControlEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object shows whether the buffer has room to
        accept new packets or if it is full.

        If the status is spaceAvailable(1), the buffer is
        accepting new packets normally.  If the status is
        full(2) and the associated bufferControlFullAction
        object is wrapWhenFull, the buffer is accepting new
        packets by deleting enough of the oldest packets
        to make room for new ones as they arrive.  Otherwise,
        if the status is full(2) and the
        bufferControlFullAction object is lockWhenFull,
        then the buffer has stopped collecting packets.

        When this object is set to full(2) the probe must
        not later set it to spaceAvailable(1) except in the
        case of a significant gain in resources such as
        an increase of bufferControlOctetsGranted.  In
        particular, the wrap-mode action of deleting old
        packets to make room for newly arrived packets
        must not affect the value of this object."))
(defoid |bufferControlFullAction| (|bufferControlEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Controls the action of the buffer when it
        reaches the full status.  When in the lockWhenFull(1)
        state and a packet is added to the buffer that
        fills the buffer, the bufferControlFullStatus will
        be set to full(2) and this buffer will stop capturing
        packets."))
(defoid |bufferControlCaptureSliceSize| (|bufferControlEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of octets of each packet
        that will be saved in this capture buffer.
        For example, if a 1500 octet packet is received by
        the probe and this object is set to 500, then only
        500 octets of the packet will be stored in the
        associated capture buffer.  If this variable is set
        to 0, the capture buffer will save as many octets
        as is possible.

        This object may not be modified if the associated
        bufferControlStatus object is equal to valid(1)."))
(defoid |bufferControlDownloadSliceSize| (|bufferControlEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of octets of each packet
        in this capture buffer that will be returned in
        an SNMP retrieval of that packet.  For example,
        if 500 octets of a packet have been stored in the
        associated capture buffer, the associated
        bufferControlDownloadOffset is 0, and this
        object is set to 100, then the captureBufferPacket
        object that contains the packet will contain only
        the first 100 octets of the packet.

        A prudent manager will take into account possible
        interoperability or fragmentation problems that may
        occur if the download slice size is set too large.
        In particular, conformant SNMP implementations are not
        required to accept messages whose length exceeds 484
        octets, although they are encouraged to support larger
        datagrams whenever feasible."))
(defoid |bufferControlDownloadOffset| (|bufferControlEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The offset of the first octet of each packet
        in this capture buffer that will be returned in
        an SNMP retrieval of that packet.  For example,
        if 500 octets of a packet have been stored in the
        associated capture buffer and this object is set to
        100, then the captureBufferPacket object that
        contains the packet will contain bytes starting
        100 octets into the packet."))
(defoid |bufferControlMaxOctetsRequested| (|bufferControlEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The requested maximum number of octets to be
        saved in this captureBuffer, including any
        implementation-specific overhead. If this variable
        is set to -1, the capture buffer will save as many
        octets as is possible.

        When this object is created or modified, the probe
        should set bufferControlMaxOctetsGranted as closely
        to this object as is possible for the particular probe
        implementation and available resources.  However, if
        the object has the special value of -1, the probe
        must set bufferControlMaxOctetsGranted to -1."))
(defoid |bufferControlMaxOctetsGranted| (|bufferControlEntry| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of octets that can be
        saved in this captureBuffer, including overhead.
        If this variable is -1, the capture buffer will save
        as many octets as possible.

        When the bufferControlMaxOctetsRequested object is
        created or modified, the probe should set this object
        as closely to the requested value as is possible for the
        particular probe implementation and available resources.
        However, if the request object has the special value

        of -1, the probe must set this object to -1.

        The probe must not lower this value except as a result of
        a modification to the associated
        bufferControlMaxOctetsRequested object.

        When this maximum number of octets is reached
        and a new packet is to be added to this
        capture buffer and the corresponding
        bufferControlFullAction is set to wrapWhenFull(2),
        enough of the oldest packets associated with this
        capture buffer shall be deleted by the agent so
        that the new packet can be added.  If the corresponding
        bufferControlFullAction is set to lockWhenFull(1),
        the new packet shall be discarded.  In either case,
        the probe must set bufferControlFullStatus to
        full(2).

        When the value of this object changes to a value less
        than the current value, entries are deleted from
        the captureBufferTable associated with this
        bufferControlEntry.  Enough of the
        oldest of these captureBufferEntries shall be
        deleted by the agent so that the number of octets
        used remains less than or equal to the new value of
        this object.

        When the value of this object changes to a value greater
        than the current value, the number of associated
        captureBufferEntries may be allowed to grow."))
(defoid |bufferControlCapturedPackets| (|bufferControlEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets currently in this captureBuffer."))
(defoid |bufferControlTurnOnTime| (|bufferControlEntry| 11)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when this capture buffer was
        first turned on."))
(defoid |bufferControlOwner| (|bufferControlEntry| 12)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it."))
(defoid |bufferControlStatus| (|bufferControlEntry| 13)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The status of this buffer Control Entry."))
(defoid |captureBufferTable| (|capture| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of packets captured off of a channel."))
(defoid |captureBufferEntry| (|captureBufferTable| 1)
  (:type 'object-type)
  (:syntax '|CaptureBufferEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A packet captured off of an attached network.  As an
        example, an instance of the captureBufferPacketData
        object might be named captureBufferPacketData.3.1783"))
(deftype |CaptureBufferEntry| () 't)
(defoid |captureBufferControlIndex| (|captureBufferEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The index of the bufferControlEntry with which
        this packet is associated."))
(defoid |captureBufferIndex| (|captureBufferEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry
        in the captureBuffer table associated with a
        particular bufferControlEntry.  This index will
        start at 1 and increase by one for each new packet
        added with the same captureBufferControlIndex.

        Should this value reach 2147483647, the next packet
        added with the same captureBufferControlIndex shall
        cause this value to wrap around to 1."))
(defoid |captureBufferPacketID| (|captureBufferEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that describes the order of packets
        that are received on a particular interface.
        The packetID of a packet captured on an
        interface is defined to be greater than the
        packetID's of all packets captured previously on
        the same interface.  As the captureBufferPacketID
        object has a maximum positive value of 2^31 - 1,
        any captureBufferPacketID object shall have the
        value of the associated packet's packetID mod 2^31."))
(defoid |captureBufferPacketData| (|captureBufferEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The data inside the packet, starting at the beginning
        of the packet plus any offset specified in the

        associated bufferControlDownloadOffset, including any
        link level headers.  The length of the data in this object
        is the minimum of the length of the captured packet minus
        the offset, the length of the associated
        bufferControlCaptureSliceSize minus the offset, and the
        associated bufferControlDownloadSliceSize.  If this minimum
        is less than zero, this object shall have a length of zero."))
(defoid |captureBufferPacketLength| (|captureBufferEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The actual length (off the wire) of the packet stored
        in this entry, including FCS octets."))
(defoid |captureBufferPacketTime| (|captureBufferEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of milliseconds that had passed since
        this capture buffer was first turned on when this
        packet was captured."))
(defoid |captureBufferPacketStatus| (|captureBufferEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A value which indicates the error status of this packet.

        The value of this object is defined in the same way as
        filterPktStatus.  The value is a sum.  This sum
        initially takes the value zero.  Then, for each
        error, E, that has been discovered in this packet,
        2 raised to a value representing E is added to the sum.

        The errors defined for a packet captured off of an
        Ethernet interface are as follows:

            bit #    Error
                0    Packet is longer than 1518 octets

                1    Packet is shorter than 64 octets
                2    Packet experienced a CRC or Alignment error
                3    First packet in this capture buffer after
                     it was detected that some packets were
                     not processed correctly.
                4    Packet's order in buffer is only approximate
                     (May only be set for packets sent from
                     the probe)

        For example, an Ethernet fragment would have a
        value of 6 (2^1 + 2^2).

        As this MIB is expanded to new media types, this object
        will have other media-specific errors defined."))
(defoid |eventTable| (|event| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of events to be generated."))
(defoid |eventEntry| (|eventTable| 1)
  (:type 'object-type)
  (:syntax '|EventEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of parameters that describe an event to be generated
        when certain conditions are met.  As an example, an instance
        of the eventLastTimeSent object might be named
        eventLastTimeSent.6"))
(deftype |EventEntry| () 't)
(defoid |eventIndex| (|eventEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry in the
        event table.  Each such entry defines one event that
        is to be generated when the appropriate conditions
        occur."))
(defoid |eventDescription| (|eventEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "A comment describing this event entry."))
(defoid |eventType| (|eventEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The type of notification that the probe will make
        about this event.  In the case of log, an entry is
        made in the log table for each event.  In the case of
        snmp-trap, an SNMP trap is sent to one or more
        management stations."))
(defoid |eventCommunity| (|eventEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "If an SNMP trap is to be sent, it will be sent to
        the SNMP community specified by this octet string."))
(defoid |eventLastTimeSent| (|eventEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this event
        entry last generated an event.  If this entry has
        not generated any events, this value will be
        zero."))
(defoid |eventOwner| (|eventEntry| 6)
  (:type 'object-type)
  (:syntax '|OwnerString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The entity that configured this entry and is therefore
        using the resources assigned to it.

        If this object contains a string starting with 'monitor'
        and has associated entries in the log table, all connected
        management stations should retrieve those log entries,
        as they may have significance to all management stations
        connected to this device"))
(defoid |eventStatus| (|eventEntry| 7)
  (:type 'object-type)
  (:syntax '|EntryStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this event entry.

        If this object is not equal to valid(1), all associated
        log entries shall be deleted by the agent."))
(defoid |logTable| (|event| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of events that have been logged."))
(defoid |logEntry| (|logTable| 1)
  (:type 'object-type)
  (:syntax '|LogEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of data describing an event that has been
        logged.  For example, an instance of the logDescription
        object might be named logDescription.6.47"))
(deftype |LogEntry| () 't)
(defoid |logEventIndex| (|logEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The event entry that generated this log
        entry.  The log identified by a particular
        value of this index is associated with the same
        eventEntry as identified by the same value
        of eventIndex."))
(defoid |logIndex| (|logEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An index that uniquely identifies an entry
        in the log table amongst those generated by the
        same eventEntries.  These indexes are
        assigned beginning with 1 and increase by one
        with each new log entry.  The association
        between values of logIndex and logEntries
        is fixed for the lifetime of each logEntry.
        The agent may choose to delete the oldest
        instances of logEntry as required because of
        lack of memory.  It is an implementation-specific
        matter as to when this deletion may occur."))
(defoid |logTime| (|logEntry| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when this log entry was created."))
(defoid |logDescription| (|logEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An implementation dependent description of the
        event that activated this log entry."))
(defoid |rmonEventsV2| (|rmon| 0)
  (:type 'object-identity)
  (:status '|current|)
  (:description "Definition point for RMON notifications."))
(defoid |risingAlarm| (|rmonEventsV2| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "The SNMP trap that is generated when an alarm
        entry crosses its rising threshold and generates
        an event that is configured for sending SNMP
        traps."))
(defoid |fallingAlarm| (|rmonEventsV2| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "The SNMP trap that is generated when an alarm
        entry crosses its falling threshold and generates
        an event that is configured for sending SNMP
        traps."))
(defoid |rmonCompliances| (|rmonConformance| 9)
  (:type 'object-identity))
(defoid |rmonGroups| (|rmonConformance| 10) (:type 'object-identity))
(defoid |rmonCompliance| (|rmonCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The requirements for conformance to the RMON MIB. At least
        one of the groups in this module must be implemented to
        conform to the RMON MIB. Implementations of this MIB
        must also implement the system group of MIB-II [16] and the
        IF-MIB [17]."))
(defoid |rmonEtherStatsGroup| (|rmonGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Ethernet Statistics Group."))
(defoid |rmonHistoryControlGroup| (|rmonGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON History Control Group."))
(defoid |rmonEthernetHistoryGroup| (|rmonGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Ethernet History Group."))
(defoid |rmonAlarmGroup| (|rmonGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Alarm Group."))
(defoid |rmonHostGroup| (|rmonGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Host Group."))
(defoid |rmonHostTopNGroup| (|rmonGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Host Top 'N' Group."))
(defoid |rmonMatrixGroup| (|rmonGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Matrix Group."))
(defoid |rmonFilterGroup| (|rmonGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Filter Group."))
(defoid |rmonPacketCaptureGroup| (|rmonGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Packet Capture Group."))
(defoid |rmonEventGroup| (|rmonGroups| 10)
  (:type 'object-group)
  (:status '|current|)
  (:description "The RMON Event Group."))
(defoid |rmonNotificationGroup| (|rmonGroups| 11)
  (:type 'notification-group)
  (:status '|current|)
  (:description "The RMON Notification Group."))
