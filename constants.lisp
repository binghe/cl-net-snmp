;;;; $Id$

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

;;; Following constants are come from SYSMAN/Lisp-SNMP project

(defconstant +error-status-no-error+		  0)
(defconstant +error-status-too-big+		  1)
(defconstant +error-status-no-such-name+	  2) ;for proxy compatibility
(defconstant +error-status-bad-value+		  3) ;for proxy compatibility
(defconstant +error-status-read-only+		  4) ;for proxy compatibility
(defconstant +error-status-generic-error+	  5)
(defconstant +error-status-no-access+		  6)
(defconstant +error-status-wrong-type+		  7)
(defconstant +error-status-wrong-length+	  8)
(defconstant +error-status-wrong-encoding+	  9)
(defconstant +error-status-wrong-value+		 10)
(defconstant +error-status-no-creation+		 11)
(defconstant +error-status-inconsistent-value+	 12)
(defconstant +error-status-resource-unavailable+ 13)
(defconstant +error-status-commit-failed+	 14)
(defconstant +error-status-undo-failed+		 15)
(defconstant +error-status-authorization-error+	 16)
(defconstant +error-status-not-writable+	 17)
(defconstant +error-status-inconsistent-name+	 18)
