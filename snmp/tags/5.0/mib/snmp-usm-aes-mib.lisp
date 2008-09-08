;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-USM-AES-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'snmp-usm-aes-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-usm-aes-mib *mib-modules*))
(defoid |snmpUsmAesMIB| (|snmpModules| 20)
  (:type 'module-identity)
  (:description
   "Definitions of Object Identities needed for
                  the use of AES by SNMP's User-based Security
                  Model.

                  Copyright (C) The Internet Society (2004).

            This version of this MIB module is part of RFC 3826;
            see the RFC itself for full legal notices.
            Supplementary information may be available on
            http://www.ietf.org/copyrights/ianamib.html."))
(defoid |usmAesCfb128Protocol| (|snmpPrivProtocols| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The CFB128-AES-128 Privacy Protocol."))
