;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;LM-SENSORS-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'lm-sensors-mib))

(defpackage :asn.1/lm-sensors-mib
  (:nicknames :lm-sensors-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Gauge32|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :asn.1/ucd-snmp-mib |ucdExperimental|))

(in-package :lm-sensors-mib)

(defoid |lmSensors| (|ucdExperimental| 16) (:type 'object-identity))

(defoid |lmSensorsMIB| (|lmSensors| 1)
  (:type 'module-identity)
  (:description
   "This MIB module defines objects for lm_sensor derived data."))

(defoid |lmTempSensorsTable| (|lmSensors| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Table of temperature sensors and their values."))

(defoid |lmTempSensorsEntry| (|lmTempSensorsTable| 1)
  (:type 'object-type)
  (:syntax '|LMTempSensorsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a device and its statistics."))

(defclass |LMTempSensorsEntry| (sequence-type)
  ((|lmTempSensorsIndex| :type |Integer32|)
   (|lmTempSensorsDevice| :type |DisplayString|)
   (|lmTempSensorsValue| :type |Gauge32|)))

(defoid |lmTempSensorsIndex| (|lmTempSensorsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference index for each observed device."))

(defoid |lmTempSensorsDevice| (|lmTempSensorsEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the temperature sensor we are reading."))

(defoid |lmTempSensorsValue| (|lmTempSensorsEntry| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The temperature of this sensor in mC."))

(defoid |lmFanSensorsTable| (|lmSensors| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Table of fan sensors and their values."))

(defoid |lmFanSensorsEntry| (|lmFanSensorsTable| 1)
  (:type 'object-type)
  (:syntax '|LMFanSensorsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a device and its statistics."))

(defclass |LMFanSensorsEntry| (sequence-type)
  ((|lmFanSensorsIndex| :type |Integer32|)
   (|lmFanSensorsDevice| :type |DisplayString|)
   (|lmFanSensorsValue| :type |Gauge32|)))

(defoid |lmFanSensorsIndex| (|lmFanSensorsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference index for each observed device."))

(defoid |lmFanSensorsDevice| (|lmFanSensorsEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the fan sensor we are reading."))

(defoid |lmFanSensorsValue| (|lmFanSensorsEntry| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The rotation speed of the fan in RPM."))

(defoid |lmVoltSensorsTable| (|lmSensors| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Table of voltage sensors and their values."))

(defoid |lmVoltSensorsEntry| (|lmVoltSensorsTable| 1)
  (:type 'object-type)
  (:syntax '|LMVoltSensorsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a device and its statistics."))

(defclass |LMVoltSensorsEntry| (sequence-type)
  ((|lmVoltSensorsIndex| :type |Integer32|)
   (|lmVoltSensorsDevice| :type |DisplayString|)
   (|lmVoltSensorsValue| :type |Gauge32|)))

(defoid |lmVoltSensorsIndex| (|lmVoltSensorsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference index for each observed device."))

(defoid |lmVoltSensorsDevice| (|lmVoltSensorsEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the device we are reading."))

(defoid |lmVoltSensorsValue| (|lmVoltSensorsEntry| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The voltage in mV."))

(defoid |lmMiscSensorsTable| (|lmSensors| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Table of miscellaneous sensor devices and their values."))

(defoid |lmMiscSensorsEntry| (|lmMiscSensorsTable| 1)
  (:type 'object-type)
  (:syntax '|LMMiscSensorsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a device and its statistics."))

(defclass |LMMiscSensorsEntry| (sequence-type)
  ((|lmMiscSensorsIndex| :type |Integer32|)
   (|lmMiscSensorsDevice| :type |DisplayString|)
   (|lmMiscSensorsValue| :type |Gauge32|)))

(defoid |lmMiscSensorsIndex| (|lmMiscSensorsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference index for each observed device."))

(defoid |lmMiscSensorsDevice| (|lmMiscSensorsEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the device we are reading."))

(defoid |lmMiscSensorsValue| (|lmMiscSensorsEntry| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value of this sensor."))

(eval-when (:load-toplevel :execute)
  (pushnew 'lm-sensors-mib *mib-modules*)
  (setf *current-module* nil))

