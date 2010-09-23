;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:BASE;NET-SNMP-TC.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'net-snmp-tc))

(defpackage :asn.1/net-snmp-tc
  (:nicknames :net-snmp-tc)
  (:use :common-lisp :asn.1)
  (:import-from :asn.1/net-snmp-mib |netSnmpModuleIDs|
                |netSnmpAgentOIDs| |netSnmpDomains|)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |Opaque|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :net-snmp-tc)

(defoid |netSnmpTCs| (|netSnmpModuleIDs| 1)
  (:type 'module-identity)
  (:description
   "Textual conventions and enumerations for the Net-SNMP project"))

(define-textual-convention |Float|
                           t
                           (:status '|current|)
                           (:description
                            "A single precision floating-point number.  The semantics
         and encoding are identical for type 'single' defined in
         IEEE Standard for Binary Floating-Point,
         ANSI/IEEE Std 754-1985.
         The value is restricted to the BER serialization of
         the following ASN.1 type:
             FLOATTYPE ::= [120] IMPLICIT FloatType
         (note: the value 120 is the sum of '30'h and '48'h)
         The BER serialization of the length for values of
         this type must use the definite length, short
         encoding form.

         For example, the BER serialization of value 123
         of type FLOATTYPE is '9f780442f60000'h.  (The tag
         is '9f78'h; the length is '04'h; and the value is
         '42f60000'h.) The BER serialization of value
         '9f780442f60000'h of data type Opaque is
         '44079f780442f60000'h. (The tag is '44'h; the length
         is '07'h; and the value is '9f780442f60000'h.)"))

(defoid |hpux9| (|netSnmpAgentOIDs| 1) (:type 'object-identity))

(defoid |sunos4| (|netSnmpAgentOIDs| 2) (:type 'object-identity))

(defoid |solaris| (|netSnmpAgentOIDs| 3) (:type 'object-identity))

(defoid |osf| (|netSnmpAgentOIDs| 4) (:type 'object-identity))

(defoid |ultrix| (|netSnmpAgentOIDs| 5) (:type 'object-identity))

(defoid |hpux10| (|netSnmpAgentOIDs| 6) (:type 'object-identity))

(defoid |netbsd| (|netSnmpAgentOIDs| 7) (:type 'object-identity))

(defoid |freebsd| (|netSnmpAgentOIDs| 8) (:type 'object-identity))

(defoid |irix| (|netSnmpAgentOIDs| 9) (:type 'object-identity))

(defoid |linux| (|netSnmpAgentOIDs| 10) (:type 'object-identity))

(defoid |bsdi| (|netSnmpAgentOIDs| 11) (:type 'object-identity))

(defoid |openbsd| (|netSnmpAgentOIDs| 12) (:type 'object-identity))

(defoid |win32| (|netSnmpAgentOIDs| 13) (:type 'object-identity))

(defoid |hpux11| (|netSnmpAgentOIDs| 14) (:type 'object-identity))

(defoid |aix| (|netSnmpAgentOIDs| 15) (:type 'object-identity))

(defoid |macosx| (|netSnmpAgentOIDs| 16) (:type 'object-identity))

(defoid |unknown| (|netSnmpAgentOIDs| 255) (:type 'object-identity))

(defoid |netSnmpTCPDomain| (|netSnmpDomains| 1)
  (:type 'object-identity))

(defoid |netSnmpUnixDomain| (|netSnmpDomains| 2)
  (:type 'object-identity))

(defoid |netSnmpAAL5PVCDomain| (|netSnmpDomains| 3)
  (:type 'object-identity))

(defoid |netSnmpUDPIPv6Domain| (|netSnmpDomains| 4)
  (:type 'object-identity))

(defoid |netSnmpTCPIPv6Domain| (|netSnmpDomains| 5)
  (:type 'object-identity))

(defoid |netSnmpCallbackDomain| (|netSnmpDomains| 6)
  (:type 'object-identity))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-tc *mib-modules*)
  (setf *current-module* nil))

