;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;HCNUM-TC.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'hcnum-tc))

(defpackage :asn.1/hcnum-tc
  (:nicknames :hcnum-tc)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |mib-2|
                |Counter64|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention))

(in-package :hcnum-tc)

(defoid |hcnumTC| (|mib-2| 78)
  (:type 'module-identity)
  (:description
   "A MIB module containing textual conventions
         for high capacity data types. This module
         addresses an immediate need for data types not directly
         supported in the SMIv2. This short-term solution
         is meant to be deprecated as a long-term solution
         is deployed."))

(deftype |CounterBasedGauge64| () 't)

(deftype |ZeroBasedCounter64| () 't)

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'hcnum-tc *mib-modules*)
  (setf *current-module* nil))

