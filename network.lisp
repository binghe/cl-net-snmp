;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

#-(and lispworks win32)
(defun send-snmp-message (session message &key (receive t) (report nil))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (declare (type session session)
           (type message message))
  (cond (receive ; normal message
         (socket-sync (socket-of session) message
                      :address (host-of session)
                      :port (port-of session)
                      :encode-function #'(lambda (x)
                                           (values (coerce (ber-encode x) 'octets)
                                                   (request-id-of (pdu-of x))))
                      :decode-function #'(lambda (x)
                                           (let ((m (decode-message session x)))
                                             (values m (request-id-of (pdu-of m)))))
                      :max-receive-length +max-snmp-packet-size+))
        ;; report message: send and get raw response
        ((and (not receive) report)
         (socket-sync (socket-of session) message
                      :address (host-of session)
                      :port (port-of session)
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

#+(and lispworks win32)
(defun send-snmp-message (session message &key (receive t) (report nil))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project.

   On LispWorks Win32, the WAIT-FOR-INPUT is broken, so we directly use LISPWORKS-UDP"
  (declare (type session session)
           (type message message))
  (cond (receive ; normal message
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
        ;; report message: send and get raw response
        ((and (not receive) report)
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
