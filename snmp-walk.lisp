(in-package :snmp)

(defgeneric snmp-walk (object var)
  (:documentation "SNMP Walk"))

(defmethod snmp-walk ((host string) var)
  (with-open-session (s host)
    (snmp-walk s var)))

(defmethod snmp-walk ((session session) var)
  (snmp-walk session (*->oid var)))

(defmethod snmp-walk ((session session) (var object-id))
  "SNMP Walk for v1, v2c and v3"
  ;; Get a report first if the session is new created
  (when (and (= +snmp-version-3+ (version-of session))
             (need-report-p session))
    (snmp-report session))
  (let ((message (make-instance (gethash (type-of session) *session->message*)
                                :session session
                                :pdu (make-instance 'get-next-request-pdu
                                                    :variable-bindings (list nil)))))
    (labels ((iter (v acc)
               (setf (car (variable-bindings-of (pdu-of message))) (list v nil))
               (let ((data (ber-encode message))
                     (socket (socket-of session)))
                 (write-sequence data socket)
                 (force-output socket)
                 ;; time goes ...
                 (let ((result (decode-message session socket)))
                   (let ((vb (car (variable-bindings-of (pdu-of result)))))
                     (if (not (oid-< (car vb) var))
                       (nreverse acc)
                       ;; Increase MsgID and RequestID and do next loop
                       (progn
                         (when (= +snmp-version-3+ (version-of session))
                           (setf (msg-id-of message) (generate-msg-id message)))
                         (setf (request-id-of (pdu-of message)) (generate-request-id (pdu-of message)))
                         (iter (first vb) (cons vb acc)))))))))
      (iter var nil))))
