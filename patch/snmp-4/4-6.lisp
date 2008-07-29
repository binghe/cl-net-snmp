(in-package :snmp)

;;; full request.lisp

(defgeneric snmp-request (session request bindings &key context)
  (:documentation "General SNMP request operation"))

(defmethod snmp-request ((session session) (request symbol) (bindings list)
                         &key context)
  (when bindings
    (let ((vb (mapcar #'(lambda (x) (if (consp x)
                                        (list (oid (first x)) (second x))
                                        (list (oid x) nil)))
                      bindings)))
      ;; Get a report first if the session is new created.
      (when (and (= (version-of session) +snmp-version-3+)
                 (need-report-p session))
        (snmp-report session :context context))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :context context
                                    :pdu (make-instance request
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (coerce x 'list))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-request ((host string) request bindings &key context)
  (with-open-session (s host)
    (snmp-request s request bindings :context context)))

(defmethod snmp-request (session request (binding string) &key context)
  (snmp-request session request (list (list (oid binding) nil)) :context context))

(defmethod snmp-request (session request (binding vector) &key context)
  (snmp-request session request (list (list (oid binding) nil)) :context context))

(defun snmp-get (session bindings &key context)
  (let ((result (mapcar #'second
                        (snmp-request session 'get-request-pdu bindings
                                      :context context))))
    (if (consp bindings) result (car result))))

(defun snmp-get-next (session bindings &key context)
  (let ((result (mapcar #'second
                        (snmp-request session 'get-next-request-pdu bindings
                                      :context context))))
    (if (consp bindings) result (car result))))

(defun snmp-set (session bindings &key context)
  (let ((result (mapcar #'second
                        (snmp-request session 'set-request-pdu bindings
                                      :context context))))
    (if (consp bindings) result (car result))))

;;; snmp-reader.lisp

(defvar *snmp-readtable* (copy-readtable nil))

(defun oid-reader (stream char)
  (declare (ignore char))
  (let* ((*package* (find-package :asn.1))
         (tokens-list
          (loop for i = (read-char stream nil #\] t)
                until (char= i #\])
                collect i)))
    (oid (coerce tokens-list 'string))))

(eval-when (:load-toplevel :execute)
  (set-macro-character #\] (get-macro-character #\)) nil *snmp-readtable*)
  (set-macro-character #\[ #'oid-reader nil *snmp-readtable*))

;;; message.lisp

;;; SNMPv3 Message Encode
(defmethod ber-encode ((message v3-message))
  (let* ((session (session-of message))
         (global-data (generate-global-data (msg-id-of message)
                                            (if (report-flag message) 0
                                              (security-level-of session))))
         (msg-data (list (engine-id-of session) ; contextEngineID
                         (or (context-of message)
                             *default-context*) ; contextName
                         (pdu-of message)))     ; PDU
         (need-auth-p (and (not (report-flag message))
                           (auth-protocol-of session)))
         (need-priv-p (and (not (report-flag message))
                           (priv-protocol-of session)))
         ;; RFC 2574 (USM for SNMPv3), 7.3.1.
         ;; 1) The msgAuthenticationParameters field is set to the
         ;;    serialization, according to the rules in [RFC1906], of an OCTET
         ;;    STRING containing 12 zero octets.
         (msg-authentication-parameters (if need-auth-p
                                          (make-string 12 :initial-element (code-char 0))
                                          ""))
         ;; RFC 2574 (USM for SNMPv3), 8.1.1.1. DES key and Initialization Vector
         ;; Now it's a list, not string, as we do this later.
         (msg-privacy-parameters (if need-priv-p
                                   (generate-privacy-parameters message)
                                   nil)))
    ;; Privacy support (we encrypt and replace msg-data here)
    (when need-priv-p
      (setf msg-data (encrypt-message message msg-privacy-parameters msg-data)))
    ;; Authentication support
    (labels ((encode-v3-message (auth)
               (ber-encode (list (version-of session)
                                 global-data
                                 (ber-encode->string (list (engine-id-of session)
                                                           (engine-boots-of session)
                                                           (engine-time-of session)
                                                           (if (report-flag message)
                                                             ""
                                                             (security-name-of session))
                                                           auth
                                                           (map 'string #'code-char
                                                                msg-privacy-parameters)))
                                 msg-data))))
      (let ((unauth-data (encode-v3-message msg-authentication-parameters)))
        (if (not need-auth-p) unauth-data
          ;; authencate the encode-data and re-encode it
          (encode-v3-message
           (authenticate-message
            (coerce unauth-data '(simple-array (unsigned-byte 8) (*)))
            (coerce (auth-local-key-of session) '(simple-array (unsigned-byte 8) (*)))
            (auth-protocol-of session))))))))

;;; package.lisp

(export '(*snmp-readtable* snmp-request))
