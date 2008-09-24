;;;; MIB change in this patch

(in-package :asn.1)

(setf *current-module* 'lisp-mib)

(defoid |lispFeatureTable| (|lispSystem| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "*features*"))

(defoid |lispFeatureEntry| (|lispFeatureTable| 1)
  (:type 'object-type)
  (:syntax '|LispFeatureEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the lispFeatureTable."))

(deftype |LispFeatureEntry| () 't)

(defoid |lispFeatureIndex| (|lispFeatureEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
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
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "(list-all-packages)"))

(defoid |lispPackageEntry| (|lispPackageTable| 1)
  (:type 'object-type)
  (:syntax '|LispPackageEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the lispPackageTable."))

(deftype |LispPackageEntry| () 't)

(defoid |lispPackageIndex| (|lispPackageEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
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

(in-package :snmp)

(defparameter *version* 5.5)
