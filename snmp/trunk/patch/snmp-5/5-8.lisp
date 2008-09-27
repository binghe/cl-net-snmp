(in-package :snmp)

(defparameter *version* 5.8)

(defun generate-global-data (id level)
  (list id
        ;; msgMaxSize
        +max-snmp-packet-size+
        ;; msgFlags: security-level + reportable flag
        (make-string 1 :initial-element (code-char (logior #b100 level)))
        ;; msgSecurityModel: USM (3)
        +snmp-sec-model-usm+))
