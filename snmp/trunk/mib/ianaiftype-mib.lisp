;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANAIFTYPE-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|IANAifType-MIB|))

(defpackage :|ASN.1/IANAifType-MIB|
  (:nicknames :|IANAifType-MIB|)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :|IANAifType-MIB|)

(defoid |ianaifType| (|mib-2| 30)
  (:type 'module-identity)
  (:description
   "This MIB module defines the IANAifType Textual
                     Convention, and thus the enumerated values of
                     the ifType object defined in MIB-II's ifTable."))

(define-textual-convention |IANAifType|
                           t
                           (:status '|current|)
                           (:description
                            "This data type is used as the syntax of the ifType
               object in the (updated) definition of MIB-II's
               ifTable.

               The definition of this textual convention with the
               addition of newly assigned values is published
               periodically by the IANA, in either the Assigned
               Numbers RFC, or some derivative of it specific to
               Internet Network Management number assignments.  (The
               latest arrangements can be obtained by contacting the
               IANA.)

               Requests for new values should be made to IANA via
               email (iana@iana.org).

               The relationship between the assignment of ifType
               values and of OIDs to particular media-specific MIBs
               is solely the purview of IANA and is subject to change
               without notice.  Quite often, a media-specific MIB's
               OID-subtree assignment within MIB-II's 'transmission'
               subtree will be the same as its ifType value.
               However, in some circumstances this will not be the
               case, and implementors must not pre-assume any
               specific relationship between ifType values and
               transmission subtree OIDs."))

(define-textual-convention |IANAtunnelType|
                           t
                           (:status '|current|)
                           (:description
                            "The encapsulation method used by a tunnel. The value
            direct indicates that a packet is encapsulated
            directly within a normal IP header, with no
            intermediate header, and unicast to the remote tunnel
            endpoint (e.g., an RFC 2003 IP-in-IP tunnel, or an RFC
            1933 IPv6-in-IPv4 tunnel). The value minimal indicates
            that a Minimal Forwarding Header (RFC 2004) is
            inserted between the outer header and the payload
            packet. The value UDP indicates that the payload
            packet is encapsulated within a normal UDP packet
            (e.g., RFC 1234).

            The values sixToFour, sixOverFour, and isatap
            indicates that an IPv6 packet is encapsulated directly
            within an IPv4 header, with no intermediate header,
            and unicast to the destination determined by the 6to4,
            6over4, or ISATAP protocol.

            The remaining protocol-specific values indicate that a
            header of the protocol of that name is inserted
            between the outer header and the payload header.

            The assignment policy for IANAtunnelType values is
            identical to the policy for assigning IANAifType
            values."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|IANAifType-MIB| *mib-modules*)
  (setf *current-module* nil))

