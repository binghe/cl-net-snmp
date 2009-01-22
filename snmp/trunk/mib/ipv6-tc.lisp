;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-TC.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'ipv6-tc))

(defpackage :asn.1/ipv6-tc
  (:nicknames :ipv6-tc)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :ipv6-tc)

(deftype |Ipv6Address| () 't)

(deftype |Ipv6AddressPrefix| () 't)

(deftype |Ipv6AddressIfIdentifier| () 't)

(deftype |Ipv6IfIndex| () 't)

(deftype |Ipv6IfIndexOrZero| () 't)

(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-tc *mib-modules*)
  (setf *current-module* nil))

