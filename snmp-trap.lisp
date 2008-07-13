(in-package :snmp)

(defvar *default-trap-enterprise* (object-id '#(1 3 6 1 4 1 26670)) "enterprises")

(defgeneric snmp-trap (session vars &key &allow-other-keys)
  (:documentation "SNMP Trap"))

(defmethod snmp-trap ((session v1-session) (vars list) &key
                      (enterprise *default-trap-enterprise*)
                      (agent-addr "0.0.0.0")
                      (generic-trap +enterprise-specific+)
                      (specific-trap 0)
                      (uptime (truncate (* (get-internal-run-time)
                                           #.(/ 100 internal-time-units-per-second))))
                      &allow-other-keys)
  "SNMPv1 Trap PDU is different from v2c and v3, no request id"
  (declare (type integer generic-trap specific-trap)
           (type base-string agent-addr))
  (let ((vb (if (null vars) #()
              (mapcar #'(lambda (x) (list (*->oid (car x)) (cdr x))) vars))))
    (let ((message (make-instance 'v1-message :session session
                                  :pdu (make-instance 'trap-pdu
                                                      :variable-bindings vb
                                                      :enterprise enterprise
                                                      :agent-addr (ipaddress agent-addr)
                                                      :generic-trap generic-trap
                                                      :specific-trap specific-trap
                                                      :timestamp (timeticks uptime)))))
      (send-snmp-message session message :receive nil))))

(defun snmp-trap-internal (session vars uptime trap-oid inform &optional (context ""))
  (let ((vb (list* (list (object-id '#(1 3 6 1 2 1 1 3 0))
                         (make-instance 'timeticks :value uptime))
                   (list (object-id '#(1 3 6 1 6 3 1 1 4 1 0))
                         trap-oid)
                   (mapcar #'(lambda (x) (list (*->oid (car x)) (cdr x))) vars))))
    (let ((message (make-instance (gethash (type-of session) *session->message*)
                                  :session session
                                  :context context
                                  :pdu (make-instance (if inform
                                                        'inform-request-pdu
                                                        'snmpv2-trap-pdu)
                                                      :variable-bindings vb))))
      (send-snmp-message session message :receive inform))))

(defmethod snmp-trap ((session v2c-session) (vars list) &key
                      (uptime (truncate (* (get-internal-run-time)
                                           #.(/ 100 internal-time-units-per-second))))
                      (trap-oid *default-trap-enterprise*)
                      (inform nil)
                      &allow-other-keys)
  (snmp-trap-internal session vars uptime trap-oid inform))

(defmethod snmp-trap ((session v3-session) (vars list) &key
                      (uptime (truncate (* (get-internal-run-time)
                                           #.(/ 100 internal-time-units-per-second))))
                      (trap-oid *default-trap-enterprise*)
                      (inform nil)
                      (context "")
                      &allow-other-keys)
  (when (need-report-p session)
    (snmp-report session))
  (snmp-trap-internal session vars uptime trap-oid inform context))

(defgeneric snmp-inform (session vars &key &allow-other-keys)
  (:documentation "SNMP Inform, only support v2c and v3 session"))

(defmethod snmp-inform ((session v2c-session) (vars list) &key
                        (uptime (truncate (* (get-internal-run-time)
                                             #.(/ 100 internal-time-units-per-second))))
                        (trap-oid *default-trap-enterprise*)
                        &allow-other-keys)
  "SNMPv2 Inform"
  (snmp-trap session vars :uptime uptime :trap-oid trap-oid :inform t))

(defmethod snmp-inform ((session v3-session) (vars list) &key
                        (uptime (truncate (* (get-internal-run-time)
                                             #.(/ 100 internal-time-units-per-second))))
                        (trap-oid *default-trap-enterprise*)
                        (context "")
                        &allow-other-keys)
  "SNMPv3 Inform"
  (snmp-trap session vars :uptime uptime :trap-oid trap-oid :inform t :context context))
