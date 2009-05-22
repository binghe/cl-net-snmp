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

(define-textual-convention |Ipv6Address|
                           octet-string
                           (:display-hint "2x:")
                           (:status '|current|)
                           (:description
                            "This data type is used to model IPv6 addresses.
        This is a binary string of 16 octets in network
        byte-order."))

(define-textual-convention |Ipv6AddressPrefix|
                           octet-string
                           (:display-hint "2x:")
                           (:status '|current|)
                           (:description
                            "This data type is used to model IPv6 address
       prefixes. This is a binary string of up to 16
       octets in network byte-order."))

(define-textual-convention |Ipv6AddressIfIdentifier|
                           octet-string
                           (:display-hint "2x:")
                           (:status '|current|)
                           (:description
                            "This data type is used to model IPv6 address
       interface identifiers. This is a binary string
        of up to 8 octets in network byte-order."))

(define-textual-convention |Ipv6IfIndex|
                           t
                           (:display-hint "d")
                           (:status '|current|)
                           (:description
                            "A unique value, greater than zero for each
       internetwork-layer interface in the managed
       system. It is recommended that values are assigned
       contiguously starting from 1. The value for each
       internetwork-layer interface must remain constant
       at least from one re-initialization of the entity's
       network management system to the next

       re-initialization."))

(define-textual-convention |Ipv6IfIndexOrZero|
                           t
                           (:display-hint "d")
                           (:status '|current|)
                           (:description
                            "This textual convention is an extension of the
         Ipv6IfIndex convention.  The latter defines
         a greater than zero value used to identify an IPv6
         interface in the managed system.  This extension
         permits the additional value of zero.  The value
         zero is object-specific and must therefore be
         defined as part of the description of any object
         which uses this syntax.  Examples of the usage of
         zero might include situations where interface was
         unknown, or when none or all interfaces need to be
         referenced."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-tc *mib-modules*)
  (setf *current-module* nil))

