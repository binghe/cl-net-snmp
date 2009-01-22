;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANA-RTPROTO-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'iana-rtproto-mib))

(defpackage :asn.1/iana-rtproto-mib
  (:nicknames :iana-rtproto-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :iana-rtproto-mib)

(defoid |ianaRtProtoMIB| (|mib-2| 84)
  (:type 'module-identity)
  (:description
   "This MIB module defines the IANAipRouteProtocol and
            IANAipMRouteProtocol textual conventions for use in MIBs
            which need to identify unicast or multicast routing
            mechanisms.

            Any additions or changes to the contents of this MIB module
            require either publication of an RFC, or Designated Expert
            Review as defined in RFC 2434, Guidelines for Writing an
            IANA Considerations Section in RFCs.  The Designated Expert 
            will be selected by the IESG Area Director(s) of the Routing
            Area."))

(deftype |IANAipRouteProtocol| () 't)

(deftype |IANAipMRouteProtocol| () 't)

(eval-when (:load-toplevel :execute)
  (pushnew 'iana-rtproto-mib *mib-modules*)
  (setf *current-module* nil))

