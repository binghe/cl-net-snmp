;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-FLOW-LABEL-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-flow-label-mib *mib-modules*))
(setf *current-module* 'ipv6-flow-label-mib)
(defpackage :asn.1/ipv6-flow-label-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|
                |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))
(in-package :asn.1/ipv6-flow-label-mib)
(defoid |ipv6FlowLabelMIB| (|mib-2| 103)
  (:type 'module-identity)
  (:description
   "This MIB module provides commonly used textual
                   conventions for IPv6 Flow Labels.

                   Copyright (C) The Internet Society (2003).  This
                   version of this MIB module is part of RFC 3595,
                   see the RFC itself for full legal notices.
                  "))
(deftype |IPv6FlowLabel| () 't)
(deftype |IPv6FlowLabelOrAny| () 't)
