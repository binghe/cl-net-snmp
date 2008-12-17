;;;; Patch 5.21: restore CREATE-SOCKET keyword in OPEN-SESSION, for MSI's non-blocking patch.

(in-package :snmp)

(declaim (inline session-socket-p))

(defun session-socket-p (session)
  (slot-boundp session 'socket))

(defun close-session (session)
  (declare (type session session))
  (when (session-socket-p session)
    (socket-close (socket-of session))))

(defun open-session (host &key (port *default-snmp-port*)
                               (version *default-snmp-version*)
                               (community *default-snmp-community*)
                               (create-socket t)
                               user auth priv)
  ;; first, what version we are talking about if version not been set?
  (let* ((real-version (or (gethash version *snmp-version-table*)
                           (if user +snmp-version-3+ *default-snmp-version*)))
         (args (list (gethash real-version *snmp-class-table*)
                     :host host :port port)))
    (when create-socket
      (nconc args (list :socket (snmp-connect host port))))
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

(setf *minor-version* 21)
