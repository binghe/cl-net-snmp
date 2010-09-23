;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-ROOT-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-root-mib))

(defpackage :asn.1/vmware-root-mib
  (:nicknames :vmware-root-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |enterprises|))

(in-package :vmware-root-mib)

(defoid |vmware| (|enterprises| 6876)
  (:type 'module-identity)
  (:description
   "VMware managed object root assignements
                This module defines the VMware SNMP MIB root
                and its primary subtrees.
               "))

(defoid |vmwNotifications| (|vmware| 0)
  (:type 'object-identity)
  (:status '|current|)
  (:description "Parent of all notifications (traps, informs)."))

(defoid |vmwSystem| (|vmware| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Parent of all managed objects relating to system software identification."))

(defoid |vmwVirtMachines| (|vmware| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Parent of all managed objects relating to virtual machine inventory."))

(defoid |vmwResources| (|vmware| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Parent of all managed objects relating to resource utilization."))

(defoid |vmwProductSpecific| (|vmware| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "parent of objects specific to a given hardware/software product."))

(defoid |vmwLdap| (|vmware| 40)
  (:type 'object-identity)
  (:status '|current|)
  (:description "VMware specific LDAP schema definitions."))

(defoid |vmwTraps| (|vmware| 50)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Managed objects defined under this node are only visible in
     notifications varbind lists and can not be polled."))

(defoid |vmwOID| (|vmware| 60)
  (:type 'object-identity)
  (:status '|deprecated|)
  (:description "Assignments under this are no longer made."))

(defoid |vmwareAgentCapabilities| (|vmware| 70)
  (:type 'object-identity)
  (:status '|current|)
  (:description "All agent capabilities defnitions occur under this."))

(defoid |vmwExperimental| (|vmware| 700)
  (:type 'object-identity)
  (:status '|current|)
  (:description "Used for product testing and development."))

(defoid |vmwObsolete| (|vmware| 800)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Conformance, meta SMI oids for Obsolete smi assignements done under this arc."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-root-mib *mib-modules*)
  (setf *current-module* nil))

