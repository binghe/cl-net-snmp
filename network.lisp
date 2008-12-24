;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defgeneric send-snmp-message (session message &key &allow-other-keys))

(defmethod send-snmp-message ((session v1-session) (message v1-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         #-(and lispworks mswindows)
         (socket-sync (socket-of session) message
                      :host (host-of session)
                      :port (port-of session)
                      :encode-function #'(lambda (x)
                                           (values (coerce (ber-encode x) 'octets)
                                                   (request-id-of (pdu-of x))))
                      :decode-function #'(lambda (x)
                                           (let ((m (decode-message session x)))
                                             (values m (request-id-of (pdu-of m)))))
                      :max-receive-length +max-snmp-packet-size+)
         #+(and lispworks mswindows)
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
                    #-(and lispworks mswindows)
                    (socket-sync (socket-of session) message
                                 :host (host-of session)
                                 :port (port-of session)
                                 :encode-function #'encode-function
                                 :decode-function #'decode-function
                                 :max-receive-length +max-snmp-packet-size+)
                    #+(and lispworks mswindows)
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
                          :host (host-of session)
                          :port (port-of session))))))

;;; Send/receive multiple SNMP message once

(defun send-snmp-messages (engine requests)
  (declare (type list requests)
           (ignore engine))
  (let ((work-list (cons (list-length requests)
                         (mapcar #'(lambda (x)
                                     (destructuring-bind (session message) x
                                       (make-instance 'snmp-operation
                                                      :session session
                                                      :message message)))
                                 requests))))
    ;; connect the list together
    (nconc work-list work-list)
    (sm-0 work-list)))

(defun sm-0 (work-list)
  (declare (type list work-list))
  work-list)
