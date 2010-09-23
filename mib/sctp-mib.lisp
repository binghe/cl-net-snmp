;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:BASE;SCTP-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute) (setf *current-module* 'sctp-mib))

(defpackage :asn.1/sctp-mib
  (:nicknames :sctp-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Integer32| |Unsigned32| |Gauge32| |Counter32|
                |Counter64| |mib-2|)
  (:import-from :|ASN.1/SNMPv2-TC| |TimeStamp| |TruthValue|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/inet-address-mib |InetAddressType| |InetAddress|
                |InetPortNumber|))

(in-package :sctp-mib)

(defoid |sctpMIB| (|mib-2| 104)
  (:type 'module-identity)
  (:description
   "The MIB module for managing SCTP implementations.

       Copyright (C) The Internet Society (2004).  This version of
       this MIB module is part of RFC 3873; see the RFC itself for
       full legal notices. "))

(defoid |sctpObjects| (|sctpMIB| 1) (:type 'object-identity))

(defoid |sctpStats| (|sctpObjects| 1) (:type 'object-identity))

(defoid |sctpParams| (|sctpObjects| 2) (:type 'object-identity))

(defoid |sctpCurrEstab| (|sctpStats| 1)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of associations for which the current state is
       either ESTABLISHED, SHUTDOWN-RECEIVED or SHUTDOWN-PENDING.")
  (:reference
   "Section 4 in RFC2960 covers the SCTP   Association state
       diagram."))

(defoid |sctpActiveEstabs| (|sctpStats| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that associations have made a direct
       transition to the ESTABLISHED state from the COOKIE-ECHOED
       state: COOKIE-ECHOED -> ESTABLISHED. The upper layer initiated
       the association attempt.")
  (:reference
   "Section 4 in RFC2960 covers the SCTP   Association state
       diagram."))

(defoid |sctpPassiveEstabs| (|sctpStats| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that associations have made a direct
       transition to the ESTABLISHED state from the CLOSED state:
       CLOSED -> ESTABLISHED. The remote endpoint initiated the
       association attempt.")
  (:reference
   "Section 4 in RFC2960 covers the SCTP   Association state
       diagram."))

(defoid |sctpAborteds| (|sctpStats| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that associations have made a direct
       transition to the CLOSED state from any state using the
       primitive 'ABORT': AnyState --Abort--> CLOSED. Ungraceful
       termination of the association.")
  (:reference
   "Section 4 in RFC2960 covers the SCTP   Association state
       diagram."))

(defoid |sctpShutdowns| (|sctpStats| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that associations have made a direct
       transition to the CLOSED state from either the SHUTDOWN-SENT
       state or the SHUTDOWN-ACK-SENT state. Graceful termination of
       the association.")
  (:reference
   "Section 4 in RFC2960 covers the SCTP   Association state
       diagram."))

(defoid |sctpOutOfBlues| (|sctpStats| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of out of the blue packets received by the host.
       An out of the blue packet is an SCTP packet correctly formed,
       including the proper checksum, but for which the receiver was
       unable to identify an appropriate association.")
  (:reference
   "Section 8.4 in RFC2960 deals with the Out-Of-The-Blue
        (OOTB) packet definition and procedures."))

(defoid |sctpChecksumErrors| (|sctpStats| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP packets received with an invalid
       checksum.")
  (:reference
   "The checksum is located at the end of the SCTP packet as per
       Section 3.1 in RFC2960. RFC3309 updates SCTP to use a 32 bit
       CRC checksum."))

(defoid |sctpOutCtrlChunks| (|sctpStats| 8)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP control chunks sent (retransmissions are
       not included). Control chunks are those chunks different from
       DATA.")
  (:reference
   "Sections 1.3.5 and 1.4 in RFC2960 refer to control chunk as
       those chunks different from those that contain user
       information, i.e., DATA chunks."))

(defoid |sctpOutOrderChunks| (|sctpStats| 9)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP ordered data chunks sent (retransmissions
       are not included).")
  (:reference
   "Section 3.3.1 in RFC2960 defines the ordered data chunk."))

(defoid |sctpOutUnorderChunks| (|sctpStats| 10)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP unordered chunks (data chunks in which the
       U bit is set to 1) sent (retransmissions are not included).")
  (:reference
   "Section 3.3.1 in RFC2960 defines the unordered data chunk."))

(defoid |sctpInCtrlChunks| (|sctpStats| 11)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP control chunks received (no duplicate
       chunks included).")
  (:reference
   "Sections 1.3.5 and 1.4 in RFC2960 refer to control chunk as
       those chunks different from those that contain user
       information, i.e., DATA chunks."))

(defoid |sctpInOrderChunks| (|sctpStats| 12)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP ordered data chunks received (no duplicate
       chunks included).")
  (:reference
   "Section 3.3.1 in RFC2960 defines the ordered data chunk."))

(defoid |sctpInUnorderChunks| (|sctpStats| 13)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP unordered chunks (data chunks in which the
       U bit is set to 1) received (no duplicate chunks included).")
  (:reference
   "Section 3.3.1 in RFC2960 defines the unordered data chunk."))

(defoid |sctpFragUsrMsgs| (|sctpStats| 14)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of user messages that have to be fragmented
       because of the MTU."))

(defoid |sctpReasmUsrMsgs| (|sctpStats| 15)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of user messages reassembled, after conversion
       into DATA chunks.")
  (:reference
   "Section 6.9 in RFC2960 includes a description of the
       reassembly process."))

(defoid |sctpOutSCTPPacks| (|sctpStats| 16)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP packets sent. Retransmitted DATA chunks
       are included."))

(defoid |sctpInSCTPPacks| (|sctpStats| 17)
  (:type 'object-type)
  (:syntax '|Counter64|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of SCTP packets received. Duplicates are
       included."))

(defoid |sctpDiscontinuityTime| (|sctpStats| 18)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
       any one or more of this general statistics counters suffered a
       discontinuity.  The relevant counters are the specific
       instances associated with this interface of any Counter32 or
       Counter64 object contained in the SCTP layer statistics
       (defined below sctpStats branch).  If no such discontinuities
       have occurred since the last re-initialization of the local
       management subsystem, then this object contains a zero value.")
  (:reference
   "The inclusion of this object is recommended by RFC2578."))

(defoid |sctpRtoAlgorithm| (|sctpParams| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The algorithm used to determine the timeout value (T3-rtx)
       used for re-transmitting unacknowledged chunks.")
  (:reference
   "Section 6.3.1 and 6.3.2 in RFC2960 cover the RTO calculation
       and retransmission timer rules."))

(defoid |sctpRtoMin| (|sctpParams| 2)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum value permitted by a SCTP implementation for the
       retransmission timeout value, measured in milliseconds.  More
       refined semantics for objects of this type depend upon the
       algorithm used to determine the retransmission timeout value.

       A retransmission time value of zero means immediate
       retransmission.

       The value of this object has to be lower than or equal to
       stcpRtoMax's value."))

(defoid |sctpRtoMax| (|sctpParams| 3)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum value permitted by a SCTP implementation for the
       retransmission timeout value, measured in milliseconds.  More
       refined semantics for objects of this type depend upon the
       algorithm used to determine the retransmission timeout value.

       A retransmission time value of zero means immediate re-
       transmission.

       The value of this object has to be greater than or equal to
       stcpRtoMin's value."))

(defoid |sctpRtoInitial| (|sctpParams| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The initial value for the retransmission timer.

       A retransmission time value of zero means immediate re-
       transmission."))

(defoid |sctpMaxAssocs| (|sctpParams| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The limit on the total number of associations the entity can
       support. In entities where the maximum number of associations
       is dynamic, this object should contain the value -1."))

(defoid |sctpValCookieLife| (|sctpParams| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Valid cookie life in the 4-way start-up handshake procedure.")
  (:reference
   "Section 5.1.3 in RFC2960 explains the cookie generation
       process. Recommended value is per section 14 in RFC2960."))

(defoid |sctpMaxInitRetr| (|sctpParams| 7)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of retransmissions at the start-up phase
       (INIT and COOKIE ECHO chunks). ")
  (:reference
   "Section 5.1.4, 5.1.6 in RFC2960 refers to Max.Init.Retransmit
       parameter. Recommended value is per section 14 in RFC2960."))

(defoid |sctpAssocTable| (|sctpObjects| 3)
  (:type 'object-type)
  (:syntax '(vector |SctpAssocEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing SCTP association-specific information."))

(defoid |sctpAssocEntry| (|sctpAssocTable| 1)
  (:type 'object-type)
  (:syntax '|SctpAssocEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "General common variables and statistics for the whole
       association."))

(defclass |SctpAssocEntry|
          (sequence-type)
          ((|sctpAssocId| :type |Unsigned32|)
           (|sctpAssocRemHostName| :type octet-string)
           (|sctpAssocLocalPort| :type |InetPortNumber|)
           (|sctpAssocRemPort| :type |InetPortNumber|)
           (|sctpAssocRemPrimAddrType| :type |InetAddressType|)
           (|sctpAssocRemPrimAddr| :type |InetAddress|)
           (|sctpAssocHeartBeatInterval| :type |Unsigned32|)
           (|sctpAssocState| :type integer)
           (|sctpAssocInStreams| :type |Unsigned32|)
           (|sctpAssocOutStreams| :type |Unsigned32|)
           (|sctpAssocMaxRetr| :type |Unsigned32|)
           (|sctpAssocPrimProcess| :type |Unsigned32|)
           (|sctpAssocT1expireds| :type |Counter32|)
           (|sctpAssocT2expireds| :type |Counter32|)
           (|sctpAssocRtxChunks| :type |Counter32|)
           (|sctpAssocStartTime| :type |TimeStamp|)
           (|sctpAssocDiscontinuityTime| :type |TimeStamp|)))

(defoid |sctpAssocId| (|sctpAssocEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Association Identification. Value identifying the
       association. "))

(defoid |sctpAssocRemHostName| (|sctpAssocEntry| 2)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The peer's DNS name. This object needs to have the same
       format as the encoding in the DNS protocol.  This implies that
       the domain name can be up to 255 octets long, each octet being
       0<=x<=255 as value with US-ASCII A-Z having a case insensitive
       matching.

       If no DNS domain name was received from the peer at init time
       (embedded in the INIT or INIT-ACK chunk), this object is
       meaningless. In such cases the object MUST contain a zero-
       length string value. Otherwise, it contains the remote host
       name received at init time."))

(defoid |sctpAssocLocalPort| (|sctpAssocEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The local SCTP port number used for this association."))

(defoid |sctpAssocRemPort| (|sctpAssocEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The remote SCTP port number used for this association."))

(defoid |sctpAssocRemPrimAddrType| (|sctpAssocEntry| 5)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The internet type of primary remote IP address. "))

(defoid |sctpAssocRemPrimAddr| (|sctpAssocEntry| 6)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The primary remote IP address. The type of this address is
       determined by the value of sctpAssocRemPrimAddrType.

       The client side will know this value after INIT_ACK message
       reception, the server side will know this value when sending
       INIT_ACK message. However, values will be filled in at
       established(4) state."))

(defoid |sctpAssocHeartBeatInterval| (|sctpAssocEntry| 7)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current heartbeat interval..

       Zero value means no HeartBeat, even when the concerned
       sctpAssocRemAddrHBFlag object is true."))

(defoid |sctpAssocState| (|sctpAssocEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The state of this SCTP association.

       As in TCP, deleteTCB(9) is the only value that may be set by a
       management station. If any other value is received, then the
       agent must return a wrongValue error.

       If a management station sets this object to the value
       deleteTCB(9), then this has the effect of deleting the TCB (as
       defined in SCTP) of the corresponding association on the
       managed node, resulting in immediate termination of the
       association.

       As an implementation-specific option, an ABORT chunk may be
       sent from the managed node to the other SCTP endpoint as a
       result of setting the deleteTCB(9) value. The ABORT chunk
       implies an ungraceful association shutdown.")
  (:reference
   "Section 4 in RFC2960 covers the SCTP Association state
       diagram."))

(defoid |sctpAssocInStreams| (|sctpAssocEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Inbound Streams according to the negotiation at association
       start up.")
  (:reference
   "Section 1.3 in RFC2960 includes a definition of stream.
       Section 5.1.1 in RFC2960 covers the streams negotiation
       process."))

(defoid |sctpAssocOutStreams| (|sctpAssocEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Outbound Streams according to the negotiation at association
       start up. ")
  (:reference
   "Section 1.3 in RFC2960 includes a definition of stream.
       Section 5.1.1 in RFC2960 covers the streams negotiation
       process."))

(defoid |sctpAssocMaxRetr| (|sctpAssocEntry| 11)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of data retransmissions in the association
       context. This value is specific for each association and the
       upper layer can change it by calling the appropriate
       primitives. This value has to be smaller than the addition of
       all the maximum number for all the paths
       (sctpAssocRemAddrMaxPathRtx).

       A value of zero value means no retransmissions."))

(defoid |sctpAssocPrimProcess| (|sctpAssocEntry| 12)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object identifies the system level process which holds
       primary responsibility for the SCTP association.
       Wherever possible, this should be the system's native unique
       identification number. The special value 0 can be used to
       indicate that no primary process is known.

       Note that the value of this object can be used as a pointer
       into the swRunTable of the HOST-RESOURCES-MIB(if the value is
       smaller than 2147483647) or into the sysApplElmtRunTable of
       the SYSAPPL-MIB."))

(defoid |sctpAssocT1expireds| (|sctpAssocEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The T1 timer determines how long to wait for an
       acknowledgement after sending an INIT or COOKIE-ECHO chunk.
       This object reflects the number of times the T1 timer expires
       without having received the acknowledgement.

       Discontinuities in the value of this counter can occur at re-
       initialization of the management system, and at other times as
       indicated by the value of sctpAssocDiscontinuityTime.")
  (:reference "Section 5 in RFC2960."))

(defoid |sctpAssocT2expireds| (|sctpAssocEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The T2 timer determines how long to wait for an
       acknowledgement after sending a SHUTDOWN or SHUTDOWN-ACK
       chunk. This object reflects the number of times that T2- timer
       expired.

       Discontinuities in the value of this counter can occur at re-
       initialization of the management system, and at other times as
       indicated by the value of sctpAssocDiscontinuityTime.")
  (:reference "Section 9.2 in RFC2960."))

(defoid |sctpAssocRtxChunks| (|sctpAssocEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "When T3-rtx expires, the DATA chunks that triggered the T3
       timer will be re-sent according with the retransmissions
       rules. Every DATA chunk that was included in the SCTP packet
       that triggered the T3-rtx timer must be added to the value of
       this counter.

       Discontinuities in the value of this counter can occur at re-
       initialization of the management system, and at other times as
       indicated by the value of sctpAssocDiscontinuityTime.")
  (:reference
   "Section 6 in RFC2960 covers the retransmission process and
       rules."))

(defoid |sctpAssocStartTime| (|sctpAssocEntry| 16)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time that the association
       represented by this row enters the ESTABLISHED state, i.e.,
       the sctpAssocState object is set to established(4). The
       value of this object will be zero:
       - before the association enters the established(4)
         state, or

       - if the established(4) state was entered prior to
         the last re-initialization of the local network management
         subsystem."))

(defoid |sctpAssocDiscontinuityTime| (|sctpAssocEntry| 17)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime on the most recent occasion at which
       any one or more of this SCTP association counters suffered a
       discontinuity.  The relevant counters are the specific
       instances associated with this interface of any Counter32 or
       Counter64 object contained in the sctpAssocTable or
       sctpLocalAddrTable or sctpRemAddrTable.  If no such
       discontinuities have occurred since the last re-initialization
       of the local management subsystem, then this object contains a
       zero value. ")
  (:reference
   "The inclusion of this object is recommended by RFC2578."))

(defoid |sctpAssocLocalAddrTable| (|sctpObjects| 4)
  (:type 'object-type)
  (:syntax '(vector |SctpAssocLocalAddrEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Expanded table of sctpAssocTable based on the AssocId index.
       This table shows data related to each local IP address which
       is used by this association."))

(defoid |sctpAssocLocalAddrEntry| (|sctpAssocLocalAddrTable| 1)
  (:type 'object-type)
  (:syntax '|SctpAssocLocalAddrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Local information about the available addresses. There will
       be an entry for every local IP address defined for this

       association.
       Implementors need to be aware that if the size of
       sctpAssocLocalAddr exceeds 114 octets then OIDs of column
       instances in this table will have more than 128 sub-
       identifiers and cannot be accessed using SNMPv1, SNMPv2c, or
       SNMPv3."))

(defclass |SctpAssocLocalAddrEntry|
          (sequence-type)
          ((|sctpAssocLocalAddrType| :type |InetAddressType|)
           (|sctpAssocLocalAddr| :type |InetAddress|)
           (|sctpAssocLocalAddrStartTime| :type |TimeStamp|)))

(defoid |sctpAssocLocalAddrType| (|sctpAssocLocalAddrEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Internet type of local IP address used for this association."))

(defoid |sctpAssocLocalAddr| (|sctpAssocLocalAddrEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The value of a local IP address available for this
       association. The type of this address is determined by the
       value of sctpAssocLocalAddrType."))

(defoid |sctpAssocLocalAddrStartTime| (|sctpAssocLocalAddrEntry| 3)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time that this row was
       created."))

(defoid |sctpAssocRemAddrTable| (|sctpObjects| 5)
  (:type 'object-type)
  (:syntax '(vector |SctpAssocRemAddrEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Expanded table of sctpAssocTable based on the AssocId index.
       This table shows data related to each remote peer IP address
       which is used by this association."))

(defoid |sctpAssocRemAddrEntry| (|sctpAssocRemAddrTable| 1)
  (:type 'object-type)
  (:syntax '|SctpAssocRemAddrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about the most important variables for every
       remote IP address. There will be an entry for every remote IP
       address defined for this association.

       Implementors need to be aware that if the size of
       sctpAssocRemAddr exceeds 114 octets then OIDs of column
       instances in this table will have more than 128 sub-
       identifiers and cannot be accessed using SNMPv1, SNMPv2c, or
       SNMPv3."))

(defclass |SctpAssocRemAddrEntry|
          (sequence-type)
          ((|sctpAssocRemAddrType| :type |InetAddressType|)
           (|sctpAssocRemAddr| :type |InetAddress|)
           (|sctpAssocRemAddrActive| :type |TruthValue|)
           (|sctpAssocRemAddrHBActive| :type |TruthValue|)
           (|sctpAssocRemAddrRTO| :type |Unsigned32|)
           (|sctpAssocRemAddrMaxPathRtx| :type |Unsigned32|)
           (|sctpAssocRemAddrRtx| :type |Counter32|)
           (|sctpAssocRemAddrStartTime| :type |TimeStamp|)))

(defoid |sctpAssocRemAddrType| (|sctpAssocRemAddrEntry| 1)
  (:type 'object-type)
  (:syntax '|InetAddressType|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Internet type of a remote IP address available for this
       association."))

(defoid |sctpAssocRemAddr| (|sctpAssocRemAddrEntry| 2)
  (:type 'object-type)
  (:syntax '|InetAddress|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The value of a remote IP address available for this
       association. The type of this address is determined by the
       value of sctpAssocLocalAddrType."))

(defoid |sctpAssocRemAddrActive| (|sctpAssocRemAddrEntry| 3)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object gives information about the reachability of this
       specific remote IP address.

       When the object is set to 'true' (1), the remote IP address is
       understood as Active. Active means that the threshold of no
       answers received from this IP address has not been reached.

       When the object is set to 'false' (2), the remote IP address
       is understood as Inactive. Inactive means that either no
       heartbeat or any other message was received from this address,
       reaching the threshold defined by the protocol.")
  (:reference
   "The remote transport states are defined as Active and
       Inactive in the SCTP, RFC2960."))

(defoid |sctpAssocRemAddrHBActive| (|sctpAssocRemAddrEntry| 4)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object indicates whether the optional Heartbeat check
       associated to one destination transport address is activated
       or not (value equal to true or false, respectively). "))

(defoid |sctpAssocRemAddrRTO| (|sctpAssocRemAddrEntry| 5)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current Retransmission Timeout. T3-rtx timer as defined
       in the protocol SCTP.")
  (:reference
   "Section 6.3 in RFC2960 deals with the Retransmission Timer
       Management."))

(defoid |sctpAssocRemAddrMaxPathRtx| (|sctpAssocRemAddrEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Maximum number of DATA chunks retransmissions allowed to a
       remote IP address before it is considered inactive, as defined
       in RFC2960.")
  (:reference "Section 8.2, 8.3 and 14 in RFC2960."))

(defoid |sctpAssocRemAddrRtx| (|sctpAssocRemAddrEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Number of DATA chunks retransmissions to this specific IP
       address. When T3-rtx expires, the DATA chunk that triggered
       the T3 timer will be re-sent according to the retransmissions
       rules. Every DATA chunk that is included in a SCTP packet and
       was transmitted to this specific IP address before, will be
       included in this counter.

       Discontinuities in the value of this counter can occur at re-
       initialization of the management system, and at other times as
       indicated by the value of sctpAssocDiscontinuityTime."))

(defoid |sctpAssocRemAddrStartTime| (|sctpAssocRemAddrEntry| 8)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time that this row was
       created."))

(defoid |sctpLookupLocalPortTable| (|sctpObjects| 6)
  (:type 'object-type)
  (:syntax '(vector |SctpLookupLocalPortEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "With the use of this table, a list of associations which are

       using the specified local port can be retrieved."))

(defoid |sctpLookupLocalPortEntry| (|sctpLookupLocalPortTable| 1)
  (:type 'object-type)
  (:syntax '|SctpLookupLocalPortEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is indexed by local port and association ID.
       Specifying a local port, we would get a list of the
       associations whose local port is the one specified."))

(defclass |SctpLookupLocalPortEntry|
          (sequence-type)
          ((|sctpLookupLocalPortStartTime| :type |TimeStamp|)))

(defoid |sctpLookupLocalPortStartTime| (|sctpLookupLocalPortEntry| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time that this row was created.

       As the table will be created after the sctpAssocTable
       creation, this value could be equal to the sctpAssocStartTime
       object from the main table."))

(defoid |sctpLookupRemPortTable| (|sctpObjects| 7)
  (:type 'object-type)
  (:syntax '(vector |SctpLookupRemPortEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "With the use of this table, a list of associations which are
       using the specified remote port can be got"))

(defoid |sctpLookupRemPortEntry| (|sctpLookupRemPortTable| 1)
  (:type 'object-type)
  (:syntax '|SctpLookupRemPortEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is indexed by remote port and association ID.
       Specifying a remote port we would get a list of the
       associations whose local port is the one specified "))

(defclass |SctpLookupRemPortEntry|
          (sequence-type)
          ((|sctpLookupRemPortStartTime| :type |TimeStamp|)))

(defoid |sctpLookupRemPortStartTime| (|sctpLookupRemPortEntry| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time that this row was created.

       As the table will be created after the sctpAssocTable
       creation, this value could be equal to the sctpAssocStartTime
       object from the main table."))

(defoid |sctpLookupRemHostNameTable| (|sctpObjects| 8)
  (:type 'object-type)
  (:syntax '(vector |SctpLookupRemHostNameEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "With the use of this table, a list of associations with that
       particular host can be retrieved."))

(defoid |sctpLookupRemHostNameEntry| (|sctpLookupRemHostNameTable| 1)
  (:type 'object-type)
  (:syntax '|SctpLookupRemHostNameEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is indexed by remote host name and association ID.
       Specifying a host name we would get a list of the associations
       specifying that host name as the remote one.

       Implementors need to be aware that if the size of
       sctpAssocRemHostName exceeds 115 octets then OIDs of column
       instances in this table will have more than 128 sub-
       identifiers and cannot be accessed using SNMPv1, SNMPv2c, or
       SNMPv3."))

(defclass |SctpLookupRemHostNameEntry|
          (sequence-type)
          ((|sctpLookupRemHostNameStartTime| :type |TimeStamp|)))

(defoid |sctpLookupRemHostNameStartTime|
        (|sctpLookupRemHostNameEntry| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time that this row was created.

       As the table will be created after the sctpAssocTable
       creation, this value could be equal to the sctpAssocStartTime
       object from the main table."))

(defoid |sctpLookupRemPrimIPAddrTable| (|sctpObjects| 9)
  (:type 'object-type)
  (:syntax '(vector |SctpLookupRemPrimIPAddrEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "With the use of this table, a list of associations that have
       the specified IP address as primary within the remote set of
       active addresses can be retrieved."))

(defoid |sctpLookupRemPrimIPAddrEntry|
        (|sctpLookupRemPrimIPAddrTable| 1)
  (:type 'object-type)
  (:syntax '|SctpLookupRemPrimIPAddrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is indexed by primary address and association ID.
       Specifying a primary address, we would get a list of the
       associations that have the specified remote IP address marked
       as primary.
       Implementors need to be aware that if the size of
       sctpAssocRemPrimAddr exceeds 114 octets then OIDs of column
       instances in this table will have more than 128 sub-
       identifiers and cannot be accessed using SNMPv1, SNMPv2c, or
       SNMPv3."))

(defclass |SctpLookupRemPrimIPAddrEntry|
          (sequence-type)
          ((|sctpLookupRemPrimIPAddrStartTime| :type |TimeStamp|)))

(defoid |sctpLookupRemPrimIPAddrStartTime|
        (|sctpLookupRemPrimIPAddrEntry| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of SysUpTime at the time that this row was created.

       As the table will be created after the sctpAssocTable
       creation, this value could be equal to the sctpAssocStartTime
       object from the main table."))

(defoid |sctpLookupRemIPAddrTable| (|sctpObjects| 10)
  (:type 'object-type)
  (:syntax '(vector |SctpLookupRemIPAddrEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "With the use of this table, a list of associations that have
       the specified IP address as one of the remote ones can be
       retrieved. "))

(defoid |sctpLookupRemIPAddrEntry| (|sctpLookupRemIPAddrTable| 1)
  (:type 'object-type)
  (:syntax '|SctpLookupRemIPAddrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table is indexed by a remote IP address and association
       ID. Specifying an IP address we would get a list of the
       associations that have the specified IP address included
       within the set of remote IP addresses."))

(defclass |SctpLookupRemIPAddrEntry|
          (sequence-type)
          ((|sctpLookupRemIPAddrStartTime| :type |TimeStamp|)))

(defoid |sctpLookupRemIPAddrStartTime| (|sctpLookupRemIPAddrEntry| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of SysUpTime at the time that this row was created.

       As the table will be created after the sctpAssocTable
       creation, this value could be equal to the sctpAssocStartTime
       object from the main table."))

(defoid |sctpMibConformance| (|sctpMIB| 2) (:type 'object-identity))

(defoid |sctpMibCompliances| (|sctpMibConformance| 1)
  (:type 'object-identity))

(defoid |sctpMibGroups| (|sctpMibConformance| 2)
  (:type 'object-identity))

(defoid |sctpLayerParamsGroup| (|sctpMibGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Common parameters for the SCTP layer, i.e., for all the
       associations. They can usually be referred to as configuration
       parameters."))

(defoid |sctpStatsGroup| (|sctpMibGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Statistics group. It includes the objects to collect state
       changes in the SCTP protocol local layer and flow control
       statistics."))

(defoid |sctpPerAssocParamsGroup| (|sctpMibGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "The SCTP group of objects to manage per-association
       parameters. These variables include all the SCTP basic
       features."))

(defoid |sctpPerAssocStatsGroup| (|sctpMibGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Per Association Statistics group. It includes the objects to
       collect flow control statistics per association."))

(defoid |sctpInverseGroup| (|sctpMibGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description "Objects used in the inverse lookup tables."))

(defoid |sctpMibCompliance| (|sctpMibCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which implement
       this SCTP MIB Module.

       There are a number of INDEX objects that cannot be represented
       in the form of OBJECT clauses in SMIv2, but for which we have
       the following compliance requirements, expressed in OBJECT
       clause form in this description clause:

-- OBJECT        sctpAssocLocalAddrType
-- SYNTAX        InetAddressType {ipv4(1), ipv6(2)}
-- DESCRIPTION
--       It is only required to have IPv4 and IPv6 addresses without
--       zone indices.
--       The address with zone indices is required if an
--       implementation can connect multiple zones.
--
-- OBJECT        sctpAssocLocalAddr
-- SYNTAX        InetAddress (SIZE(4|16))
-- DESCRIPTION
--       An implementation is only required to support globally
--       unique IPv4 and IPv6 addresses.
--
-- OBJECT        sctpAssocRemAddrType
-- SYNTAX        InetAddressType {ipv4(1), ipv6(2)}
-- DESCRIPTION
--       It is only required to have IPv4 and IPv6 addresses without
--       zone indices.
--       The address with zone indices is required if an
--       implementation can connect multiple zones.
--
-- OBJECT        sctpAssocRemAddr
-- SYNTAX        InetAddress (SIZE(4|16))
-- DESCRIPTION
--       An implementation is only required to support globally
--       unique IPv4 and IPv6 addresses.
--
       "))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'sctp-mib *mib-modules*)
  (setf *current-module* nil))

