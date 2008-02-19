(in-package :snmp)

(defgeneric snmp-walk (object vars)
  (:documentation "SNMP Walk"))

(defmethod snmp-walk ((host string) (vars list))
  (with-open-session (s host)
    (snmp-walk s vars)))

(defmethod snmp-walk ((session session) (vars list))
  "SNMP Walk for v1, v2c and v3"
  (when vars
    (let ((base-vars (mapcar #'*->oid vars)))
      (labels ((iter (current-vars acc)
                 (let ((temp (snmp-get-next session current-vars)))
                   (let ((new-vars (mapcar #'first temp)))
                     (if (some #'oid->= new-vars base-vars)
                       acc
                       (iter new-vars (mapcar #'cons temp acc)))))))
        (iter base-vars (make-list (length vars)))))))

(defmethod snmp-walk (object (var string))
  (car (snmp-walk object (list var))))

(defmethod snmp-walk (object (var object-id))
  (car (snmp-walk object (list var))))
