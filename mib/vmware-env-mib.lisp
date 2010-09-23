;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-ENV-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-env-mib))

(defpackage :asn.1/vmware-env-mib
  (:nicknames :vmware-env-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |Integer32| notification-type
                object-type |TimeTicks| module-identity
                object-identity)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :asn.1/vmware-root-mib |vmwProductSpecific|
                |vmwNotifications|)
  (:import-from :asn.1/vmware-products-mib |vmwESX|)
  (:import-from :asn.1/vmware-tc-mib |VmwSubsystemStatus|
                |VmwSubsystemTypes|))

(in-package :vmware-env-mib)

(defoid |vmwEnv| (|vmwProductSpecific| 20) (:type 'object-identity))

(defoid |vmwEnvironmentalMIB| (|vmwEnv| 10)
  (:type 'module-identity)
  (:description
   "This MIB module identifies hardware components of a machine as provided by IPMI."))

(defoid |vmwESXNotifications| (|vmwESX| 0)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Parent of all ESX specific notifications (traps, informs)."))

(defoid |vmwEnvNumber| (|vmwEnv| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Count of number of conceptual rows in vmwEnvTable"))

(defoid |vmwEnvLastChange| (|vmwEnv| 2)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUptime when a conceptual row was added
         or deleted from this table"))

(defoid |vmwEnvTable| (|vmwEnv| 3)
  (:type 'object-type)
  (:syntax '(vector |VmwEnvEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is populated from monitoring subsystems such as IPMI
         One conceptual row is maintained for each reporting component.
         Conceptual rows are not persistent across device resets"))

(defoid |vmwEnvEntry| (|vmwEnvTable| 1)
  (:type 'object-type)
  (:syntax '|VmwEnvEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "One entry for each physical component reporting its
         status to ESX Operating System"))

(defclass |VmwEnvEntry|
          (sequence-type)
          ((|vmwEnvIndex| :type |Integer32|)
           (|vmwSubsystemType| :type |VmwSubsystemTypes|)
           (|vmwHardwareStatus| :type |VmwSubsystemStatus|)
           (|vmwEventDescription| :type |DisplayString|)
           (|vmwEnvHardwareTime| :type |TimeTicks|)))

(defoid |vmwEnvIndex| (|vmwEnvEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A unique identifier that does not persist across management restarts"))

(defoid |vmwSubsystemType| (|vmwEnvEntry| 2)
  (:type 'object-type)
  (:syntax '|VmwSubsystemTypes|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Hardware component reporting environmental state"))

(defoid |vmwHardwareStatus| (|vmwEnvEntry| 3)
  (:type 'object-type)
  (:syntax '|VmwSubsystemStatus|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Last reported state of this component"))

(defoid |vmwEventDescription| (|vmwEnvEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Human readable description of this event"))

(defoid |vmwEnvHardwareTime| (|vmwEnvEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Value of sysUptime when vmwHardwareStatus was obtained"))

(defoid |vmwEnvHardwareEvent| (|vmwNotifications| 301)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification, if the agent is so configured, may be sent when the
         system has detected a material change in physical condition of the
         hardware"))

(defoid |vmwESXEnvHardwareEvent| (|vmwESXNotifications| 301)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "ESX Specific version of this notification, 
         if the agent is so configured, may be sent when 
         the ESX Operating System has detected a material change in 
         physical condition of the hardware"))

(defoid |vmwEnvironmentalMIBConformance| (|vmwEnvironmentalMIB| 2)
  (:type 'object-identity))

(defoid |vmwEnvironmentMIBCompliances|
        (|vmwEnvironmentalMIBConformance| 1)
  (:type 'object-identity))

(defoid |vmwEnvMIBGroups| (|vmwEnvironmentalMIBConformance| 2)
  (:type 'object-identity))

(defoid |vmwEnvMIBBasicCompliance2| (|vmwEnvironmentMIBCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement the 
    VMWARE-RESOURCE-MIB."))

(defoid |vmwEnvMIBBasicCompliance| (|vmwEnvironmentMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|obsolete|)
  (:description
   "The compliance statement for entities which implement the 
    VMWARE-RESOURCE-MIB."))

(defoid |vmwEnvironmentGroup| (|vmwEnvMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects provide physical hardware environmental details."))

(defoid |vmwEnvNotificationGroup| (|vmwEnvMIBGroups| 2)
  (:type 'notification-group)
  (:status '|current|)
  (:description "Notifications related to physical subsystems."))

(defoid |vmwESXEnvNotificationGroup| (|vmwEnvMIBGroups| 3)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "ESX System specific notifications about physical subsystems."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-env-mib *mib-modules*)
  (setf *current-module* nil))

