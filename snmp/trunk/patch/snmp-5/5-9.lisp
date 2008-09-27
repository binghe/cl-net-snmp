;;;; Patch 5.9: better SNMPv3 support

(in-package :snmp)

;;; Remove unused function
(fmakunbound 'generate-salt)
(unintern 'generate-salt)

;;; New DECODE-MESSAGE will also decode MsgID part
(defmethod decode-message ((s v3-session) (message-list list))
  (destructuring-bind (version global-data security-string data) message-list
    (declare (ignore version))
    (let ((msg-id (elt global-data 0)))
      (if (not (priv-protocol-of s))
        (let ((pdu (elt data 2)))
          (make-instance 'v3-message :session s :id msg-id :pdu pdu))
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
            (let ((pdu (elt (ber-decode data) 2)))
              (make-instance 'v3-message :session s :id msg-id :pdu pdu))))))))

;; change SEND-SNMP-MESSAGE from defun to defgeneric
(fmakunbound 'send-snmp-message)
(defgeneric send-snmp-message (session message &key))

(defmethod send-snmp-message ((session v1-session) (message v1-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         #-(and lispworks win32)
         (socket-sync (socket-of session) message
                      :address (host-of session)
                      :port (port-of session)
                      :encode-function #'(lambda (x)
                                           (values (coerce (ber-encode x) 'octets)
                                                   (request-id-of (pdu-of x))))
                      :decode-function #'(lambda (x)
                                           (let ((m (decode-message session x)))
                                             (values m (request-id-of (pdu-of m)))))
                      :max-receive-length +max-snmp-packet-size+)
         #+(and lispworks win32)
         (comm:sync-message (socket (socket-of session)) ; raw socket fd
                            message
                            (host-of session)
                            (port-of session)
                            :encode-function #'(lambda (x)
                                                 (values (coerce (ber-encode x) 'octets)
                                                         (request-id-of (pdu-of x))))
                            :decode-function #'(lambda (x)
                                                 (let ((m (decode-message session x)))
                                                   (values m (request-id-of (pdu-of m)))))
                            :max-receive-length +max-snmp-packet-size+))
        (t (let* ((data (coerce (ber-encode message) 'octets))
                  (data-length (length data)))
             (socket-send (socket-of session) data data-length
                          :address (host-of session)
                          :port (port-of session))))))

(defmethod send-snmp-message ((session v3-session) (message v3-message) &key (receive t) (report nil))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         #-(and lispworks win32)
         (socket-sync (socket-of session) message
                      :address (host-of session)
                      :port (port-of session)
                      :encode-function #'(lambda (x)
                                           (values (coerce (ber-encode x) 'octets)
                                                   (msg-id-of x)))
                      :decode-function #'(lambda (x)
                                           (let ((m (decode-message session x)))
                                             (values m (msg-id-of m))))
                      :max-receive-length +max-snmp-packet-size+)
         #+(and lispworks win32)
         (comm:sync-message (socket (socket-of session)) ; raw socket fd
                            message
                            (host-of session)
                            (port-of session)
                            :encode-function #'(lambda (x)
                                                 (values (coerce (ber-encode x) 'octets)
                                                         (msg-id-of x)))
                            :decode-function #'(lambda (x)
                                                 (let ((m (decode-message session x)))
                                                   (values m (msg-id-of m))))
                            :max-receive-length +max-snmp-packet-size+))
        ;; report message: send and get raw response
        ((and (not receive) report)
         #-(and lispworks win32)
         (socket-sync (socket-of session) message
                      :address (host-of session)
                      :port (port-of session)
                      :encode-function #'(lambda (x)
                                           (values (coerce (ber-encode x) 'octets) 0))
                      :max-receive-length +max-snmp-packet-size+)
         #+(and lispworks win32)
         (comm:sync-message (socket (socket-of session)) ; raw socket fd
                            message
                            (host-of session)
                            (port-of session)
                            :encode-function #'(lambda (x)
                                                 (values (coerce (ber-encode x) 'octets) 0))
                            :max-receive-length +max-snmp-packet-size+))
        ;; trap message: only send once
        ((and (not receive) (not report))
         (let* ((data (coerce (ber-encode message) 'octets))
                (data-length (length data)))
           (socket-send (socket-of session) data data-length
                        :address (host-of session)
                        :port (port-of session))))))

(defparameter *version* 5.9)
