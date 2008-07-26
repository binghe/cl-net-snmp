(in-package :snmp)

(defconstant +max-snmp-packet-size+ 65507)

(defconstant +usm-auth-ku-len+ 32)
(defconstant +usm-priv-ku-len+ 32)

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
