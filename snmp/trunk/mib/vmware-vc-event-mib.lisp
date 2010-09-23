;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-VC-EVENT-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-vc-event-mib))

(defpackage :asn.1/vmware-vc-event-mib
  (:nicknames :vmware-vc-event-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                notification-type)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :asn.1/vmware-products-mib |vmwVC|)
  (:import-from :asn.1/vmware-tc-mib |VmwLongSnmpAdminString|))

(in-package :vmware-vc-event-mib)

(defoid |vmwVCMIB| (|vmwVC| 1)
  (:type 'module-identity)
  (:description
   "This MIB module identifies vCenter Trap notifications (traps or inform)."))

(defoid |vmwVCNotifications| (|vmwVC| 0) (:type 'object-identity))

(defoid |vpxdAlarm| (|vmwVCNotifications| 201)
  (:type 'notification-type)
  (:status '|obsolete|)
  (:description
   "This notification is sent on entity alarm state change, by the vCenter Server SNMP agent.
         This information is also available through the vSphere client, through the Alarms screen,
         or through the Managed Object Browser(MOB) interface for alarms at
         https://<vCenter Server machine address>/mob/?moid=AlarmManager.
         Listing individual objects of a specific type or ID can be done through the PropertyCollector SDK API.
         See http://www.vmware.com/support/developer/vc-sdk/visdk2xpubs/ReferenceGuide/vmodl.query.PropertyCollector.html
         for details."))

(defoid |vpxdDiagnostic| (|vmwVCNotifications| 202)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification is sent on starting or restarting vCenter Server,
         on requesting a test notification explicitly, and can also be
         configured to be sent periodically at a specified time interval via
         vCenter Server configuration by the vCenter Server SNMP agent."))

(defoid |vpxdAlarmInfo| (|vmwVCNotifications| 203)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification is sent on entity alarm state change, by the vCenter Server SNMP agent.
         This information is also available through the vSphere client, through the Alarms screen,
         or through the Managed Object Browser(MOB) interface for alarms at
         https://<vCenter Server machine address>/mob/?moid=AlarmManager.
         Listing individual objects of a specific type or ID can be done through the PropertyCollector SDK API.
         See http://www.vmware.com/support/developer/vc-sdk/visdk2xpubs/ReferenceGuide/vmodl.query.PropertyCollector.html
         for details."))

(defoid |vmwVpxdTrapType| (|vmwVC| 301)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|obsolete|)
  (:description "This is the alarm notification type."))

(defoid |vmwVpxdHostName| (|vmwVC| 302)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|obsolete|)
  (:description
   "This is the name of the vSphere host in the notification."))

(defoid |vmwVpxdVMName| (|vmwVC| 303)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|obsolete|)
  (:description "This is the name of the VM in the notification."))

(defoid |vmwVpxdOldStatus| (|vmwVC| 304)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description "This is the old status in the notification."))

(defoid |vmwVpxdNewStatus| (|vmwVC| 305)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description "This is the new status in the notification."))

(defoid |vmwVpxdObjValue| (|vmwVC| 306)
  (:type 'object-type)
  (:syntax '|VmwLongSnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "This is the current object value in the notification."))

(defoid |vmwVpxdTargetObj| (|vmwVC| 307)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "This is the current object in the notification. This may be
	one of esx host name, vm name, or other. This value must not be empty."))

(defoid |vmwVpxdTargetObjType| (|vmwVC| 308)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description "This is the alarm target object type."))

(defoid |vmwVCMIBConformance| (|vmwVCMIB| 2) (:type 'object-identity))

(defoid |vmwVCMIBCompliances| (|vmwVCMIBConformance| 1)
  (:type 'object-identity))

(defoid |vmwVCMIBGroups| (|vmwVCMIBConformance| 2)
  (:type 'object-identity))

(defoid |vmwVCMIBBasicCompliance| (|vmwVCMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|obsolete|)
  (:description
   "The compliance statement for entities which implement VMWARE-VC-EVENT-MIB."))

(defoid |vmwVCMIBBasicComplianceRev2| (|vmwVCMIBCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement VMWARE-VC-EVENT-MIB."))

(defoid |vmwVCAlarmInfoGroup| (|vmwVCMIBGroups| 1)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description "These objects provide alarm notification details."))

(defoid |vmwVCNotificationGroup| (|vmwVCMIBGroups| 2)
  (:type 'notification-group)
  (:status '|obsolete|)
  (:description "Group of objects describing notifications (traps)."))

(defoid |vmwVCAlarmGroup| (|vmwVCMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects provide alarm notification details."))

(defoid |vmwVCAlarmNotificationGroup| (|vmwVCMIBGroups| 4)
  (:type 'notification-group)
  (:status '|current|)
  (:description "Group of objects describing notifications (traps)."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-vc-event-mib *mib-modules*)
  (setf *current-module* nil))

