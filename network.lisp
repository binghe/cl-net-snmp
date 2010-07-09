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
             (usocket:socket-send (socket-of session) data data-length)))))

(defmethod send-snmp-message ((session v3-session) (message v3-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         (labels ((encode-function (x)
                    (values (coerce (ber-encode x) 'octets)
                            (message-id-of x)))
                  (decode-function (x)
                    (let ((m (decode-message session x)))
                      (values m (message-id-of m))))
                  (send ()
                    (socket-sync (socket-of session) message
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
             (usocket:socket-send (socket-of session) data data-length)))))

;;; SOCKET-SYNC (from old USOCKET-UDP)

(defparameter *socket-sync-timeout* 2 "in seconds")
(defparameter *socket-sync-retries* 3 "in seconds")

(defun default-rtt-function (message) (values message 0))

(defun socket-sync (socket message &key
                    (max-receive-length +max-snmp-packet-size+)
                    (encode-function #'default-rtt-function)
                    (decode-function #'default-rtt-function)
                    &aux
                    send-data send-data-length
                    recv-data recv-message
                    (send-retries *socket-sync-retries*)
                    (recv-retries *socket-sync-retries*)
                    send-seq (recv-seq -1)
                    (sockets (list socket)))
  "sync messages on single socket"
  (declare (type usocket:datagram-usocket socket))

  ;; Encode data for send
  (multiple-value-setq (send-data send-seq)
    (funcall encode-function message))
  (setq send-data-length (length send-data))

  ;; Define basic network operations
  (labels ((send ()
             (let ((nbytes (usocket:socket-send socket send-data send-data-length)))
               (unless (plusp nbytes)
                 (error 'snmp-error))
               nbytes))
           (wait ()
             (multiple-value-bind (sockets real-time)
                 (usocket:wait-for-input sockets :timeout *socket-sync-timeout*)
               (declare (ignore sockets))
               real-time))
           (recv ()
             (let ((recv-data (usocket:socket-receive socket nil max-receive-length)))
               (when recv-data
                 (multiple-value-setq (recv-message recv-seq)
                   (funcall decode-function recv-data))
                 (= send-seq recv-seq)))))

    ;; Work cycles
    (prog ()
      :send
        (princ "S")
        (if (plusp (decf send-retries))
            (unless (send) (go :exit))
          (go :exit))

      :wait
        (princ "W")
        (unless (wait) (go :send))

      :recv
        (princ "R")
        (unless (recv) (go :wait))

      :exit
        (princ "E")
        (return recv-message))))
