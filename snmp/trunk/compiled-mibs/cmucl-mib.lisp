;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;CMUCL-MIB.TXT by CL-NET-SNMP
(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'cmucl-mib))

(defpackage :asn.1/cmucl-mib
  (:nicknames :cmucl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :cmucl-mib)

(defoid |cmucl| (|commonLisp| 6)
  (:type 'module-identity)
  (:description "The MIB module for CMUCL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'cmucl-mib *mib-modules*)
  (setf *current-module* nil))

