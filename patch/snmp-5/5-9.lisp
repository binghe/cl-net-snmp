;;;; Patch 5.9: better SNMPv3 support

(in-package :snmp)

(defparameter *version* 5.9)

;;; Remove unused function
(fmakunbound 'generate-salt)
(unintern 'generate-salt)

