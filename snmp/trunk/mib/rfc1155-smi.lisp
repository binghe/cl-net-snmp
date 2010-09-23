;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:BASE;RFC1155-SMI.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'rfc1155-smi))

(defpackage :asn.1/rfc1155-smi
  (:nicknames :rfc1155-smi)
  (:use :common-lisp :asn.1))

(in-package :rfc1155-smi)

(defoid |internet| (|dod| 1) (:type 'object-identity))

(defoid |directory| (|internet| 1) (:type 'object-identity))

(defoid |mgmt| (|internet| 2) (:type 'object-identity))

(defoid |experimental| (|internet| 3) (:type 'object-identity))

(defoid |private| (|internet| 4) (:type 'object-identity))

(defoid |enterprises| (|private| 1) (:type 'object-identity))

(defmacro object-type ())

(deftype |ObjectName| () 't)

(deftype |ObjectSyntax| () 't)

(deftype |SimpleSyntax| () 't)

(deftype |ApplicationSyntax| () 't)

(deftype |NetworkAddress| () 't)

(deftype |IpAddress| () 't)

(deftype |Counter| () 't)

(deftype |Gauge| () 't)

(deftype |TimeTicks| () 't)

(deftype |Opaque| () 't)

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'rfc1155-smi *mib-modules*)
  (setf *current-module* nil))

