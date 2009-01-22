;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:LISP;LISP-SBCL-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'lisp-sbcl-mib))

(defpackage :asn.1/lisp-sbcl-mib
  (:nicknames :lisp-sbcl-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))

(in-package :lisp-sbcl-mib)

(defoid |sbcl| (|common-lisp| 7)
  (:type 'module-identity)
  (:description "The MIB module for SBCL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-sbcl-mib *mib-modules*)
  (setf *current-module* nil))

