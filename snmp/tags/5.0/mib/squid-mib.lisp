;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:MISC;SQUID-MIB.MIB

(in-package :asn.1)
(setf *current-module* 'squid-mib)
(eval-when (:load-toplevel :execute) (pushnew 'squid-mib *mib-modules*))
(defoid |nlanr| (|enterprises| 3495) (:type 'object-identity))
(defoid |squid| (|nlanr| 1)
  (:type 'module-identity)
  (:description
   "Squid MIB defined for the management of the squid
		proxy server. See http://squid.nlanr.net/."))
(defoid |cacheSystem| (|squid| 1) (:type 'object-identity))
(defoid |cacheConfig| (|squid| 2) (:type 'object-identity))
(defoid |cachePerf| (|squid| 3) (:type 'object-identity))
(defoid |cacheNetwork| (|squid| 4) (:type 'object-identity))
(defoid |cacheMesh| (|squid| 5) (:type 'object-identity))
(defoid |cacheSysVMsize| (|cacheSystem| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Virtual Memory size in KB"))
(defoid |cacheSysStorage| (|cacheSystem| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Diskspace in KB"))
(defoid |cacheUptime| (|cacheSystem| 3)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of timeticks since cache started "))
(defoid |cacheAdmin| (|cacheConfig| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Administrator E-Mail address "))
(defoid |cacheSoftware| (|cacheConfig| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Software Name "))
(defoid |cacheVersionId| (|cacheConfig| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Software Version "))
(defoid |cacheLoggingFacility| (|cacheConfig| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   " Logging Facility. An informational string
			  indicating logging info like debug level, 
			  local/syslog/remote logging etc "))
(defoid |cacheStorageConfig| (|cacheConfig| 5) (:type 'object-identity))
(defoid |cacheMemMaxSize| (|cacheStorageConfig| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Memory Maximum Size "))
(defoid |cacheMemHighWM| (|cacheStorageConfig| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Memory High Water Mark "))
(defoid |cacheMemLowWM| (|cacheStorageConfig| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Memory Low Water Mark "))
(defoid |cacheSwapMaxSize| (|cacheStorageConfig| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Swap Maximum Size "))
(defoid |cacheSwapHighWM| (|cacheStorageConfig| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Swap High Water Mark "))
(defoid |cacheSwapLowWM| (|cacheStorageConfig| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Cache Swap Low Water Mark "))
(defoid |cacheSysPerf| (|cachePerf| 1) (:type 'object-identity))
(defoid |cacheProtoStats| (|cachePerf| 2) (:type 'object-identity))
(defoid |cacheSysPageFaults| (|cacheSysPerf| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of system page faults "))
(defoid |cacheSysNumReads| (|cacheSysPerf| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description " Number of Reads "))
(defoid |cacheSysDefReads| (|cacheSysPerf| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description " see cachemgr "))
(defoid |cacheMemUsage| (|cacheSysPerf| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Amount of system memory allocated by the cache"))
(defoid |cacheCpuUsage| (|cacheSysPerf| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Amount of cpu seconds consumed"))
(defoid |cacheMaxResSize| (|cacheSysPerf| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Maximum Resident Size"))
(defoid |cacheNumObjCount| (|cacheSysPerf| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of objects "))
(defoid |cacheCurrentLRUExpiration| (|cacheSysPerf| 8)
  (:type 'object-type)
  (:syntax '|TimeTicks|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheCurrentUnlinkRequests| (|cacheSysPerf| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheCurrentUnusedFileDescrCount| (|cacheSysPerf| 10)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheCurrentReservedFileDescrCount| (|cacheSysPerf| 11)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheProtoAggregateStats| (|cacheProtoStats| 1)
  (:type 'object-identity))
(defoid |cacheClientProtoHttpRequests| (|cacheProtoAggregateStats| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpHits| (|cacheProtoAggregateStats| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpErrors| (|cacheProtoAggregateStats| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpInKb| (|cacheProtoAggregateStats| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpOutKb| (|cacheProtoAggregateStats| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIcpPktsSent| (|cacheProtoAggregateStats| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIcpPktsRecv| (|cacheProtoAggregateStats| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIcpKbSent| (|cacheProtoAggregateStats| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIcpKbRecv| (|cacheProtoAggregateStats| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheServerRequests| (|cacheProtoAggregateStats| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheServerErrors| (|cacheProtoAggregateStats| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheServerInKb| (|cacheProtoAggregateStats| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheServerOutKb| (|cacheProtoAggregateStats| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheCurrentSwapSize| (|cacheProtoAggregateStats| 14)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheClients| (|cacheProtoAggregateStats| 15)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheMedianSvcTable| (|cacheProtoStats| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description " "))
(defoid |cacheMedianSvcEntry| (|cacheMedianSvcTable| 1)
  (:type 'object-type)
  (:syntax '|CacheMedianSvcEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description " An entry in cacheMedianSvcTable "))
(deftype |CacheMedianSvcEntry| () 't)
(defoid |cacheMedianTime| (|cacheMedianSvcEntry| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpAllSvcTime| (|cacheMedianSvcEntry| 2)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpMissSvcTime| (|cacheMedianSvcEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpNmSvcTime| (|cacheMedianSvcEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHttpHitSvcTime| (|cacheMedianSvcEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIcpQuerySvcTime| (|cacheMedianSvcEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIcpReplySvcTime| (|cacheMedianSvcEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheDnsSvcTime| (|cacheMedianSvcEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheRequestHitRatio| (|cacheMedianSvcEntry| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheRequestByteRatio| (|cacheMedianSvcEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheIpCache| (|cacheNetwork| 1) (:type 'object-identity))
(defoid |cacheFqdnCache| (|cacheNetwork| 2) (:type 'object-identity))
(defoid |cacheDns| (|cacheNetwork| 3) (:type 'object-identity))
(defoid |cacheEntries| (|cacheIpCache| 1)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheRequests| (|cacheIpCache| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheHits| (|cacheIpCache| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cachePendingHits| (|cacheIpCache| 4)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheNegativeHits| (|cacheIpCache| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheMisses| (|cacheIpCache| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheBlockingGetHostByName| (|cacheIpCache| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheAttemptReleaseLockedEntries| (|cacheIpCache| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnEntries| (|cacheFqdnCache| 1)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnRequests| (|cacheFqdnCache| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnHits| (|cacheFqdnCache| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnPendingHits| (|cacheFqdnCache| 4)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnNegativeHits| (|cacheFqdnCache| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnMisses| (|cacheFqdnCache| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheFqdnBlockingGetHostByAddr| (|cacheFqdnCache| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheDnsRequests| (|cacheDns| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheDnsReplies| (|cacheDns| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cacheDnsNumberServers| (|cacheDns| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " "))
(defoid |cachePeerTable| (|cacheMesh| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   " This table contains an enumeration of
			  the peer caches, complete with info "))
(defoid |cachePeerEntry| (|cachePeerTable| 1)
  (:type 'object-type)
  (:syntax '|CachePeerEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description " An entry in cachePeerTable "))
(deftype |CachePeerEntry| () 't)
(defoid |cachePeerName| (|cachePeerEntry| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   " The FQDN name or internal alias for the
		      	    peer cache"))
(defoid |cachePeerAddr| (|cachePeerEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " The IP Address of the peer cache "))
(defoid |cachePeerPortHttp| (|cachePeerEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " The port the peer listens for HTTP requests "))
(defoid |cachePeerPortIcp| (|cachePeerEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   " The port the peer listens for ICP requests 
			  should be 0 if not configured to send ICP requests "))
(defoid |cachePeerType| (|cachePeerEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description " Peer Type "))
(defoid |cachePeerState| (|cachePeerEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " The operational state of this peer "))
(defoid |cachePeerPingsSent| (|cachePeerEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of pings sent to peer "))
(defoid |cachePeerPingsAcked| (|cachePeerEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of pings received from peer "))
(defoid |cachePeerFetches| (|cachePeerEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of times this peer was selected  "))
(defoid |cachePeerRtt| (|cachePeerEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Last known round-trip time to the peer (in ms) "))
(defoid |cachePeerIgnored| (|cachePeerEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " How many times this peer was ignored "))
(defoid |cachePeerKeepAlSent| (|cachePeerEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of keepalives sent "))
(defoid |cachePeerKeepAlRecv| (|cachePeerEntry| 13)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of keepalives received "))
(defoid |cacheClientTable| (|cacheMesh| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of cache client entries."))
(defoid |cacheClientEntry| (|cacheClientTable| 1)
  (:type 'object-type)
  (:syntax '|CacheClientEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry in cacheClientTable"))
(deftype |CacheClientEntry| () 't)
(defoid |cacheClientAddr| (|cacheClientEntry| 1)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The client's IP address "))
(defoid |cacheClientHttpRequests| (|cacheClientEntry| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of HTTP requests received from client "))
(defoid |cacheClientHttpKb| (|cacheClientEntry| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Amount of total HTTP traffic to this client  "))
(defoid |cacheClientHttpHits| (|cacheClientEntry| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   " Number of hits in response to this client's HTTP requests "))
(defoid |cacheClientHTTPHitKb| (|cacheClientEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Amount of HTTP hit traffic in KB "))
(defoid |cacheClientIcpRequests| (|cacheClientEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Number of ICP requests received from client "))
(defoid |cacheClientIcpKb| (|cacheClientEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Amount of total ICP traffic to this client (child) "))
(defoid |cacheClientIcpHits| (|cacheClientEntry| 8)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   " Number of hits in response to this client's ICP requests "))
(defoid |cacheClientIcpHitKb| (|cacheClientEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description " Amount of ICP hit traffic in KB "))
