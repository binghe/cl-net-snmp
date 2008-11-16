;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NETWORK-SERVICES-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'network-services-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'network-services-mib *mib-modules*))
(defoid |application| (|mib-2| 27)
  (:type 'module-identity)
  (:description
   "The MIB module describing network service applications"))
(deftype |DistinguishedName| () 't)
(deftype |URLString| () 't)
(defoid |applTable| (|application| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table holding objects which apply to all different
         kinds of applications providing network services.
         Each network service application capable of being
         monitored should have a single entry in this table."))
(defoid |applEntry| (|applTable| 1)
  (:type 'object-type)
  (:syntax '|ApplEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry associated with a single network service
       application."))
(deftype |ApplEntry| () 't)
(defoid |applIndex| (|applEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An index to uniquely identify the network service
       application. This attribute is the index used for
       lexicographic ordering of the table."))
(defoid |applName| (|applEntry| 2)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The name the network service application chooses to be
       known by."))
(defoid |applDirectoryName| (|applEntry| 3)
  (:type 'object-type)
  (:syntax '|DistinguishedName|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Distinguished Name of the directory entry where
       static information about this application is stored.
       An empty string indicates that no information about
       the application is available in the directory."))
(defoid |applVersion| (|applEntry| 4)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The version of network service application software.
       This field is usually defined by the vendor of the
       network service application software."))
(defoid |applUptime| (|applEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time the network service
       application was last initialized.  If the application was
       last initialized prior to the last initialization of the
       network management subsystem, then this object contains
       a zero value."))
(defoid |applOperStatus| (|applEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Indicates the operational status of the network service
       application. 'down' indicates that the network service is

       not available. 'up' indicates that the network service
       is operational and available.  'halted' indicates that the
       service is operational but not available.  'congested'
       indicates that the service is operational but no additional
       inbound associations can be accommodated.  'restarting'
       indicates that the service is currently unavailable but is
       in the process of restarting and will be available soon.
       'quiescing' indicates that service is currently operational
       but is in the process of shutting down. Additional inbound
       associations may be rejected by applications in the
       'quiescing' state."))
(defoid |applLastChange| (|applEntry| 7)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time the network service
       application entered its current operational state.  If
       the current state was entered prior to the last
       initialization of the local network management subsystem,
       then this object contains a zero value."))
(defoid |applInboundAssociations| (|applEntry| 8)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of current associations to the network service
       application, where it is the responder.  An inbound
       association occurs when another application successfully
       connects to this one."))
(defoid |applOutboundAssociations| (|applEntry| 9)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of current associations to the network service
       application, where it is the initiator.  An outbound
       association occurs when this application successfully
       connects to another one."))
(defoid |applAccumulatedInboundAssociations| (|applEntry| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of associations to the application entity
       since application initialization, where it was the responder."))
(defoid |applAccumulatedOutboundAssociations| (|applEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of associations to the application entity
       since application initialization, where it was the initiator."))
(defoid |applLastInboundActivity| (|applEntry| 12)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this application last
       had an inbound association.  If the last association
       occurred prior to the last initialization of the network
       subsystem, then this object contains a zero value."))
(defoid |applLastOutboundActivity| (|applEntry| 13)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this application last
       had an outbound association.  If the last association
       occurred prior to the last initialization of the network
       subsystem, then this object contains a zero value."))
(defoid |applRejectedInboundAssociations| (|applEntry| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of inbound associations the application
       entity has rejected, since application initialization.
       Rejected associations are not counted in the accumulated
       association totals.  Note that this only counts

       associations the application entity has rejected itself;
       it does not count rejections that occur at lower layers
       of the network.  Thus, this counter may not reflect the
       true number of failed inbound associations."))
(defoid |applFailedOutboundAssociations| (|applEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number associations where the application entity
       is initiator and association establishment has failed,
       since application initialization.  Failed associations are
       not counted in the accumulated association totals."))
(defoid |applDescription| (|applEntry| 16)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A text description of the application.  This information
       is intended to identify and briefly describe the
       application in a status display."))
(defoid |applURL| (|applEntry| 17)
  (:type 'object-type)
  (:syntax '|URLString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A URL pointing to a description of the application.
       This information is intended to identify and describe
       the application in a status display."))
(defoid |assocTable| (|application| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table holding a set of all active application

         associations."))
(defoid |assocEntry| (|assocTable| 1)
  (:type 'object-type)
  (:syntax '|AssocEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry associated with an association for a network
       service application."))
(deftype |AssocEntry| () 't)
(defoid |assocIndex| (|assocEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An index to uniquely identify each association for a network
       service application.  This attribute is the index that is
       used for lexicographic ordering of the table.  Note that the
       table is also indexed by the applIndex."))
(defoid |assocRemoteApplication| (|assocEntry| 2)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The name of the system running remote network service
       application.  For an IP-based application this should be
       either a domain name or IP address.  For an OSI application
       it should be the string encoded distinguished name of the
       managed object.  For X.400(1984) MTAs which do not have a
       Distinguished Name, the RFC 2156 syntax 'mta in

       globalid' used in X400-Received: fields can be used. Note,
       however, that not all connections an MTA makes are
       necessarily to another MTA."))
(defoid |assocApplicationProtocol| (|assocEntry| 3)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An identification of the protocol being used for the
       application.  For an OSI Application, this will be the
       Application Context.  For Internet applications, OID
       values of the form {applTCPProtoID port} or {applUDPProtoID
       port} are used for TCP-based and UDP-based protocols,
       respectively. In either case 'port' corresponds to the
       primary port number being used by the protocol. The
       usual IANA procedures may be used to register ports for
       new protocols."))
(defoid |assocApplicationType| (|assocEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This indicates whether the remote application is some type of
       client making use of this network service (e.g., a Mail User
       Agent) or a server acting as a peer. Also indicated is whether
       the remote end initiated an incoming connection to the network
       service or responded to an outgoing connection made by the
       local application.  MTAs and messaging gateways are
       considered to be peers for the purposes of this variable."))
(defoid |assocDuration| (|assocEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of sysUpTime at the time this association was
       started.  If this association started prior to the last
       initialization of the network subsystem, then this
       object contains a zero value."))
(defoid |applConformance| (|application| 3) (:type 'object-identity))
(defoid |applGroups| (|applConformance| 1) (:type 'object-identity))
(defoid |applCompliances| (|applConformance| 2)
  (:type 'object-identity))
(defoid |applCompliance| (|applCompliances| 1)
  (:type 'module-compliance)
  (:status '|obsolete|)
  (:description
   "The compliance statement for RFC 1565 implementations
       which support the Network Services Monitoring MIB
       for basic monitoring of network service applications.
       This is the basic compliance statement for RFC 1565."))
(defoid |assocCompliance| (|applCompliances| 2)
  (:type 'module-compliance)
  (:status '|obsolete|)
  (:description
   "The compliance statement for RFC 1565 implementations
       which support the Network Services Monitoring MIB
       for basic monitoring of network service applications
       and their associations."))
(defoid |applRFC2248Compliance| (|applCompliances| 3)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for RFC 2248 implementations
       which support the Network Services Monitoring MIB
       for basic monitoring of network service applications."))
(defoid |assocRFC2248Compliance| (|applCompliances| 4)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for RFC 2248 implementations

       which support the Network Services Monitoring MIB for
       basic monitoring of network service applications and
       their associations."))
(defoid |applRFC2788Compliance| (|applCompliances| 5)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2788 implementations
       which support the Network Services Monitoring MIB
       for basic monitoring of network service applications."))
(defoid |assocRFC2788Compliance| (|applCompliances| 6)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for RFC 2788 implementations
       which support the Network Services Monitoring MIB for
       basic monitoring of network service applications and
       their associations."))
(defoid |applRFC1565Group| (|applGroups| 7)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description
   "A collection of objects providing basic monitoring of
       network service applications.  This is the original set
       of such objects defined in RFC 1565."))
(defoid |assocRFC1565Group| (|applGroups| 2)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description
   "A collection of objects providing basic monitoring of
       network service applications' associations.  This is the
       original set of such objects defined in RFC 1565."))
(defoid |applRFC2248Group| (|applGroups| 3)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing basic monitoring of
       network service applications.  This group was originally
       defined in RFC 2248; note that applDirectoryName is
       missing."))
(defoid |assocRFC2248Group| (|applGroups| 4)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing basic monitoring of
       network service applications' associations.  This group
       was originally defined by RFC 2248."))
(defoid |applRFC2788Group| (|applGroups| 5)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic monitoring of
       network service applications.  This is the appropriate

       group for RFC 2788 -- it adds the applDirectoryName object
       missing in RFC 2248."))
(defoid |assocRFC2788Group| (|applGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing basic monitoring of
       network service applications' associations.  This is
       the appropriate group for RFC 2788."))
(defoid |applTCPProtoID| (|application| 4) (:type 'object-identity))
(defoid |applUDPProtoID| (|application| 5) (:type 'object-identity))
