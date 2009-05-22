;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;OSPF-TRAP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ospf-trap-mib))

(defpackage :asn.1/ospf-trap-mib
  (:nicknames :ospf-trap-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                notification-type |IpAddress|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/ospf-mib |ospfRouterId| |ospfIfIpAddress|
                |ospfAddressLessIf| |ospfIfState| |ospfVirtIfAreaId|
                |ospfVirtIfNeighbor| |ospfVirtIfState| |ospfNbrIpAddr|
                |ospfNbrAddressLessIndex| |ospfNbrRtrId| |ospfNbrState|
                |ospfVirtNbrArea| |ospfVirtNbrRtrId| |ospfVirtNbrState|
                |ospfLsdbType| |ospfLsdbLsid| |ospfLsdbRouterId|
                |ospfLsdbAreaId| |ospfExtLsdbLimit| |ospf|))

(in-package :ospf-trap-mib)

(defoid |ospfTrap| (|ospf| 16)
  (:type 'module-identity)
  (:description
   "The MIB module to describe traps for  the  OSPF
          Version 2 Protocol."))

(defoid |ospfTrapControl| (|ospfTrap| 1) (:type 'object-identity))

(defoid |ospfTraps| (|ospfTrap| 2) (:type 'object-identity))

(defoid |ospfSetTrap| (|ospfTrapControl| 1)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A four-octet string serving as a bit  map  for
           the trap events defined by the OSPF traps. This
           object is used to enable and  disable  specific
           OSPF   traps   where  a  1  in  the  bit  field
           represents enabled.  The right-most bit  (least
           significant) represents trap 0."))

(defoid |ospfConfigErrorType| (|ospfTrapControl| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Potential types  of  configuration  conflicts.
           Used  by the ospfConfigError and ospfConfigVir-
           tError traps."))

(defoid |ospfPacketType| (|ospfTrapControl| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "OSPF packet types."))

(defoid |ospfPacketSrc| (|ospfTrapControl| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP address of an inbound packet that  can-
           not be identified by a neighbor instance."))

(defoid |ospfIfStateChange| (|ospfTraps| 16)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfIfStateChange trap signifies that there
           has been a change in the state of a non-virtual
           OSPF interface. This trap should  be  generated
           when  the interface state regresses (e.g., goes
           from Dr to Down) or progresses  to  a  terminal
           state  (i.e.,  Point-to-Point, DR Other, Dr, or
           Backup)."))

(defoid |ospfVirtIfStateChange| (|ospfTraps| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfIfStateChange trap signifies that there
           has  been a change in the state of an OSPF vir-
           tual interface.
           This trap should be generated when  the  inter-
           face  state  regresses  (e.g., goes from Point-
           to-Point to Down) or progresses to  a  terminal
           state (i.e., Point-to-Point)."))

(defoid |ospfNbrStateChange| (|ospfTraps| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An  ospfNbrStateChange  trap  signifies   that
           there  has been a change in the state of a non-
           virtual OSPF neighbor.   This  trap  should  be
           generated  when  the  neighbor  state regresses
           (e.g., goes from Attempt or Full  to  1-Way  or
           Down)  or progresses to a terminal state (e.g.,
           2-Way or Full).  When an  neighbor  transitions
           from  or  to Full on non-broadcast multi-access
           and broadcast networks, the trap should be gen-
           erated  by the designated router.  A designated
           router transitioning to Down will be  noted  by
           ospfIfStateChange."))

(defoid |ospfVirtNbrStateChange| (|ospfTraps| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfIfStateChange trap signifies that there
           has  been a change in the state of an OSPF vir-
           tual neighbor.  This trap should  be  generated
           when  the  neighbor state regresses (e.g., goes
           from Attempt or  Full  to  1-Way  or  Down)  or
           progresses to a terminal state (e.g., Full)."))

(defoid |ospfIfConfigError| (|ospfTraps| 4)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfIfConfigError  trap  signifies  that  a
           packet  has  been received on a non-virtual in-
           terface  from  a  router  whose   configuration
           parameters  conflict  with this router's confi-
           guration parameters.  Note that the  event  op-
           tionMismatch  should  cause  a  trap only if it
           prevents an adjacency from forming."))

(defoid |ospfVirtIfConfigError| (|ospfTraps| 5)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfConfigError trap signifies that a pack-
           et  has  been  received  on a virtual interface
           from a router  whose  configuration  parameters
           conflict   with   this  router's  configuration
           parameters.  Note that the event optionMismatch
           should  cause a trap only if it prevents an ad-
           jacency from forming."))

(defoid |ospfIfAuthFailure| (|ospfTraps| 6)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfIfAuthFailure  trap  signifies  that  a
           packet  has  been received on a non-virtual in-
           terface from a router whose authentication  key
           or  authentication  type  conflicts  with  this
           router's authentication key  or  authentication
           type."))

(defoid |ospfVirtIfAuthFailure| (|ospfTraps| 7)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfVirtIfAuthFailure trap signifies that a
           packet has been received on a virtual interface
           from a router whose authentication key  or  au-
           thentication  type conflicts with this router's
           authentication key or authentication type."))

(defoid |ospfIfRxBadPacket| (|ospfTraps| 8)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfIfRxBadPacket trap  signifies  that  an
           OSPF  packet has been received on a non-virtual
           interface that cannot be parsed."))

(defoid |ospfVirtIfRxBadPacket| (|ospfTraps| 9)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfRxBadPacket trap signifies that an OSPF
           packet has been received on a virtual interface
           that cannot be parsed."))

(defoid |ospfTxRetransmit| (|ospfTraps| 10)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfTxRetransmit  trap  signifies  than  an
           OSPF  packet  has  been retransmitted on a non-
           virtual interface.  All packets that may be re-
           transmitted  are associated with an LSDB entry.
           The LS type, LS ID, and Router ID are  used  to
           identify the LSDB entry."))

(defoid |ospfVirtIfTxRetransmit| (|ospfTraps| 11)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfTxRetransmit  trap  signifies  than  an
           OSPF packet has been retransmitted on a virtual
           interface.  All packets that may be retransmit-
           ted  are  associated with an LSDB entry. The LS
           type, LS ID, and Router ID are used to identify
           the LSDB entry."))

(defoid |ospfOriginateLsa| (|ospfTraps| 12)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfOriginateLsa trap signifies that a  new
           LSA  has  been originated by this router.  This
           trap should not be invoked for simple refreshes
           of  LSAs  (which happesn every 30 minutes), but
           instead will only be invoked  when  an  LSA  is
           (re)originated due to a topology change.  Addi-
           tionally, this trap does not include LSAs  that
           are  being  flushed  because  they have reached
           MaxAge."))

(defoid |ospfMaxAgeLsa| (|ospfTraps| 13)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfMaxAgeLsa trap signifies  that  one  of
           the LSA in the router's link-state database has
           aged to MaxAge."))

(defoid |ospfLsdbOverflow| (|ospfTraps| 14)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfLsdbOverflow trap  signifies  that  the
           number of LSAs in the router's link-state data-
           base has exceeded ospfExtLsdbLimit."))

(defoid |ospfLsdbApproachingOverflow| (|ospfTraps| 15)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An ospfLsdbApproachingOverflow trap  signifies
           that  the  number of LSAs in the router's link-
           state database has exceeded ninety  percent  of
           ospfExtLsdbLimit."))

(defoid |ospfTrapConformance| (|ospfTrap| 3) (:type 'object-identity))

(defoid |ospfTrapGroups| (|ospfTrapConformance| 1)
  (:type 'object-identity))

(defoid |ospfTrapCompliances| (|ospfTrapConformance| 2)
  (:type 'object-identity))

(defoid |ospfTrapCompliance| (|ospfTrapCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description "The compliance statement "))

(defoid |ospfTrapControlGroup| (|ospfTrapGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required  to  control  traps
           from OSPF systems."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ospf-trap-mib *mib-modules*)
  (setf *current-module* nil))

