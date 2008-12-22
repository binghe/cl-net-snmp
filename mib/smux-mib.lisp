;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SMUX-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute) (pushnew 'smux-mib *mib-modules*))
(setf *current-module* 'smux-mib)
(defpackage :asn.1/smux-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |enterprises|))
(in-package :asn.1/smux-mib)
(defoid |unix| (|enterprises| 4) (:type 'object-identity))
(defoid |smux| (|unix| 4) (:type 'object-identity))
(defoid |smuxPeerTable| (|smux| 1)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The SMUX peer table."))
(defoid |smuxPeerEntry| (|smuxPeerTable| 1)
  (:type 'object-type)
  (:syntax '|SmuxPeerEntry|)
  (:status '|mandatory|)
  (:description "An entry in the SMUX peer table."))
(deftype |SmuxPeerEntry| () 't)
(defoid |smuxPindex| (|smuxPeerEntry| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description "An index which uniquely identifies a SMUX peer."))
(defoid |smuxPidentity| (|smuxPeerEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:status '|mandatory|)
  (:description "The authoritative designation for a SMUX peer."))
(defoid |smuxPdescription| (|smuxPeerEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "A human-readable description of a SMUX peer."))
(defoid |smuxPstatus| (|smuxPeerEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The type of SMUX peer.

            Setting this object to the value invalid(2) has
            the effect of invaliding the corresponding entry
            in the smuxPeerTable.  It is an implementation-
            specific matter as to whether the agent removes an
            invalidated entry from the table.  Accordingly,
            management stations must be prepared to receive
            tabular information from agents that correspond to
            entries not currently in use.  Proper
            interpretation of such entries requires
            examination of the relative smuxPstatus object."))
(defoid |smuxTreeTable| (|smux| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description "The SMUX tree table."))
(defoid |smuxTreeEntry| (|smuxTreeTable| 1)
  (:type 'object-type)
  (:syntax '|SmuxTreeEntry|)
  (:status '|mandatory|)
  (:description "An entry in the SMUX tree table."))
(deftype |SmuxTreeEntry| () 't)
(defoid |smuxTsubtree| (|smuxTreeEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:status '|mandatory|)
  (:description "The MIB subtree being exported by a SMUX peer."))
(defoid |smuxTpriority| (|smuxTreeEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The SMUX peer's priority when exporting the MIB
            subtree."))
(defoid |smuxTindex| (|smuxTreeEntry| 3)
  (:type 'object-type)
  (:syntax ':integer)
  (:status '|mandatory|)
  (:description "The SMUX peer's identity."))
(defoid |smuxTstatus| (|smuxTreeEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:status '|mandatory|)
  (:description
   "The type of SMUX tree.

            Setting this object to the value invalid(2) has
            the effect of invaliding the corresponding entry
            in the smuxTreeTable.  It is an implementation-
            specific matter as to whether the agent removes an
            invalidated entry from the table.  Accordingly,
            management stations must be prepared to receive
            tabular information from agents that correspond to
            entries not currently in use.  Proper
            interpretation of such entries requires
            examination of the relative smuxTstatus object."))
