;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-USM-AES-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'snmp-usm-aes-mib))

(defpackage :asn.1/snmp-usm-aes-mib
  (:nicknames :snmp-usm-aes-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |snmpModules|)
  (:import-from :asn.1/snmp-framework-mib |snmpPrivProtocols|))

(in-package :snmp-usm-aes-mib)

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
  (:description "The CFB128-AES-128 Privacy Protocol.")
  (:reference
   "- Specification for the ADVANCED ENCRYPTION
                    STANDARD. Federal Information Processing
                    Standard (FIPS) Publication 197.
                    (November 2001).

                  - Dworkin, M., NIST Recommendation for Block
                    Cipher Modes of Operation, Methods and
                    Techniques. NIST Special Publication 800-38A
                    (December 2001).
                 "))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-usm-aes-mib *mib-modules*)
  (setf *current-module* nil))

