;;;; -*- Mode: Lisp -*-
;;;; Generated from MIB:LISP;ECL-MIB.TXT by SNMP 6.1

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'ecl-mib))

(defpackage :asn.1/ecl-mib
  (:nicknames :ecl-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |commonLisp|))

(in-package :ecl-mib)

(defoid |ecl| (|commonLisp| 11)
  (:type 'module-identity)
  (:description "The MIB module for ECL"))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ecl-mib *mib-modules*)
  (setf *current-module* nil))

