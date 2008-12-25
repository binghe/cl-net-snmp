;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMPV2-SMI.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|SNMPv2-SMI| *mib-modules*)
  (setf *current-module* '|SNMPv2-SMI|))

(defpackage :|ASN.1/SNMPv2-SMI|
  (:nicknames :|SNMPv2-SMI|)
  (:use :common-lisp :asn.1))

(in-package :|SNMPv2-SMI|)

(defoid |org| (|iso| 3) (:type 'object-identity))

(defoid |dod| (|org| 6) (:type 'object-identity))

(defoid |internet| (|dod| 1) (:type 'object-identity))

(defoid |directory| (|internet| 1) (:type 'object-identity))

(defoid |mgmt| (|internet| 2) (:type 'object-identity))

(defoid |mib-2| (|mgmt| 1) (:type 'object-identity))

(defoid |transmission| (|mib-2| 10) (:type 'object-identity))

(defoid |experimental| (|internet| 3) (:type 'object-identity))

(defoid |private| (|internet| 4) (:type 'object-identity))

(defoid |enterprises| (|private| 1) (:type 'object-identity))

(defoid |security| (|internet| 5) (:type 'object-identity))

(defoid |snmpV2| (|internet| 6) (:type 'object-identity))

(defoid |snmpDomains| (|snmpV2| 1) (:type 'object-identity))

(defoid |snmpProxys| (|snmpV2| 2) (:type 'object-identity))

(defoid |snmpModules| (|snmpV2| 3) (:type 'object-identity))

(deftype |ExtUTCTime| () 't)

(defmacro module-identity ())

(defmacro object-identity ())

(deftype |ObjectName| () 'object-id)

(deftype |NotificationName| () 'object-id)

(deftype |ObjectSyntax| () 't)

(deftype |SimpleSyntax| () 't)

(deftype |Integer32| () 't)

(deftype |ApplicationSyntax| () 't)

(deftype |IpAddress| () 't)

(deftype |Counter32| () 't)

(deftype |Gauge32| () 't)

(deftype |Unsigned32| () 't)

(deftype |TimeTicks| () 't)

(deftype |Opaque| () 't)

(deftype |Counter64| () 't)

(defmacro object-type ())

(defmacro notification-type ())

(defoid |zeroDotZero| (|zero| 0)
  (:type 'object-identity)
  (:status '|current|)
  (:description "A value used for null identifiers."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

