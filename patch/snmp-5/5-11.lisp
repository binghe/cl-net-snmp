;;; Patch 5.11: re-send v3 message when got a report

(in-package :snmp)

(defparameter *version* 5.11)

(defmethod decode-message ((s v3-session) (message-list list))
  (destructuring-bind (version global-data security-string data) message-list
    (declare (ignore version))
    (let ((msg-id (elt global-data 0))
          (encrypt-flag (plusp (logand #b10
                                       (char-code (elt (elt global-data 2) 0))))))
      (when encrypt-flag
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
      (let* ((context (elt data 1))
             (pdu     (elt data 2))
             (report-p (typep pdu 'report-pdu))
             (report-flag (and (not (need-report-p s)) report-p)))
        (when report-p
          (update-session-from-report s security-string))
        (make-instance 'v3-message
                       :session s
                       :id msg-id
                       :report report-flag
                       :context context
                       :pdu pdu)))))

(defmethod send-snmp-message ((session v3-session) (message v3-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         (labels ((encode-function (x)
                    (values (coerce (ber-encode x) 'octets)
                            (msg-id-of x)))
                  (decode-function (x)
                    (let ((m (decode-message session x)))
                      (values m (msg-id-of m))))
                  (send ()
                    #-(and lispworks win32)
                    (socket-sync (socket-of session) message
                                 :address (host-of session)
                                 :port (port-of session)
                                 :encode-function #'encode-function
                                 :decode-function #'decode-function
                                 :max-receive-length +max-snmp-packet-size+)
                    #+(and lispworks win32)
                    (comm:sync-message (socket (socket-of session)) ; raw socket fd
                                       message
                                       (host-of session)
                                       (port-of session)
                                       :encode-function #'encode-function
                                       :decode-function #'decode-function
                                       :max-receive-length +max-snmp-packet-size+)))
           (let ((reply-message (send)))
             (if (report-flag-of reply-message)
               (send) ; send again when got a snmp report
               reply-message))))
        ;; trap message: only send once
        (t (let* ((data (coerce (ber-encode message) 'octets))
                  (data-length (length data)))
             (socket-send (socket-of session) data data-length
                          :address (host-of session)
                          :port (port-of session))))))

(defun snmp-report (session &key (context *default-context*))
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context (or context *default-context*)
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (let ((reply (send-snmp-message session message)))
      (map 'list #'(lambda (x) (coerce x 'list))
           (variable-bindings-of (pdu-of reply))))))
