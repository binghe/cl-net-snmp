(in-package :snmp)

(defgeneric snmp-get (object &rest vars)
  (:documentation "SNMP Get"))

(defmethod snmp-get ((host string) &rest vars)
  (let ((session (open-session host)))
    (unwind-protect
        (apply #'snmp-get session vars)
      (close-session session))))

(defmethod snmp-get ((session v1-session) &rest vars)
  (let ((vb (if (null vars)
              ;; for null vars, see sequence.lisp
              (empty-sequence)
              ;; for non-null vars
              (mapcar #'(lambda (x) (list (*->oid x) nil)) vars))))
    (let ((message (make-instance 'v1-message
                                  :version (version-of session)
                                  :community (community-of session)
                                  :pdu (make-instance 'get-request-pdu
                                                      :variable-bindings vb))))
      (let ((data (ber-encode message))
            (socket (socket-of session)))
        (write-sequence data socket)
        (force-output socket)
        (let ((message (decode-message socket 1)))
          (let ((data (variable-bindings-of (msg-pdu-of message))))
            (if (empty-sequence-p data)
              nil
              (mapcar #'second data))))))))

(defmethod snmp-get ((session v3-session) &rest vars)
  (declare (type list vars))
  (let ((vb (if (null vars)
              ;; for null vars, see sequence.lisp
              (empty-sequence)
              ;; for non-null vars
              (mapcar #'(lambda (x) (list (*->oid x) nil)) vars))))
    (let ((message (make-instance 'v3-message
                                  :user-name (security-name-of session)
                                  :security-level (security-level-of session)
                                  :engine-id (engine-id-of session)
                                  :engine-boots (engine-boots-of session)
                                  :engine-time (engine-time-of session)
                                  :pdu (make-instance 'get-request-pdu
                                                      :variable-bindings vb))))
      (let ((data (ber-encode message))
            (socket (socket-of session)))
        (write-sequence data socket)
        (force-output socket)
        (let ((message (decode-message socket 3)))
          (let ((data (variable-bindings-of (msg-pdu-of message))))
            (if (empty-sequence-p data)
              nil
              (mapcar #'second data))))))))
