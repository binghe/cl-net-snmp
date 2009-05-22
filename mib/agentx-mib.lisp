;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;AGENTX-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'agentx-mib))

(defpackage :asn.1/agentx-mib
  (:nicknames :agentx-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Unsigned32| |mib-2|)
  (:import-from :asn.1/snmp-framework-mib |SnmpAdminString|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |TimeStamp|
                |TruthValue| |TDomain|))

(in-package :agentx-mib)

(defoid |agentxMIB| (|mib-2| 74)
  (:type 'module-identity)
  (:description
   "This is the MIB module for the SNMP Agent Extensibility
     Protocol (AgentX).  This MIB module will be implemented by
     the master agent.
    "))

(define-textual-convention |AgentxTAddress|
                           octet-string
                           (:status '|current|)
                           (:description
                            "Denotes a transport service address.  This is identical to
      the TAddress textual convention (SNMPv2-SMI) except that
      zero-length values are permitted.
     "))

(defoid |agentxObjects| (|agentxMIB| 1) (:type 'object-identity))

(defoid |agentxGeneral| (|agentxObjects| 1) (:type 'object-identity))

(defoid |agentxConnection| (|agentxObjects| 2) (:type 'object-identity))

(defoid |agentxSession| (|agentxObjects| 3) (:type 'object-identity))

(defoid |agentxRegistration| (|agentxObjects| 4)
  (:type 'object-identity))

(defoid |agentxDefaultTimeout| (|agentxGeneral| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The default length of time, in seconds, that the master
      agent should allow to elapse after dispatching a message
      to a session before it regards the subagent as not
      responding.  This is a system-wide value that may
      override the timeout value associated with a particular
      session (agentxSessionTimeout) or a particular registered
      MIB region (agentxRegTimeout).  If the associated value of
      agentxSessionTimeout and agentxRegTimeout are zero, or
      impractical in accordance with implementation-specific
      procedure of the master agent, the value represented by
      this object will be the effective timeout value for the

      master agent to await a response to a dispatch from a
      given subagent.
     "))

(defoid |agentxMasterAgentXVer| (|agentxGeneral| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The AgentX protocol version supported by this master agent.
      The current protocol version is 1.  Note that the master agent
      must also allow interaction with earlier version subagents.
     "))

(defoid |agentxConnTableLastChange| (|agentxConnection| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the last row creation or deletion
      occurred in the agentxConnectionTable.
     "))

(defoid |agentxConnectionTable| (|agentxConnection| 2)
  (:type 'object-type)
  (:syntax '(vector |AgentxConnectionEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The agentxConnectionTable tracks all current AgentX transport
      connections.  There may be zero, one, or more AgentX sessions
      carried on a given AgentX connection.
     "))

(defoid |agentxConnectionEntry| (|agentxConnectionTable| 1)
  (:type 'object-type)
  (:syntax '|AgentxConnectionEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An agentxConnectionEntry contains information describing a
      single AgentX transport connection.  A connection may be

      used to support zero or more AgentX sessions.  An entry is
      created when a new transport connection is established,
      and is destroyed when the transport connection is terminated.
     "))

(defclass |AgentxConnectionEntry|
          (sequence-type)
          ((|agentxConnIndex| :type |Unsigned32|)
           (|agentxConnOpenTime| :type |TimeStamp|)
           (|agentxConnTransportDomain| :type |TDomain|)
           (|agentxConnTransportAddress| :type |AgentxTAddress|)))

(defoid |agentxConnIndex| (|agentxConnectionEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "agentxConnIndex contains the value that uniquely identifies
      an open transport connection used by this master agent
      to provide AgentX service.  Values of this index should
      not be re-used.  The value assigned to a given transport
      connection is constant for the lifetime of that connection.
     "))

(defoid |agentxConnOpenTime| (|agentxConnectionEntry| 2)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when this connection was established
      and, therefore, its value when this entry was added to the table.
     "))

(defoid |agentxConnTransportDomain| (|agentxConnectionEntry| 3)
  (:type 'object-type)
  (:syntax '|TDomain|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The transport protocol in use for this connection to the
      subagent.
     "))

(defoid |agentxConnTransportAddress| (|agentxConnectionEntry| 4)
  (:type 'object-type)
  (:syntax '|AgentxTAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The transport address of the remote (subagent) end of this
      connection to the master agent.  This object may be zero-length
      for unix-domain sockets (and possibly other types of transport
      addresses) since the subagent need not bind a filename to its
      local socket.
     "))

(defoid |agentxSessionTableLastChange| (|agentxSession| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the last row creation or deletion
      occurred in the agentxSessionTable.
     "))

(defoid |agentxSessionTable| (|agentxSession| 2)
  (:type 'object-type)
  (:syntax '(vector |AgentxSessionEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of AgentX subagent sessions currently in effect.
     "))

(defoid |agentxSessionEntry| (|agentxSessionTable| 1)
  (:type 'object-type)
  (:syntax '|AgentxSessionEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about a single open session between the AgentX
      master agent and a subagent is contained in this entry.  An
      entry is created when a new session is successfully established
      and is destroyed either when the subagent transport connection
      has terminated or when the subagent session is closed.
     "))

(defclass |AgentxSessionEntry|
          (sequence-type)
          ((|agentxSessionIndex| :type |Unsigned32|)
           (|agentxSessionObjectID| :type object-id)
           (|agentxSessionDescr| :type |SnmpAdminString|)
           (|agentxSessionAdminStatus| :type integer)
           (|agentxSessionOpenTime| :type |TimeStamp|)
           (|agentxSessionAgentXVer| :type integer)
           (|agentxSessionTimeout| :type integer)))

(defoid |agentxSessionIndex| (|agentxSessionEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A unique index for the subagent session.  It is the same as
      h.sessionID defined in the agentx header.  Note that if
      a subagent's session with the master agent is closed for
      any reason its index should not be re-used.
      A value of zero(0) is specifically allowed in order
      to be compatible with the definition of h.sessionId.
     "))

(defoid |agentxSessionObjectID| (|agentxSessionEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This is taken from the o.id field of the agentx-Open-PDU.
      This attribute will report a value of '0.0' for subagents
      not supporting the notion of an AgentX session object
      identifier.
     "))

(defoid |agentxSessionDescr| (|agentxSessionEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A textual description of the session.  This is analogous to
      sysDescr defined in the SNMPv2-MIB in RFC 1907 [19] and is
      taken from the o.descr field of the agentx-Open-PDU.
      This attribute will report a zero-length string value for
      subagents not supporting the notion of a session description.
     "))

(defoid |agentxSessionAdminStatus| (|agentxSessionEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The administrative (desired) status of the session.  Setting
      the value to 'down(2)' closes the subagent session (with c.reason
      set to 'reasonByManager').
     "))

(defoid |agentxSessionOpenTime| (|agentxSessionEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when this session was opened and,
      therefore, its value when this entry was added to the table.
     "))

(defoid |agentxSessionAgentXVer| (|agentxSessionEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The version of the AgentX protocol supported by the
      session.  This must be less than or equal to the value of
      agentxMasterAgentXVer.
     "))

(defoid |agentxSessionTimeout| (|agentxSessionEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The length of time, in seconds, that a master agent should
      allow to elapse after dispatching a message to this session
      before it regards the subagent as not responding.  This value
      is taken from the o.timeout field of the agentx-Open-PDU.
      This is a session-specific value that may be overridden by
      values associated with the specific registered MIB regions
      (see agentxRegTimeout). A value of zero(0) indicates that
      the master agent's default timeout value should be used

      (see agentxDefaultTimeout).
     "))

(defoid |agentxRegistrationTableLastChange| (|agentxRegistration| 1)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime when the last row creation or deletion
      occurred in the agentxRegistrationTable.
     "))

(defoid |agentxRegistrationTable| (|agentxRegistration| 2)
  (:type 'object-type)
  (:syntax '(vector |AgentxRegistrationEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of registered regions.
     "))

(defoid |agentxRegistrationEntry| (|agentxRegistrationTable| 1)
  (:type 'object-type)
  (:syntax '|AgentxRegistrationEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Contains information for a single registered region.  An
      entry is created when a session  successfully registers a
      region and is destroyed for any of three reasons: this region
      is unregistered by the session, the session is closed,
      or the subagent connection is closed.
     "))

(defclass |AgentxRegistrationEntry|
          (sequence-type)
          ((|agentxRegIndex| :type |Unsigned32|)
           (|agentxRegContext| :type octet-string)
           (|agentxRegStart| :type object-id)
           (|agentxRegRangeSubId| :type |Unsigned32|)
           (|agentxRegUpperBound| :type |Unsigned32|)
           (|agentxRegPriority| :type |Unsigned32|)
           (|agentxRegTimeout| :type integer)
           (|agentxRegInstance| :type |TruthValue|)))

(defoid |agentxRegIndex| (|agentxRegistrationEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "agentxRegIndex uniquely identifies a registration entry.
      This value is constant for the lifetime of an entry.
     "))

(defoid |agentxRegContext| (|agentxRegistrationEntry| 2)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The context in which the session supports the objects in this
      region.  A zero-length context indicates the default context.
     "))

(defoid |agentxRegStart| (|agentxRegistrationEntry| 3)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The starting OBJECT IDENTIFIER of this registration entry.  The
      session identified by agentxSessionIndex implements objects
      starting at this value (inclusive).  Note that this value could
      identify an object type, an object instance, or a partial object
      instance.
     "))

(defoid |agentxRegRangeSubId| (|agentxRegistrationEntry| 4)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "agentxRegRangeSubId is used to specify the range.  This is
      taken from r.region_subid in the registration PDU.  If the value
      of this object is zero, no range is specified.  If it is non-zero,
      it identifies the `nth' sub-identifier in r.region for which
      this entry's agentxRegUpperBound value is substituted in the
      OID for purposes of defining the region's upper bound.
     "))

(defoid |agentxRegUpperBound| (|agentxRegistrationEntry| 5)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "agentxRegUpperBound represents the upper-bound sub-identifier in
     a registration.  This is taken from the r.upper_bound in the
     registration PDU.  If agentxRegRangeSubid (r.region_subid) is
     zero, this value is also zero and is not used to define an upper
     bound for this registration.
    "))

(defoid |agentxRegPriority| (|agentxRegistrationEntry| 6)
  (:type 'object-type)
  (:syntax '|Unsigned32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The registration priority.  Lower values have higher priority.
      This value is taken from r.priority in the register PDU.
      Sessions should use the value of 127 for r.priority if a
      default value is desired.
     "))

(defoid |agentxRegTimeout| (|agentxRegistrationEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The timeout value, in seconds, for responses to
      requests associated with this registered MIB region.
      A value of zero(0) indicates the default value (indicated
      by by agentxSessionTimeout or agentxDefaultTimeout) is to
      be used.  This value is taken from the r.timeout field of
      the agentx-Register-PDU.
     "))

(defoid |agentxRegInstance| (|agentxRegistrationEntry| 8)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of agentxRegInstance is `true' for
      registrations for which the INSTANCE_REGISTRATION
      was set, and is `false' for all other registrations.
     "))

(defoid |agentxConformance| (|agentxMIB| 2) (:type 'object-identity))

(defoid |agentxMIBGroups| (|agentxConformance| 1)
  (:type 'object-identity))

(defoid |agentxMIBCompliances| (|agentxConformance| 2)
  (:type 'object-identity))

(defoid |agentxMIBCompliance| (|agentxMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities that implement the
      AgentX protocol.  Note that a compliant agent can implement all
      objects in this MIB module as read-only.
     "))

(defoid |agentxMIBGroup| (|agentxMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "All accessible objects in the AgentX MIB.
     "))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'agentx-mib *mib-modules*)
  (setf *current-module* nil))

