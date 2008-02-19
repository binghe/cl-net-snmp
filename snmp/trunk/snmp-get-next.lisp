(in-package :snmp)

(defgeneric snmp-get-next (object vars)
  (:documentation "SNMP Get"))

(defmethod snmp-get-next ((host string) (vars list))
  (when vars
    (with-open-session (s host)
      (snmp-get-next s vars))))

(defmethod snmp-get-next ((session session) (vars list))
  "SNMP Get-Next-Request for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :pdu (make-instance 'get-next-request-pdu
                                                        :variable-bindings vb))))
        (let ((data (ber-encode message))
              (socket (socket-of session)))
          (write-sequence data socket)
          (force-output socket)
          ;; time goes up ...
          (let ((message (decode-message session socket)))
            (variable-bindings-of (pdu-of message))))))))

(defmethod snmp-get-next ((host string) (var string))
  (car (snmp-get-next host (list var))))

(defmethod snmp-get-next ((host string) (var object-id))
  (car (snmp-get-next host (list var))))
