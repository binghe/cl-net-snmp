;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-PRODUCTS-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-products-mib))

(defpackage :asn.1/vmware-products-mib
  (:nicknames :vmware-products-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity)
  (:import-from :asn.1/vmware-root-mib |vmwOID| |vmwProductSpecific|))

(in-package :vmware-products-mib)

(defoid |vmwProducts| (|vmwProductSpecific| 11)
  (:type 'module-identity)
  (:description
   "This MIB module provides the OID identifiers
                which are returned from SNMPv2-MIB sysObjectId for 
                agents in specific VMware products.
               "))

(defoid |vmwESX| (|vmwProductSpecific| 1) (:type 'object-identity))

(defoid |vmwDVS| (|vmwProductSpecific| 2) (:type 'object-identity))

(defoid |vmwVC| (|vmwProductSpecific| 3) (:type 'object-identity))

(defoid |vmwServer| (|vmwProductSpecific| 4) (:type 'object-identity))

(defoid |oidESX| (|vmwOID| 1) (:type 'object-identity))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-products-mib *mib-modules*)
  (setf *current-module* nil))

