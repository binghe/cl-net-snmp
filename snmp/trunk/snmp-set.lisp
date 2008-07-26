;;;; $Id$

(in-package :snmp)

(defgeneric snmp-set (object vars &key)
  (:documentation "SNMP Set"))

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
