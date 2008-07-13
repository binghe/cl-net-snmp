;;;; -*- Mode: Lisp -*-

(in-package :snmp)

(defgeneric snmp-get (object vars &key &allow-other-keys)
  (:documentation "SNMP Get"))

(defmethod snmp-get ((host string) (vars list) &key (context ""))
  (when vars
    (with-open-session (s host)
      (snmp-get s vars :context context))))

(defmethod snmp-get ((session session) (vars list) &key (context ""))
  "SNMP GET for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
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

(defmethod snmp-get ((host string) (var string) &key (context ""))
  (car (snmp-get host (list var) :context context)))

(defmethod snmp-get ((host string) (var object-id) &key (context ""))
  (car (snmp-get host (list var) :context context)))

;;; RFC 3416: 4.2.3. The GetBulkRequest-PDU
(defun generate-table (vars vbs non-repeaters max-repetitions)
  (declare (type fixnum non-repeaters max-repetitions))
  (let* ((var-number (list-length vars))
         (n (min non-repeaters var-number))
         (m max-repetitions)
         (r (max (- var-number n) 0))
         result-table)
    ;; non-repeaters
    (dotimes (i n)
      (push (pop vbs) result-table))
    ;; table
    (when (and (plusp m) (plusp r))
      (dotimes (i m)
        (push (let (record)
                (dotimes (j r (nreverse record))
                  (push (pop vbs) record)))
              result-table)))
    (values (nreverse result-table)
            (mapcar #'*->oid vars))))

(defgeneric snmp-bulk (object vars &key &allow-other-keys)
  (:documentation "SNMP Get Bulk"))

(defmethod snmp-bulk ((host string) (vars list) &key
                      (non-repeaters 0) (max-repetitions 1) (context ""))
  (when vars
    (with-open-session (s host)
      (snmp-bulk s vars
                 :non-repeaters non-repeaters
                 :max-repetitions max-repetitions
                 :context context))))

(defmethod snmp-bulk ((session session) (vars list) &key
                      (non-repeaters 0) (max-repetitions 1) (context ""))
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :pdu (make-instance 'get-bulk-request-pdu
                                                        :non-repeaters non-repeaters
                                                        :max-repetitions max-repetitions
                                                        :variable-bindings vb)
                                    :context context)))

        (let ((reply (send-snmp-message session message)))
          (when reply
            (generate-table vars
                            (variable-bindings-of (pdu-of reply))
                            non-repeaters max-repetitions)))))))

:eof
