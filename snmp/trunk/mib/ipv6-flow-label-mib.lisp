;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-FLOW-LABEL-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'ipv6-flow-label-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-flow-label-mib *mib-modules*))
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
