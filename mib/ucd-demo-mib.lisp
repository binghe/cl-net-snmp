;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;UCD-DEMO-MIB.TXT by ASN.1 5.0

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'ucd-demo-mib *mib-modules*)
  (setf *current-module* 'ucd-demo-mib))
(defpackage :asn.1/ucd-demo-mib
  (:nicknames :ucd-demo-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32|)
  (:import-from :asn.1/ucd-snmp-mib |ucdavis|))
(in-package :ucd-demo-mib)
(defoid |ucdDemoMIB| (|ucdavis| 14)
  (:type 'module-identity)
  (:description "The UCD-SNMP Demonstration MIB."))
(defoid |ucdDemoMIBObjects| (|ucdDemoMIB| 1) (:type 'object-identity))
(defoid |ucdDemoPublic| (|ucdDemoMIBObjects| 1)
  (:type 'object-identity))
(defoid |ucdDemoResetKeys| (|ucdDemoPublic| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A set of value 1 to this object resets the
	 demonstration user's auth and priv keys to the
	 keys based on the P->Ku->Kul transformation of the
	 value of the ucdDemoPasspharse object.

	 Values other than 1 are ignored."))
(defoid |ucdDemoPublicString| (|ucdDemoPublic| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A publicly settable string that can be set for testing 
	 snmpsets.  This value has no real usage other than
	 testing purposes."))
(defoid |ucdDemoUserList| (|ucdDemoPublic| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The list of users affected by the ucdDemoResetKeys object."))
(defoid |ucdDemoPassphrase| (|ucdDemoPublic| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The demo passphrase that ucdDemoResetKeys changes each 
	 users localized key to based on the P->Ku->Kul transformation."))
(eval-when (:load-toplevel :execute) (setf *current-module* nil))
