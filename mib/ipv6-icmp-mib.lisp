;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IPV6-ICMP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ipv6-icmp-mib))

(defpackage :asn.1/ipv6-icmp-mib
  (:nicknames :ipv6-icmp-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Counter32| |mib-2|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/ipv6-mib |ipv6IfEntry|))

(in-package :ipv6-icmp-mib)

(defoid |ipv6IcmpMIB| (|mib-2| 56)
  (:type 'module-identity)
  (:description
   "The MIB module for entities implementing
        the ICMPv6."))

(defoid |ipv6IcmpMIBObjects| (|ipv6IcmpMIB| 1) (:type 'object-identity))

(defoid |ipv6IfIcmpTable| (|ipv6IcmpMIBObjects| 1)
  (:type 'object-type)
  (:syntax '(vector |Ipv6IfIcmpEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "IPv6 ICMP statistics. This table contains statistics
      of ICMPv6 messages that are received and sourced by
      the entity."))

(defoid |ipv6IfIcmpEntry| (|ipv6IfIcmpTable| 1)
  (:type 'object-type)
  (:syntax '|Ipv6IfIcmpEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An ICMPv6 statistics entry containing
      objects at a particular IPv6 interface.

      Note that a receiving interface is
      the interface to which a given ICMPv6 message
      is addressed which may not be necessarily
      the input interface for the message.

      Similarly,  the sending interface is
      the interface that sources a given
      ICMP message which is usually but not
      necessarily the output interface for the message."))

(defclass |Ipv6IfIcmpEntry|
          (sequence-type)
          ((|ipv6IfIcmpInMsgs| :type |Counter32|)
           (|ipv6IfIcmpInErrors| :type |Counter32|)
           (|ipv6IfIcmpInDestUnreachs| :type |Counter32|)
           (|ipv6IfIcmpInAdminProhibs| :type |Counter32|)
           (|ipv6IfIcmpInTimeExcds| :type |Counter32|)
           (|ipv6IfIcmpInParmProblems| :type |Counter32|)
           (|ipv6IfIcmpInPktTooBigs| :type |Counter32|)
           (|ipv6IfIcmpInEchos| :type |Counter32|)
           (|ipv6IfIcmpInEchoReplies| :type |Counter32|)
           (|ipv6IfIcmpInRouterSolicits| :type |Counter32|)
           (|ipv6IfIcmpInRouterAdvertisements| :type |Counter32|)
           (|ipv6IfIcmpInNeighborSolicits| :type |Counter32|)
           (|ipv6IfIcmpInNeighborAdvertisements| :type |Counter32|)
           (|ipv6IfIcmpInRedirects| :type |Counter32|)
           (|ipv6IfIcmpInGroupMembQueries| :type |Counter32|)
           (|ipv6IfIcmpInGroupMembResponses| :type |Counter32|)
           (|ipv6IfIcmpInGroupMembReductions| :type |Counter32|)
           (|ipv6IfIcmpOutMsgs| :type |Counter32|)
           (|ipv6IfIcmpOutErrors| :type |Counter32|)
           (|ipv6IfIcmpOutDestUnreachs| :type |Counter32|)
           (|ipv6IfIcmpOutAdminProhibs| :type |Counter32|)
           (|ipv6IfIcmpOutTimeExcds| :type |Counter32|)
           (|ipv6IfIcmpOutParmProblems| :type |Counter32|)
           (|ipv6IfIcmpOutPktTooBigs| :type |Counter32|)
           (|ipv6IfIcmpOutEchos| :type |Counter32|)
           (|ipv6IfIcmpOutEchoReplies| :type |Counter32|)
           (|ipv6IfIcmpOutRouterSolicits| :type |Counter32|)
           (|ipv6IfIcmpOutRouterAdvertisements| :type |Counter32|)
           (|ipv6IfIcmpOutNeighborSolicits| :type |Counter32|)
           (|ipv6IfIcmpOutNeighborAdvertisements| :type |Counter32|)
           (|ipv6IfIcmpOutRedirects| :type |Counter32|)
           (|ipv6IfIcmpOutGroupMembQueries| :type |Counter32|)
           (|ipv6IfIcmpOutGroupMembResponses| :type |Counter32|)
           (|ipv6IfIcmpOutGroupMembReductions| :type |Counter32|)))

(defoid |ipv6IfIcmpInMsgs| (|ipv6IfIcmpEntry| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of ICMP messages received
      by the interface which includes all those
      counted by ipv6IfIcmpInErrors. Note that this
      interface is the interface to which the
      ICMP messages were addressed which may not be
      necessarily the input interface for the messages."))

(defoid |ipv6IfIcmpInErrors| (|ipv6IfIcmpEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP messages which the interface
      received but determined as having ICMP-specific
      errors (bad ICMP checksums, bad length, etc.)."))

(defoid |ipv6IfIcmpInDestUnreachs| (|ipv6IfIcmpEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Destination Unreachable
      messages received by the interface."))

(defoid |ipv6IfIcmpInAdminProhibs| (|ipv6IfIcmpEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP destination
      unreachable/communication administratively
      prohibited messages received by the interface."))

(defoid |ipv6IfIcmpInTimeExcds| (|ipv6IfIcmpEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Time Exceeded messages
       received by the interface."))

(defoid |ipv6IfIcmpInParmProblems| (|ipv6IfIcmpEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Parameter Problem messages
       received by the interface."))

(defoid |ipv6IfIcmpInPktTooBigs| (|ipv6IfIcmpEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Packet Too Big messages
      received by the interface."))

(defoid |ipv6IfIcmpInEchos| (|ipv6IfIcmpEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Echo (request) messages
       received by the interface."))

(defoid |ipv6IfIcmpInEchoReplies| (|ipv6IfIcmpEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Echo Reply messages received
      by the interface."))

(defoid |ipv6IfIcmpInRouterSolicits| (|ipv6IfIcmpEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Router Solicit messages
       received by the interface."))

(defoid |ipv6IfIcmpInRouterAdvertisements| (|ipv6IfIcmpEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Router Advertisement messages
      received by the interface."))

(defoid |ipv6IfIcmpInNeighborSolicits| (|ipv6IfIcmpEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Neighbor Solicit messages
       received by the interface."))

(defoid |ipv6IfIcmpInNeighborAdvertisements| (|ipv6IfIcmpEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Neighbor Advertisement
      messages received by the interface."))

(defoid |ipv6IfIcmpInRedirects| (|ipv6IfIcmpEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of Redirect messages received
      by the interface."))

(defoid |ipv6IfIcmpInGroupMembQueries| (|ipv6IfIcmpEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMPv6 Group Membership Query
      messages received by the interface."))

(defoid |ipv6IfIcmpInGroupMembResponses| (|ipv6IfIcmpEntry| 16)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMPv6 Group Membership Response messages
      received by the interface."))

(defoid |ipv6IfIcmpInGroupMembReductions| (|ipv6IfIcmpEntry| 17)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMPv6 Group Membership Reduction messages
      received by the interface."))

(defoid |ipv6IfIcmpOutMsgs| (|ipv6IfIcmpEntry| 18)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of ICMP messages which this
      interface attempted to send.  Note that this counter
      includes all those counted by icmpOutErrors."))

(defoid |ipv6IfIcmpOutErrors| (|ipv6IfIcmpEntry| 19)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP messages which this interface did
      not send due to problems discovered within ICMP
      such as a lack of buffers.  This value should not
      include errors discovered outside the ICMP layer
      such as the inability of IPv6 to route the resultant
      datagram.  In some implementations there may be no
      types of error which contribute to this counter's
      value."))

(defoid |ipv6IfIcmpOutDestUnreachs| (|ipv6IfIcmpEntry| 20)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Destination Unreachable

      messages sent by the interface."))

(defoid |ipv6IfIcmpOutAdminProhibs| (|ipv6IfIcmpEntry| 21)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Number of ICMP dest unreachable/communication
       administratively prohibited messages sent."))

(defoid |ipv6IfIcmpOutTimeExcds| (|ipv6IfIcmpEntry| 22)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Time Exceeded messages sent
      by the interface."))

(defoid |ipv6IfIcmpOutParmProblems| (|ipv6IfIcmpEntry| 23)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Parameter Problem messages
      sent by the interface."))

(defoid |ipv6IfIcmpOutPktTooBigs| (|ipv6IfIcmpEntry| 24)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Packet Too Big messages sent
      by the interface."))

(defoid |ipv6IfIcmpOutEchos| (|ipv6IfIcmpEntry| 25)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Echo (request) messages sent
      by the interface."))

(defoid |ipv6IfIcmpOutEchoReplies| (|ipv6IfIcmpEntry| 26)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Echo Reply messages sent
      by the interface."))

(defoid |ipv6IfIcmpOutRouterSolicits| (|ipv6IfIcmpEntry| 27)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Router Solicitation messages
       sent by the interface."))

(defoid |ipv6IfIcmpOutRouterAdvertisements| (|ipv6IfIcmpEntry| 28)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Router Advertisement messages
      sent by the interface."))

(defoid |ipv6IfIcmpOutNeighborSolicits| (|ipv6IfIcmpEntry| 29)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Neighbor Solicitation
       messages sent by the interface."))

(defoid |ipv6IfIcmpOutNeighborAdvertisements| (|ipv6IfIcmpEntry| 30)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMP Neighbor Advertisement
      messages sent by the interface."))

(defoid |ipv6IfIcmpOutRedirects| (|ipv6IfIcmpEntry| 31)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of Redirect messages sent. For
      a host, this object will always be zero,
      since hosts do not send redirects."))

(defoid |ipv6IfIcmpOutGroupMembQueries| (|ipv6IfIcmpEntry| 32)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMPv6 Group Membership Query
      messages sent."))

(defoid |ipv6IfIcmpOutGroupMembResponses| (|ipv6IfIcmpEntry| 33)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMPv6 Group Membership Response
      messages sent."))

(defoid |ipv6IfIcmpOutGroupMembReductions| (|ipv6IfIcmpEntry| 34)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ICMPv6 Group Membership Reduction
      messages sent."))

(defoid |ipv6IcmpConformance| (|ipv6IcmpMIB| 2)
  (:type 'object-identity))

(defoid |ipv6IcmpCompliances| (|ipv6IcmpConformance| 1)
  (:type 'object-identity))

(defoid |ipv6IcmpGroups| (|ipv6IcmpConformance| 2)
  (:type 'object-identity))

(defoid |ipv6IcmpCompliance| (|ipv6IcmpCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMPv2 entities which
      implement ICMPv6."))

(defoid |ipv6IcmpGroup| (|ipv6IcmpGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The ICMPv6 group of objects providing information
          specific to ICMPv6."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ipv6-icmp-mib *mib-modules*)
  (setf *current-module* nil))

