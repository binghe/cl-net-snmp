;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;SBCL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'sbcl-mib))

(defpackage :asn.1/sbcl-mib
  (:nicknames :sbcl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :sbcl-mib)

(defoid |sbcl| (|commonLisp| 7)
  (:type 'module-identity)
  (:description "The MIB module for SBCL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'sbcl-mib *mib-modules*)
  (setf *current-module* nil))

