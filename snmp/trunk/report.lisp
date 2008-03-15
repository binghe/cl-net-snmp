;;; SNMPv3 get-request & report support

(in-package :snmp)

(defun need-report-p (session)
  "return true if a SNMPv3 session has no engine infomation set"
  (declare (type v3-session session))
  (zerop (engine-time-of session)))

(defun snmp-report (session)
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message :session session :report t
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (send-snmp-message session message :receive nil)
    (let ((ber-stream #+lispworks  (socket-of session)
		      #+sbcl (let ((buffer (socket-receive (socket-of session) nil 65507)))
			       (make-instance 'ber-stream
                                              :sequence (map 'vector #'char-code buffer)))))
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
	  ;; security-data: 3rd field of message list
	  (ber-decode<-string (third (coerce (ber-decode ber-stream) 'list)))
	(declare (ignore user auth priv))
	(setf (engine-id-of session) engine-id
	      (engine-boots-of session) engine-boots
	      (engine-time-of session) engine-time)
	session))))
