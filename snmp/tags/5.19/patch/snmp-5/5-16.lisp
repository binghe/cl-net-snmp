(in-package :snmp)

(setf *minor-version* 16)

(defgeneric snmp-walk (object vars &key &allow-other-keys)
  (:documentation "SNMP Walk, only useful for debug"))

(defgeneric snmp-request (session request bindings &key &allow-other-keys)
  (:documentation "General SNMP request operation"))

(defgeneric send-snmp-message (session message &key &allow-other-keys))

(defgeneric snmp-bulk (object vars &key &allow-other-keys)
  (:documentation "SNMP Get Bulk"))

