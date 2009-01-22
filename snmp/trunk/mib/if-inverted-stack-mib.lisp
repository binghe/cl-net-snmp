;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IF-INVERTED-STACK-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'if-inverted-stack-mib))

(defpackage :asn.1/if-inverted-stack-mib
  (:nicknames :if-inverted-stack-mib)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/if-mib |ifStackGroup2| |ifStackHigherLayer|
                |ifStackLowerLayer|))

(in-package :if-inverted-stack-mib)

(defoid |ifInvertedStackMIB| (|mib-2| 77)
  (:type 'module-identity)
  (:description
   "The MIB module which provides the Inverted Stack Table for
          interface sub-layers."))

(defoid |ifInvMIBObjects| (|ifInvertedStackMIB| 1)
  (:type 'object-identity))

(defoid |ifInvStackTable| (|ifInvMIBObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information on the relationships between

          the multiple sub-layers of network interfaces.  In
          particular, it contains information on which sub-layers run
          'underneath' which other sub-layers, where each sub-layer
          corresponds to a conceptual row in the ifTable.  For
          example, when the sub-layer with ifIndex value x runs
          underneath the sub-layer with ifIndex value y, then this
          table contains:

            ifInvStackStatus.x.y=active

          For each ifIndex value, z, which identifies an active
          interface, there are always at least two instantiated rows
          in this table associated with z.  For one of these rows, z
          is the value of ifStackHigherLayer; for the other, z is the
          value of ifStackLowerLayer.  (If z is not involved in
          multiplexing, then these are the only two rows associated
          with z.)

          For example, two rows exist even for an interface which has
          no others stacked on top or below it:

            ifInvStackStatus.z.0=active
            ifInvStackStatus.0.z=active

          This table contains exactly the same number of rows as the
          ifStackTable, but the rows appear in a different order."))

(defoid |ifInvStackEntry| (|ifInvStackTable| 1)
  (:type 'object-type)
  (:syntax '|IfInvStackEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information on a particular relationship between two sub-
          layers, specifying that one sub-layer runs underneath the
          other sub-layer.  Each sub-layer corresponds to a conceptual
          row in the ifTable."))

(defclass |IfInvStackEntry| (sequence-type)
  ((|ifInvStackStatus| :type |RowStatus|)))

(defoid |ifInvStackStatus| (|ifInvStackEntry| 1)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The status of the relationship between two sub-layers.

          An instance of this object exists for each instance of the
          ifStackStatus object, and vice versa.  For example, if the
          variable ifStackStatus.H.L exists, then the variable
          ifInvStackStatus.L.H must also exist, and vice versa.  In
          addition, the two variables always have the same value.

          However, unlike ifStackStatus, the ifInvStackStatus object
          is NOT write-able.  A network management application wishing
          to change a relationship between sub-layers H and L cannot
          do so by modifying the value of ifInvStackStatus.L.H, but
          must instead modify the value of ifStackStatus.H.L.  After
          the ifStackTable is modified, the change will be reflected
          in this table."))

(defoid |ifInvConformance| (|ifInvMIBObjects| 2)
  (:type 'object-identity))

(defoid |ifInvGroups| (|ifInvConformance| 1) (:type 'object-identity))

(defoid |ifInvCompliances| (|ifInvConformance| 2)
  (:type 'object-identity))

(defoid |ifInvCompliance| (|ifInvCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which provide
          inverted information on the layering of network interfaces."))

(defoid |ifInvStackGroup| (|ifInvGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing inverted information on
          the layering of MIB-II interfaces."))

(eval-when (:load-toplevel :execute)
  (pushnew 'if-inverted-stack-mib *mib-modules*)
  (setf *current-module* nil))

