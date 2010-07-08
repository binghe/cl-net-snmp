;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defgeneric send-snmp-message (session message &key &allow-other-keys))

(defmethod send-snmp-message ((session v1-session) (message v1-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         (socket-sync (socket-of session)
                      message
                      :host (host-of session)
                      :port (port-of session)
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
                                  :port (port-of session))))))

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
                    (socket-sync (socket-of session) message
                                 :host (host-of session)
                                 :port (port-of session)
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
                                  :port (port-of session))))))

;;; SOCKET-SYNC (from old USOCKET-UDP)

(defparameter *socket-sync-timeout* 2 "in seconds")
(defparameter *socket-sync-retries* 3 "in seconds")

(defun default-rtt-function (message) (values message 0))

(defun socket-sync (socket message &key host port
                    (max-receive-length +max-snmp-packet-size+)
                    (encode-function #'default-rtt-function)
                    (decode-function #'default-rtt-function))
  (declare (type usocket:datagram-usocket socket))
  (multiple-value-bind (data send-seq)
      (funcall encode-function message)
    (let ((data-length (length data))
          (retries *socket-sync-retries*)
          (recv-message nil)
          (recv-seq -1))
      (labels ((send ()
                 (when (plusp retries)
                   (usocket:socket-send socket data data-length :host host :port port)
                   (decf retries)))
               (wait ()
                 (multiple-value-bind (sockets real-time)
                     (usocket:wait-for-input socket :timeout *socket-sync-timeout*)
                   (declare (ignore sockets))
                 real-time))
               (receive ()
                 (multiple-value-setq (recv-message recv-seq)
                     (funcall decode-function
                              (usocket:socket-receive socket nil max-receive-length)))
                 (= send-seq recv-seq)))
        (tagbody
         send
           (unless (send) (go end))
         wait
           (unless (wait) (go send))
         receive
           (unless (receive) (go wait))
         end
           recv-message)))))
