(in-package :snmp)

(export '(+snmp-version-1+ +snmp-version-2c+ +snmp-version-3+))

(defmethod snmp-walk ((session session) (vars list) &key (context ""))
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

(defun generate-table (vars vbs non-repeaters max-repetitions)
  (declare (type fixnum non-repeaters max-repetitions))
  (let* ((var-number (list-length vars))
         (n (min non-repeaters var-number))
         (m max-repetitions)
         (r (max (- var-number n) 0))
         (real-vbs (mapcar #'(lambda (x) (coerce x 'list))
                           (coerce vbs 'list)))
         result-table)
    ;; non-repeaters
    (dotimes (i n)
      (push (pop real-vbs) result-table))
    ;; table
    (when (and (plusp m) (plusp r))
      (dotimes (i m)
        (push (let (record)
                (dotimes (j r (nreverse record))
                  (push (pop real-vbs) record)))
              result-table)))
    (values (nreverse result-table)
            (mapcar #'oid vars))))

(defmethod snmp-bulk ((session session) (vars list) &key
                      (non-repeaters 0) (max-repetitions 1) (context ""))
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

(defmethod snmp-bulk ((host string) (var string) &key (context ""))
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))

(defmethod snmp-bulk ((host string) (var object-id) &key (context ""))
  (multiple-value-bind (table header) (snmp-bulk host (list var) :context context)
    (values (car table) (car header))))
