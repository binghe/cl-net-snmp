;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun need-report-p (session)
  "return true if a SNMPv3 session has no engine infomation set"
  (declare (type v3-session session))
  (zerop (engine-time-of session)))

(defun snmp-report (session &key (context *default-context*))
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context context
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (let ((report-data (send-snmp-message session message
                                          :receive nil :report t)))
      (update-session-from-report session
                                  (elt (ber-decode report-data) 2)))))
