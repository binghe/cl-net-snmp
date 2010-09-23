;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-AGENTCAP-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-agentcap-mib))

(defpackage :asn.1/vmware-agentcap-mib
  (:nicknames :vmware-agentcap-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity)
  (:import-from :asn.1/vmware-root-mib |vmwareAgentCapabilities|)
  (:import-from :|ASN.1/SNMPv2-CONF| agent-capabilities))

(in-package :vmware-agentcap-mib)

(defoid |vmwAgentCapabilityMIB| (|vmwareAgentCapabilities| 1)
  (:type 'module-identity)
  (:description
   "This module defines agent capabilities for VMware agents."))

(defoid |vmwEsxCapability| (|vmwAgentCapabilityMIB| 1)
  (:type 'object-identity))

(defoid |vmwESX41x| (|vmwEsxCapability| 2)
  (:type 'agent-capabilities)
  (:status '|current|)
  (:description "Release 4.1.x for VMware ESX")
  (:reference "http://www.vmware.com/products")
  (:syntax 't))

(defoid |vmwESX40x| (|vmwEsxCapability| 1)
  (:type 'agent-capabilities)
  (:status '|current|)
  (:description "Release 4.0.x for VMware ESX")
  (:reference "http://www.vmware.com/products")
  (:syntax 't)
  (:syntax 't))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-agentcap-mib *mib-modules*)
  (setf *current-module* nil))

