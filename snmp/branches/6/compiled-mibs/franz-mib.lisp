;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;FRANZ-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|Franz-MIB|))

(defpackage :|ASN.1/Franz-MIB|
  (:nicknames :|Franz-MIB|)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :|Franz-MIB|)

(defoid |alisp| (|commonLisp| 9)
  (:type 'module-identity)
  (:description "The MIB module for Allegro CL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew '|Franz-MIB| *mib-modules*)
  (setf *current-module* nil))

