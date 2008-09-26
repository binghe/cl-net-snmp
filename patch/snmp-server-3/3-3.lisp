(in-package :snmp)

(defun process-message-v1/v2c (message)
  (destructuring-bind (version community pdu) (coerce message 'list)
    (let ((reply-pdu (process-pdu pdu)))
      (when reply-pdu
        (list version community reply-pdu)))))

(unuse-package :snmp-system)

(defun mklist (obj)
  (if (listp obj) obj (list obj)))

(in-package :snmp-system)

(unexport '(dbind mklist))
(fmakunbound 'dbind)
(fmakunbound 'mklist)
