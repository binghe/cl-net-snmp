;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;UCD-DISKIO-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ucd-diskio-mib))

(defpackage :asn.1/ucd-diskio-mib
  (:nicknames :ucd-diskio-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Counter32| |Counter64|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :asn.1/ucd-snmp-mib |ucdExperimental|))

(in-package :ucd-diskio-mib)

(defoid |ucdDiskIOMIB| (|ucdExperimental| 15)
  (:type 'module-identity)
  (:description
   "This MIB module defines objects for disk IO statistics."))

(defoid |diskIOTable| (|ucdDiskIOMIB| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Table of IO devices and how much data they have read/written."))

(defoid |diskIOEntry| (|diskIOTable| 1)
  (:type 'object-type)
  (:syntax '|DiskIOEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a device and its statistics."))

(defclass |DiskIOEntry|
          (asn.1-type)
          ((|diskIOIndex| :type |Integer32|)
           (|diskIODevice| :type |DisplayString|)
           (|diskIONRead| :type |Counter32|)
           (|diskIONWritten| :type |Counter32|)
           (|diskIOReads| :type |Counter32|)
           (|diskIOWrites| :type |Counter32|)
           (|diskIONReadX| :type |Counter64|)
           (|diskIONWrittenX| :type |Counter64|)))

(defoid |diskIOIndex| (|diskIOEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference index for each observed device."))

(defoid |diskIODevice| (|diskIOEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the device we are counting/checking."))

(defoid |diskIONRead| (|diskIOEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bytes read from this device since boot."))

(defoid |diskIONWritten| (|diskIOEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bytes written to this device since boot."))

(defoid |diskIOReads| (|diskIOEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of read accesses from this device since boot."))

(defoid |diskIOWrites| (|diskIOEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of write accesses to this device since boot."))

(defoid |diskIOLA1| (|diskIOEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The 1 minute average load of disk (%)"))

(defoid |diskIOLA5| (|diskIOEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The 5 minute average load of disk (%)"))

(defoid |diskIOLA15| (|diskIOEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The 15 minute average load of disk (%)"))

(defoid |diskIONReadX| (|diskIOEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bytes read from this device since boot."))

(defoid |diskIONWrittenX| (|diskIOEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bytes written to this device since boot."))

(eval-when (:load-toplevel :execute)
  (pushnew 'ucd-diskio-mib *mib-modules*)
  (setf *current-module* nil))

