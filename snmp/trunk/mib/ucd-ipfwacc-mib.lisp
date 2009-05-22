;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;UCD-IPFWACC-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'ucd-ipfwacc-mib))

(defpackage :asn.1/ucd-ipfwacc-mib
  (:nicknames :ucd-ipfwacc-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| object-type module-identity
                |IpAddress| |Integer32| |Counter32|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :asn.1/ucd-snmp-mib |ucdExperimental|))

(in-package :ucd-ipfwacc-mib)

(defoid |ucdIpFwAccMIB| (|ucdExperimental| 1)
  (:type 'module-identity)
  (:description
   "This module defines MIB components for reading information
         from the accounting rules IP Firewall. This would typically
         let you read the rules and the counters. I did not include
         some flags and fields that I considered irrelevant for the
         accounting rules. Resetting the counters of the rules by SNMP
         would be simple, but I don't consider it so useful. I gave no
         consideration to implementing write access for allowing
         modification of the accounting rules.

         Cristian.Estan@net.utcluj.ro "))

(defoid |ipFwAccTable| (|ucdIpFwAccMIB| 1)
  (:type 'object-type)
  (:syntax '(vector |IpFwAccEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A table with the accounting rules of the IP firewall"))

(defoid |ipFwAccEntry| (|ipFwAccTable| 1)
  (:type 'object-type)
  (:syntax '|IpFwAccEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An accounting rule of the IP firewall"))

(defclass |IpFwAccEntry|
          (sequence-type)
          ((|ipFwAccIndex| :type |Integer32|)
           (|ipFwAccSrcAddr| :type |IpAddress|)
           (|ipFwAccSrcNetMask| :type |IpAddress|)
           (|ipFwAccDstAddr| :type |IpAddress|)
           (|ipFwAccDstNetMask| :type |IpAddress|)
           (|ipFwAccViaName| :type |DisplayString|)
           (|ipFwAccViaAddr| :type |IpAddress|)
           (|ipFwAccProto| :type integer)
           (|ipFwAccBidir| :type integer)
           (|ipFwAccDir| :type integer)
           (|ipFwAccBytes| :type |Counter32|)
           (|ipFwAccPackets| :type |Counter32|)
           (|ipFwAccNrSrcPorts| :type |Integer32|)
           (|ipFwAccNrDstPorts| :type |Integer32|)
           (|ipFwAccSrcIsRange| :type integer)
           (|ipFwAccDstIsRange| :type integer)
           (|ipFwAccPort1| :type |Integer32|)
           (|ipFwAccPort2| :type |Integer32|)
           (|ipFwAccPort3| :type |Integer32|)
           (|ipFwAccPort4| :type |Integer32|)
           (|ipFwAccPort5| :type |Integer32|)
           (|ipFwAccPort6| :type |Integer32|)
           (|ipFwAccPort7| :type |Integer32|)
           (|ipFwAccPort8| :type |Integer32|)
           (|ipFwAccPort9| :type |Integer32|)
           (|ipFwAccPort10| :type |Integer32|)))

(defoid |ipFwAccIndex| (|ipFwAccEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference index for each firewall rule."))

(defoid |ipFwAccSrcAddr| (|ipFwAccEntry| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The source address in the firewall rule."))

(defoid |ipFwAccSrcNetMask| (|ipFwAccEntry| 3)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The netmask of the source address in the firewall rule."))

(defoid |ipFwAccDstAddr| (|ipFwAccEntry| 4)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The destination address in the firewall rule."))

(defoid |ipFwAccDstNetMask| (|ipFwAccEntry| 5)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The netmask of the destination address in the firewall rule."))

(defoid |ipFwAccViaName| (|ipFwAccEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The name of the interface to which the rule applies. If no
	 interface is associated with the present rule, this should
	 contain a dash (-)."))

(defoid |ipFwAccViaAddr| (|ipFwAccEntry| 7)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The address of the interface to which the rule applies.
	 Using this parameter makes sense when multiple addresses are
	 associated to the same physical interface. If not defined
	 for the current rule this should be set to 0."))

(defoid |ipFwAccProto| (|ipFwAccEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The protocol(s) to which the rule applies."))

(defoid |ipFwAccBidir| (|ipFwAccEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Whether the rule works in both directions (i.e. with the
	 source and destination parts swapped) or not."))

(defoid |ipFwAccDir| (|ipFwAccEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Whether the rule applies to packets entering or exiting the
	 kernel."))

(defoid |ipFwAccBytes| (|ipFwAccEntry| 11)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of bytes that matched this rule since the last
	 reset of the counters."))

(defoid |ipFwAccPackets| (|ipFwAccEntry| 12)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets that matched this rule since the last
	 reset of the counters."))

(defoid |ipFwAccNrSrcPorts| (|ipFwAccEntry| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ports that refer to the source address."))

(defoid |ipFwAccNrDstPorts| (|ipFwAccEntry| 14)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of ports that refer to the destination address."))

(defoid |ipFwAccSrcIsRange| (|ipFwAccEntry| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Interpret the first two ports of the source part as
	 the upper and lower limit of an interval or not."))

(defoid |ipFwAccDstIsRange| (|ipFwAccEntry| 16)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Interpret the first two ports of the destination part as
	 the upper and lower limit of an interval or not."))

(defoid |ipFwAccPort1| (|ipFwAccEntry| 17)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 1."))

(defoid |ipFwAccPort2| (|ipFwAccEntry| 18)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 2."))

(defoid |ipFwAccPort3| (|ipFwAccEntry| 19)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 3."))

(defoid |ipFwAccPort4| (|ipFwAccEntry| 20)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 4."))

(defoid |ipFwAccPort5| (|ipFwAccEntry| 21)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 5."))

(defoid |ipFwAccPort6| (|ipFwAccEntry| 22)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 6."))

(defoid |ipFwAccPort7| (|ipFwAccEntry| 23)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 7."))

(defoid |ipFwAccPort8| (|ipFwAccEntry| 24)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 8."))

(defoid |ipFwAccPort9| (|ipFwAccEntry| 25)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 9."))

(defoid |ipFwAccPort10| (|ipFwAccEntry| 26)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Port number 10."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'ucd-ipfwacc-mib *mib-modules*)
  (setf *current-module* nil))

