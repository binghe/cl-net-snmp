;;; SNMPv3 get-request & report support

(in-package :snmp)

(defun snmp-report (session)
  (declare (type v3-session session))
  (let ((message
         (make-instance 'v3-message
                        :pdu (make-instance 'get-request-pdu
                                            :variable-bindings (empty-sequence)))))
    (let ((data (ber-encode message))
          (socket (socket-of session)))
      (write-sequence data socket)
      (force-output socket)
      (let ((message (decode-message socket 3)))
        (with-slots (msg-engine-id msg-engine-boots msg-engine-time) message
          (setf (engine-id-of session) msg-engine-id
                (engine-boots-of session) msg-engine-boots
                (engine-time-of session) msg-engine-time)
          session)))))
