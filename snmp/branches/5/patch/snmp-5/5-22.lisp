;;;; Handle terminal condition correctly, just detect duplicate return OIDs.
;;;; Thanks for John Fremlin from MSI

(in-package :snmp)

(defun walk-terminate-p (new-vars current-vars base-vars)
  (or (some #'oid->= new-vars base-vars)
      (some #'ber-equal new-vars current-vars)))

(defmethod snmp-walk ((session session) (vars list) &key context)
  "SNMP Walk for v1, v2c and v3"
  (when vars
    (let ((base-vars (mapcar #'oid vars)))
      (labels ((iter (current-vars acc first-p)
                 (let* ((temp (snmp-get-next session current-vars :context context))
                        (new-vars (mapcar #'first temp)))
                   (if (walk-terminate-p new-vars
                                         current-vars
                                         base-vars)
                       (if first-p
                           (snmp-get session vars)
                         (mapcar #'nreverse acc))
                     (iter new-vars (mapcar #'cons temp acc) nil)))))
        (iter base-vars (make-list (length vars)) t)))))
