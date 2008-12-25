;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:LISP;LISP-CMUCL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-cmucl-mib *mib-modules*)
  (setf *current-module* 'lisp-cmucl-mib))

(defpackage :asn.1/lisp-cmucl-mib
  (:nicknames :lisp-cmucl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))

(in-package :lisp-cmucl-mib)

(defoid |cmucl| (|common-lisp| 6)
  (:type 'module-identity)
  (:description "The MIB module for CMUCL"))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

