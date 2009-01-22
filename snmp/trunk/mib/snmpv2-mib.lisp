;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;SNMPV2-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* '|SNMPv2-MIB|))

(defpackage :|ASN.1/SNMPv2-MIB|
  (:nicknames :|SNMPv2-MIB|)
  (:use :closer-common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                notification-type |TimeTicks| |Counter32| |snmpModules|
                |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString| |TestAndIncr|
                |TimeStamp|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group))

(in-package :|SNMPv2-MIB|)

(defoid |snmpMIB| (|snmpModules| 1)
  (:type 'module-identity)
  (:description
   "The MIB module for SNMP entities.

             Copyright (C) The Internet Society (2002). This
             version of this MIB module is part of RFC 3418;
             see the RFC itself for full legal notices.
            "))

(defoid |snmpMIBObjects| (|snmpMIB| 1) (:type 'object-identity))

(defoid |system| (|mib-2| 1) (:type 'object-identity))

(defoid |sysDescr| (|system| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual description of the entity.  This value should
            include the full name and version identification of
            the system's hardware type, software operating-system,
            and networking software."))

(defoid |sysObjectID| (|system| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The vendor's authoritative identification of the
            network management subsystem contained in the entity.
            This value is allocated within the SMI enterprises
            subtree (1.3.6.1.4.1) and provides an easy and
            unambiguous means for determining `what kind of box' is
            being managed.  For example, if vendor `Flintstones,
            Inc.' was assigned the subtree 1.3.6.1.4.1.424242,
            it could assign the identifier 1.3.6.1.4.1.424242.1.1
            to its `Fred Router'."))

(defoid |sysUpTime| (|system| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time (in hundredths of a second) since the
            network management portion of the system was last
            re-initialized."))

(defoid |sysContact| (|system| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The textual identification of the contact person for
            this managed node, together with information on how
            to contact this person.  If no contact information is
            known, the value is the zero-length string."))

(defoid |sysName| (|system| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "An administratively-assigned name for this managed
            node.  By convention, this is the node's fully-qualified
            domain name.  If the name is unknown, the value is
            the zero-length string."))

(defoid |sysLocation| (|system| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The physical location of this node (e.g., 'telephone
            closet, 3rd floor').  If the location is unknown, the
            value is the zero-length string."))

(defoid |sysServices| (|system| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A value which indicates the set of services that this
            entity may potentially offer.  The value is a sum.

            This sum initially takes the value zero. Then, for
            each layer, L, in the range 1 through 7, that this node
            performs transactions for, 2 raised to (L - 1) is added
            to the sum.  For example, a node which performs only
            routing functions would have a value of 4 (2^(3-1)).
            In contrast, a node which is a host offering application
            services would have a value of 72 (2^(4-1) + 2^(7-1)).
            Note that in the context of the Internet suite of
            protocols, values should be calculated accordingly:

                 layer      functionality
                   1        physical (e.g., repeaters)
                   2        datalink/subnetwork (e.g., bridges)
                   3        internet (e.g., supports the IP)
                   4        end-to-end  (e.g., supports the TCP)
                   7        applications (e.g., supports the SMTP)

            For systems including OSI protocols, layers 5 and 6
            may also be counted."))

(defoid |sysORLastChange| (|system| 8)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time of the most recent
            change in state or value of any instance of sysORID."))

(defoid |sysORTable| (|system| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The (conceptual) table listing the capabilities of
            the local SNMP application acting as a command
            responder with respect to various MIB modules.
            SNMP entities having dynamically-configurable support
            of MIB modules will have a dynamically-varying number
            of conceptual rows."))

(defoid |sysOREntry| (|sysORTable| 1)
  (:type 'object-type)
  (:syntax '|SysOREntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry (conceptual row) in the sysORTable."))

(defclass |SysOREntry| (sequence-type)
  ((|sysORIndex| :type integer)
   (|sysORID| :type object-id)
   (|sysORDescr| :type |DisplayString|)
   (|sysORUpTime| :type |TimeStamp|)))

(defoid |sysORIndex| (|sysOREntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The auxiliary variable used for identifying instances
            of the columnar objects in the sysORTable."))

(defoid |sysORID| (|sysOREntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An authoritative identification of a capabilities
            statement with respect to various MIB modules supported
            by the local SNMP application acting as a command
            responder."))

(defoid |sysORDescr| (|sysOREntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual description of the capabilities identified
            by the corresponding instance of sysORID."))

(defoid |sysORUpTime| (|sysOREntry| 4)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this conceptual
            row was last instantiated."))

(defoid |snmp| (|mib-2| 11) (:type 'object-identity))

(defoid |snmpInPkts| (|snmp| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of messages delivered to the SNMP
            entity from the transport service."))

(defoid |snmpInBadVersions| (|snmp| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of SNMP messages which were delivered
            to the SNMP entity and were for an unsupported SNMP
            version."))

(defoid |snmpInBadCommunityNames| (|snmp| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of community-based SNMP messages (for
           example,  SNMPv1) delivered to the SNMP entity which
           used an SNMP community name not known to said entity.
           Also, implementations which authenticate community-based
           SNMP messages using check(s) in addition to matching
           the community name (for example, by also checking
           whether the message originated from a transport address
           allowed to use a specified community name) MAY include
           in this value the number of messages which failed the
           additional check(s).  It is strongly RECOMMENDED that

           the documentation for any security model which is used
           to authenticate community-based SNMP messages specify
           the precise conditions that contribute to this value."))

(defoid |snmpInBadCommunityUses| (|snmp| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of community-based SNMP messages (for
           example, SNMPv1) delivered to the SNMP entity which
           represented an SNMP operation that was not allowed for
           the SNMP community named in the message.  The precise
           conditions under which this counter is incremented
           (if at all) depend on how the SNMP entity implements
           its access control mechanism and how its applications
           interact with that access control mechanism.  It is
           strongly RECOMMENDED that the documentation for any
           access control mechanism which is used to control access
           to and visibility of MIB instrumentation specify the
           precise conditions that contribute to this value."))

(defoid |snmpInASNParseErrs| (|snmp| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of ASN.1 or BER errors encountered by
            the SNMP entity when decoding received SNMP messages."))

(defoid |snmpEnableAuthenTraps| (|snmp| 30)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Indicates whether the SNMP entity is permitted to
            generate authenticationFailure traps.  The value of this
            object overrides any configuration information; as such,
            it provides a means whereby all authenticationFailure
            traps may be disabled.

            Note that it is strongly recommended that this object
            be stored in non-volatile memory so that it remains
            constant across re-initializations of the network
            management system."))

(defoid |snmpSilentDrops| (|snmp| 31)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of Confirmed Class PDUs (such as
           GetRequest-PDUs, GetNextRequest-PDUs,
           GetBulkRequest-PDUs, SetRequest-PDUs, and
           InformRequest-PDUs) delivered to the SNMP entity which
           were silently dropped because the size of a reply
           containing an alternate Response Class PDU (such as a
           Response-PDU) with an empty variable-bindings field
           was greater than either a local constraint or the
           maximum message size associated with the originator of
           the request."))

(defoid |snmpProxyDrops| (|snmp| 32)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of Confirmed Class PDUs
            (such as GetRequest-PDUs, GetNextRequest-PDUs,
            GetBulkRequest-PDUs, SetRequest-PDUs, and
            InformRequest-PDUs) delivered to the SNMP entity which
            were silently dropped because the transmission of
            the (possibly translated) message to a proxy target
            failed in a manner (other than a time-out) such that
            no Response Class PDU (such as a Response-PDU) could
            be returned."))

(defoid |snmpTrap| (|snmpMIBObjects| 4) (:type 'object-identity))

(defoid |snmpTrapOID| (|snmpTrap| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The authoritative identification of the notification
            currently being sent.  This variable occurs as
            the second varbind in every SNMPv2-Trap-PDU and
            InformRequest-PDU."))

(defoid |snmpTrapEnterprise| (|snmpTrap| 3)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "The authoritative identification of the enterprise
            associated with the trap currently being sent.  When an
            SNMP proxy agent is mapping an RFC1157 Trap-PDU
            into a SNMPv2-Trap-PDU, this variable occurs as the
            last varbind."))

(defoid |snmpTraps| (|snmpMIBObjects| 5) (:type 'object-identity))

(defoid |coldStart| (|snmpTraps| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "A coldStart trap signifies that the SNMP entity,
            supporting a notification originator application, is
            reinitializing itself and that its configuration may
            have been altered."))

(defoid |warmStart| (|snmpTraps| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "A warmStart trap signifies that the SNMP entity,
            supporting a notification originator application,
            is reinitializing itself such that its configuration
            is unaltered."))

(defoid |authenticationFailure| (|snmpTraps| 5)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "An authenticationFailure trap signifies that the SNMP
             entity has received a protocol message that is not
             properly authenticated.  While all implementations
             of SNMP entities MAY be capable of generating this
             trap, the snmpEnableAuthenTraps object indicates
             whether this trap will be generated."))

(defoid |snmpSet| (|snmpMIBObjects| 6) (:type 'object-identity))

(defoid |snmpSetSerialNo| (|snmpSet| 1)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "An advisory lock used to allow several cooperating
            command generator applications to coordinate their
            use of the SNMP set operation.

            This object is used for coarse-grain coordination.
            To achieve fine-grain coordination, one or more similar
            objects might be defined within each MIB group, as
            appropriate."))

(defoid |snmpMIBConformance| (|snmpMIB| 2) (:type 'object-identity))

(defoid |snmpMIBCompliances| (|snmpMIBConformance| 1)
  (:type 'object-identity))

(defoid |snmpMIBGroups| (|snmpMIBConformance| 2)
  (:type 'object-identity))

(defoid |snmpBasicCompliance| (|snmpMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for SNMPv2 entities which
            implement the SNMPv2 MIB.

            This compliance statement is replaced by
            snmpBasicComplianceRev2."))

(defoid |snmpBasicComplianceRev2| (|snmpMIBCompliances| 3)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which
            implement this MIB module."))

(defoid |snmpGroup| (|snmpMIBGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic instrumentation
            and control of an SNMP entity."))

(defoid |snmpCommunityGroup| (|snmpMIBGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic instrumentation
            of a SNMP entity which supports community-based
            authentication."))

(defoid |snmpSetGroup| (|snmpMIBGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects which allow several cooperating
            command generator applications to coordinate their
            use of the set operation."))

(defoid |systemGroup| (|snmpMIBGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The system group defines objects which are common to all
            managed systems."))

(defoid |snmpBasicNotificationsGroup| (|snmpMIBGroups| 7)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "The basic notifications implemented by an SNMP entity
        supporting command responder applications."))

(defoid |snmpWarmStartNotificationGroup| (|snmpMIBGroups| 11)
  (:type 'notification-group)
  (:status '|current|)
  (:description
   "An additional notification for an SNMP entity supporting
     command responder applications, if it is able to reinitialize
     itself such that its configuration is unaltered."))

(defoid |snmpNotificationGroup| (|snmpMIBGroups| 12)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required for entities
            which support notification originator applications."))

(defoid |snmpOutPkts| (|snmp| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Messages which were
            passed from the SNMP protocol entity to the
            transport service."))

(defoid |snmpInTooBigs| (|snmp| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field was
            `tooBig'."))

(defoid |snmpInNoSuchNames| (|snmp| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field was
            `noSuchName'."))

(defoid |snmpInBadValues| (|snmp| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were
            delivered to the SNMP protocol entity and for
            which the value of the error-status field was
            `badValue'."))

(defoid |snmpInReadOnlys| (|snmp| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number valid SNMP PDUs which were delivered
            to the SNMP protocol entity and for which the value
            of the error-status field was `readOnly'.  It should
            be noted that it is a protocol error to generate an
            SNMP PDU which contains the value `readOnly' in the
            error-status field, as such this object is provided
            as a means of detecting incorrect implementations of
            the SNMP."))

(defoid |snmpInGenErrs| (|snmp| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were delivered
            to the SNMP protocol entity and for which the value
            of the error-status field was `genErr'."))

(defoid |snmpInTotalReqVars| (|snmp| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of MIB objects which have been
            retrieved successfully by the SNMP protocol entity
            as the result of receiving valid SNMP Get-Request
            and Get-Next PDUs."))

(defoid |snmpInTotalSetVars| (|snmp| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of MIB objects which have been
            altered successfully by the SNMP protocol entity as
            the result of receiving valid SNMP Set-Request PDUs."))

(defoid |snmpInGetRequests| (|snmp| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Get-Request PDUs which
            have been accepted and processed by the SNMP
            protocol entity."))

(defoid |snmpInGetNexts| (|snmp| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Get-Next PDUs which have been
            accepted and processed by the SNMP protocol entity."))

(defoid |snmpInSetRequests| (|snmp| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Set-Request PDUs which
            have been accepted and processed by the SNMP protocol
            entity."))

(defoid |snmpInGetResponses| (|snmp| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Get-Response PDUs which
            have been accepted and processed by the SNMP protocol
            entity."))

(defoid |snmpInTraps| (|snmp| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Trap PDUs which have been
            accepted and processed by the SNMP protocol entity."))

(defoid |snmpOutTooBigs| (|snmp| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were generated
            by the SNMP protocol entity and for which the value
            of the error-status field was `tooBig.'"))

(defoid |snmpOutNoSuchNames| (|snmp| 21)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were generated
            by the SNMP protocol entity and for which the value
            of the error-status was `noSuchName'."))

(defoid |snmpOutBadValues| (|snmp| 22)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were generated
            by the SNMP protocol entity and for which the value
            of the error-status field was `badValue'."))

(defoid |snmpOutGenErrs| (|snmp| 24)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP PDUs which were generated
            by the SNMP protocol entity and for which the value
            of the error-status field was `genErr'."))

(defoid |snmpOutGetRequests| (|snmp| 25)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Get-Request PDUs which
            have been generated by the SNMP protocol entity."))

(defoid |snmpOutGetNexts| (|snmp| 26)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Get-Next PDUs which have
            been generated by the SNMP protocol entity."))

(defoid |snmpOutSetRequests| (|snmp| 27)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Set-Request PDUs which
            have been generated by the SNMP protocol entity."))

(defoid |snmpOutGetResponses| (|snmp| 28)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Get-Response PDUs which
            have been generated by the SNMP protocol entity."))

(defoid |snmpOutTraps| (|snmp| 29)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The total number of SNMP Trap PDUs which have
            been generated by the SNMP protocol entity."))

(defoid |snmpObsoleteGroup| (|snmpMIBGroups| 10)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description
   "A collection of objects from RFC 1213 made obsolete
            by this MIB module."))

(eval-when (:load-toplevel :execute)
  (pushnew '|SNMPv2-MIB| *mib-modules*)
  (setf *current-module* nil))

