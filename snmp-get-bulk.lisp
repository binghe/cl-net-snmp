(in-package :snmp)

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

(defgeneric snmp-get-bulk (object vars &key)
  (:documentation "SNMP Get Bulk"))

(defmethod snmp-get-bulk ((host string) (vars list) &key (non-repeaters 0) (max-repetitions 1))
  (when vars
    (with-open-session (s host)
      (snmp-get-bulk s vars
                     :non-repeaters non-repeaters
                     :max-repetitions max-repetitions))))

(defmethod snmp-get-bulk ((session session) (vars list) &key (non-repeaters 0) (max-repetitions 1))
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
                                                        :variable-bindings vb))))
        (let ((data (ber-encode message))
              (socket (socket-of session)))
          (write-sequence data socket)
          (force-output socket)
          ;; time goes up ...
          (let ((message (decode-message session socket)))
            (generate-table vars
                            (variable-bindings-of (pdu-of message))
                            non-repeaters max-repetitions)))))))
