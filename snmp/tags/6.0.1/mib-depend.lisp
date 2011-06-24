;;;; -*- Mode: Lisp -*-
;;;; Generated by #p"SNMP:UPDATE-MIB.LISP"

(IN-PACKAGE :ASN.1)

(EVAL-WHEN (:LOAD-TOPLEVEL :EXECUTE)
  (MAPCAR #'(LAMBDA (X)
              (SETF (GETHASH (CAR X) *MIB-MODULE-DEPENDENCY*) (CDR X)))
          '((SCL-MIB |SNMPv2-SMI| LISP-MIB)
            (SBCL-MIB |SNMPv2-SMI| LISP-MIB)
            (|LispWorks-MIB| |SNMPv2-SMI| LISP-MIB)
            (|Franz-MIB| |SNMPv2-SMI| LISP-MIB)
            (ECL-MIB |SNMPv2-SMI| LISP-MIB)
            (CMUCL-MIB |SNMPv2-SMI| LISP-MIB)
            (|Clozure-MIB| |SNMPv2-SMI| LISP-MIB)
            (ABCL-MIB |SNMPv2-SMI| LISP-MIB)
            (LISP-MIB |SNMPv2-SMI| |SNMPv2-TC|)
            (|IANAifType-MIB| |SNMPv2-SMI| |SNMPv2-TC|)
            (|SNMPv2-MIB| |SNMPv2-SMI| |SNMPv2-TC| |SNMPv2-CONF|)
            (|SNMPv2-CONF| |SNMPv2-SMI|)
            (|SNMPv2-TM| |SNMPv2-SMI| |SNMPv2-TC|)
            (|SNMPv2-TC| |SNMPv2-SMI|))))