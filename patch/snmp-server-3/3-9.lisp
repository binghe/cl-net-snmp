;;;; -*- Mode: Lisp -*-
;;;; Patch 3.9: SCL MIB

(in-package :snmp)

;;; update-mib.lisp

#+lispworks
(pushnew #p"SNMP:SERVER;MIB;LISP-SCL-MIB.TXT" *mib-list*)

;;; lisp-mib.lisp

(in-package :asn.1)

(setf *current-module* 'lisp-mib)
(defoid |clNetSnmpAgentSCL| (|clNetSnmpAgentOIDs| 10)
  (:type 'object-identity))

;;; scl.lisp

#+scl
(def-scalar-variable "sysObjectID" (agent)
  (oid "clNetSnmpAgentSCL"))

(in-package :asn.1)

;;; lisp-scl-mib.lisp

(setf *current-module* 'lisp-scl-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-scl-mib *mib-modules*))
(defoid |scl| (|common-lisp| 10)
  (:type 'module-identity)
  (:description "The MIB module for Scieneer CL"))

;;; mib-depend.lisp

(EVAL-WHEN (:LOAD-TOPLEVEL :EXECUTE)
  (MAPCAR #'(LAMBDA (ASN.1::X)
              (SETF (GETHASH (CAR ASN.1::X)
                             ASN.1::*MIB-MODULE-DEPENDENCY*)
                    (CDR ASN.1::X)))
          '((LISP-SCL-MIB |SNMPv2-SMI| LISP-MIB))))

;;; package.lisp

(defparameter *server-major-version* 3)
(defparameter *server-minor-version* 9)
