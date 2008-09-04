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
                                :context (or context *default-context*)
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (let ((report-data (send-snmp-message session message
                                          :receive nil :report t)))
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
          ;; security-data: 3rd field of message list
          (coerce (ber-decode<-string (elt (ber-decode report-data) 2)) 'list)
        (declare (ignore user auth priv))
        (setf (engine-id-of session) engine-id
              (engine-boots-of session) engine-boots
              (engine-time-of session) engine-time)
        (when (and (auth-protocol-of session) (slot-boundp session 'auth-key))
          (setf (auth-local-key-of session)
                (generate-kul (map '(simple-array (unsigned-byte 8) (*))
                                   #'char-code engine-id)
                              (auth-key-of session))))
        (when (and (priv-protocol-of session) (slot-boundp session 'priv-key))
          (setf (priv-local-key-of session)
                (generate-kul (map '(simple-array (unsigned-byte 8) (*))
                                   #'char-code engine-id)
                              (priv-key-of session))))
        session))))
