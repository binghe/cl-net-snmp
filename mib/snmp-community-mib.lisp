;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMP-COMMUNITY-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'snmp-community-mib))

(defpackage :asn.1/snmp-community-mib
  (:nicknames :snmp-community-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |IpAddress| module-identity
                object-type |Integer32| |snmpModules|)
  (:import-from :|ASN.1/SNMPv2-TC| |RowStatus| |StorageType|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|
                |SnmpEngineID|)
  (:import-from :asn.1/snmp-target-mib |SnmpTagValue|
                |snmpTargetAddrEntry|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group))

(in-package :snmp-community-mib)

(defoid |snmpCommunityMIB| (|snmpModules| 18)
  (:type 'module-identity)
  (:description
   "This MIB module defines objects to help support coexistence
             between SNMPv1, SNMPv2c, and SNMPv3."))

(defoid |snmpCommunityMIBObjects| (|snmpCommunityMIB| 1)
  (:type 'object-identity))

(defoid |snmpCommunityMIBConformance| (|snmpCommunityMIB| 2)
  (:type 'object-identity))

(defoid |snmpCommunityTable| (|snmpCommunityMIBObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of community strings configured in the SNMP
         engine's Local Configuration Datastore (LCD)."))

(defoid |snmpCommunityEntry| (|snmpCommunityTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpCommunityEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Information about a particular community string."))

(defclass |SnmpCommunityEntry|
          (asn.1-type)
          ((|snmpCommunityIndex| :type |SnmpAdminString|)
           (|snmpCommunityName| :type t)
           (|snmpCommunitySecurityName| :type |SnmpAdminString|)
           (|snmpCommunityContextEngineID| :type |SnmpEngineID|)
           (|snmpCommunityContextName| :type |SnmpAdminString|)
           (|snmpCommunityTransportTag| :type |SnmpTagValue|)
           (|snmpCommunityStorageType| :type |StorageType|)
           (|snmpCommunityStatus| :type |RowStatus|)))

(defoid |snmpCommunityIndex| (|snmpCommunityEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The unique index value of a row in this table."))

(defoid |snmpCommunityName| (|snmpCommunityEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The community string for which a row in this table
         represents a configuration."))

(defoid |snmpCommunitySecurityName| (|snmpCommunityEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A human readable string representing the corresponding
         value of snmpCommunityName in a Security Model
         independent format."))

(defoid |snmpCommunityContextEngineID| (|snmpCommunityEntry| 4)
  (:type 'object-type)
  (:syntax '|SnmpEngineID|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The contextEngineID indicating the location of the
         context in which management information is accessed
         when using the community string specified by the
         corresponding instance of snmpCommunityName.

         The default value is the snmpEngineID of the entity in
         which this object is instantiated."))

(defoid |snmpCommunityContextName| (|snmpCommunityEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The context in which management information is accessed
         when using the community string specified by the corresponding
         instance of snmpCommunityName."))

(defoid |snmpCommunityTransportTag| (|snmpCommunityEntry| 6)
  (:type 'object-type)
  (:syntax '|SnmpTagValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object specifies a set of transport endpoints
         from which a command responder application will accept
         management requests.  If a management request containing
         this community is received on a transport endpoint other
         than the transport endpoints identified by this object,
         the request is deemed unauthentic.

         The transports identified by this object are specified

         in the snmpTargetAddrTable.  Entries in that table
         whose snmpTargetAddrTagList contains this tag value
         are identified.

         If the value of this object has zero-length, transport
         endpoints are not checked when authenticating messages
         containing this community string."))

(defoid |snmpCommunityStorageType| (|snmpCommunityEntry| 7)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row in the
         snmpCommunityTable.  Conceptual rows having the value
         'permanent' need not allow write-access to any
         columnar object in the row."))

(defoid |snmpCommunityStatus| (|snmpCommunityEntry| 8)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row in the snmpCommunityTable.

         An entry in this table is not qualified for activation
         until instances of all corresponding columns have been
         initialized, either through default values, or through
         Set operations.  The snmpCommunityName and
         snmpCommunitySecurityName objects must be explicitly set.

         There is no restriction on setting columns in this table
         when the value of snmpCommunityStatus is active(1)."))

(defoid |snmpTargetAddrExtTable| (|snmpCommunityMIBObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of mask and mms values associated with the

         snmpTargetAddrTable.

         The snmpTargetAddrExtTable augments the
         snmpTargetAddrTable with a transport address mask value
         and a maximum message size value.  The transport address
         mask allows entries in the snmpTargetAddrTable to define
         a set of addresses instead of just a single address.
         The maximum message size value allows the maximum
         message size of another SNMP entity to be configured for
         use in SNMPv1 (and SNMPv2c) transactions, where the
         message format does not specify a maximum message size."))

(defoid |snmpTargetAddrExtEntry| (|snmpTargetAddrExtTable| 1)
  (:type 'object-type)
  (:syntax '|SnmpTargetAddrExtEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Information about a particular mask and mms value."))

(defclass |SnmpTargetAddrExtEntry|
          (asn.1-type)
          ((|snmpTargetAddrTMask| :type t)
           (|snmpTargetAddrMMS| :type |Integer32|)))

(defoid |snmpTargetAddrTMask| (|snmpTargetAddrExtEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The mask value associated with an entry in the
         snmpTargetAddrTable.  The value of this object must
         have the same length as the corresponding instance of
         snmpTargetAddrTAddress, or must have length 0.  An
         attempt to set it to any other value will result in
         an inconsistentValue error.

         The value of this object allows an entry in the
         snmpTargetAddrTable to specify multiple addresses.
         The mask value is used to select which bits of
         a transport address must match bits of the corresponding
         instance of snmpTargetAddrTAddress, in order for the
         transport address to match a particular entry in the
         snmpTargetAddrTable.  Bits which are 1 in the mask
         value indicate bits in the transport address which
         must match bits in the snmpTargetAddrTAddress value.

         Bits which are 0 in the mask indicate bits in the
         transport address which need not match.  If the
         length of the mask is 0, the mask should be treated
         as if all its bits were 1 and its length were equal
         to the length of the corresponding value of
         snmpTargetAddrTable.

         This object may not be modified while the value of the
         corresponding instance of snmpTargetAddrRowStatus is
         active(1).  An attempt to set this object in this case
         will result in an inconsistentValue error."))

(defoid |snmpTargetAddrMMS| (|snmpTargetAddrExtEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum message size value associated with an entry
         in the snmpTargetAddrTable."))

(defoid |snmpTrapAddress| (|snmpCommunityMIBObjects| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The value of the agent-addr field of a Trap PDU which
         is forwarded by a proxy forwarder application using
         an SNMP version other than SNMPv1.  The value of this
         object SHOULD contain the value of the agent-addr field
         from the original Trap PDU as generated by an SNMPv1
         agent."))

(defoid |snmpTrapCommunity| (|snmpCommunityMIBObjects| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The value of the community string field of an SNMPv1
         message containing a Trap PDU which is forwarded by a
         a proxy forwarder application using an SNMP version
         other than SNMPv1.  The value of this object SHOULD
         contain the value of the community string field from
         the original SNMPv1 message containing a Trap PDU as
         generated by an SNMPv1 agent."))

(defoid |snmpCommunityMIBCompliances| (|snmpCommunityMIBConformance| 1)
  (:type 'object-identity))

(defoid |snmpCommunityMIBGroups| (|snmpCommunityMIBConformance| 2)
  (:type 'object-identity))

(defoid |snmpCommunityMIBCompliance| (|snmpCommunityMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP engines which
         implement the SNMP-COMMUNITY-MIB."))

(defoid |snmpProxyTrapForwardCompliance|
        (|snmpCommunityMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP engines which
         contain a proxy forwarding application which is
         capable of forwarding SNMPv1 traps using SNMPv2c
         or SNMPv3."))

(defoid |snmpCommunityGroup| (|snmpCommunityMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing for configuration
         of community strings for SNMPv1 (and SNMPv2c) usage."))

(defoid |snmpProxyTrapForwardGroup| (|snmpCommunityMIBGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Objects which are used by proxy forwarding applications
         when translating traps between SNMP versions.  These are
         used to preserve SNMPv1-specific information when

         translating to SNMPv2c or SNMPv3."))

(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-community-mib *mib-modules*)
  (setf *current-module* nil))

