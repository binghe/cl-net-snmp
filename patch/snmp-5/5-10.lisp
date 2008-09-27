;;; Patch 5.10: decode more from message

(in-package :snmp)

(defparameter *version* 5.10)

(defmethod decode-message ((s v3-session) (message-list list))
  (destructuring-bind (version global-data security-string data) message-list
    (declare (ignore version))
    (let ((msg-id (elt global-data 0))
          (report-flag (plusp (logand #b100 
                                      (char-code (elt (elt global-data 2) 0))))))
      (when report-flag
        (update-session-from-report s security-string))
      (when (and (not report-flag) (priv-protocol-of s))
        ;;; decrypt message
        (let ((salt (map 'octets #'char-code
                         (elt (ber-decode<-string security-string) 5)))
              (des-key (subseq (priv-local-key-of s) 0 8))
              (pre-iv (subseq (priv-local-key-of s) 8 16))
              (data (map 'octets #'char-code data)))
          (let* ((iv (map 'octets #'logxor pre-iv salt))
                 (cipher (ironclad:make-cipher :des ; (priv-protocol-of s)
                                               :mode :cbc
                                               :key des-key 
                                               :initialization-vector iv)))
            (ironclad:decrypt-in-place cipher data)
            (setf data (ber-decode data)))))
      (let ((context (elt data 1))
            (pdu     (elt data 2)))
        (make-instance 'v3-message
                       :session s
                       :id msg-id
                       :report report-flag
                       :context context
                       :pdu pdu)))))

(defun snmp-report (session &key (context *default-context*))
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context context
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (let ((report-data (send-snmp-message session message
                                          :receive nil :report t)))
      (update-session-from-report session
                                  (elt (ber-decode report-data) 2)))))

(defun update-session-from-report (session security-string)
  (declare (type v3-session session)
           (type string security-string))
  (destructuring-bind (engine-id engine-boots engine-time user auth priv)
      ;; security-data: 3rd field of message list
      (coerce (ber-decode<-string security-string) 'list)
    (declare (ignore user auth priv))
    (setf (engine-id-of session) engine-id
          (engine-boots-of session) engine-boots
          (engine-time-of session) engine-time)
    (when (and (auth-protocol-of session) (slot-boundp session 'auth-key))
      (setf (auth-local-key-of session)
            (generate-kul (map 'octets #'char-code engine-id)
                          (auth-key-of session))))
    (when (and (priv-protocol-of session) (slot-boundp session 'priv-key))
      (setf (priv-local-key-of session)
            (generate-kul (map 'octets #'char-code engine-id)
                          (priv-key-of session))))
    session))
