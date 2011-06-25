;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; SNMP 6.1: SNMP/TCP support

(in-package :snmp)

;; redefine session class, removing all type information.
(defclass session ()
  ((socket            :accessor socket-of
                      :initarg :socket)
   (host              :accessor host-of
                      :initarg :host)
   (port              :accessor port-of
                      :initarg :port)
   (version           :accessor version-of
                      :initarg :version))
  (:documentation "SNMP session base class"))

;; new keyword argument :protocol
(defun snmp-connect (host port &key (protocol :datagram))
  (ecase protocol
    ((:stream :tcp)
     (usocket:socket-connect host port :protocol :stream :element-type '(unsigned-byte 8)))
    ((:datagram :udp)
     (usocket:socket-connect host port :protocol :datagram))))

;; new keyword argument :protocol
(defun open-session (host &key (protocol :datagram) ; 6.1
                               (port *default-snmp-port*)
                               version
                               (community *default-snmp-community*)
                               (create-socket t)
                               user auth priv)
  ;; first, what version we are talking about if version not been set?
  (let* ((real-version (or (gethash version *snmp-version-map*)
                           (if user +snmp-version-3+ *default-snmp-version*)))
         (args (list (gethash real-version *snmp-class-map*)
                     :host host :port port)))
    (when create-socket
      (nconc args (list :socket (snmp-connect host port :protocol protocol)))) ; 6.1
    (if (/= real-version +snmp-version-3+)
      ;; for SNMPv1 and v2c, only set the community
      (nconc args (list :community (or community *default-snmp-community*)))
      ;; for SNMPv3, we detect the auth and priv parameters
      (progn
        (nconc args (list :security-name user))
        (when auth
          (if (atom auth)
            (nconc args (list :auth-protocol *default-auth-protocol*)
                   (if (stringp auth)
                     (list :auth-key (generate-ku auth :hash-type *default-auth-protocol*))
                     (list :auth-local-key (coerce auth 'octets))))
            (destructuring-bind (auth-protocol . auth-key) auth
              (nconc args (list :auth-protocol auth-protocol)
                     (let ((key (if (atom auth-key) auth-key (car auth-key))))
                       (if (stringp key)
                         (list :auth-key (generate-ku key :hash-type auth-protocol))
                         (list :auth-local-key (coerce key 'octets))))))))
        (when priv
          (if (atom priv)
            (nconc args (list :priv-protocol *default-priv-protocol*)
                   (if (stringp auth)
                     (list :priv-key (generate-ku priv :hash-type :md5))
                     (list :priv-local-key (coerce priv 'octets))))
            (destructuring-bind (priv-protocol . priv-key) priv
              (nconc args (list :priv-protocol priv-protocol)
                     (let ((key (if (atom priv-key) priv-key (car priv-key))))
                       (if (stringp key)
                         (list :priv-key (generate-ku key :hash-type :md5))
                         (list :priv-local-key (coerce key 'octets))))))))))
    (apply #'make-instance args)))

(declaim (inline stream-session-p))
(defun stream-session-p (session)
  (declare (type session session))
  (typep (socket-of session) 'usocket:stream-usocket))

(defun send-stream-message (session message receive-p)
  (declare (type session session)
           (type message message))
  (let* ((stream (usocket:socket-stream (socket-of session)))
         (data (coerce (ber-encode message) 'octets)))
    (write-sequence data stream)
    (finish-output stream)
    (when receive-p
      (decode-message session stream))))

(defmethod send-snmp-message ((session v1-session) (message v1-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (if (stream-session-p session)
      (send-stream-message session message receive)
    (if receive ; normal message
        (flet ((encode-function (x)
                 (values (coerce (ber-encode x) 'octets)
                         (request-id-of (pdu-of x))))
               (decode-function (x)
                 (let ((m (decode-message session x)))
                   (values m (request-id-of (pdu-of m))))))
          (socket-sync (socket-of session) message
                       :encode-function #'encode-function
                       :decode-function #'decode-function
                       :max-receive-length +max-snmp-packet-size+))
      ;; trap message: only send once
      (let* ((data (coerce (ber-encode message) 'octets))
             (data-length (length data)))
        (usocket:socket-send (socket-of session) data data-length)))))

(defmethod send-snmp-message ((session v3-session) (message v3-message) &key (receive t))
  "this new send-snmp-message is just a interface,
   all UDP retransmit code are moved into usocket-udp project."
  (if (stream-session-p session)
      (flet ((send () (send-stream-message session message receive)))
        (let ((reply-message (send)))
          (if (and receive (report-flag-of reply-message))
              (send)
            reply-message)))
    (if receive ; normal message
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
              reply-message)))
      ;; trap message: only send once
      (let* ((data (coerce (ber-encode message) 'octets))
             (data-length (length data)))
        (usocket:socket-send (socket-of session) data data-length)))))
