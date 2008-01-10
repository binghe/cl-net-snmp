;;; SNMPv3 get-request & report support

(in-package :snmp)

(defun snmp-get-report (session)
  (declare (type v3-session session))
  (let ((message
         (make-instance 'v3-message
                        :version (version-of session)
                        :global-data (generate-global-data session)
                        :security-data (generate-security-data session)
                        :pdu (make-instance
			      'get-request-pdu
			      :request-id 0
			      :variable-bindings (empty-sequence)))))
    0))
