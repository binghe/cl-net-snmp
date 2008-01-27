;;; SNMPv3 get-request & report support

(in-package :snmp)

(defun need-report-p (session)
  "return true if a SNMPv3 session has no engine infomation set"
  (declare (type v3-session session))
  (zerop (engine-time-of session)))

(defun snmp-report (session)
  (declare (type v3-session session))
  (let ((message
         (make-instance 'v3-message
                        :session session
                        :report t
                        :pdu (make-instance 'get-request-pdu
                                            :variable-bindings (empty-sequence)))))
    (let ((data (ber-encode message))
          (socket (socket-of session)))
      (write-sequence data socket)
      (force-output socket)
      ;; time goes up ...
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
          ;; security-data: 3rd field of message list
          (ber-decode<-string (third (ber-decode socket)))
        (declare (ignore user auth priv))
        (setf (engine-id-of session) engine-id
              (engine-boots-of session) engine-boots
              (engine-time-of session) engine-time)
        session))))
