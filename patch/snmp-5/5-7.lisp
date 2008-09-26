(in-package :asn.1)

(defoid |lispModuleTable| (|lispSystem| 16)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "*modules*"))

(defoid |lispModuleEntry| (|lispModuleTable| 1)
  (:type 'object-type)
  (:syntax '|LispModuleEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the lispModuleTable."))

(deftype |LispModuleEntry| () 't)

(defoid |lispModuleIndex| (|lispModuleEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
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

(in-package :snmp)

(defparameter *version* 5.7)
