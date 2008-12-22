;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from SNMP:SERVER;MIB;LISP-SCL-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-scl-mib *mib-modules*))
(setf *current-module* 'lisp-scl-mib)
(defpackage :asn.1/lisp-scl-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))
(in-package :asn.1/lisp-scl-mib)
(defoid |scl| (|common-lisp| 10)
  (:type 'module-identity)
  (:description "The MIB module for Scieneer CL"))
