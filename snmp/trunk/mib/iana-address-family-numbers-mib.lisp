;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANA-ADDRESS-FAMILY-NUMBERS-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'iana-address-family-numbers-mib))

(defpackage :asn.1/iana-address-family-numbers-mib
  (:nicknames :iana-address-family-numbers-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :iana-address-family-numbers-mib)

(defoid |ianaAddressFamilyNumbers| (|mib-2| 72)
  (:type 'module-identity)
  (:description
   "The MIB module defines the AddressFamilyNumbers
          textual convention."))

(deftype |AddressFamilyNumbers| () 't)

(eval-when (:load-toplevel :execute)
  (pushnew 'iana-address-family-numbers-mib *mib-modules*)
  (setf *current-module* nil))

