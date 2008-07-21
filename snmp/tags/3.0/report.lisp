;;;; -*- Mode: lisp; -*-

(in-package :snmp)

(defun need-report-p (session)
  "return true if a SNMPv3 session has no engine infomation set"
  (declare (type v3-session session))
  (zerop (engine-time-of session)))

(defun snmp-report (session &key (context ""))
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context context
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (send-snmp-message session message :receive nil :report t)
    (let ((ber-stream (socket-receive (socket-of session) nil 65507)))
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
	  ;; security-data: 3rd field of message list
	  (coerce (ber-decode<-string (elt (ber-decode ber-stream) 2)) 'list)
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
