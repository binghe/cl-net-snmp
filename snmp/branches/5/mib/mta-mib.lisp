;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;MTA-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'mta-mib)
(eval-when (:load-toplevel :execute) (pushnew 'mta-mib *mib-modules*))
(defoid |mta| (|mib-2| 28)
  (:type 'module-identity)
  (:description
   "The MIB module describing Message Transfer Agents (MTAs)"))
(defoid |mtaTable| (|mta| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The table holding information specific to an MTA."))
(defoid |mtaEntry| (|mtaTable| 1)
  (:type 'object-type)
  (:syntax '|MtaEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The entry associated with each MTA."))
(deftype |MtaEntry| () 't)
(defoid |mtaReceivedMessages| (|mtaEntry| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages received since MTA initialization.
      This includes messages transmitted to this MTA from other
      MTAs as well as messages that have been submitted to the
      MTA directly by end-users or applications."))
(defoid |mtaStoredMessages| (|mtaEntry| 2)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of messages currently stored in the MTA.
      This includes messages that are awaiting transmission to
      some other MTA or are waiting for delivery to an end-user
      or application."))
(defoid |mtaTransmittedMessages| (|mtaEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages transmitted since MTA initialization.
      This includes messages that were transmitted to some other
      MTA or are waiting for delivery to an end-user or
      application."))
(defoid |mtaReceivedVolume| (|mtaEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total volume of messages received since MTA
      initialization, measured in kilo-octets.  This volume should
      include all transferred data that is logically above the mail
      transport protocol level.  For example, an SMTP-based MTA
      should use the number of kilo-octets in the message header
      and body, while an X.400-based MTA should use the number of
      kilo-octets of P2 data.  This includes messages transmitted
      to this MTA from other MTAs as well as messages that have
      been submitted to the MTA directly by end-users or
      applications."))
(defoid |mtaStoredVolume| (|mtaEntry| 5)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total volume of messages currently stored in the MTA,
      measured in kilo-octets.  This volume should include all
      stored data that is logically above the mail transport
      protocol level.  For example, an SMTP-based MTA should
      use the number of kilo-octets in the message header and
      body, while an X.400-based MTA would use the number of
      kilo-octets of P2 data.  This includes messages that are
      awaiting transmission to some other MTA or are waiting
      for delivery to an end-user or application."))
(defoid |mtaTransmittedVolume| (|mtaEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total volume of messages transmitted since MTA
      initialization, measured in kilo-octets.  This volume should
      include all transferred data that is logically above the mail
      transport protocol level.  For example, an SMTP-based MTA
      should use the number of kilo-octets in the message header
      and body, while an X.400-based MTA should use the number of
      kilo-octets of P2 data.  This includes messages that were
      transmitted to some other MTA or are waiting for delivery
      to an end-user or application."))
(defoid |mtaReceivedRecipients| (|mtaEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of recipients specified in all messages
      received since MTA initialization.  Recipients this MTA
      has no responsibility for, i.e. inactive envelope
      recipients or ones referred to in message headers,
      should not be counted even if information about such
      recipients is available.  This includes messages
      transmitted to this MTA from other MTAs as well as
      messages that have been submitted to the MTA directly
      by end-users or applications."))
(defoid |mtaStoredRecipients| (|mtaEntry| 8)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of recipients specified in all messages
      currently stored in the MTA.  Recipients this MTA has no
      responsibility for, i.e. inactive envelope recipients or
      ones referred to in message headers, should not be
      counted.  This includes messages that are awaiting
      transmission to some other MTA or are waiting for
      delivery to an end-user or application."))
(defoid |mtaTransmittedRecipients| (|mtaEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of recipients specified in all messages
      transmitted since MTA initialization.  Recipients this
      MTA had no responsibility for, i.e. inactive envelope
      recipients or ones referred to in message headers,
      should not be counted.  This includes messages that were
      transmitted to some other MTA or are waiting for
      delivery to an end-user or application."))
(defoid |mtaSuccessfulConvertedMessages| (|mtaEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages that have been successfully
      converted from one form to another since MTA
      initialization."))
(defoid |mtaFailedConvertedMessages| (|mtaEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages for which an unsuccessful
      attempt was made to convert them from one form to
      another since MTA initialization."))
(defoid |mtaLoopsDetected| (|mtaEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A message loop is defined as a situation where the MTA
      decides that a given message will never be delivered to
      one or more recipients and instead will continue to
      loop endlessly through one or more MTAs.  This variable
      counts the number of times the MTA has detected such a
      situation since MTA initialization. Note that the
      mechanism MTAs use to detect loops (e.g., trace field
      counting, count of references to this MTA in a trace
      field, examination of DNS or other directory information,
      etc.), the level at which loops are detected (e.g., per
      message, per recipient, per directory entry, etc.), and
      the handling of a loop once it is detected (e.g., looping

      messages are held, looping messages are bounced or sent
      to the postmaster, messages that the MTA knows will loop
      won't be accepted, etc.) vary widely from one MTA to the
      next and cannot be inferred from this variable."))
(defoid |mtaGroupTable| (|mta| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table holding information specific to each MTA group."))
(defoid |mtaGroupEntry| (|mtaGroupTable| 1)
  (:type 'object-type)
  (:syntax '|MtaGroupEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The entry associated with each MTA group."))
(deftype |MtaGroupEntry| () 't)
(defoid |mtaGroupIndex| (|mtaGroupEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The index associated with a group for a given MTA."))
(defoid |mtaGroupReceivedMessages| (|mtaGroupEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages received to this group since
      group creation."))
(defoid |mtaGroupRejectedMessages| (|mtaGroupEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages rejected by this group since
      group creation."))
(defoid |mtaGroupStoredMessages| (|mtaGroupEntry| 4)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of messages currently stored in this
      group's queue."))
(defoid |mtaGroupTransmittedMessages| (|mtaGroupEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages transmitted by this group since
      group creation."))
(defoid |mtaGroupReceivedVolume| (|mtaGroupEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total volume of messages received to this group since
      group creation, measured in kilo-octets.  This volume
      should include all transferred data that is logically above
      the mail transport protocol level.  For example, an
      SMTP-based MTA should use the number of kilo-octets in the
      message header and body, while an X.400-based MTA should use
      the number of kilo-octets of P2 data."))
(defoid |mtaGroupStoredVolume| (|mtaGroupEntry| 7)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total volume of messages currently stored in this
      group's queue, measured in kilo-octets.  This volume should
      include all stored data that is logically above the mail
      transport protocol level.  For example, an SMTP-based
      MTA should use the number of kilo-octets in the message
      header and body, while an X.400-based MTA would use the
      number of kilo-octets of P2 data."))
(defoid |mtaGroupTransmittedVolume| (|mtaGroupEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total volume of messages transmitted by this group
      since group creation, measured in kilo-octets.  This
      volume should include all transferred data that is logically
      above the mail transport protocol level.  For example, an
      SMTP-based MTA should use the number of kilo-octets in the
      message header and body, while an X.400-based MTA should use
      the number of kilo-octets of P2 data."))
(defoid |mtaGroupReceivedRecipients| (|mtaGroupEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of recipients specified in all messages
      received to this group since group creation.
      Recipients this MTA has no responsibility for should not
      be counted."))
(defoid |mtaGroupStoredRecipients| (|mtaGroupEntry| 10)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of recipients specified in all messages
      currently stored in this group's queue.  Recipients this
      MTA has no responsibility for should not be counted."))
(defoid |mtaGroupTransmittedRecipients| (|mtaGroupEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of recipients specified in all messages
      transmitted by this group since group creation.
      Recipients this MTA had no responsibility for should not
      be counted."))
(defoid |mtaGroupOldestMessageStored| (|mtaGroupEntry| 12)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Time since the oldest message in this group's queue was

      placed in the queue."))
(defoid |mtaGroupInboundAssociations| (|mtaGroupEntry| 13)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of current associations to the group, where the
      group is the responder."))
(defoid |mtaGroupOutboundAssociations| (|mtaGroupEntry| 14)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of current associations to the group, where the
     group is the initiator."))
(defoid |mtaGroupAccumulatedInboundAssociations| (|mtaGroupEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of associations to the group since
     group creation, where the MTA was the responder."))
(defoid |mtaGroupAccumulatedOutboundAssociations| (|mtaGroupEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of associations from the group since
      group creation, where the MTA was the initiator."))
(defoid |mtaGroupLastInboundActivity| (|mtaGroupEntry| 17)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Time since the last time that this group had an active
     inbound association for purposes of message reception."))
(defoid |mtaGroupLastOutboundActivity| (|mtaGroupEntry| 18)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Time since the last time that this group had a
      successful outbound association for purposes of
      message delivery."))
(defoid |mtaGroupLastOutboundAssociationAttempt| (|mtaGroupEntry| 34)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Time since the last time that this group attempted
      to make an outbound association for purposes of
      message delivery."))
(defoid |mtaGroupRejectedInboundAssociations| (|mtaGroupEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of inbound associations the group has
     rejected, since group creation.  Rejected associations
     are not counted in the accumulated association totals."))
(defoid |mtaGroupFailedOutboundAssociations| (|mtaGroupEntry| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number associations where the group was the
     initiator and association establishment has failed,
     since group creation.  Failed associations are
     not counted in the accumulated association totals."))
(defoid |mtaGroupInboundRejectionReason| (|mtaGroupEntry| 21)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The failure reason, if any, for the last association this
     group refused to respond to. If no association attempt

     has been made since the MTA was initialized the value
     should be 'never'."))
(defoid |mtaGroupOutboundConnectFailureReason| (|mtaGroupEntry| 22)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The failure reason, if any, for the last association attempt
     this group initiated. If no association attempt has been
     made since the MTA was initialized the value should be
     'never'."))
(defoid |mtaGroupScheduledRetry| (|mtaGroupEntry| 23)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of time until this group is next scheduled to
      attempt to make an association."))
(defoid |mtaGroupMailProtocol| (|mtaGroupEntry| 24)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An identification of the protocol being used by this group.
      For an group employing OSI protocols, this will be the
      Application Context.    For Internet applications, OID
      values of the form {applTCPProtoID port} or {applUDPProtoID
      port} are used for TCP-based and UDP-based protocols,
      respectively. In either case 'port' corresponds to the
      primary port number being used by the protocol. The
      usual IANA procedures may be used to register ports for
      new protocols. applTCPProtoID and applUDPProtoID are
      defined in the NETWORK-SERVICES-MIB, RFC 2788."))
(defoid |mtaGroupName| (|mtaGroupEntry| 25)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A descriptive name for the group. If this group connects to
      a single remote MTA this should be the name of that MTA. If

      this in turn is an Internet MTA this should be the domain
      name.  For an OSI MTA it should be the string encoded
      distinguished name of the managed object using the format
      defined in RFC 2253.  For X.400(1984) MTAs which do not
      have a Distinguished Name, the RFC 2156 syntax
      'mta in globalid' used in X400-Received: fields can be
      used."))
(defoid |mtaGroupSuccessfulConvertedMessages| (|mtaGroupEntry| 26)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages that have been successfully
      converted from one form to another in this group
      since group creation."))
(defoid |mtaGroupFailedConvertedMessages| (|mtaGroupEntry| 27)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of messages for which an unsuccessful
      attempt was made to convert them from one form to
      another in this group since group creation."))
(defoid |mtaGroupDescription| (|mtaGroupEntry| 28)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A description of the group's purpose.  This information is
      intended to identify the group in a status display."))
(defoid |mtaGroupURL| (|mtaGroupEntry| 29)
  (:type 'object-type)
  (:syntax '|URLString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A URL pointing to a description of the group.  This
      information is intended to identify and briefly describe
      the group in a status display."))
(defoid |mtaGroupCreationTime| (|mtaGroupEntry| 30)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Time since this group was first created."))
(defoid |mtaGroupHierarchy| (|mtaGroupEntry| 31)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Describes how this group fits into the hierarchy. A
      positive value is interpreted as an mtaGroupIndex
      value for some other group whose variables include
      those of this group (and usually others). A negative
      value is interpreted as a group collection code: Groups
      with common negative hierarchy values comprise one
      particular breakdown of MTA activity as a whole. A
      zero value means that this MIB implementation doesn't
      implement hierarchy indicators and thus the overall
      group hierarchy cannot be determined."))
(defoid |mtaGroupOldestMessageId| (|mtaGroupEntry| 32)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Message ID of the oldest message in the group's queue.
      Whenever possible this should be in the form of an
      RFC 822 msg-id; X.400 may convert X.400 message
      identifiers to this form by following the rules laid
      out in RFC2156."))
(defoid |mtaGroupLoopsDetected| (|mtaGroupEntry| 33)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A message loop is defined as a situation where the MTA
      decides that a given message will never be delivered to
      one or more recipients and instead will continue to
      loop endlessly through one or more MTAs.  This variable
      counts the number of times the MTA has detected such a
      situation in conjunction with something associated with

      this group since group creation.  Note that the
      mechanism MTAs use to detect loops (e.g., trace field
      counting, count of references to this MTA in a trace
      field, examination of DNS or other directory information,
      etc.), the level at which loops are detected (e.g., per
      message, per recipient, per directory entry, etc.), and
      the handling of a loop once it is detected (e.g., looping
      messages are held, looping messages are bounced or sent
      to the postmaster, messages that the MTA knows will loop
      won't be accepted, etc.) vary widely from one MTA to the
      next and cannot be inferred from this variable."))
(defoid |mtaGroupAssociationTable| (|mta| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table holding information regarding the associations
      for each MTA group."))
(defoid |mtaGroupAssociationEntry| (|mtaGroupAssociationTable| 1)
  (:type 'object-type)
  (:syntax '|MtaGroupAssociationEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The entry holding information regarding the associations
      for each MTA group."))
(deftype |MtaGroupAssociationEntry| () 't)
(defoid |mtaGroupAssociationIndex| (|mtaGroupAssociationEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reference into association table to allow correlation of
      this group's active associations with the association table."))
(defoid |mtaGroupErrorTable| (|mta| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table holding information regarding accumulated errors
      for each MTA group."))
(defoid |mtaGroupErrorEntry| (|mtaGroupErrorTable| 1)
  (:type 'object-type)
  (:syntax '|MtaGroupErrorEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The entry holding information regarding accumulated
      errors for each MTA group."))
(deftype |MtaGroupErrorEntry| () 't)
(defoid |mtaGroupInboundErrorCount| (|mtaGroupErrorEntry| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Count of the number of errors of a given type that have
      been accumulated in association with a particular group
      while processing incoming messages. In the case of SMTP

      these will typically be errors reporting by an SMTP
      server to the remote client; in the case of X.400
      these will typically be errors encountered while
      processing an incoming message."))
(defoid |mtaGroupInternalErrorCount| (|mtaGroupErrorEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Count of the number of errors of a given type that have
      been accumulated in association with a particular group
      during internal MTA processing."))
(defoid |mtaGroupOutboundErrorCount| (|mtaGroupErrorEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Count of the number of errors of a given type that have
      been accumulated in association with a particular group's
      outbound connection activities. In the case of an SMTP
      client these will typically be errors reported while
      attempting to contact or while communicating with the
      remote SMTP server. In the case of X.400 these will
      typically be errors encountered while constructing
      or attempting to deliver an outgoing message."))
(defoid |mtaStatusCode| (|mtaGroupErrorEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An index capable of representing an Enhanced Mail System
      Status Code.  Enhanced Mail System Status Codes are
      defined in RFC 1893.  These codes have the form

          class.subject.detail

      Here 'class' is either 2, 4, or 5 and both 'subject' and
      'detail'  are integers in the range 0..999. Given a status
      code the corresponding index value is defined to be
      ((class * 1000) + subject) * 1000 + detail.  Both SMTP
      error response codes and X.400 reason and diagnostic codes
      can be mapped into these codes, resulting in a namespace

      capable of describing most error conditions a mail system
      encounters in a generic yet detailed way."))
(defoid |mtaConformance| (|mta| 4) (:type 'object-identity))
(defoid |mtaGroups| (|mtaConformance| 1) (:type 'object-identity))
(defoid |mtaCompliances| (|mtaConformance| 2) (:type 'object-identity))
(defoid |mtaCompliance| (|mtaCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 1566 implementations
      which support the Mail Monitoring MIB for basic
      monitoring of MTAs."))
(defoid |mtaAssocCompliance| (|mtaCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 1566 implementations
      which support the Mail Monitoring MIB for monitoring
      of MTAs and their associations."))
(defoid |mtaRFC2249Compliance| (|mtaCompliances| 5)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2249 implementations
      which support the Mail Monitoring MIB for basic
      monitoring of MTAs."))
(defoid |mtaRFC2249AssocCompliance| (|mtaCompliances| 6)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2249 implementations

      which support the Mail Monitoring MIB for monitoring of
      MTAs and their associations."))
(defoid |mtaRFC2249ErrorCompliance| (|mtaCompliances| 7)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2249 implementations
      which support the Mail Monitoring MIB for monitoring of
      MTAs and detailed errors."))
(defoid |mtaRFC2249FullCompliance| (|mtaCompliances| 8)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2249 implementations
      which support the full Mail Monitoring MIB for
      monitoring of MTAs, associations, and detailed errors."))
(defoid |mtaRFC2789Compliance| (|mtaCompliances| 9)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2789 implementations
      which support the Mail Monitoring MIB for basic
      monitoring of MTAs."))
(defoid |mtaRFC2789AssocCompliance| (|mtaCompliances| 10)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2789 implementations
      which support the Mail Monitoring MIB for monitoring of
      MTAs and their associations."))
(defoid |mtaRFC2789ErrorCompliance| (|mtaCompliances| 11)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2789 implementations
      which support the Mail Monitoring MIB for monitoring of
      MTAs and detailed errors."))
(defoid |mtaRFC2789FullCompliance| (|mtaCompliances| 12)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2789 implementations
      which support the full Mail Monitoring MIB for
      monitoring of MTAs, associations, and detailed errors."))
(defoid |mtaRFC1566Group| (|mtaGroups| 10)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic monitoring of MTAs.
      This is the original set of such objects defined in RFC
      1566."))
(defoid |mtaRFC1566AssocGroup| (|mtaGroups| 11)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing monitoring of MTA
      associations.  This is the original set of such objects
      defined in RFC 1566."))
(defoid |mtaRFC2249Group| (|mtaGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic monitoring of MTAs.
      This group was originally defined in RFC 2249."))
(defoid |mtaRFC2249AssocGroup| (|mtaGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing monitoring of MTA
      associations.  This group was originally defined in RFC
      2249."))
(defoid |mtaRFC2249ErrorGroup| (|mtaGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing monitoring of
      detailed MTA errors.  This group was originally defined
      in RFC 2249."))
(defoid |mtaRFC2789Group| (|mtaGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic monitoring of MTAs.

      This is the appropriate group for RFC 2789."))
(defoid |mtaRFC2789AssocGroup| (|mtaGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing monitoring of MTA
      associations.  This is the appropriate group for RFC
      2789 association monitoring."))
(defoid |mtaRFC2789ErrorGroup| (|mtaGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing monitoring of
      detailed MTA errors.  This is the appropriate group
      for RFC 2789 error monitoring."))
