;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun snmp-report (session &key (context *default-context*))
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context (or context *default-context*)
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (let ((reply (send-snmp-message session message)))
      (map 'list #'(lambda (x) (coerce x 'list))
           (variable-bindings-of (pdu-of reply))))))
