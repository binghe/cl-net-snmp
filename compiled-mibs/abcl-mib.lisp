;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;ABCL-MIB.TXT by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'abcl-mib))

(defpackage :asn.1/abcl-mib
  (:nicknames :abcl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :abcl-mib)

(defoid |abcl| (|commonLisp| 12)
  (:type 'module-identity)
  (:description "The MIB module for ABCL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'abcl-mib *mib-modules*)
  (setf *current-module* nil))

