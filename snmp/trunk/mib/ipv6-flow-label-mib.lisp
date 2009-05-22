;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-FLOW-LABEL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ipv6-flow-label-mib))

(defpackage :asn.1/ipv6-flow-label-mib
  (:nicknames :ipv6-flow-label-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|
                |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :ipv6-flow-label-mib)

(defoid |ipv6FlowLabelMIB| (|mib-2| 103)
  (:type 'module-identity)
  (:description
   "This MIB module provides commonly used textual
                   conventions for IPv6 Flow Labels.

                   Copyright (C) The Internet Society (2003).  This
                   version of this MIB module is part of RFC 3595,
                   see the RFC itself for full legal notices.
                  "))

(define-textual-convention |IPv6FlowLabel|
                           t
                           (:display-hint "d")
                           (:status '|current|)
                           (:description
                            "The flow identifier or Flow Label in an IPv6
                   packet header that may be used to discriminate
                   traffic flows.
                  ")
                           (:reference
                            "Internet Protocol, Version 6 (IPv6) specification,
                   section 6.  RFC 2460.
                  "))

(define-textual-convention |IPv6FlowLabelOrAny|
                           t
                           (:display-hint "d")
                           (:status '|current|)
                           (:description
                            "The flow identifier or Flow Label in an IPv6
                   packet header that may be used to discriminate
                   traffic flows.  The value of -1 is used to
                   indicate a wildcard, i.e. any value.
                  "))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-flow-label-mib *mib-modules*)
  (setf *current-module* nil))

