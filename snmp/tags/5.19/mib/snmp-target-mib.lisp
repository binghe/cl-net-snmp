;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-TARGET-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'snmp-target-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-target-mib *mib-modules*))
(defoid |snmpTargetMIB| (|snmpModules| 12)
  (:type 'module-identity)
  (:description
   "This MIB module defines MIB objects which provide
         mechanisms to remotely configure the parameters used
         by an SNMP entity for the generation of SNMP messages.

         Copyright (C) The Internet Society (2002). This
         version of this MIB module is part of RFC 3413;
         see the RFC itself for full legal notices.
        "))
(defoid |snmpTargetObjects| (|snmpTargetMIB| 1)
  (:type 'object-identity))
(defoid |snmpTargetConformance| (|snmpTargetMIB| 3)
  (:type 'object-identity))
(deftype |SnmpTagValue| () 't)
(deftype |SnmpTagList| () 't)
(defoid |snmpTargetSpinLock| (|snmpTargetObjects| 1)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This object is used to facilitate modification of table
         entries in the SNMP-TARGET-MIB module by multiple
         managers.  In particular, it is useful when modifying
         the value of the snmpTargetAddrTagList object.

         The procedure for modifying the snmpTargetAddrTagList
         object is as follows:

             1.  Retrieve the value of snmpTargetSpinLock and
                 of snmpTargetAddrTagList.

             2.  Generate a new value for snmpTargetAddrTagList.

             3.  Set the value of snmpTargetSpinLock to the
                 retrieved value, and the value of
                 snmpTargetAddrTagList to the new value.  If
                 the set fails for the snmpTargetSpinLock
                 object, go back to step 1."))
(defoid |snmpTargetAddrTable| (|snmpTargetObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of transport addresses to be used in the generation
         of SNMP messages."))
(defoid |snmpTargetAddrEntry| (|snmpTargetAddrTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpTargetAddrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A transport address to be used in the generation
         of SNMP operations.

         Entries in the snmpTargetAddrTable are created and
         deleted using the snmpTargetAddrRowStatus object."))
(deftype |SnmpTargetAddrEntry| () 't)
(defoid |snmpTargetAddrName| (|snmpTargetAddrEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this snmpTargetAddrEntry."))
(defoid |snmpTargetAddrTDomain| (|snmpTargetAddrEntry| 2)
  (:type 'object-type)
  (:syntax '|TDomain|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object indicates the transport type of the address
         contained in the snmpTargetAddrTAddress object."))
(defoid |snmpTargetAddrTAddress| (|snmpTargetAddrEntry| 3)
  (:type 'object-type)
  (:syntax '|TAddress|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object contains a transport address.  The format of
         this address depends on the value of the
         snmpTargetAddrTDomain object."))
(defoid |snmpTargetAddrTimeout| (|snmpTargetAddrEntry| 4)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object should reflect the expected maximum round
         trip time for communicating with the transport address
         defined by this row.  When a message is sent to this
         address, and a response (if one is expected) is not
         received within this time period, an implementation
         may assume that the response will not be delivered.

         Note that the time interval that an application waits
         for a response may actually be derived from the value
         of this object.  The method for deriving the actual time
         interval is implementation dependent.  One such method
         is to derive the expected round trip time based on a
         particular retransmission algorithm and on the number
         of timeouts which have occurred.  The type of message may
         also be considered when deriving expected round trip
         times for retransmissions.  For example, if a message is
         being sent with a securityLevel that indicates both

         authentication and privacy, the derived value may be
         increased to compensate for extra processing time spent
         during authentication and encryption processing."))
(defoid |snmpTargetAddrRetryCount| (|snmpTargetAddrEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object specifies a default number of retries to be
         attempted when a response is not received for a generated
         message.  An application may provide its own retry count,
         in which case the value of this object is ignored."))
(defoid |snmpTargetAddrTagList| (|snmpTargetAddrEntry| 6)
  (:type 'object-type)
  (:syntax '|SnmpTagList|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object contains a list of tag values which are
         used to select target addresses for a particular
         operation."))
(defoid |snmpTargetAddrParams| (|snmpTargetAddrEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object identifies an entry in the
         snmpTargetParamsTable.  The identified entry
         contains SNMP parameters to be used when generating
         messages to be sent to this transport address."))
(defoid |snmpTargetAddrStorageType| (|snmpTargetAddrEntry| 8)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
         Conceptual rows having the value 'permanent' need not
         allow write-access to any columnar objects in the row."))
(defoid |snmpTargetAddrRowStatus| (|snmpTargetAddrEntry| 9)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

         To create a row in this table, a manager must
         set this object to either createAndGo(4) or
         createAndWait(5).

         Until instances of all corresponding columns are
         appropriately configured, the value of the
         corresponding instance of the snmpTargetAddrRowStatus
         column is 'notReady'.

         In particular, a newly created row cannot be made
         active until the corresponding instances of
         snmpTargetAddrTDomain, snmpTargetAddrTAddress, and
         snmpTargetAddrParams have all been set.

         The following objects may not be modified while the
         value of this object is active(1):
             - snmpTargetAddrTDomain
             - snmpTargetAddrTAddress
         An attempt to set these objects while the value of
         snmpTargetAddrRowStatus is active(1) will result in
         an inconsistentValue error."))
(defoid |snmpTargetParamsTable| (|snmpTargetObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of SNMP target information to be used
         in the generation of SNMP messages."))
(defoid |snmpTargetParamsEntry| (|snmpTargetParamsTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpTargetParamsEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A set of SNMP target information.

         Entries in the snmpTargetParamsTable are created and
         deleted using the snmpTargetParamsRowStatus object."))
(deftype |SnmpTargetParamsEntry| () 't)
(defoid |snmpTargetParamsName| (|snmpTargetParamsEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this snmpTargetParamsEntry."))
(defoid |snmpTargetParamsMPModel| (|snmpTargetParamsEntry| 2)
  (:type 'object-type)
  (:syntax '|SnmpMessageProcessingModel|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The Message Processing Model to be used when generating
         SNMP messages using this entry."))
(defoid |snmpTargetParamsSecurityModel| (|snmpTargetParamsEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The Security Model to be used when generating SNMP
          messages using this entry.  An implementation may
          choose to return an inconsistentValue error if an
          attempt is made to set this variable to a value
          for a security model which the implementation does
          not support."))
(defoid |snmpTargetParamsSecurityName| (|snmpTargetParamsEntry| 4)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The securityName which identifies the Principal on
         whose behalf SNMP messages will be generated using
         this entry."))
(defoid |snmpTargetParamsSecurityLevel| (|snmpTargetParamsEntry| 5)
  (:type 'object-type)
  (:syntax '|SnmpSecurityLevel|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The Level of Security to be used when generating
         SNMP messages using this entry."))
(defoid |snmpTargetParamsStorageType| (|snmpTargetParamsEntry| 6)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.
         Conceptual rows having the value 'permanent' need not
         allow write-access to any columnar objects in the row."))
(defoid |snmpTargetParamsRowStatus| (|snmpTargetParamsEntry| 7)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

         To create a row in this table, a manager must
         set this object to either createAndGo(4) or
         createAndWait(5).

         Until instances of all corresponding columns are
         appropriately configured, the value of the
         corresponding instance of the snmpTargetParamsRowStatus
         column is 'notReady'.

         In particular, a newly created row cannot be made
         active until the corresponding
         snmpTargetParamsMPModel,
         snmpTargetParamsSecurityModel,
         snmpTargetParamsSecurityName,
         and snmpTargetParamsSecurityLevel have all been set.

         The following objects may not be modified while the
         value of this object is active(1):
             - snmpTargetParamsMPModel
             - snmpTargetParamsSecurityModel
             - snmpTargetParamsSecurityName
             - snmpTargetParamsSecurityLevel
         An attempt to set these objects while the value of
         snmpTargetParamsRowStatus is active(1) will result in
         an inconsistentValue error."))
(defoid |snmpUnavailableContexts| (|snmpTargetObjects| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
         engine which were dropped because the context
         contained in the message was unavailable."))
(defoid |snmpUnknownContexts| (|snmpTargetObjects| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
         engine which were dropped because the context
         contained in the message was unknown."))
(defoid |snmpTargetCompliances| (|snmpTargetConformance| 1)
  (:type 'object-identity))
(defoid |snmpTargetGroups| (|snmpTargetConformance| 2)
  (:type 'object-identity))
(defoid |snmpTargetCommandResponderCompliance|
        (|snmpTargetCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which include
         a command responder application."))
(defoid |snmpTargetBasicGroup| (|snmpTargetGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic remote
         configuration of management targets."))
(defoid |snmpTargetResponseGroup| (|snmpTargetGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing remote configuration
         of management targets for applications which generate
         SNMP messages for which a response message would be
         expected."))
(defoid |snmpTargetCommandResponderGroup| (|snmpTargetGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects required for command responder
         applications, used for counting error conditions."))