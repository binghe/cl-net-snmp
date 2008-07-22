;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:HCNUM-TC

(in-package :asn.1)
(setf *current-module* 'hcnum-tc)
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
