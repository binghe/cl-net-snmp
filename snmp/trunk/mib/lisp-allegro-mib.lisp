;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from SNMP:SERVER;MIB;LISP-ALLEGRO-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'lisp-allegro-mib *mib-modules*))
(setf *current-module* 'lisp-allegro-mib)
(defpackage :asn.1/lisp-allegro-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                object-identity notification-type |enterprises|)
  (:import-from :asn.1/lisp-mib |common-lisp|))
(in-package :asn.1/lisp-allegro-mib)
(defoid |allegro| (|common-lisp| 9)
  (:type 'module-identity)
  (:description "The MIB module for Allegro CL"))
