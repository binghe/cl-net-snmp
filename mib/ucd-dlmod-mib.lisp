;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;UCD-DLMOD-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ucd-dlmod-mib))

(defpackage :asn.1/ucd-dlmod-mib
  (:nicknames :ucd-dlmod-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| object-type module-identity
                |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :asn.1/ucd-snmp-mib |ucdExperimental|))

(in-package :ucd-dlmod-mib)

(defoid |ucdDlmodMIB| (|ucdExperimental| 14)
  (:type 'module-identity)
  (:description
   "This file defines the MIB objects for dynamic 
	 loadable MIB modules."))

(defoid |dlmodNextIndex| (|ucdDlmodMIB| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The index number of next appropiate unassigned entry
	 in the dlmodTable."))

(defoid |dlmodTable| (|ucdDlmodMIB| 2)
  (:type 'object-type)
  (:syntax '(vector |DlmodEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of dlmodEntry."))

(defoid |dlmodEntry| (|dlmodTable| 1)
  (:type 'object-type)
  (:syntax '|DlmodEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The parameters of dynamically loaded MIB module."))

(defclass |DlmodEntry| (sequence-type)
  ((|dlmodIndex| :type |Integer32|)
   (|dlmodName| :type |DisplayString|)
   (|dlmodPath| :type |DisplayString|)
   (|dlmodError| :type |DisplayString|)
   (|dlmodStatus| :type integer)))

(defoid |dlmodIndex| (|dlmodEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An index that uniqely identifies an entry in the dlmodTable."))

(defoid |dlmodName| (|dlmodEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "The module name."))

(defoid |dlmodPath| (|dlmodEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "The path of the module executable file."))

(defoid |dlmodError| (|dlmodEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The last error from dlmod_load_module."))

(defoid |dlmodStatus| (|dlmodEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "The current status of the loaded module."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ucd-dlmod-mib *mib-modules*)
  (setf *current-module* nil))

