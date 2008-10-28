;;;; $Id$

(in-package :snmp)

(defgeneric snmp-walk (object vars &key &allow-other-keys)
  (:documentation "SNMP Walk, only useful for debug"))

(defmethod snmp-walk ((host string) (vars list) &key context)
  (with-open-session (s host)
    (snmp-walk s vars :context context)))

(defmethod snmp-walk ((session session) (vars list) &key context)
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

(defmethod snmp-walk (object (var string) &key context)
  (car (snmp-walk object (list var) :context context)))

(defmethod snmp-walk (object (var object-id) &key context)
  (car (snmp-walk object (list var) :context context)))
