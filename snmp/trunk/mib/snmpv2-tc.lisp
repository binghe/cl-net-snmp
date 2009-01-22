;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMPV2-TC.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|SNMPv2-TC|))

(defpackage :|ASN.1/SNMPv2-TC|
  (:nicknames :|SNMPv2-TC|)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |TimeTicks|))

(in-package :|SNMPv2-TC|)

(defmacro textual-convention ())

(deftype |DisplayString| () 't)

(deftype |PhysAddress| () 't)

(deftype |MacAddress| () 't)

(deftype |TruthValue| () 't)

(deftype |TestAndIncr| () 't)

(deftype |AutonomousType| () 't)

(deftype |InstancePointer| () 't)

(deftype |VariablePointer| () 't)

(deftype |RowPointer| () 't)

(deftype |RowStatus| () 't)

(deftype |TimeStamp| () 't)

(deftype |TimeInterval| () 't)

(deftype |DateAndTime| () 't)

(deftype |StorageType| () 't)

(deftype |TDomain| () 't)

(deftype |TAddress| () 't)

(eval-when (:load-toplevel :execute)
  (pushnew '|SNMPv2-TC| *mib-modules*)
  (setf *current-module* nil))

