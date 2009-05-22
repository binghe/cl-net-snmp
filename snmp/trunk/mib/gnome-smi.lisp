;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;GNOME-SMI.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'gnome-smi))

(defpackage :asn.1/gnome-smi
  (:nicknames :gnome-smi)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |enterprises|))

(in-package :gnome-smi)

(defoid |gnome| (|enterprises| 3319)
  (:type 'module-identity)
  (:description "The Structure of GNOME."))

(defoid |gnomeProducts| (|gnome| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "gnomeProducts is the root OBJECT IDENTIFIER from
		which sysObjectID values are assigned."))

(defoid |gnomeMgmt| (|gnome| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "gnomeMgmt defines the subtree for production GNOME related
		MIB registrations."))

(defoid |gnomeTest| (|gnome| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "gnomeTest defines the subtree for testing GNOME related
		MIB registrations."))

(defoid |gnomeSysadmin| (|gnome| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "gnomeSysadmin defines the subtree for GNOME related Sysadmin
		MIB registrations."))

(defoid |gnomeLDAP| (|gnome| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "gnomeLDAP defines the subtree for GNOME related LDAP
		registrations."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'gnome-smi *mib-modules*)
  (setf *current-module* nil))

