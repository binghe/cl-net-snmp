(in-package :snmp)

(defgeneric snmp-get (object &rest vars)
  (:documentation "SNMP Get"))

(defmethod snmp-get ((host string) &rest vars)
  (when vars
    (with-open-session (s host)
      (apply #'snmp-get s vars))))

(defmethod snmp-get ((session v1-session) &rest vars)
  (when vars
    (let* ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars))
           (message (make-instance 'v1-message
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
            (mapcar #'second data)))))))

(defmethod snmp-get ((session session) &rest vars)
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance 'v3-message
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
