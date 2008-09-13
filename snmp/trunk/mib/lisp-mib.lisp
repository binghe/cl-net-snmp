;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from SNMP:SERVER;MIB;LISP-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'lisp-mib)
(eval-when (:load-toplevel :execute) (pushnew 'lisp-mib *mib-modules*))
(defoid |lisp| (|enterprises| 31609)
  (:type 'module-identity)
  (:description "The MIB module for Lisp."))
(defoid |common-lisp| (|lisp| 1) (:type 'object-identity))
(defoid |scheme| (|lisp| 2) (:type 'object-identity))
(defoid |lispSystem| (|common-lisp| 1) (:type 'object-identity))
(defoid |lispConstants| (|common-lisp| 2) (:type 'object-identity))
(defoid |lispPackages| (|common-lisp| 3) (:type 'object-identity))
(defoid |lispApplications| (|common-lisp| 4) (:type 'object-identity))
(defoid |lispImplementationType| (|lispSystem| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(lisp-implementation-type)"))
(defoid |lispImplementationVersion| (|lispSystem| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(lisp-implementation-version)"))
(defoid |lispLongSiteName| (|lispSystem| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "(long-site-name)"))
(defoid |lispShortSiteName| (|lispSystem| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "(short-site-name)"))
(defoid |lispMachineInstance| (|lispSystem| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(machine-instance)"))
(defoid |lispMachineType| (|lispSystem| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(machine-type)"))
(defoid |lispMachineVersion| (|lispSystem| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(machine-version)"))
(defoid |lispSoftwareType| (|lispSystem| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(software-type)"))
(defoid |lispSoftwareVersion| (|lispSystem| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(software-version)"))
(defoid |lispInternalRealTime| (|lispSystem| 10)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(get-internal-real-time)"))
(defoid |lispInternalRunTime| (|lispSystem| 11)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(get-internal-run-time)"))
(defoid |lispInternalTimeUnitsPerSecond| (|lispSystem| 12)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "internal-time-units-per-second"))
(defoid |lispUniversalTime| (|lispSystem| 13)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(get-universal-time)"))
(defoid |lispMostPositiveShortFloat| (|lispConstants| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveShortFloat| (|lispConstants| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveNormalizedShortFloat| (|lispConstants| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostPositiveDoubleFloat| (|lispConstants| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveDoubleFloat| (|lispConstants| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveNormalizedDoubleFloat| (|lispConstants| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostPositiveLongFloat| (|lispConstants| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveLongFloat| (|lispConstants| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveNormalizedLongFloat| (|lispConstants| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostPositiveSingleFloat| (|lispConstants| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveSingleFloat| (|lispConstants| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastPositiveNormalizedSingleFloat| (|lispConstants| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostNegativeShortFloat| (|lispConstants| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeShortFloat| (|lispConstants| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeNormalizedShortFloat| (|lispConstants| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostNegativeSingleFloat| (|lispConstants| 16)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeSingleFloat| (|lispConstants| 17)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeNormalizedSingleFloat| (|lispConstants| 18)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostNegativeDoubleFloat| (|lispConstants| 19)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeDoubleFloat| (|lispConstants| 20)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeNormalizedDoubleFloat| (|lispConstants| 21)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispMostNegativeLongFloat| (|lispConstants| 22)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeLongFloat| (|lispConstants| 23)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |lispLeastNegativeNormalizedLongFloat| (|lispConstants| 24)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|))
(defoid |cl-net-snmp| (|lispPackages| 1) (:type 'object-identity))
(defoid |clNetSnmpObjects| (|cl-net-snmp| 1) (:type 'object-identity))
(defoid |clNetSnmpEnumerations| (|cl-net-snmp| 2)
  (:type 'object-identity))
(defoid |clNetSnmpAgentOIDs| (|clNetSnmpEnumerations| 1)
  (:type 'object-identity))
(defoid |clNetSnmpAgent| (|clNetSnmpAgentOIDs| 1)
  (:type 'object-identity))
(defoid |clNetSnmpAgentLispWorks| (|clNetSnmpAgentOIDs| 5)
  (:type 'object-identity))
(defoid |clNetSnmpAgentCMUCL| (|clNetSnmpAgentOIDs| 6)
  (:type 'object-identity))
(defoid |clNetSnmpAgentSBCL| (|clNetSnmpAgentOIDs| 7)
  (:type 'object-identity))
(defoid |clNetSnmpAgentClozure| (|clNetSnmpAgentOIDs| 8)
  (:type 'object-identity))
(defoid |clNetSnmpAgentAllegroCL| (|clNetSnmpAgentOIDs| 9)
  (:type 'object-identity))
