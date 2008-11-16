(in-package :snmp)

(setf *minor-version* 17)

(defmethod snmp-request (session request (binding object-id) &key context)
  (snmp-request session request (list (list binding nil)) :context context))
