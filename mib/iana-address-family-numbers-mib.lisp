;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:IANA-ADDRESS-FAMILY-NUMBERS-MIB

(in-package :asn.1)
(setf *current-module* 'iana-address-family-numbers-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'iana-address-family-numbers-mib *mib-modules*))
(defoid |ianaAddressFamilyNumbers| (|mib-2| 72)
  (:type 'module-identity)
  (:description
   "The MIB module defines the AddressFamilyNumbers
          textual convention."))
(deftype |AddressFamilyNumbers| () 't)
