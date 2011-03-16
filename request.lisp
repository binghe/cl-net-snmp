;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun snmp-report (session &key context)
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context (or context *default-context*)
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings nil))))
    (let ((reply (send-snmp-message session message)))
      (map 'list #'(lambda (x) (coerce x 'list))
           (variable-bindings-of (pdu-of reply))))))

(defgeneric snmp-request (session request bindings &key &allow-other-keys)
  (:documentation "General SNMP request operation"))

(defmethod snmp-request ((session session) (request symbol) (bindings list)
                         &key context)
  (when bindings
    (let ((vb (mapcar #'(lambda (x) (if (consp x)
                                        (list (oid (first x)) (second x))
                                        (list (oid x) nil)))
                      bindings)))
      ;; Get a report first if the session is new created.
      (when (and (= (version-of session) +snmp-version-3+)
                 (need-report-p session))
        (snmp-report session :context context))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :context (or context *default-context*)
                                    :pdu (make-instance request
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (coerce x 'list))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-request ((host string) request bindings &key context)
  (with-open-session (s host)
    (snmp-request s request bindings :context context)))

(defmethod snmp-request (session request (binding string) &key context)
  (snmp-request session request (list (list (oid binding) nil)) :context context))

(defmethod snmp-request (session request (binding vector) &key context)
  (snmp-request session request (list (list (oid binding) nil)) :context context))

(defmethod snmp-request (session request (binding object-id) &key context)
  (snmp-request session request (list (list binding nil)) :context context))

(defmethod snmp-request (session request (binding simple-oid) &key context)
  (snmp-request session request (list (list binding nil)) :context context))

(defun snmp-get (session bindings &key context)
  (let ((result (mapcar #'second
                        (snmp-request session 'get-request-pdu bindings
                                      :context context))))
    (if (consp bindings) result (car result))))

(defun snmp-get-next (session bindings &key context)
  (let ((result (snmp-request session 'get-next-request-pdu bindings
                              :context context)))
    (if (consp bindings) result (car result))))

(defun snmp-set (session bindings &key context)
  (let ((result (mapcar #'second
                        (snmp-request session 'set-request-pdu bindings
                                      :context context))))
    (if (consp bindings) result (car result))))
