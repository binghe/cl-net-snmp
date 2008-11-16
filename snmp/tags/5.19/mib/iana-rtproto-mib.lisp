;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANA-RTPROTO-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'iana-rtproto-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'iana-rtproto-mib *mib-modules*))
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
