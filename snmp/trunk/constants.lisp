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

(defconstant +snmp-sec-model-any+ 0)
(defconstant +snmp-sec-model-snmpv1+ 1)
(defconstant +snmp-sec-model-snmpv2c+ 2)
(defconstant +snmp-sec-model-usm+ 3)

(defconstant +snmp-sec-level-noauth+     1)
(defconstant +snmp-sec-level-authnopriv+ 2)
(defconstant +snmp-sec-level-authpriv+   3)

;;; from snmp_client.h
(defconstant +snmp-stat-success+ 0)
(defconstant +snmp-stat-error+ 1)
(defconstant +snmp-stat-timeout+ 2)

