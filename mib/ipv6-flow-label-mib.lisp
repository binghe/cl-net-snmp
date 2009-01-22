;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-FLOW-LABEL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ipv6-flow-label-mib))

(defpackage :asn.1/ipv6-flow-label-mib
  (:nicknames :ipv6-flow-label-mib)
  (:use :closer-common-lisp :asn.1)
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

(deftype |IPv6FlowLabel| () 't)

(deftype |IPv6FlowLabelOrAny| () 't)

(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-flow-label-mib *mib-modules*)
  (setf *current-module* nil))

