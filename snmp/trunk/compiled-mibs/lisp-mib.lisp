;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;LISP-MIB.TXT by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'lisp-mib))

(defpackage :asn.1/lisp-mib
  (:nicknames :lisp-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|))

(in-package :lisp-mib)

(defoid |lisp| (|enterprises| 31609)
  (:type 'module-identity)
  (:description "The MIB module for Lisp."))

(defoid |commonLisp| (|lisp| 1) (:type 'object-identity))

(defoid |scheme| (|lisp| 2) (:type 'object-identity))

(defoid |lispSystem| (|commonLisp| 1) (:type 'object-identity))

(defoid |lispConstants| (|commonLisp| 2) (:type 'object-identity))

(defoid |lispPackages| (|commonLisp| 3) (:type 'object-identity))

(defoid |lispApplications| (|commonLisp| 4) (:type 'object-identity))

(defoid |lispImplementationType| (|lispSystem| 1)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(lisp-implementation-type)"))

(defoid |lispImplementationVersion| (|lispSystem| 2)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(lisp-implementation-version)"))

(defoid |lispLongSiteName| (|lispSystem| 3)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "(long-site-name)"))

(defoid |lispShortSiteName| (|lispSystem| 4)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "(short-site-name)"))

(defoid |lispMachineInstance| (|lispSystem| 5)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(machine-instance)"))

(defoid |lispMachineType| (|lispSystem| 6)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(machine-type)"))

(defoid |lispMachineVersion| (|lispSystem| 7)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(machine-version)"))

(defoid |lispSoftwareType| (|lispSystem| 8)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(software-type)"))

(defoid |lispSoftwareVersion| (|lispSystem| 9)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(software-version)"))

(defoid |lispInternalRealTime| (|lispSystem| 10)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(get-internal-real-time)"))

(defoid |lispInternalRunTime| (|lispSystem| 11)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(get-internal-run-time)"))

(defoid |lispInternalTimeUnitsPerSecond| (|lispSystem| 12)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "internal-time-units-per-second"))

(defoid |lispUniversalTime| (|lispSystem| 13)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "(get-universal-time)"))

(defoid |lispFeatureTable| (|lispSystem| 14)
  (:type 'object-type)
  (:syntax '(vector |lispFeatureEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "*features*"))

(defoid |lispFeatureEntry| (|lispFeatureTable| 1)
  (:type 'object-type)
  (:syntax '|LispFeatureEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the lispFeatureTable."))

(defclass |LispFeatureEntry|
          (sequence-type)
          ((|lispFeatureIndex| :type integer)
           (|lispFeatureName| :type |DisplayString|)))

(defoid |lispFeatureIndex| (|lispFeatureEntry| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The auxiliary variable used for identifying instances
            of the columnar objects in the lispFeatureTable."))

(defoid |lispFeatureName| (|lispFeatureEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The string name of each element in *features*."))

(defoid |lispPackageTable| (|lispSystem| 15)
  (:type 'object-type)
  (:syntax '(vector |lispPackageEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "(list-all-packages)"))

(defoid |lispPackageEntry| (|lispPackageTable| 1)
  (:type 'object-type)
  (:syntax '|LispPackageEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the lispPackageTable."))

(defclass |LispPackageEntry|
          (sequence-type)
          ((|lispPackageIndex| :type integer)
           (|lispPackageName| :type |DisplayString|)))

(defoid |lispPackageIndex| (|lispPackageEntry| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The auxiliary variable used for identifying instances
            of the columnar objects in the lispPackageTable."))

(defoid |lispPackageName| (|lispPackageEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The string name of each element in (list-all-packages)."))

(defoid |lispModuleTable| (|lispSystem| 16)
  (:type 'object-type)
  (:syntax '(vector |lispModuleEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "*modules*"))

(defoid |lispModuleEntry| (|lispModuleTable| 1)
  (:type 'object-type)
  (:syntax '|LispModuleEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the lispModuleTable."))

(defclass |LispModuleEntry|
          (sequence-type)
          ((|lispModuleIndex| :type integer)
           (|lispModuleName| :type |DisplayString|)))

(defoid |lispModuleIndex| (|lispModuleEntry| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The auxiliary variable used for identifying instances
            of the columnar objects in the lispModuleTable."))

(defoid |lispModuleName| (|lispModuleEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The string name of each element in (list-all-packages)."))

(defoid |lispMostPositiveShortFloat| (|lispConstants| 1)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveShortFloat| (|lispConstants| 2)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveNormalizedShortFloat| (|lispConstants| 3)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostPositiveDoubleFloat| (|lispConstants| 4)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveDoubleFloat| (|lispConstants| 5)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveNormalizedDoubleFloat| (|lispConstants| 6)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostPositiveLongFloat| (|lispConstants| 7)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveLongFloat| (|lispConstants| 8)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveNormalizedLongFloat| (|lispConstants| 9)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostPositiveSingleFloat| (|lispConstants| 10)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveSingleFloat| (|lispConstants| 11)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastPositiveNormalizedSingleFloat| (|lispConstants| 12)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostNegativeShortFloat| (|lispConstants| 13)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeShortFloat| (|lispConstants| 14)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeNormalizedShortFloat| (|lispConstants| 15)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostNegativeSingleFloat| (|lispConstants| 16)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeSingleFloat| (|lispConstants| 17)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeNormalizedSingleFloat| (|lispConstants| 18)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostNegativeDoubleFloat| (|lispConstants| 19)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeDoubleFloat| (|lispConstants| 20)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeNormalizedDoubleFloat| (|lispConstants| 21)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispMostNegativeLongFloat| (|lispConstants| 22)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeLongFloat| (|lispConstants| 23)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |lispLeastNegativeNormalizedLongFloat| (|lispConstants| 24)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|))

(defoid |clSnmp| (|lispPackages| 1) (:type 'object-identity))

(defoid |clSnmpObjects| (|clSnmp| 1) (:type 'object-identity))

(defoid |clSnmpEnumerations| (|clSnmp| 2) (:type 'object-identity))

(defoid |clSnmpAgentOIDs| (|clSnmpEnumerations| 1)
  (:type 'object-identity))

(defoid |clSnmpAgent| (|clSnmpAgentOIDs| 1) (:type 'object-identity))

(defoid |clSnmpAgentLispWorks| (|clSnmpAgentOIDs| 5)
  (:type 'object-identity))

(defoid |clSnmpAgentCMUCL| (|clSnmpAgentOIDs| 6)
  (:type 'object-identity))

(defoid |clSnmpAgentSBCL| (|clSnmpAgentOIDs| 7)
  (:type 'object-identity))

(defoid |clSnmpAgentClozure| (|clSnmpAgentOIDs| 8)
  (:type 'object-identity))

(defoid |clSnmpAgentAllegroCL| (|clSnmpAgentOIDs| 9)
  (:type 'object-identity))

(defoid |clSnmpAgentSCL| (|clSnmpAgentOIDs| 10)
  (:type 'object-identity))

(defoid |clSnmpAgentECL| (|clSnmpAgentOIDs| 11)
  (:type 'object-identity))

(defoid |clSnmpAgentABCL| (|clSnmpAgentOIDs| 12)
  (:type 'object-identity))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-mib *mib-modules*)
  (setf *current-module* nil))

