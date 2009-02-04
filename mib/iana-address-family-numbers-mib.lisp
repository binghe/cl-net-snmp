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

(define-textual-convention |AddressFamilyNumbers|
                           t
                           (:status '|current|)
                           (:description
                            "The definition of this textual convention with the
          addition of newly assigned values is published
          periodically by the IANA, in either the Assigned
          Numbers RFC, or some derivative of it specific to
          Internet Network Management number assignments.
          (The latest arrangements can be obtained by
          contacting the IANA.)

          The enumerations are described as:

          other(0),    -- none of the following
          ipV4(1),     -- IP Version 4
          ipV6(2),     -- IP Version 6
          nsap(3),     -- NSAP
          hdlc(4),     -- (8-bit multidrop)
          bbn1822(5),
          all802(6),   -- (includes all 802 media
                       --   plus Ethernet 'canonical format')
          e163(7),
          e164(8),     -- (SMDS, Frame Relay, ATM)
          f69(9),      -- (Telex)
          x121(10),    -- (X.25, Frame Relay)
          ipx(11),     -- IPX (Internet Protocol Exchange)
          appleTalk(12),  -- Apple Talk
          decnetIV(13),   -- DEC Net Phase IV
          banyanVines(14),  -- Banyan Vines
          e164withNsap(15),
                       -- (E.164 with NSAP format subaddress)
          dns(16),     -- (Domain Name System)
          distinguishedName(17), -- (Distinguished Name, per X.500)
          asNumber(18), -- (16-bit quantity, per the AS number space)
          xtpOverIpv4(19),  -- XTP over IP version 4
          xtpOverIpv6(20),  -- XTP over IP version 6
          xtpNativeModeXTP(21),  -- XTP native mode XTP
          fibreChannelWWPN(22),  -- Fibre Channel World-Wide Port Name 
          fibreChannelWWNN(23),  -- Fibre Channel World-Wide Node Name
          gwid(24),    -- Gateway Identifier 
          reserved(65535)

          Requests for new values should be made to IANA via
          email (iana@iana.org)."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'iana-address-family-numbers-mib *mib-modules*)
  (setf *current-module* nil))

