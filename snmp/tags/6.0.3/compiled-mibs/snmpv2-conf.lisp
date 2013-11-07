;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:IETF;SNMPV2-CONF by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|SNMPv2-CONF|))

(defpackage :|ASN.1/SNMPv2-CONF|
  (:nicknames :|SNMPv2-CONF|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |ObjectName| |NotificationName|
                |ObjectSyntax|))

(in-package :|SNMPv2-CONF|)

(defmacro object-group ())

(defmacro notification-group ())

(defmacro module-compliance ())

(defmacro agent-capabilities ())

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|SNMPv2-CONF| *mib-modules*)
  (setf *current-module* nil))

