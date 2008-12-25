;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;HOST-RESOURCES-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'host-resources-mib *mib-modules*)
  (setf *current-module* 'host-resources-mib))

(defpackage :asn.1/host-resources-mib
  (:nicknames :host-resources-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type |mib-2|
                |Integer32| |Counter32| |Gauge32| |TimeTicks|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |DisplayString|
                |TruthValue| |DateAndTime| |AutonomousType|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/if-mib |InterfaceIndexOrZero|))

(in-package :host-resources-mib)

(defoid |host| (|mib-2| 25) (:type 'object-identity))

(defoid |hrSystem| (|host| 1) (:type 'object-identity))

(defoid |hrStorage| (|host| 2) (:type 'object-identity))

(defoid |hrDevice| (|host| 3) (:type 'object-identity))

(defoid |hrSWRun| (|host| 4) (:type 'object-identity))

(defoid |hrSWRunPerf| (|host| 5) (:type 'object-identity))

(defoid |hrSWInstalled| (|host| 6) (:type 'object-identity))

(defoid |hrMIBAdminInfo| (|host| 7) (:type 'object-identity))

(defoid |hostResourcesMibModule| (|hrMIBAdminInfo| 1)
  (:type 'module-identity)
  (:description
   "This MIB is for use in managing host systems. The term
       `host' is construed to mean any computer that communicates
       with other similar computers attached to the internet and
       that is directly used by one or more human beings. Although
       this MIB does not necessarily apply to devices whose primary
       function is communications services (e.g., terminal servers,
       routers, bridges, monitoring equipment), such relevance is
       not explicitly precluded.  This MIB instruments attributes
       common to all internet hosts including, for example, both
       personal computers and systems that run variants of Unix."))

(deftype |KBytes| () 't)

(deftype |ProductID| () 't)

(deftype |InternationalDisplayString| () 't)

(defoid |hrSystemUptime| (|hrSystem| 1)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of time since this host was last
        initialized.  Note that this is different from
        sysUpTime in the SNMPv2-MIB [RFC1907] because
        sysUpTime is the uptime of the network management
        portion of the system."))

(defoid |hrSystemDate| (|hrSystem| 2)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "The host's notion of the local date and time of day."))

(defoid |hrSystemInitialLoadDevice| (|hrSystem| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The index of the hrDeviceEntry for the device from
        which this host is configured to load its initial
        operating system configuration (i.e., which operating
        system code and/or boot parameters).

        Note that writing to this object just changes the
        configuration that will be used the next time the
        operating system is loaded and does not actually cause
        the reload to occur."))

(defoid |hrSystemInitialLoadParameters| (|hrSystem| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This object contains the parameters (e.g. a pathname
        and parameter) supplied to the load device when
        requesting the initial operating system configuration
        from that device.

     Note that writing to this object just changes the
     configuration that will be used the next time the
     operating system is loaded and does not actually cause
     the reload to occur."))

(defoid |hrSystemNumUsers| (|hrSystem| 5)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of user sessions for which this host is
        storing state information.  A session is a collection
        of processes requiring a single act of user
        authentication and possibly subject to collective job
        control."))

(defoid |hrSystemProcesses| (|hrSystem| 6)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of process contexts currently loaded or
        running on this system."))

(defoid |hrSystemMaxProcesses| (|hrSystem| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of process contexts this system
        can support.  If there is no fixed maximum, the value
        should be zero.  On systems that have a fixed maximum,
        this object can help diagnose failures that occur when
        this maximum is reached."))

(defoid |hrStorageTypes| (|hrStorage| 1) (:type 'object-identity))

(defoid |hrMemorySize| (|hrStorage| 2)
  (:type 'object-type)
  (:syntax '|KBytes|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of physical read-write main memory,
        typically RAM, contained by the host."))

(defoid |hrStorageTable| (|hrStorage| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of logical storage areas on
        the host.

        An entry shall be placed in the storage table for each
        logical area of storage that is allocated and has
        fixed resource limits.  The amount of storage
        represented in an entity is the amount actually usable
        by the requesting entity, and excludes loss due to
        formatting or file system reference information.

        These entries are associated with logical storage
        areas, as might be seen by an application, rather than
        physical storage entities which are typically seen by
        an operating system.  Storage such as tapes and
        floppies without file systems on them are typically
        not allocated in chunks by the operating system to
        requesting applications, and therefore shouldn't
        appear in this table.  Examples of valid storage for
        this table include disk partitions, file systems, ram
        (for some architectures this is further segmented into
        regular memory, extended memory, and so on), backing
        store for virtual memory (`swap space').

        This table is intended to be a useful diagnostic for
        `out of memory' and `out of buffers' types of
        failures.  In addition, it can be a useful performance
        monitoring tool for tracking memory, disk, or buffer
        usage."))

(defoid |hrStorageEntry| (|hrStorageTable| 1)
  (:type 'object-type)
  (:syntax '|HrStorageEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one logical storage area on
        the host.  As an example, an instance of the
        hrStorageType object might be named hrStorageType.3"))

(deftype |HrStorageEntry| () 't)

(defoid |hrStorageIndex| (|hrStorageEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each logical storage area
        contained by the host."))

(defoid |hrStorageType| (|hrStorageEntry| 2)
  (:type 'object-type)
  (:syntax '|AutonomousType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The type of storage represented by this entry."))

(defoid |hrStorageDescr| (|hrStorageEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A description of the type and instance of the storage
        described by this entry."))

(defoid |hrStorageAllocationUnits| (|hrStorageEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The size, in bytes, of the data objects allocated
        from this pool.  If this entry is monitoring sectors,
        blocks, buffers, or packets, for example, this number
        will commonly be greater than one.  Otherwise this
        number will typically be one."))

(defoid |hrStorageSize| (|hrStorageEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The size of the storage represented by this entry, in
        units of hrStorageAllocationUnits. This object is
        writable to allow remote configuration of the size of
        the storage area in those cases where such an
        operation makes sense and is possible on the
        underlying system. For example, the amount of main
        memory allocated to a buffer pool might be modified or
        the amount of disk space allocated to virtual memory
        might be modified."))

(defoid |hrStorageUsed| (|hrStorageEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of the storage represented by this entry
        that is allocated, in units of
        hrStorageAllocationUnits."))

(defoid |hrStorageAllocationFailures| (|hrStorageEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of requests for storage represented by
        this entry that could not be honored due to not enough
        storage.  It should be noted that as this object has a
        SYNTAX of Counter32, that it does not have a defined
        initial value.  However, it is recommended that this
        object be initialized to zero, even though management
        stations must not depend on such an initialization."))

(defoid |hrDeviceTypes| (|hrDevice| 1) (:type 'object-identity))

(defoid |hrDeviceTable| (|hrDevice| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of devices contained by the
        host."))

(defoid |hrDeviceEntry| (|hrDeviceTable| 1)
  (:type 'object-type)
  (:syntax '|HrDeviceEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one device contained by the
        host.  As an example, an instance of the hrDeviceType
        object might be named hrDeviceType.3"))

(deftype |HrDeviceEntry| () 't)

(defoid |hrDeviceIndex| (|hrDeviceEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each device contained by the host.
        The value for each device must remain constant at
        least from one re-initialization of the agent to the
        next re-initialization."))

(defoid |hrDeviceType| (|hrDeviceEntry| 2)
  (:type 'object-type)
  (:syntax '|AutonomousType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An indication of the type of device.

        If this value is
        `hrDeviceProcessor { hrDeviceTypes 3 }' then an entry
        exists in the hrProcessorTable which corresponds to
        this device.

        If this value is
        `hrDeviceNetwork { hrDeviceTypes 4 }', then an entry
        exists in the hrNetworkTable which corresponds to this
        device.

        If this value is
        `hrDevicePrinter { hrDeviceTypes 5 }', then an entry
        exists in the hrPrinterTable which corresponds to this
        device.

        If this value is
        `hrDeviceDiskStorage { hrDeviceTypes 6 }', then an
        entry exists in the hrDiskStorageTable which
        corresponds to this device."))

(defoid |hrDeviceDescr| (|hrDeviceEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual description of this device, including the
        device's manufacturer and revision, and optionally,
        its serial number."))

(defoid |hrDeviceID| (|hrDeviceEntry| 4)
  (:type 'object-type)
  (:syntax '|ProductID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The product ID for this device."))

(defoid |hrDeviceStatus| (|hrDeviceEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current operational state of the device described
        by this row of the table.  A value unknown(1)
        indicates that the current state of the device is
        unknown.  running(2) indicates that the device is up
        and running and that no unusual error conditions are
        known.  The warning(3) state indicates that agent has
        been informed of an unusual error condition by the
        operational software (e.g., a disk device driver) but
        that the device is still 'operational'.  An example
        would be a high number of soft errors on a disk.  A
        value of testing(4), indicates that the device is not
        available for use because it is in the testing state.
        The state of down(5) is used only when the agent has
        been informed that the device is not available for any
        use."))

(defoid |hrDeviceErrors| (|hrDeviceEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of errors detected on this device.  It
        should be noted that as this object has a SYNTAX of
        Counter32, that it does not have a defined initial
        value.  However, it is recommended that this object be
        initialized to zero, even though management stations
        must not depend on such an initialization."))

(defoid |hrProcessorTable| (|hrDevice| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of processors contained by the
        host.

        Note that this table is potentially sparse: a
        (conceptual) entry exists only if the correspondent
        value of the hrDeviceType object is
        `hrDeviceProcessor'."))

(defoid |hrProcessorEntry| (|hrProcessorTable| 1)
  (:type 'object-type)
  (:syntax '|HrProcessorEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one processor contained by
        the host.  The hrDeviceIndex in the index represents
        the entry in the hrDeviceTable that corresponds to the
        hrProcessorEntry.

        As an example of how objects in this table are named,
        an instance of the hrProcessorFrwID object might be
        named hrProcessorFrwID.3"))

(deftype |HrProcessorEntry| () 't)

(defoid |hrProcessorFrwID| (|hrProcessorEntry| 1)
  (:type 'object-type)
  (:syntax '|ProductID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The product ID of the firmware associated with the
        processor."))

(defoid |hrProcessorLoad| (|hrProcessorEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The average, over the last minute, of the percentage
        of time that this processor was not idle.
        Implementations may approximate this one minute
        smoothing period if necessary."))

(defoid |hrNetworkTable| (|hrDevice| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of network devices contained
        by the host.

        Note that this table is potentially sparse: a
        (conceptual) entry exists only if the correspondent
        value of the hrDeviceType object is
        `hrDeviceNetwork'."))

(defoid |hrNetworkEntry| (|hrNetworkTable| 1)
  (:type 'object-type)
  (:syntax '|HrNetworkEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one network device contained
        by the host.  The hrDeviceIndex in the index
        represents the entry in the hrDeviceTable that
        corresponds to the hrNetworkEntry.

        As an example of how objects in this table are named,
        an instance of the hrNetworkIfIndex object might be
        named hrNetworkIfIndex.3"))

(deftype |HrNetworkEntry| () 't)

(defoid |hrNetworkIfIndex| (|hrNetworkEntry| 1)
  (:type 'object-type)
  (:syntax '|InterfaceIndexOrZero|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of ifIndex which corresponds to this
        network device. If this device is not represented in
        the ifTable, then this value shall be zero."))

(defoid |hrPrinterTable| (|hrDevice| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of printers local to the host.

        Note that this table is potentially sparse: a
        (conceptual) entry exists only if the correspondent
        value of the hrDeviceType object is
        `hrDevicePrinter'."))

(defoid |hrPrinterEntry| (|hrPrinterTable| 1)
  (:type 'object-type)
  (:syntax '|HrPrinterEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one printer local to the
        host.  The hrDeviceIndex in the index represents the
        entry in the hrDeviceTable that corresponds to the
        hrPrinterEntry.

        As an example of how objects in this table are named,
        an instance of the hrPrinterStatus object might be
        named hrPrinterStatus.3"))

(deftype |HrPrinterEntry| () 't)

(defoid |hrPrinterStatus| (|hrPrinterEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The current status of this printer device."))

(defoid |hrPrinterDetectedErrorState| (|hrPrinterEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object represents any error conditions detected
        by the printer.  The error conditions are encoded as
        bits in an octet string, with the following
        definitions:

             Condition         Bit #

             lowPaper              0

             noPaper               1
             lowToner              2
             noToner               3
             doorOpen              4
             jammed                5
             offline               6
             serviceRequested      7
             inputTrayMissing      8
             outputTrayMissing     9
             markerSupplyMissing  10
             outputNearFull       11
             outputFull           12
             inputTrayEmpty       13
             overduePreventMaint  14

        Bits are numbered starting with the most significant
        bit of the first byte being bit 0, the least
        significant bit of the first byte being bit 7, the
        most significant bit of the second byte being bit 8,
        and so on.  A one bit encodes that the condition was
        detected, while a zero bit encodes that the condition
        was not detected.

        This object is useful for alerting an operator to
        specific warning or error conditions that may occur,
        especially those requiring human intervention."))

(defoid |hrDiskStorageTable| (|hrDevice| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of long-term storage devices
        contained by the host.  In particular, disk devices
        accessed remotely over a network are not included
        here.

        Note that this table is potentially sparse: a
        (conceptual) entry exists only if the correspondent
        value of the hrDeviceType object is
        `hrDeviceDiskStorage'."))

(defoid |hrDiskStorageEntry| (|hrDiskStorageTable| 1)
  (:type 'object-type)
  (:syntax '|HrDiskStorageEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one long-term storage device
        contained by the host.  The hrDeviceIndex in the index
        represents the entry in the hrDeviceTable that
        corresponds to the hrDiskStorageEntry. As an example,
        an instance of the hrDiskStorageCapacity object might
        be named hrDiskStorageCapacity.3"))

(deftype |HrDiskStorageEntry| () 't)

(defoid |hrDiskStorageAccess| (|hrDiskStorageEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An indication if this long-term storage device is
        readable and writable or only readable.  This should
        reflect the media type, any write-protect mechanism,
        and any device configuration that affects the entire
        device."))

(defoid |hrDiskStorageMedia| (|hrDiskStorageEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An indication of the type of media used in this long-
        term storage device."))

(defoid |hrDiskStorageRemoveble| (|hrDiskStorageEntry| 3)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Denotes whether or not the disk media may be removed
        from the drive."))

(defoid |hrDiskStorageCapacity| (|hrDiskStorageEntry| 4)
  (:type 'object-type)
  (:syntax '|KBytes|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total size for this long-term storage device. If
        the media is removable and is currently removed, this
        value should be zero."))

(defoid |hrPartitionTable| (|hrDevice| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of partitions for long-term
        storage devices contained by the host.  In particular,
        partitions accessed remotely over a network are not
        included here."))

(defoid |hrPartitionEntry| (|hrPartitionTable| 1)
  (:type 'object-type)
  (:syntax '|HrPartitionEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one partition.  The
        hrDeviceIndex in the index represents the entry in the
        hrDeviceTable that corresponds to the
        hrPartitionEntry.

        As an example of how objects in this table are named,
        an instance of the hrPartitionSize object might be
        named hrPartitionSize.3.1"))

(deftype |HrPartitionEntry| () 't)

(defoid |hrPartitionIndex| (|hrPartitionEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each partition on this long-term
        storage device.  The value for each long-term storage
        device must remain constant at least from one re-
        initialization of the agent to the next re-
        initialization."))

(defoid |hrPartitionLabel| (|hrPartitionEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "A textual description of this partition."))

(defoid |hrPartitionID| (|hrPartitionEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A descriptor which uniquely represents this partition
        to the responsible operating system.  On some systems,
        this might take on a binary representation."))

(defoid |hrPartitionSize| (|hrPartitionEntry| 4)
  (:type 'object-type)
  (:syntax '|KBytes|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The size of this partition."))

(defoid |hrPartitionFSIndex| (|hrPartitionEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The index of the file system mounted on this
        partition.  If no file system is mounted on this
        partition, then this value shall be zero.  Note that
        multiple partitions may point to one file system,
        denoting that that file system resides on those
        partitions.  Multiple file systems may not reside on
        one partition."))

(defoid |hrFSTypes| (|hrDevice| 9) (:type 'object-identity))

(defoid |hrFSTable| (|hrDevice| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of file systems local to this
        host or remotely mounted from a file server.  File
        systems that are in only one user's environment on a
        multi-user system will not be included in this table."))

(defoid |hrFSEntry| (|hrFSTable| 1)
  (:type 'object-type)
  (:syntax '|HrFSEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one file system local to
        this host or remotely mounted from a file server.
        File systems that are in only one user's environment
        on a multi-user system will not be included in this
        table.

        As an example of how objects in this table are named,
        an instance of the hrFSMountPoint object might be
        named hrFSMountPoint.3"))

(deftype |HrFSEntry| () 't)

(defoid |hrFSIndex| (|hrFSEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each file system local to this
        host.  The value for each file system must remain
        constant at least from one re-initialization of the
        agent to the next re-initialization."))

(defoid |hrFSMountPoint| (|hrFSEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The path name of the root of this file system."))

(defoid |hrFSRemoteMountPoint| (|hrFSEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A description of the name and/or address of the
        server that this file system is mounted from.  This
        may also include parameters such as the mount point on
        the remote file system.  If this is not a remote file
        system, this string should have a length of zero."))

(defoid |hrFSType| (|hrFSEntry| 4)
  (:type 'object-type)
  (:syntax '|AutonomousType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object identifies the type of this
        file system."))

(defoid |hrFSAccess| (|hrFSEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An indication if this file system is logically
        configured by the operating system to be readable and
        writable or only readable.  This does not represent
        any local access-control policy, except one that is
        applied to the file system as a whole."))

(defoid |hrFSBootable| (|hrFSEntry| 6)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A flag indicating whether this file system is
        bootable."))

(defoid |hrFSStorageIndex| (|hrFSEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The index of the hrStorageEntry that represents
        information about this file system.  If there is no
        such information available, then this value shall be
        zero.  The relevant storage entry will be useful in
        tracking the percent usage of this file system and
        diagnosing errors that may occur when it runs out of
        space."))

(defoid |hrFSLastFullBackupDate| (|hrFSEntry| 8)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The last date at which this complete file system was

        copied to another storage device for backup.  This
        information is useful for ensuring that backups are
        being performed regularly.

        If this information is not known, then this variable
        shall have the value corresponding to January 1, year
        0000, 00:00:00.0, which is encoded as
        (hex)'00 00 01 01 00 00 00 00'."))

(defoid |hrFSLastPartialBackupDate| (|hrFSEntry| 9)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The last date at which a portion of this file system
        was copied to another storage device for backup.  This
        information is useful for ensuring that backups are
        being performed regularly.

        If this information is not known, then this variable
        shall have the value corresponding to January 1, year
        0000, 00:00:00.0, which is encoded as
        (hex)'00 00 01 01 00 00 00 00'."))

(defoid |hrSWOSIndex| (|hrSWRun| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of the hrSWRunIndex for the hrSWRunEntry
        that represents the primary operating system running
        on this host.  This object is useful for quickly and
        uniquely identifying that primary operating system."))

(defoid |hrSWRunTable| (|hrSWRun| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of software running on the
        host."))

(defoid |hrSWRunEntry| (|hrSWRunTable| 1)
  (:type 'object-type)
  (:syntax '|HrSWRunEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for one piece of software
        running on the host Note that because the installed
        software table only contains information for software
        stored locally on this host, not every piece of
        running software will be found in the installed
        software table.  This is true of software that was
        loaded and run from a non-local source, such as a
        network-mounted file system.

        As an example of how objects in this table are named,
        an instance of the hrSWRunName object might be named
        hrSWRunName.1287"))

(deftype |HrSWRunEntry| () 't)

(defoid |hrSWRunIndex| (|hrSWRunEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each piece of software running on
        the host.  Wherever possible, this should be the
        system's native, unique identification number."))

(defoid |hrSWRunName| (|hrSWRunEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual description of this running piece of
        software, including the manufacturer, revision,  and
        the name by which it is commonly known.  If this
        software was installed locally, this should be the
        same string as used in the corresponding
        hrSWInstalledName."))

(defoid |hrSWRunID| (|hrSWRunEntry| 3)
  (:type 'object-type)
  (:syntax '|ProductID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The product ID of this running piece of software."))

(defoid |hrSWRunPath| (|hrSWRunEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A description of the location on long-term storage
        (e.g. a disk drive) from which this software was
        loaded."))

(defoid |hrSWRunParameters| (|hrSWRunEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A description of the parameters supplied to this
        software when it was initially loaded."))

(defoid |hrSWRunType| (|hrSWRunEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The type of this software."))

(defoid |hrSWRunStatus| (|hrSWRunEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The status of this running piece of software.
        Setting this value to invalid(4) shall cause this
        software to stop running and to be unloaded. Sets to
        other values are not valid."))

(defoid |hrSWRunPerfTable| (|hrSWRunPerf| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of running software
        performance metrics."))

(defoid |hrSWRunPerfEntry| (|hrSWRunPerfTable| 1)
  (:type 'object-type)
  (:syntax '|HrSWRunPerfEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry containing software performance
        metrics.  As an example, an instance of the
        hrSWRunPerfCPU object might be named
        hrSWRunPerfCPU.1287"))

(deftype |HrSWRunPerfEntry| () 't)

(defoid |hrSWRunPerfCPU| (|hrSWRunPerfEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of centi-seconds of the total system's CPU
        resources consumed by this process.  Note that on a
        multi-processor system, this value may increment by
        more than one centi-second in one centi-second of real
        (wall clock) time."))

(defoid |hrSWRunPerfMem| (|hrSWRunPerfEntry| 2)
  (:type 'object-type)
  (:syntax '|KBytes|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of real system memory allocated to
        this process."))

(defoid |hrSWInstalledLastChange| (|hrSWInstalled| 1)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when an entry in the
        hrSWInstalledTable was last added, renamed, or
        deleted.  Because this table is likely to contain many
        entries, polling of this object allows a management
        station to determine when re-downloading of the table
        might be useful."))

(defoid |hrSWInstalledLastUpdateTime| (|hrSWInstalled| 2)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the hrSWInstalledTable
        was last completely updated.  Because caching of this
        data will be a popular implementation strategy,
        retrieval of this object allows a management station
        to obtain a guarantee that no data in this table is
        older than the indicated time."))

(defoid |hrSWInstalledTable| (|hrSWInstalled| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table of software installed on this
        host."))

(defoid |hrSWInstalledEntry| (|hrSWInstalledTable| 1)
  (:type 'object-type)
  (:syntax '|HrSWInstalledEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A (conceptual) entry for a piece of software
        installed on this host.

        As an example of how objects in this table are named,
        an instance of the hrSWInstalledName object might be
        named hrSWInstalledName.96"))

(deftype |HrSWInstalledEntry| () 't)

(defoid |hrSWInstalledIndex| (|hrSWInstalledEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each piece of software installed
        on the host.  This value shall be in the range from 1
        to the number of pieces of software installed on the
        host."))

(defoid |hrSWInstalledName| (|hrSWInstalledEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual description of this installed piece of
        software, including the manufacturer, revision, the
        name by which it is commonly known, and optionally,
        its serial number."))

(defoid |hrSWInstalledID| (|hrSWInstalledEntry| 3)
  (:type 'object-type)
  (:syntax '|ProductID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The product ID of this installed piece of software."))

(defoid |hrSWInstalledType| (|hrSWInstalledEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The type of this software."))

(defoid |hrSWInstalledDate| (|hrSWInstalledEntry| 5)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The last-modification date of this application as it
        would appear in a directory listing.

        If this information is not known, then this variable
        shall have the value corresponding to January 1, year
        0000, 00:00:00.0, which is encoded as
        (hex)'00 00 01 01 00 00 00 00'."))

(defoid |hrMIBCompliances| (|hrMIBAdminInfo| 2)
  (:type 'object-identity))

(defoid |hrMIBGroups| (|hrMIBAdminInfo| 3) (:type 'object-identity))

(defoid |hrMIBCompliance| (|hrMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The requirements for conformance to the Host Resources MIB."))

(defoid |hrSystemGroup| (|hrMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "The Host Resources System Group."))

(defoid |hrStorageGroup| (|hrMIBGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description "The Host Resources Storage Group."))

(defoid |hrDeviceGroup| (|hrMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description "The Host Resources Device Group."))

(defoid |hrSWRunGroup| (|hrMIBGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description "The Host Resources Running Software Group."))

(defoid |hrSWRunPerfGroup| (|hrMIBGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The Host Resources Running Software
            Performance Group."))

(defoid |hrSWInstalledGroup| (|hrMIBGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description "The Host Resources Installed Software Group."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

