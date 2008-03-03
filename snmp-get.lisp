;;;; SNMP Get

(in-package :snmp)

(defgeneric snmp-get (object vars)
  (:documentation "SNMP Get"))

(defmethod snmp-get ((host string) (vars list))
  (when vars
    (with-open-session (s host)
      (snmp-get s vars))))

(defmethod snmp-get ((session session) (vars list))
  "SNMP GET for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :pdu (make-instance 'get-request-pdu
                                                        :variable-bindings vb))))
        (let ((data (ber-encode message))
              (socket (socket-of session)))
          (write-sequence data socket)
          (force-output socket)
          ;; time goes up ...
          (let ((message (decode-message session socket)))
            (let ((data (variable-bindings-of (pdu-of message))))
              (mapcar #'second data))))))))

(defmethod snmp-get ((host string) (var string))
  (car (snmp-get host (list var))))

(defmethod snmp-get ((host string) (var object-id))
  (car (snmp-get host (list var))))
