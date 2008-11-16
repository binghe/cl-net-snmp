(in-package :snmp)

(setf *minor-version* 15)

(eval-when (:load-toplevel :execute)
  (if (and (boundp 'asn.1::*major-version*)
           (boundp 'asn.1::*minor-version*))
      (assert (or (> asn.1::*major-version* 4)
                  (and (= asn.1::*major-version* 4)
                       (>= asn.1::*minor-version* 10))))
    (error "Please use a newer version of ASN.1 package (>= 4.10)"))
  (if (and (boundp 'usocket::*major-version*)
           (boundp 'usocket::*minor-version*))
      (assert (or (> usocket::*major-version* 2)
                  (and (= usocket::*major-version* 2)
                       (>= usocket::*minor-version* 3))))
    (if (and (asdf:find-system :usocket-udp)
             (fboundp 'usocket::socket-send))
        (error "Please use a newer version of USOCKET-UDP package (>= 2.3)"))))

(defun snmp-connect (host port)
  (declare (ignore host port))
  (socket-connect/udp nil nil
                      ;; On Win32, we must bind it to set socketopt
                      #+win32 #+win32
                      :local-port *auto-port*))

(defmethod send-snmp-message ((session v1-session) (message v1-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (cond (receive ; normal message
         #-(and lispworks win32)
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
                    #-(and lispworks win32)
                    (socket-sync (socket-of session) message
                                 :host (host-of session)
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
                          :host (host-of session)
                          :port (port-of session))))))
