;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;SCL-MIB.TXT by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'scl-mib))

(defpackage :asn.1/scl-mib
  (:nicknames :scl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :scl-mib)

(defoid |scl| (|commonLisp| 10)
  (:type 'module-identity)
  (:description "The MIB module for Scieneer CL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'scl-mib *mib-modules*)
  (setf *current-module* nil))

