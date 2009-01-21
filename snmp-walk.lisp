;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defgeneric snmp-walk (object vars &key &allow-other-keys)
  (:documentation "SNMP Walk, only useful for debug"))

(defmethod snmp-walk ((host string) (vars list) &key context)
  (with-open-session (s host)
    (snmp-walk s vars :context context)))

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

(defmethod snmp-walk (object (var string) &key context)
  (car (snmp-walk object (list var) :context context)))

(defmethod snmp-walk (object (var object-id) &key context)
  (car (snmp-walk object (list var) :context context)))
