;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-SYSTEM-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-system-mib))

(defpackage :asn.1/vmware-system-mib
  (:nicknames :vmware-system-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/vmware-root-mib |vmwSystem|))

(in-package :vmware-system-mib)

(defoid |vmwSystemMIB| (|vmwSystem| 10)
  (:type 'module-identity)
  (:description
   "This MIB module provides for System Software identification"))

(defoid |vmwProdName| (|vmwSystem| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This product's name.
         VIM Property: AboutInfo.name
         https://esx.example.com/mob/?moid=ServiceInstance&doPath=content%2eabout"))

(defoid |vmwProdVersion| (|vmwSystem| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The product's version release identifier. Format is Major.Minor.Update
         VIM Property: AboutInfo.version
         https://esx.example.com/mob/?moid=ServiceInstance&doPath=content%2eabout"))

(defoid |vmwProdBuild| (|vmwSystem| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This identifier represents the most specific identifier.
         VIM Property: AboutInfo.build
         https://esx.example.com/mob/?moid=ServiceInstance&doPath=content%2eabout"))

(defoid |vmwSystemMIBConformance| (|vmwSystemMIB| 2)
  (:type 'object-identity))

(defoid |vmwSystemMIBCompliances| (|vmwSystemMIBConformance| 1)
  (:type 'object-identity))

(defoid |vmwSysMIBGroups| (|vmwSystemMIBConformance| 2)
  (:type 'object-identity))

(defoid |vmwSysMIBBasicCompliance| (|vmwSystemMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement the 
    VMWARE-SYSTEM-MIB."))

(defoid |vmwSystemGroup| (|vmwSysMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects uniquely identifies a given VMware system software image."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-system-mib *mib-modules*)
  (setf *current-module* nil))

