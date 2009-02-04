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

(define-textual-convention |CounterBasedGauge64|
                           |Counter64|
                           (:status '|current|)
                           (:description
                            "The CounterBasedGauge64 type represents a non-negative
        integer, which may increase or decrease, but shall never
        exceed a maximum value, nor fall below a minimum value. The
        maximum value can not be greater than 2^64-1
        (18446744073709551615 decimal), and the minimum value can

        not be smaller than 0.  The value of a CounterBasedGauge64
        has its maximum value whenever the information being modeled
        is greater than or equal to its maximum value, and has its
        minimum value whenever the information being modeled is
        smaller than or equal to its minimum value.  If the
        information being modeled subsequently decreases below
        (increases above) the maximum (minimum) value, the
        CounterBasedGauge64 also decreases (increases).

        Note that this TC is not strictly supported in SMIv2,
        because the 'always increasing' and 'counter wrap' semantics
        associated with the Counter64 base type are not preserved.
        It is possible that management applications which rely
        solely upon the (Counter64) ASN.1 tag to determine object
        semantics will mistakenly operate upon objects of this type
        as they would for Counter64 objects.

        This textual convention represents a limited and short-term
        solution, and may be deprecated as a long term solution is
        defined and deployed to replace it."))

(define-textual-convention |ZeroBasedCounter64|
                           |Counter64|
                           (:status '|current|)
                           (:description
                            "This TC describes an object which counts events with the
        following semantics: objects of this type will be set to
        zero(0) on creation and will thereafter count appropriate
        events, wrapping back to zero(0) when the value 2^64 is
        reached.

        Provided that an application discovers the new object within
        the minimum time to wrap it can use the initial value as a
        delta since it last polled the table of which this object is
        part.  It is important for a management station to be aware
        of this minimum time and the actual time between polls, and
        to discard data if the actual time is too long or there is
        no defined minimum time.

        Typically this TC is used in tables where the INDEX space is
        constantly changing and/or the TimeFilter mechanism is in
        use.

        Note that this textual convention does not retain all the
        semantics of the Counter64 base type. Specifically, a
        Counter64 has an arbitrary initial value, but objects
        defined with this TC are required to start at the value

        zero.  This behavior is not likely to have any adverse
        effects on management applications which are expecting
        Counter64 semantics.

        This textual convention represents a limited and short-term
        solution, and may be deprecated as a long term solution is
        defined and deployed to replace it."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'hcnum-tc *mib-modules*)
  (setf *current-module* nil))

