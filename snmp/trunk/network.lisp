;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defgeneric send-snmp-message (session message &key &allow-other-keys))

(defmethod send-snmp-message ((session v1-session) (message v1-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         #+snmp-features:usocket
         (usocket:socket-sync (socket-of session)
                              message
                              :host (host-of session)
                              :port (port-of session)
                              :encode-function #'(lambda (x)
                                                   (values (coerce (ber-encode x) 'octets)
                                                           (request-id-of (pdu-of x))))
                              :decode-function #'(lambda (x)
                                                   (let ((m (decode-message session x)))
                                                     (values m (request-id-of (pdu-of m)))))
                              :max-receive-length +max-snmp-packet-size+)
         #+snmp-features:lispworks-udp
         (comm+:sync-message (socket-of session)
                             message
                             :host (host-of session)
                             :service (port-of session)
                             :encode-function #'(lambda (x)
                                                  (values (coerce (ber-encode x) 'octets)
                                                          (request-id-of (pdu-of x))))
                             :decode-function #'(lambda (x)
                                                  (let ((m (decode-message session x)))
                                                    (values m (request-id-of (pdu-of m)))))
                             :max-receive-length +max-snmp-packet-size+))
        ;; trap message: only send once
        (t (let* ((data (coerce (ber-encode message) 'octets))
                  (data-length (length data)))
             #+snmp-features:usocket
             (usocket:socket-send (socket-of session) data data-length
                                  :host (host-of session)
                                  :port (port-of session))
             #+snmp-features:lispworks-udp
             (comm+:send-message (socket-of session) data
                                 :length data-length
                                 :host (host-of session)
                                 :service (port-of session))))))

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
                    #+snmp-features:usocket
                    (usocket:socket-sync (socket-of session) message
                                         :host (host-of session)
                                         :port (port-of session)
                                         :encode-function #'encode-function
                                         :decode-function #'decode-function
                                         :max-receive-length +max-snmp-packet-size+)
                    #+snmp-features:lispworks-udp
                    (comm+:sync-message (socket-of session)
                                        message
                                        :host (host-of session)
                                        :service (port-of session)
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
             #+snmp-features:usocket
             (usocket:socket-send (socket-of session)
                                  data
                                  data-length
                                  :host (host-of session)
                                  :port (port-of session))
             #+snmp-features:lispworks-udp
             (comm+:send-message (socket-of session)
                                 data
                                 :length data-length
                                 :host (host-of session)
                                 :service (port-of session))))))
