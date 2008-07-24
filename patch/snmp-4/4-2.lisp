(in-package :snmp)

(defparameter *default-context* "")

(export '*default-context*)

(defmethod snmp-get ((host string) (vars list) &key (context *default-context*))
  (when vars
    (with-open-session (s host)
      (snmp-get s vars :context context))))

(defmethod snmp-get ((session session) (vars list) &key (context *default-context*))
  "SNMP GET for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :context context
                                    :pdu (make-instance 'get-request-pdu
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (elt x 1))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-get ((host string) (var string) &key (context *default-context*))
  (car (snmp-get host (list var) :context context)))

(defmethod snmp-get ((host string) (var object-id) &key (context *default-context*))
  (car (snmp-get host (list var) :context context)))

(defmethod snmp-bulk ((host string) (vars list) &key
                      (non-repeaters 0) (max-repetitions 1) (context *default-context*))
  (when vars
    (with-open-session (s host)
      (snmp-bulk s vars
                 :non-repeaters non-repeaters
                 :max-repetitions max-repetitions
                 :context context))))

(defmethod snmp-bulk ((session session) (vars list) &key
                      (non-repeaters 0) (max-repetitions 1) (context *default-context*))
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :pdu (make-instance 'bulk-pdu
                                                        :non-repeaters non-repeaters
                                                        :max-repetitions max-repetitions
                                                        :variable-bindings vb)
                                    :context context)))

        (let ((reply (send-snmp-message session message)))
          (when reply
            (generate-table vars
                            (variable-bindings-of (pdu-of reply))
                            non-repeaters max-repetitions)))))))

(defmethod snmp-bulk ((host string) (var string) &key (context *default-context*))
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))

(defmethod snmp-bulk ((host string) (var object-id) &key (context *default-context*))
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))

(defmethod snmp-set ((host string) (vars list) &key (context *default-context*))
  (when vars
    (with-open-session (s host)
      (snmp-set s vars :context context))))

(defmethod snmp-set ((session session) (vars list) &key (context *default-context*))
  "SNMP SET for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (oid (car x)) (cdr x))) vars)))
      ;; Set a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :context context
                                    :pdu (make-instance 'set-request-pdu
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (elt x 1))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-set ((host string) (var string) &key (context *default-context*))
  (car (snmp-set host (list var) :context context)))

(defmethod snmp-set ((host string) (var object-id) &key (context *default-context*))
  (car (snmp-set host (list var) :context context)))

(defmethod snmp-get-next ((host string) (vars list) &key (context *default-context*))
  (when vars
    (with-open-session (s host)
      (snmp-get-next s vars :context context))))

(defmethod snmp-get-next ((session session) (vars list) &key (context *default-context*))
  "SNMP Get-Next-Request for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :context context
                                    :pdu (make-instance 'get-next-request-pdu
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (coerce x 'list))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-get-next ((host string) (var string) &key (context *default-context*))
  (car (snmp-get-next host (list var) :context context)))

(defmethod snmp-get-next ((host string) (var object-id) &key (context *default-context*))
  (car (snmp-get-next host (list var) :context context)))

(defmethod snmp-walk ((host string) (vars list) &key (context *default-context*))
  (with-open-session (s host)
    (snmp-walk s vars :context context)))

(defmethod snmp-walk ((session session) (vars list) &key (context *default-context*))
  "SNMP Walk for v1, v2c and v3"
  (when vars
    (let ((base-vars (mapcar #'oid vars)))
      (labels ((iter (current-vars acc first-p)
                 (let* ((temp (snmp-get-next session current-vars :context context))
                        (new-vars (mapcar #'first temp))
                        (new-values (mapcar #'second temp)))
                   (if (or (some #'oid->= new-vars base-vars)
                           (member :end-of-mibview new-values))
                       (if first-p
                         (snmp-get session vars)
                         (mapcar #'nreverse acc))
                     (iter new-vars (mapcar #'cons temp acc) nil)))))
        (iter base-vars (make-list (length vars)) t)))))

(defmethod snmp-walk (object (var string) &key (context *default-context*))
  (car (snmp-walk object (list var) :context context)))

(defmethod snmp-walk (object (var object-id) &key (context *default-context*))
  (car (snmp-walk object (list var) :context context)))

(defun snmp-trap-internal (session vars uptime trap-oid inform
                                   &optional (context *default-context*))
  (let ((vb (list* (list (oid "sysUpTime.0")
                         (make-instance 'timeticks :value uptime))
                   (list (oid "snmpTrapOID.0")
                         trap-oid)
                   (mapcar #'(lambda (x) (list (oid (car x)) (cdr x))) vars))))
    (let ((message (make-instance (gethash (type-of session) *session->message*)
                                  :session session
                                  :context context
                                  :pdu (make-instance (if inform
                                                        'inform-request-pdu
                                                        'snmpv2-trap-pdu)
                                                      :variable-bindings vb))))
      (send-snmp-message session message :receive inform))))

(defmethod snmp-trap ((session v3-session) (vars list) &key
                      (uptime (truncate (* (get-internal-run-time)
                                           #.(/ 100 internal-time-units-per-second))))
                      (trap-oid *default-trap-enterprise*)
                      (inform nil)
                      (context *default-context*)
                      &allow-other-keys)
  (when (need-report-p session)
    (snmp-report session))
  (snmp-trap-internal session vars uptime trap-oid inform context))

(defmethod snmp-inform ((session v3-session) (vars list) &key
                        (uptime (truncate (* (get-internal-run-time)
                                             #.(/ 100 internal-time-units-per-second))))
                        (trap-oid *default-trap-enterprise*)
                        (context *default-context*)
                        &allow-other-keys)
  "SNMPv3 Inform"
  (snmp-trap session vars :uptime uptime :trap-oid trap-oid :inform t :context context))

(defun snmp-report (session &key (context *default-context*))
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context context
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (send-snmp-message session message :receive nil :report t)
    (let ((ber-stream (socket-receive (socket-of session) nil 65507)))
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
	  ;; security-data: 3rd field of message list
	  (coerce (ber-decode<-string (elt (ber-decode ber-stream) 2)) 'list)
	(declare (ignore user auth priv))
	(setf (engine-id-of session) engine-id
	      (engine-boots-of session) engine-boots
	      (engine-time-of session) engine-time)
        (when (and (auth-protocol-of session) (slot-boundp session 'auth-key))
          (setf (auth-local-key-of session)
                (generate-kul (map '(simple-array (unsigned-byte 8) (*))
                                   #'char-code engine-id)
                              (auth-key-of session))))
        (when (and (priv-protocol-of session) (slot-boundp session 'priv-key))
          (setf (priv-local-key-of session)
                (generate-kul (map '(simple-array (unsigned-byte 8) (*))
                                   #'char-code engine-id)
                              (priv-key-of session))))
        session))))

