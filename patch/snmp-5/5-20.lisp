;;;; Patch 5.20: context fix for SNMP-BULK

(in-package :snmp)

(defmethod snmp-bulk ((host string) vars &key context
                      (non-repeaters 0) (max-repetitions 1))
  (when vars
    (with-open-session (s host)
      (snmp-bulk s vars
                 :non-repeaters non-repeaters
                 :max-repetitions max-repetitions
                 :context context))))

(defmethod snmp-bulk ((session session) (vars list) &key context
                      (non-repeaters 0) (max-repetitions 1))
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
                                    :context (or context *default-context*))))

        (let ((reply (send-snmp-message session message)))
          (when reply
            (generate-table vars
                            (variable-bindings-of (pdu-of reply))
                            non-repeaters max-repetitions)))))))

(defmethod snmp-bulk ((host session) (var string) &key context)
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))

(defmethod snmp-bulk ((host session) (var object-id) &key context)
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))

(defmethod snmp-bulk ((host session) (var vector) &key context)
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))

;;; remove unused methods
(eval-when (:load-toplevel :execute)
  (ignore-errors
    (let ((methods (mapcar #'(lambda (x)
                               (find-method #'snmp-bulk '() (mapcar #'find-class x)))
                           '((string list)
                             (string object-id)
                             (string string)))))
      (mapcar #'(lambda (x)
                  (remove-method #'snmp-bulk x))
              methods))))

(setf *minor-version* 20)
