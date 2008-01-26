(in-package :snmp)

(defconstant +min-oid-len+ 2)
(defconstant +max-oid-len+ 128)

(defconstant +usm-auth-ku-len+ 32)
(defconstant +usm-priv-ku-len+ 32)

(defconstant +asn-boolean+	#x01)
(defconstant +asn-integer+	#x02)
(defconstant +asn-bit-str+	#x03)
(defconstant +asn-octet-str+	#x04)
(defconstant +asn-null+		#x05)
(defconstant +asn-object-id+	#x06)
(defconstant +asn-sequence+	#x10)
(defconstant +asn-set+		#x11)

(defconstant +asn-universal+	#b00000000)
(defconstant +asn-application+	#b01000000)
(defconstant +asn-context+	#b10000000)
(defconstant +asn-private+	#b11000000)

(defconstant +asn-primitive+	#b00000000)
(defconstant +asn-constructor+	#b00100000)

;; defined types (from the SMI, RFC 1157)
(defconstant +asn-ipaddress+	(logior +asn-application+ 0))
(defconstant +asn-counter+	(logior +asn-application+ 1))
(defconstant +asn-gauge+	(logior +asn-application+ 2))
(defconstant +asn-unsigned+	(logior +asn-application+ 2))
(defconstant +asn-timeticks+	(logior +asn-application+ 3))
(defconstant +asn-opaque+	(logior +asn-application+ 4))

;; defined types (from the SMI, RFC 1442)
(defconstant +asn-nsap+		(logior +asn-application+ 5))
(defconstant +asn-counter64+	(logior +asn-application+ 6))
(defconstant +asn-uinteger+	(logior +asn-application+ 7))

(defconstant +asn-float+	(logior +asn-application+ 8))
(defconstant +asn-double+	(logior +asn-application+ 9))

;;; from snmp.h
(defconstant +snmp-version-1+  0)
(defconstant +snmp-version-2c+ 1)
(defconstant +snmp-version-3+  3)

(defconstant +snmp-sec-model-any+ 0)
(defconstant +snmp-sec-model-snmpv1+ 1)
(defconstant +snmp-sec-model-snmpv2c+ 2)
(defconstant +snmp-sec-model-usm+ 3)

(defconstant +snmp-sec-level-noauth+     1)
(defconstant +snmp-sec-level-authnopriv+ 2)
(defconstant +snmp-sec-level-authpriv+   3)

;; PDU types in SNMPv1, SNMPsec, SNMPv2p, SNMPv2c, SNMPv2u, SNMPv2*, and SNMPv3
(defconstant +snmp-msg-get+
  (logior +asn-context+ +asn-constructor+ 0))

(defconstant +snmp-msg-getnext+
  (logior +asn-context+ +asn-constructor+ 1))

(defconstant +snmp-msg-response+
  (logior +asn-context+ +asn-constructor+ 2))

(defconstant +snmp-msg-set+
  (logior +asn-context+ +asn-constructor+ 3))

;; PDU types in SNMPv1 and SNMPsec
(defconstant +snmp-msg-trap+
  (logior +asn-context+ +asn-constructor+ 4))

;; PDU types in SNMPv2p, SNMPv2c, SNMPv2u, SNMPv2*, and SNMPv3
(defconstant +snmp-msg-getbulk+
  (logior +asn-context+ +asn-constructor+ 5))

(defconstant +snmp-msg-inform+
  (logior +asn-context+ +asn-constructor+ 6))

(defconstant +snmp-msg-trap2+
  (logior +asn-context+ +asn-constructor+ 7))

;; PDU types in SNMPv2u, SNMPv2*, and SNMPv3
(defconstant +snmp-msg-report+
  (logior +asn-context+ +asn-constructor+ 8))

;;; from snmp_client.h
(defconstant +snmp-stat-success+ 0)
(defconstant +snmp-stat-error+ 1)
(defconstant +snmp-stat-timeout+ 2)

(defconstant +snmp-err-success+ 0)
(defconstant +snmp-err-noerror+ 0)
(defconstant +snmp-err-toobig+ 1)
(defconstant +snmp-err-nosuchname+ 2)
(defconstant +snmp-err-badvalue+ 3)
(defconstant +snmp-err-readonly+ 4)
(defconstant +snmp-err-generr+ 5)
