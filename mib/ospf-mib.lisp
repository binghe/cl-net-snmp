;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;OSPF-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ospf-mib *mib-modules*)
  (setf *current-module* 'ospf-mib))

(defpackage :asn.1/ospf-mib
  (:nicknames :ospf-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-type
                |Counter32| |Gauge32| |Integer32| |IpAddress|)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention |TruthValue|
                |RowStatus|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :|ASN.1/SNMPv2-SMI| |mib-2|))

(in-package :ospf-mib)

(defoid |ospf| (|mib-2| 14)
  (:type 'module-identity)
  (:description
   "The MIB module to describe the OSPF Version 2
       Protocol"))

(deftype |AreaID| () 't)

(deftype |RouterID| () 't)

(deftype |Metric| () 't)

(deftype |BigMetric| () 't)

(deftype |Status| () 't)

(deftype |PositiveInteger| () 't)

(deftype |HelloRange| () 't)

(deftype |UpToMaxAge| () 't)

(deftype |InterfaceIndex| () 't)

(deftype |DesignatedRouterPriority| () 't)

(deftype |TOSType| () 't)

(defoid |ospfGeneralGroup| (|ospf| 1) (:type 'object-identity))

(defoid |ospfRouterId| (|ospfGeneralGroup| 1)
  (:type 'object-type)
  (:syntax '|RouterID|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A  32-bit  integer  uniquely  identifying  the
           router in the Autonomous System.

           By  convention,  to  ensure  uniqueness,   this
           should  default  to  the  value  of  one of the
           router's IP interface addresses."))

(defoid |ospfAdminStat| (|ospfGeneralGroup| 2)
  (:type 'object-type)
  (:syntax '|Status|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The  administrative  status  of  OSPF  in  the
           router.   The  value 'enabled' denotes that the
           OSPF Process is active on at least  one  inter-
           face;  'disabled'  disables  it  on  all inter-
           faces."))

(defoid |ospfVersionNumber| (|ospfGeneralGroup| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The current version number of the OSPF  proto-
           col is 2."))

(defoid |ospfAreaBdrRtrStatus| (|ospfGeneralGroup| 4)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A flag to note whether this router is an  area
           border router."))

(defoid |ospfASBdrRtrStatus| (|ospfGeneralGroup| 5)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A flag to note whether this router is  config-
           ured as an Autonomous System border router."))

(defoid |ospfExternLsaCount| (|ospfGeneralGroup| 6)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of external (LS type 5)  link-state
           advertisements in the link-state database."))

(defoid |ospfExternLsaCksumSum| (|ospfGeneralGroup| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 32-bit unsigned sum of the LS checksums of
           the  external  link-state  advertisements  con-
           tained in the link-state  database.   This  sum
           can  be  used  to determine if there has been a
           change in a router's link state  database,  and
           to  compare  the  link-state  database  of  two
           routers."))

(defoid |ospfTOSSupport| (|ospfGeneralGroup| 8)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The router's support for type-of-service rout-
           ing."))

(defoid |ospfOriginateNewLsas| (|ospfGeneralGroup| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of  new  link-state  advertisements
           that  have been originated.  This number is in-
           cremented each time the router originates a new
           LSA."))

(defoid |ospfRxNewLsas| (|ospfGeneralGroup| 10)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of  link-state  advertisements  re-
           ceived  determined  to  be  new instantiations.
           This number does not include  newer  instantia-
           tions  of self-originated link-state advertise-
           ments."))

(defoid |ospfExtLsdbLimit| (|ospfGeneralGroup| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The  maximum   number   of   non-default   AS-
           external-LSAs entries that can be stored in the
           link-state database.  If the value is -1,  then
           there is no limit.

           When the number of non-default AS-external-LSAs
           in   a  router's  link-state  database  reaches
           ospfExtLsdbLimit, the router  enters  Overflow-
           State.   The   router  never  holds  more  than
           ospfExtLsdbLimit  non-default  AS-external-LSAs
           in  its  database. OspfExtLsdbLimit MUST be set
           identically in all routers attached to the OSPF
           backbone  and/or  any regular OSPF area. (i.e.,
           OSPF stub areas and NSSAs are excluded)."))

(defoid |ospfMulticastExtensions| (|ospfGeneralGroup| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "A Bit Mask indicating whether  the  router  is
           forwarding  IP  multicast  (Class  D) datagrams
           based on the algorithms defined in  the  Multi-
           cast Extensions to OSPF.

           Bit 0, if set, indicates that  the  router  can
           forward  IP multicast datagrams in the router's
           directly attached areas (called intra-area mul-
           ticast routing).

           Bit 1, if set, indicates that  the  router  can
           forward  IP  multicast  datagrams  between OSPF
           areas (called inter-area multicast routing).

           Bit 2, if set, indicates that  the  router  can
           forward  IP  multicast  datagrams between Auto-
           nomous Systems (called inter-AS multicast rout-
           ing).

           Only certain combinations of bit  settings  are
           allowed,  namely: 0 (no multicast forwarding is
           enabled), 1 (intra-area multicasting  only),  3
           (intra-area  and  inter-area  multicasting),  5
           (intra-area and inter-AS  multicasting)  and  7
           (multicasting  everywhere). By default, no mul-
           ticast forwarding is enabled."))

(defoid |ospfExitOverflowInterval| (|ospfGeneralGroup| 13)
  (:type 'object-type)
  (:syntax '|PositiveInteger|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The number of  seconds  that,  after  entering
           OverflowState,  a  router will attempt to leave
           OverflowState. This allows the router to  again
           originate  non-default  AS-external-LSAs.  When
           set to 0, the router will not  leave  Overflow-
           State until restarted."))

(defoid |ospfDemandExtensions| (|ospfGeneralGroup| 14)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "The router's support for demand routing."))

(defoid |ospfAreaTable| (|ospf| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information describing the configured  parame-
           ters  and cumulative statistics of the router's
           attached areas."))

(defoid |ospfAreaEntry| (|ospfAreaTable| 1)
  (:type 'object-type)
  (:syntax '|OspfAreaEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information describing the configured  parame-
           ters  and  cumulative  statistics of one of the
           router's attached areas."))

(deftype |OspfAreaEntry| () 't)

(defoid |ospfAreaId| (|ospfAreaEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A 32-bit integer uniquely identifying an area.
           Area ID 0.0.0.0 is used for the OSPF backbone."))

(defoid |ospfAuthType| (|ospfAreaEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "The authentication type specified for an area.
           Additional authentication types may be assigned
           locally on a per Area basis."))

(defoid |ospfImportAsExtern| (|ospfAreaEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The area's support for importing  AS  external
           link- state advertisements."))

(defoid |ospfSpfRuns| (|ospfAreaEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times that the intra-area  route
           table  has  been  calculated  using this area's
           link-state database.  This  is  typically  done
           using Dijkstra's algorithm."))

(defoid |ospfAreaBdrRtrCount| (|ospfAreaEntry| 5)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of area border routers reach-
           able within this area.  This is initially zero,
           and is calculated in each SPF Pass."))

(defoid |ospfAsBdrRtrCount| (|ospfAreaEntry| 6)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of Autonomous  System  border
           routers  reachable  within  this area.  This is
           initially zero, and is calculated in  each  SPF
           Pass."))

(defoid |ospfAreaLsaCount| (|ospfAreaEntry| 7)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of link-state  advertisements
           in  this  area's link-state database, excluding
           AS External LSA's."))

(defoid |ospfAreaLsaCksumSum| (|ospfAreaEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 32-bit unsigned sum of the link-state  ad-
           vertisements'  LS  checksums  contained in this
           area's link-state database.  This sum  excludes
           external (LS type 5) link-state advertisements.
           The sum can be used to determine if  there  has
           been  a  change  in a router's link state data-
           base, and to compare the link-state database of
           two routers."))

(defoid |ospfAreaSummary| (|ospfAreaEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The variable ospfAreaSummary controls the  im-
           port  of  summary LSAs into stub areas.  It has
           no effect on other areas.

           If it is noAreaSummary, the router will neither
           originate  nor  propagate summary LSAs into the
           stub area.  It will rely entirely  on  its  de-
           fault route.

           If it is sendAreaSummary, the router will  both
           summarize and propagate summary LSAs."))

(defoid |ospfAreaStatus| (|ospfAreaEntry| 10)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfStubAreaTable| (|ospf| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The set of metrics that will be advertised  by
           a default Area Border Router into a stub area."))

(defoid |ospfStubAreaEntry| (|ospfStubAreaTable| 1)
  (:type 'object-type)
  (:syntax '|OspfStubAreaEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The metric for a given Type  of  Service  that
           will  be  advertised  by  a default Area Border
           Router into a stub area."))

(deftype |OspfStubAreaEntry| () 't)

(defoid |ospfStubAreaId| (|ospfStubAreaEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 32 bit identifier for the Stub  Area.   On
           creation,  this  can  be  derived  from the in-
           stance."))

(defoid |ospfStubTOS| (|ospfStubAreaEntry| 2)
  (:type 'object-type)
  (:syntax '|TOSType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The  Type  of  Service  associated  with   the
           metric.   On creation, this can be derived from
           the instance."))

(defoid |ospfStubMetric| (|ospfStubAreaEntry| 3)
  (:type 'object-type)
  (:syntax '|BigMetric|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The metric value applied at the indicated type
           of  service.  By default, this equals the least
           metric at the type of service among the  inter-
           faces to other areas."))

(defoid |ospfStubStatus| (|ospfStubAreaEntry| 4)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfStubMetricType| (|ospfStubAreaEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the type of metric  ad-
           vertised as a default route."))

(defoid |ospfLsdbTable| (|ospf| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The OSPF Process's Link State Database."))

(defoid |ospfLsdbEntry| (|ospfLsdbTable| 1)
  (:type 'object-type)
  (:syntax '|OspfLsdbEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A single Link State Advertisement."))

(deftype |OspfLsdbEntry| () 't)

(defoid |ospfLsdbAreaId| (|ospfLsdbEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 32 bit identifier of the Area  from  which
           the LSA was received."))

(defoid |ospfLsdbType| (|ospfLsdbEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type  of  the  link  state  advertisement.
           Each  link state type has a separate advertise-
           ment format."))

(defoid |ospfLsdbLsid| (|ospfLsdbEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Link State ID is an LS Type Specific field
           containing either a Router ID or an IP Address;
           it identifies the piece of the  routing  domain
           that is being described by the advertisement."))

(defoid |ospfLsdbRouterId| (|ospfLsdbEntry| 4)
  (:type 'object-type)
  (:syntax '|RouterID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 32 bit number that uniquely identifies the
           originating router in the Autonomous System."))

(defoid |ospfLsdbSequence| (|ospfLsdbEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The sequence number field is a  signed  32-bit
           integer.   It  is used to detect old and dupli-
           cate link state advertisements.  The  space  of
           sequence  numbers  is  linearly  ordered.   The
           larger the sequence number the more recent  the
           advertisement."))

(defoid |ospfLsdbAge| (|ospfLsdbEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This field is the age of the link state adver-
           tisement in seconds."))

(defoid |ospfLsdbChecksum| (|ospfLsdbEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This field is the  checksum  of  the  complete
           contents  of  the  advertisement, excepting the
           age field.  The age field is excepted  so  that
           an   advertisement's  age  can  be  incremented
           without updating the  checksum.   The  checksum
           used  is  the same that is used for ISO connec-
           tionless datagrams; it is commonly referred  to
           as the Fletcher checksum."))

(defoid |ospfLsdbAdvertisement| (|ospfLsdbEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The entire Link State Advertisement, including
           its header."))

(defoid |ospfAreaRangeTable| (|ospf| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|obsolete|)
  (:description
   "A range if IP addresses  specified  by  an  IP
           address/IP  network  mask  pair.   For example,
           class B address range of X.X.X.X with a network
           mask  of  255.255.0.0 includes all IP addresses
           from X.X.0.0 to X.X.255.255"))

(defoid |ospfAreaRangeEntry| (|ospfAreaRangeTable| 1)
  (:type 'object-type)
  (:syntax '|OspfAreaRangeEntry|)
  (:max-access '|not-accessible|)
  (:status '|obsolete|)
  (:description
   "A range if IP addresses  specified  by  an  IP
           address/IP  network  mask  pair.   For example,
           class B address range of X.X.X.X with a network
           mask  of  255.255.0.0 includes all IP addresses
           from X.X.0.0 to X.X.255.255"))

(deftype |OspfAreaRangeEntry| () 't)

(defoid |ospfAreaRangeAreaId| (|ospfAreaRangeEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The Area the Address  Range  is  to  be  found
           within."))

(defoid |ospfAreaRangeNet| (|ospfAreaRangeEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "The IP Address of the Net or Subnet  indicated
           by the range."))

(defoid |ospfAreaRangeMask| (|ospfAreaRangeEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "The Subnet Mask that pertains to  the  Net  or
           Subnet."))

(defoid |ospfAreaRangeStatus| (|ospfAreaRangeEntry| 4)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfAreaRangeEffect| (|ospfAreaRangeEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|obsolete|)
  (:description
   "Subnets subsumed by ranges either trigger  the
           advertisement  of the indicated summary (adver-
           tiseMatching), or result in  the  subnet's  not
           being advertised at all outside the area."))

(defoid |ospfHostTable| (|ospf| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The list of Hosts, and their metrics, that the
           router will advertise as host routes."))

(defoid |ospfHostEntry| (|ospfHostTable| 1)
  (:type 'object-type)
  (:syntax '|OspfHostEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A metric to be advertised, for a given type of
           service, when a given host is reachable."))

(deftype |OspfHostEntry| () 't)

(defoid |ospfHostIpAddress| (|ospfHostEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The IP Address of the Host."))

(defoid |ospfHostTOS| (|ospfHostEntry| 2)
  (:type 'object-type)
  (:syntax '|TOSType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Type of Service of the route being config-
           ured."))

(defoid |ospfHostMetric| (|ospfHostEntry| 3)
  (:type 'object-type)
  (:syntax '|Metric|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The Metric to be advertised."))

(defoid |ospfHostStatus| (|ospfHostEntry| 4)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfHostAreaID| (|ospfHostEntry| 5)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Area the Host Entry is to be found within.
           By  default, the area that a subsuming OSPF in-
           terface is in, or 0.0.0.0"))

(defoid |ospfIfTable| (|ospf| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The OSPF Interface Table describes the  inter-
           faces from the viewpoint of OSPF."))

(defoid |ospfIfEntry| (|ospfIfTable| 1)
  (:type 'object-type)
  (:syntax '|OspfIfEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The OSPF Interface Entry describes one  inter-
           face from the viewpoint of OSPF."))

(deftype |OspfIfEntry| () 't)

(defoid |ospfIfIpAddress| (|ospfIfEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The IP address of this OSPF interface."))

(defoid |ospfAddressLessIf| (|ospfIfEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For the purpose of easing  the  instancing  of
           addressed   and  addressless  interfaces;  This
           variable takes the value 0 on  interfaces  with
           IP  Addresses,  and  the corresponding value of
           ifIndex for interfaces having no IP Address."))

(defoid |ospfIfAreaId| (|ospfIfEntry| 3)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A 32-bit integer uniquely identifying the area
           to  which  the  interface  connects.   Area  ID
           0.0.0.0 is used for the OSPF backbone."))

(defoid |ospfIfType| (|ospfIfEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The OSPF interface type.

           By way of a default, this field may be intuited
           from the corresponding value of ifType.  Broad-
           cast LANs, such as  Ethernet  and  IEEE  802.5,
           take  the  value  'broadcast', X.25 and similar
           technologies take the value 'nbma',  and  links
           that  are  definitively point to point take the
           value 'pointToPoint'."))

(defoid |ospfIfAdminStat| (|ospfIfEntry| 5)
  (:type 'object-type)
  (:syntax '|Status|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The OSPF  interface's  administrative  status.
           The  value formed on the interface, and the in-
           terface will be advertised as an internal route
           to  some  area.   The  value 'disabled' denotes
           that the interface is external to OSPF."))

(defoid |ospfIfRtrPriority| (|ospfIfEntry| 6)
  (:type 'object-type)
  (:syntax '|DesignatedRouterPriority|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The  priority  of  this  interface.   Used  in
           multi-access  networks,  this  field is used in
           the designated router election algorithm.   The
           value 0 signifies that the router is not eligi-
           ble to become the  designated  router  on  this
           particular  network.   In the event of a tie in
           this value, routers will use their Router ID as
           a tie breaker."))

(defoid |ospfIfTransitDelay| (|ospfIfEntry| 7)
  (:type 'object-type)
  (:syntax '|UpToMaxAge|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The estimated number of seconds  it  takes  to
           transmit  a  link state update packet over this
           interface."))

(defoid |ospfIfRetransInterval| (|ospfIfEntry| 8)
  (:type 'object-type)
  (:syntax '|UpToMaxAge|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds between  link-state  ad-
           vertisement  retransmissions,  for  adjacencies
           belonging to this  interface.   This  value  is
           also used when retransmitting database descrip-
           tion and link-state request packets."))

(defoid |ospfIfHelloInterval| (|ospfIfEntry| 9)
  (:type 'object-type)
  (:syntax '|HelloRange|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The length of time, in  seconds,  between  the
           Hello  packets that the router sends on the in-
           terface.  This value must be the same  for  all
           routers attached to a common network."))

(defoid |ospfIfRtrDeadInterval| (|ospfIfEntry| 10)
  (:type 'object-type)
  (:syntax '|PositiveInteger|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds that  a  router's  Hello
           packets  have  not been seen before it's neigh-
           bors declare the router down.  This  should  be
           some  multiple  of  the  Hello  interval.  This
           value must be the same for all routers attached
           to a common network."))

(defoid |ospfIfPollInterval| (|ospfIfEntry| 11)
  (:type 'object-type)
  (:syntax '|PositiveInteger|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The larger time interval, in seconds,  between
           the  Hello  packets  sent  to  an inactive non-
           broadcast multi- access neighbor."))

(defoid |ospfIfState| (|ospfIfEntry| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The OSPF Interface State."))

(defoid |ospfIfDesignatedRouter| (|ospfIfEntry| 13)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The IP Address of the Designated Router."))

(defoid |ospfIfBackupDesignatedRouter| (|ospfIfEntry| 14)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The  IP  Address  of  the  Backup   Designated
           Router."))

(defoid |ospfIfEvents| (|ospfIfEntry| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times this  OSPF  interface  has
           changed its state, or an error has occurred."))

(defoid |ospfIfAuthKey| (|ospfIfEntry| 16)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The Authentication Key.  If the Area's Author-
           ization  Type  is  simplePassword,  and the key
           length is shorter than 8 octets, the agent will
           left adjust and zero fill to 8 octets.

           Note that unauthenticated  interfaces  need  no
           authentication key, and simple password authen-
           tication cannot use a key of more  than  8  oc-
           tets.  Larger keys are useful only with authen-
           tication mechanisms not specified in this docu-
           ment.

           When read, ospfIfAuthKey always returns an  Oc-
           tet String of length zero."))

(defoid |ospfIfStatus| (|ospfIfEntry| 17)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfIfMulticastForwarding| (|ospfIfEntry| 18)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The way multicasts should  forwarded  on  this
           interface;  not  forwarded,  forwarded  as data
           link multicasts, or forwarded as data link uni-
           casts.   Data link multicasting is not meaning-
           ful on point to point and NBMA interfaces,  and
           setting ospfMulticastForwarding to 0 effective-
           ly disables all multicast forwarding."))

(defoid |ospfIfDemand| (|ospfIfEntry| 19)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Indicates whether Demand OSPF procedures (hel-
           lo supression to FULL neighbors and setting the
           DoNotAge flag on proogated LSAs) should be per-
           formed on this interface."))

(defoid |ospfIfAuthType| (|ospfIfEntry| 20)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The authentication type specified for  an  in-
           terface.   Additional  authentication types may
           be assigned locally."))

(defoid |ospfIfMetricTable| (|ospf| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The TOS metrics for  a  non-virtual  interface
           identified by the interface index."))

(defoid |ospfIfMetricEntry| (|ospfIfMetricTable| 1)
  (:type 'object-type)
  (:syntax '|OspfIfMetricEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A particular TOS metric for a non-virtual  in-
           terface identified by the interface index."))

(deftype |OspfIfMetricEntry| () 't)

(defoid |ospfIfMetricIpAddress| (|ospfIfMetricEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP address of this OSPF interface.  On row
           creation,  this  can  be  derived  from the in-
           stance."))

(defoid |ospfIfMetricAddressLessIf| (|ospfIfMetricEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "For the purpose of easing  the  instancing  of
           addressed   and  addressless  interfaces;  This
           variable takes the value 0 on  interfaces  with
           IP  Addresses, and the value of ifIndex for in-
           terfaces having no IP Address.   On  row  crea-
           tion, this can be derived from the instance."))

(defoid |ospfIfMetricTOS| (|ospfIfMetricEntry| 3)
  (:type 'object-type)
  (:syntax '|TOSType|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type of service metric  being  referenced.
           On  row  creation, this can be derived from the
           instance."))

(defoid |ospfIfMetricValue| (|ospfIfMetricEntry| 4)
  (:type 'object-type)
  (:syntax '|Metric|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The metric of using this type  of  service  on
           this interface.  The default value of the TOS 0
           Metric is 10^8 / ifSpeed."))

(defoid |ospfIfMetricStatus| (|ospfIfMetricEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfVirtIfTable| (|ospf| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Information about this router's virtual inter-
           faces."))

(defoid |ospfVirtIfEntry| (|ospfVirtIfTable| 1)
  (:type 'object-type)
  (:syntax '|OspfVirtIfEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Information about a single Virtual Interface."))

(deftype |OspfVirtIfEntry| () 't)

(defoid |ospfVirtIfAreaId| (|ospfVirtIfEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The  Transit  Area  that  the   Virtual   Link
           traverses.  By definition, this is not 0.0.0.0"))

(defoid |ospfVirtIfNeighbor| (|ospfVirtIfEntry| 2)
  (:type 'object-type)
  (:syntax '|RouterID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The Router ID of the Virtual Neighbor."))

(defoid |ospfVirtIfTransitDelay| (|ospfVirtIfEntry| 3)
  (:type 'object-type)
  (:syntax '|UpToMaxAge|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The estimated number of seconds  it  takes  to
           transmit  a link- state update packet over this
           interface."))

(defoid |ospfVirtIfRetransInterval| (|ospfVirtIfEntry| 4)
  (:type 'object-type)
  (:syntax '|UpToMaxAge|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds between  link-state  ad-
           vertisement  retransmissions,  for  adjacencies
           belonging to this  interface.   This  value  is
           also used when retransmitting database descrip-
           tion  and  link-state  request  packets.   This
           value  should  be well over the expected round-
           trip time."))

(defoid |ospfVirtIfHelloInterval| (|ospfVirtIfEntry| 5)
  (:type 'object-type)
  (:syntax '|HelloRange|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The length of time, in  seconds,  between  the
           Hello  packets that the router sends on the in-
           terface.  This value must be the same  for  the
           virtual neighbor."))

(defoid |ospfVirtIfRtrDeadInterval| (|ospfVirtIfEntry| 6)
  (:type 'object-type)
  (:syntax '|PositiveInteger|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The number of seconds that  a  router's  Hello
           packets  have  not been seen before it's neigh-
           bors declare the router down.  This  should  be
           some  multiple  of  the  Hello  interval.  This
           value must be the same for the  virtual  neigh-
           bor."))

(defoid |ospfVirtIfState| (|ospfVirtIfEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "OSPF virtual interface states."))

(defoid |ospfVirtIfEvents| (|ospfVirtIfEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of state changes or error events on
           this Virtual Link"))

(defoid |ospfVirtIfAuthKey| (|ospfVirtIfEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "If Authentication Type is simplePassword,  the
           device  will left adjust and zero fill to 8 oc-
           tets.

           Note that unauthenticated  interfaces  need  no
           authentication key, and simple password authen-
           tication cannot use a key of more  than  8  oc-
           tets.  Larger keys are useful only with authen-
           tication mechanisms not specified in this docu-
           ment.

           When  read,  ospfVifAuthKey  always  returns  a
           string of length zero."))

(defoid |ospfVirtIfStatus| (|ospfVirtIfEntry| 10)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfVirtIfAuthType| (|ospfVirtIfEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The authentication type specified for a virtu-
           al  interface.  Additional authentication types
           may be assigned locally."))

(defoid |ospfNbrTable| (|ospf| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of non-virtual neighbor information."))

(defoid |ospfNbrEntry| (|ospfNbrTable| 1)
  (:type 'object-type)
  (:syntax '|OspfNbrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The information regarding a single neighbor."))

(deftype |OspfNbrEntry| () 't)

(defoid |ospfNbrIpAddr| (|ospfNbrEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP address this neighbor is using  in  its
           IP  Source  Address.  Note that, on addressless
           links, this will not be 0.0.0.0,  but  the  ad-
           dress of another of the neighbor's interfaces."))

(defoid |ospfNbrAddressLessIndex| (|ospfNbrEntry| 2)
  (:type 'object-type)
  (:syntax '|InterfaceIndex|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "On an interface having an  IP  Address,  zero.
           On  addressless  interfaces,  the corresponding
           value of ifIndex in the Internet Standard  MIB.
           On  row  creation, this can be derived from the
           instance."))

(defoid |ospfNbrRtrId| (|ospfNbrEntry| 3)
  (:type 'object-type)
  (:syntax '|RouterID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A 32-bit integer (represented as a type  IpAd-
           dress)  uniquely  identifying  the  neighboring
           router in the Autonomous System."))

(defoid |ospfNbrOptions| (|ospfNbrEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A Bit Mask corresponding to the neighbor's op-
           tions field.

           Bit 0, if set, indicates that the  system  will
           operate  on  Type of Service metrics other than
           TOS 0.  If zero, the neighbor will  ignore  all
           metrics except the TOS 0 metric.

           Bit 1, if set, indicates  that  the  associated
           area  accepts and operates on external informa-
           tion; if zero, it is a stub area.

           Bit 2, if set, indicates that the system is ca-
           pable  of routing IP Multicast datagrams; i.e.,
           that it implements the Multicast Extensions  to
           OSPF.

           Bit 3, if set, indicates  that  the  associated
           area  is  an  NSSA.  These areas are capable of
           carrying type 7 external advertisements,  which
           are  translated into type 5 external advertise-
           ments at NSSA borders."))

(defoid |ospfNbrPriority| (|ospfNbrEntry| 5)
  (:type 'object-type)
  (:syntax '|DesignatedRouterPriority|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The priority of this neighbor in the designat-
           ed router election algorithm.  The value 0 sig-
           nifies that the neighbor is not eligible to be-
           come  the  designated router on this particular
           network."))

(defoid |ospfNbrState| (|ospfNbrEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The State of the relationship with this Neigh-
           bor."))

(defoid |ospfNbrEvents| (|ospfNbrEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of times this neighbor relationship
           has changed state, or an error has occurred."))

(defoid |ospfNbrLsRetransQLen| (|ospfNbrEntry| 8)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The  current  length  of  the   retransmission
           queue."))

(defoid |ospfNbmaNbrStatus| (|ospfNbrEntry| 9)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfNbmaNbrPermanence| (|ospfNbrEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.   'dynamic'  and  'permanent' refer to how
           the neighbor became known."))

(defoid |ospfNbrHelloSuppressed| (|ospfNbrEntry| 11)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Indicates whether Hellos are being  suppressed
           to the neighbor"))

(defoid |ospfVirtNbrTable| (|ospf| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table of virtual neighbor information."))

(defoid |ospfVirtNbrEntry| (|ospfVirtNbrTable| 1)
  (:type 'object-type)
  (:syntax '|OspfVirtNbrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Virtual neighbor information."))

(deftype |OspfVirtNbrEntry| () 't)

(defoid |ospfVirtNbrArea| (|ospfVirtNbrEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The Transit Area Identifier."))

(defoid |ospfVirtNbrRtrId| (|ospfVirtNbrEntry| 2)
  (:type 'object-type)
  (:syntax '|RouterID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A  32-bit  integer  uniquely  identifying  the
           neighboring router in the Autonomous System."))

(defoid |ospfVirtNbrIpAddr| (|ospfVirtNbrEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP address this Virtual  Neighbor  is  us-
           ing."))

(defoid |ospfVirtNbrOptions| (|ospfVirtNbrEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A Bit Mask corresponding to the neighbor's op-
           tions field.

           Bit 1, if set, indicates that the  system  will
           operate  on  Type of Service metrics other than
           TOS 0.  If zero, the neighbor will  ignore  all
           metrics except the TOS 0 metric.

           Bit 2, if set, indicates  that  the  system  is
           Network  Multicast  capable; ie, that it imple-
           ments OSPF Multicast Routing."))

(defoid |ospfVirtNbrState| (|ospfVirtNbrEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The state of the  Virtual  Neighbor  Relation-
           ship."))

(defoid |ospfVirtNbrEvents| (|ospfVirtNbrEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of  times  this  virtual  link  has
           changed its state, or an error has occurred."))

(defoid |ospfVirtNbrLsRetransQLen| (|ospfVirtNbrEntry| 7)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The  current  length  of  the   retransmission
           queue."))

(defoid |ospfVirtNbrHelloSuppressed| (|ospfVirtNbrEntry| 8)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Indicates whether Hellos are being  suppressed
           to the neighbor"))

(defoid |ospfExtLsdbTable| (|ospf| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The OSPF Process's Links State Database."))

(defoid |ospfExtLsdbEntry| (|ospfExtLsdbTable| 1)
  (:type 'object-type)
  (:syntax '|OspfExtLsdbEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A single Link State Advertisement."))

(deftype |OspfExtLsdbEntry| () 't)

(defoid |ospfExtLsdbType| (|ospfExtLsdbEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type  of  the  link  state  advertisement.
           Each  link state type has a separate advertise-
           ment format."))

(defoid |ospfExtLsdbLsid| (|ospfExtLsdbEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Link State ID is an LS Type Specific field
           containing either a Router ID or an IP Address;
           it identifies the piece of the  routing  domain
           that is being described by the advertisement."))

(defoid |ospfExtLsdbRouterId| (|ospfExtLsdbEntry| 3)
  (:type 'object-type)
  (:syntax '|RouterID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 32 bit number that uniquely identifies the
           originating router in the Autonomous System."))

(defoid |ospfExtLsdbSequence| (|ospfExtLsdbEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The sequence number field is a  signed  32-bit
           integer.   It  is used to detect old and dupli-
           cate link state advertisements.  The  space  of
           sequence  numbers  is  linearly  ordered.   The
           larger the sequence number the more recent  the
           advertisement."))

(defoid |ospfExtLsdbAge| (|ospfExtLsdbEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This field is the age of the link state adver-
           tisement in seconds."))

(defoid |ospfExtLsdbChecksum| (|ospfExtLsdbEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This field is the  checksum  of  the  complete
           contents  of  the  advertisement, excepting the
           age field.  The age field is excepted  so  that
           an   advertisement's  age  can  be  incremented
           without updating the  checksum.   The  checksum
           used  is  the same that is used for ISO connec-
           tionless datagrams; it is commonly referred  to
           as the Fletcher checksum."))

(defoid |ospfExtLsdbAdvertisement| (|ospfExtLsdbEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The entire Link State Advertisement, including
           its header."))

(defoid |ospfRouteGroup| (|ospf| 13) (:type 'object-identity))

(defoid |ospfIntraArea| (|ospfRouteGroup| 1) (:type 'object-identity))

(defoid |ospfInterArea| (|ospfRouteGroup| 2) (:type 'object-identity))

(defoid |ospfExternalType1| (|ospfRouteGroup| 3)
  (:type 'object-identity))

(defoid |ospfExternalType2| (|ospfRouteGroup| 4)
  (:type 'object-identity))

(defoid |ospfAreaAggregateTable| (|ospf| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A range of IP addresses  specified  by  an  IP
           address/IP  network  mask  pair.   For example,
           class B address range of X.X.X.X with a network
           mask  of  255.255.0.0 includes all IP addresses
           from X.X.0.0  to  X.X.255.255.   Note  that  if
           ranges  are configured such that one range sub-
           sumes  another  range  (e.g.,   10.0.0.0   mask
           255.0.0.0  and  10.1.0.0 mask 255.255.0.0), the
           most specific match is the preferred one."))

(defoid |ospfAreaAggregateEntry| (|ospfAreaAggregateTable| 1)
  (:type 'object-type)
  (:syntax '|OspfAreaAggregateEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A range of IP addresses  specified  by  an  IP
           address/IP  network  mask  pair.   For example,
           class B address range of X.X.X.X with a network
           mask  of  255.255.0.0 includes all IP addresses
           from X.X.0.0  to  X.X.255.255.   Note  that  if
           ranges are range configured such that one range
           subsumes another  range  (e.g.,  10.0.0.0  mask
           255.0.0.0  and  10.1.0.0 mask 255.255.0.0), the
           most specific match is the preferred one."))

(deftype |OspfAreaAggregateEntry| () 't)

(defoid |ospfAreaAggregateAreaID| (|ospfAreaAggregateEntry| 1)
  (:type 'object-type)
  (:syntax '|AreaID|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Area the Address Aggregate is to be  found
           within."))

(defoid |ospfAreaAggregateLsdbType| (|ospfAreaAggregateEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type of the Address Aggregate.  This field
           specifies  the  Lsdb type that this Address Ag-
           gregate applies to."))

(defoid |ospfAreaAggregateNet| (|ospfAreaAggregateEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The IP Address of the Net or Subnet  indicated
           by the range."))

(defoid |ospfAreaAggregateMask| (|ospfAreaAggregateEntry| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Subnet Mask that pertains to  the  Net  or
           Subnet."))

(defoid |ospfAreaAggregateStatus| (|ospfAreaAggregateEntry| 5)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This variable displays the status of  the  en-
           try.  Setting it to 'invalid' has the effect of
           rendering it inoperative.  The internal  effect
           (row removal) is implementation dependent."))

(defoid |ospfAreaAggregateEffect| (|ospfAreaAggregateEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Subnets subsumed by ranges either trigger  the
           advertisement  of  the indicated aggregate (ad-
           vertiseMatching), or result in the subnet's not
           being advertised at all outside the area."))

(defoid |ospfConformance| (|ospf| 15) (:type 'object-identity))

(defoid |ospfGroups| (|ospfConformance| 1) (:type 'object-identity))

(defoid |ospfCompliances| (|ospfConformance| 2)
  (:type 'object-identity))

(defoid |ospfCompliance| (|ospfCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description "The compliance statement "))

(defoid |ospfBasicGroup| (|ospfGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(defoid |ospfAreaGroup| (|ospfGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required  for  OSPF  systems
           supporting areas."))

(defoid |ospfStubAreaGroup| (|ospfGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required  for  OSPF  systems
           supporting stub areas."))

(defoid |ospfLsdbGroup| (|ospfGroups| 4)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required  for  OSPF  systems
           that display their link state database."))

(defoid |ospfAreaRangeGroup| (|ospfGroups| 5)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description
   "These objects are required for  non-CIDR  OSPF
           systems that support multiple areas."))

(defoid |ospfHostGroup| (|ospfGroups| 6)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required  for  OSPF  systems
           that support attached hosts."))

(defoid |ospfIfGroup| (|ospfGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(defoid |ospfIfMetricGroup| (|ospfGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(defoid |ospfVirtIfGroup| (|ospfGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(defoid |ospfNbrGroup| (|ospfGroups| 10)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(defoid |ospfVirtNbrGroup| (|ospfGroups| 11)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(defoid |ospfExtLsdbGroup| (|ospfGroups| 12)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "These objects are required  for  OSPF  systems
           that display their link state database."))

(defoid |ospfAreaAggregateGroup| (|ospfGroups| 13)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects are required for OSPF systems."))

(eval-when (:load-toplevel :execute) (setf *current-module* nil))

