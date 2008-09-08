;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from SNMP:SERVER;MIB;LISP-SBCL-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'lisp-sbcl-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-sbcl-mib *mib-modules*))
(defoid |sbcl| (|common-lisp| 7)
  (:type 'module-identity)
  (:description "The MIB module for SBCL"))
