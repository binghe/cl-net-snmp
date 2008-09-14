;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defvar *snmp-server-contact* "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  "Change it to yourself")

;;; system tree
(def-scalar-variable "sysDescr" (agent)
  (format nil "~A ~A on ~A"
          (lisp-implementation-type)
          (lisp-implementation-version)
          (machine-instance)))

(def-scalar-variable "sysUpTimeInstance" (agent)
  (timeticks (truncate (* #.(/ 100 internal-time-units-per-second)
                          (- (get-internal-real-time)
                             (slot-value agent 'start-up-time))))))

(def-scalar-variable "sysContact" (agent)
  *snmp-server-contact*)

(def-scalar-variable "sysName" (agent)
  (format nil "~A (~A)"
          (long-site-name) (short-site-name)))

(def-scalar-variable "sysLocation" (agent)
  (machine-instance))

(def-scalar-variable "sysORLastChange" (agent)
  (timeticks 0))

;;; OID Table definitions

(def-listy-mib-table "sysORID" ()
  (let ((id-list '("ifMIB"
                   "snmpMIB"
                   "tcpMIB"
                   "ip"
                   "udpMIB"
                   "vacmBasicGroup"
                   "snmpFrameworkMIBCompliance"
                   "snmpMPDCompliance"
                   "usmMIBCompliance")))
    (mapcar #'(lambda (x)
                #'(lambda (agent)
                    (declare (ignore agent))
                    (oid x)))
            id-list)))

(def-listy-mib-table "sysORDescr" ()
  (let ((string-list
         '("The MIB module to describe generic objects for network interface sub-layers"
           "The MIB module for SNMPv2 entities"
           "The MIB module for managing TCP implementations"
           "The MIB module for managing IP and ICMP implementations"
           "The MIB module for managing UDP implementations"
           "View-based Access Control Model for SNMP."
           "The SNMP Management Architecture MIB."
           "The MIB for Message Processing and Dispatching."
           "The management information definitions for the SNMP User-based Security Model.")))
    (mapcar #'(lambda (x)
                #'(lambda (agent)
                    (declare (ignore agent))
                    x))
            string-list)))

(def-listy-mib-table "sysORUpTime" ()
  (let ((f #'(lambda (agent) (declare (ignore agent)) (timeticks 0))))
    (list f f f f f f f f f)))

;;; |sysORID|, |sysORDescr|, |sysORUpTime| from 1 to 9 is not implemented.
#|
(def-listy-mib-table [atTable]
    (:list
     (let ((if-count 0))
       (mapcan #'(lambda (interface)
		   (incf if-count)
		   (mapcar #'(lambda (x) (cons if-count x))
			   (zl:send interface :at-entries)))
	       neti:*interfaces*)))
  (:index #'(lambda (at)
	      (list* (car at) (car at)
		     (cadr at))))
  (:sort t)
  (:entry [atEntry])
  (:slots
   ([atIfIndex] (at) (car at))
   ([atPhysAddress] (at) (cddr at))
   ([atNetAddress] (at) (make-ip-address-from-list (cadr at)))))

(def-listy-mib-table [ifTable] (:list neti:*interfaces*)
  (:entry [ifEntry])
  (:slots
   ([ifIndex] (interface ignore subids) (first subids))
   ([ifDescr] (interface) (neti:network-interface-name interface))
   ([ifType]
    (interface)
    (typecase interface
      (neti:ethernet-interface 6)	     ;ethernet-csmacd
      (t 1)))				     ;other
   ([ifMtu] (interface) (zl:send interface :max-packet-size))
   ([ifSpeed] 
    (interface)
    (make-gauge32
     (typecase interface
       (neti:ethernet-interface 10000000)
       (t 1))))
   ([ifPhysAddress] 
    (interface)
    (slot-value interface 'neti:local-hardware-address))
   ([ifAdminStatus]
    (interface)
    (if (slot-value interface 'neti:enabled)
	1				     ;up
      2))
   ([ifOperStatus]
    (interface)
    (if (slot-value interface 'neti:enabled)
	1				     ;up
      2))				     ;down
   ([ifLastChange] (interface) (timeticks 0))
   ([ifInOctets] (interface) (counter32 0))
   ([ifInUcastPkts]
    (interface)
    (counter32 (slot-value interface 'neti:receive-count)))
   ([ifInNUcastPkts] (interface) (counter32 0))
   ([ifInDiscards] (interface) (counter32 (interface-in-errors interface)))
   ([ifInErrors] (interface) (counter32 (interface-in-errors interface)))
   ([ifInUnknownProtos] (interface) (counter32 0))
   ([ifOutOctets] (interface) (counter32 0))
   ([ifOutUcastPkts] 
    (interface)
    (counter32 (slot-value interface 'neti:transmit-count)))
   ([ifOutNUcastPkts] (interface) (counter32 0))
   ([ifOutDiscards] (interface) (counter32 0))
   ([ifOutErrors] (interface) (counter32 (interface-out-errors interface)))
   ([ifOutQLen] (interface) (make-gauge32 0))))
|#

;;; .iso.org.dod.internet.mgmt.mib-2.snmp (.1.3.6.1.2.1.11)
(def-scalar-variable "snmpInPkts" (agent)
  (counter32 (slot-value agent 'in-pkts)))
(def-scalar-variable "snmpOutPkts" (agent)
  (counter32 (slot-value agent 'out-pkts)))
(def-scalar-variable "snmpInBadVersions" (agent)
  (counter32 (slot-value agent 'in-bad-versions)))
(def-scalar-variable "snmpInBadCommunityNames" (agent)
  (counter32 (slot-value agent 'in-bad-community-names)))
(def-scalar-variable "snmpInBadCommunityUses" (agent)
  (counter32 (slot-value agent 'in-bad-community-uses)))
(def-scalar-variable "snmpInASNParseErrs" (agent)
  (counter32 (slot-value agent 'in-asn-parse-errs)))
(def-scalar-variable "snmpInTooBigs" (agent)
  (counter32 (slot-value agent 'in-too-bigs)))
(def-scalar-variable "snmpInNoSuchNames" (agent)
  (counter32 (slot-value agent 'in-no-such-names)))
(def-scalar-variable "snmpInBadValues" (agent)
  (counter32 (slot-value agent 'in-bad-values)))
(def-scalar-variable "snmpInReadOnlys" (agent)
  (counter32 (slot-value agent 'in-read-onlys)))
(def-scalar-variable "snmpInGenErrs" (agent)
  (counter32 (slot-value agent 'in-gen-errs)))
(def-scalar-variable "snmpInTotalReqVars" (agent)
  (counter32 (slot-value agent 'in-total-req-vars)))
(def-scalar-variable "snmpInTotalSetVars" (agent)
  (counter32 (slot-value agent 'in-total-set-vars)))
(def-scalar-variable "snmpInGetRequests" (agent)
  (counter32 (slot-value agent 'in-get-requests)))
(def-scalar-variable "snmpInGetNexts" (agent)
  (counter32 (slot-value agent 'in-get-nexts)))
(def-scalar-variable "snmpInSetRequests" (agent)
  (counter32 (slot-value agent 'in-set-requests)))
(def-scalar-variable "snmpInGetResponses" (agent)
  (counter32 (slot-value agent 'in-get-responses)))
(def-scalar-variable "snmpInTraps" (agent)
  (counter32 (slot-value agent 'in-traps)))
(def-scalar-variable "snmpOutTooBigs" (agent)
  (counter32 (slot-value agent 'out-too-bigs)))
(def-scalar-variable "snmpOutNoSuchNames" (agent)
  (counter32 (slot-value agent 'out-no-such-names)))
(def-scalar-variable "snmpOutBadValues" (agent)
  (counter32 (slot-value agent 'out-bad-values)))
(def-scalar-variable "snmpOutGenErrs" (agent)
  (counter32 (slot-value agent 'out-gen-errs)))
(def-scalar-variable "snmpOutGetRequests" (agent)
  (counter32 (slot-value agent 'out-get-requests)))
(def-scalar-variable "snmpOutGetNexts" (agent)
  (counter32 (slot-value agent 'out-get-nexts)))
(def-scalar-variable "snmpOutSetRequests" (agent)
  (counter32 (slot-value agent 'out-set-requests)))
(def-scalar-variable "snmpOutGetResponses" (agent)
  (counter32 (slot-value agent 'out-get-responses)))
(def-scalar-variable "snmpOutTraps" (agent)
  (counter32 (slot-value agent 'out-traps)))
(def-scalar-variable "snmpEnableAuthenTraps" (agent)
  0)
(def-scalar-variable "snmpSilentDrops" (agent)
  (counter32 0))
(def-scalar-variable "snmpProxyDrops" (agent)
  (counter32 0))
