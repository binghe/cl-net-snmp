;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:BASE;HOST-RESOURCES-TYPES.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'host-resources-types))

(defpackage :asn.1/host-resources-types
  (:nicknames :host-resources-types)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity)
  (:import-from :asn.1/host-resources-mib |hrMIBAdminInfo| |hrStorage|
                |hrDevice|))

(in-package :host-resources-types)

(defoid |hostResourcesTypesModule| (|hrMIBAdminInfo| 4)
  (:type 'module-identity)
  (:description
   "This MIB module registers type definitions for
      storage types, device types, and file system types.

      After the initial revision, this module will be
      maintained by IANA."))

(defoid |hrStorageTypes| (|hrStorage| 1) (:type 'object-identity))

(defoid |hrStorageOther| (|hrStorageTypes| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used when no other defined
        type is appropriate."))

(defoid |hrStorageRam| (|hrStorageTypes| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The storage type identifier used for RAM."))

(defoid |hrStorageVirtualMemory| (|hrStorageTypes| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for virtual memory,
        temporary storage of swapped or paged memory."))

(defoid |hrStorageFixedDisk| (|hrStorageTypes| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for non-removable
        rigid rotating magnetic storage devices."))

(defoid |hrStorageRemovableDisk| (|hrStorageTypes| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for removable rigid
        rotating magnetic storage devices."))

(defoid |hrStorageFloppyDisk| (|hrStorageTypes| 6)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for non-rigid rotating
        magnetic storage devices."))

(defoid |hrStorageCompactDisc| (|hrStorageTypes| 7)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for read-only rotating
        optical storage devices."))

(defoid |hrStorageRamDisk| (|hrStorageTypes| 8)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for a file system that
        is stored in RAM."))

(defoid |hrStorageFlashMemory| (|hrStorageTypes| 9)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The storage type identifier used for flash memory."))

(defoid |hrStorageNetworkDisk| (|hrStorageTypes| 10)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The storage type identifier used for a
        networked file system."))

(defoid |hrDeviceTypes| (|hrDevice| 1) (:type 'object-identity))

(defoid |hrDeviceOther| (|hrDeviceTypes| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used when no other defined
        type is appropriate."))

(defoid |hrDeviceUnknown| (|hrDeviceTypes| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used when the device type is
        unknown."))

(defoid |hrDeviceProcessor| (|hrDeviceTypes| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a CPU."))

(defoid |hrDeviceNetwork| (|hrDeviceTypes| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used for a network interface."))

(defoid |hrDevicePrinter| (|hrDeviceTypes| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a printer."))

(defoid |hrDeviceDiskStorage| (|hrDeviceTypes| 6)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a disk drive."))

(defoid |hrDeviceVideo| (|hrDeviceTypes| 10)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a video device."))

(defoid |hrDeviceAudio| (|hrDeviceTypes| 11)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for an audio device."))

(defoid |hrDeviceCoprocessor| (|hrDeviceTypes| 12)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a co-processor."))

(defoid |hrDeviceKeyboard| (|hrDeviceTypes| 13)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used for a keyboard device."))

(defoid |hrDeviceModem| (|hrDeviceTypes| 14)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a modem."))

(defoid |hrDeviceParallelPort| (|hrDeviceTypes| 15)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a parallel port."))

(defoid |hrDevicePointing| (|hrDeviceTypes| 16)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used for a pointing device
        (e.g., a mouse)."))

(defoid |hrDeviceSerialPort| (|hrDeviceTypes| 17)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a serial port."))

(defoid |hrDeviceTape| (|hrDeviceTypes| 18)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used for a tape storage device."))

(defoid |hrDeviceClock| (|hrDeviceTypes| 19)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The device type identifier used for a clock device."))

(defoid |hrDeviceVolatileMemory| (|hrDeviceTypes| 20)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used for a volatile memory
        storage device."))

(defoid |hrDeviceNonVolatileMemory| (|hrDeviceTypes| 21)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The device type identifier used for a non-volatile memory

        storage device."))

(defoid |hrFSTypes| (|hrDevice| 9) (:type 'object-identity))

(defoid |hrFSOther| (|hrFSTypes| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used when no other
        defined type is appropriate."))

(defoid |hrFSUnknown| (|hrFSTypes| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used when the type of
        file system is unknown."))

(defoid |hrFSBerkeleyFFS| (|hrFSTypes| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Berkeley Fast File System."))

(defoid |hrFSSys5FS| (|hrFSTypes| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        System V File System."))

(defoid |hrFSFat| (|hrFSTypes| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for
        DOS's FAT file system."))

(defoid |hrFSHPFS| (|hrFSTypes| 6)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for OS/2's
        High Performance File System."))

(defoid |hrFSHFS| (|hrFSTypes| 7)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Macintosh Hierarchical File System."))

(defoid |hrFSMFS| (|hrFSTypes| 8)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Macintosh File System."))

(defoid |hrFSNTFS| (|hrFSTypes| 9)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Windows NT File System."))

(defoid |hrFSVNode| (|hrFSTypes| 10)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        VNode File System."))

(defoid |hrFSJournaled| (|hrFSTypes| 11)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Journaled File System."))

(defoid |hrFSiso9660| (|hrFSTypes| 12)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        ISO 9660 File System for CD's."))

(defoid |hrFSRockRidge| (|hrFSTypes| 13)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        RockRidge File System for CD's."))

(defoid |hrFSNFS| (|hrFSTypes| 14)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        NFS File System."))

(defoid |hrFSNetware| (|hrFSTypes| 15)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Netware File System."))

(defoid |hrFSAFS| (|hrFSTypes| 16)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Andrew File System."))

(defoid |hrFSDFS| (|hrFSTypes| 17)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        OSF DCE Distributed File System."))

(defoid |hrFSAppleshare| (|hrFSTypes| 18)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        AppleShare File System."))

(defoid |hrFSRFS| (|hrFSTypes| 19)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        RFS File System."))

(defoid |hrFSDGCFS| (|hrFSTypes| 20)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Data General DGCFS."))

(defoid |hrFSBFS| (|hrFSTypes| 21)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        SVR4 Boot File System."))

(defoid |hrFSFAT32| (|hrFSTypes| 22)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Windows FAT32 File System."))

(defoid |hrFSLinuxExt2| (|hrFSTypes| 23)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The file system type identifier used for the
        Linux EXT2 File System."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'host-resources-types *mib-modules*)
  (setf *current-module* nil))

