;;;; $Id$
;;;; Note: parts of this file come from Simon Leinen's cl-snmp project

(in-package :snmp)

(define-condition snmp-error (error)
  ())

(define-condition snmp-session-error (snmp-error)
  ((session :initarg :session
	    :reader snmp-session-error-session)))

(define-condition snmp-timeout-error (snmp-session-error)
  ()
  (:report (lambda (c stream)
	     (format stream "Timeout (~D) exceeded"
		     (snmp-session-timeout
		      (snmp-session-error-session c))))))

(define-condition snmp-query-error (snmp-session-error)
  ((query :initarg :query
	  :reader snmp-query-error-query)))

(define-condition snmp-response-error (snmp-query-error)
  ((response :initarg :response
	     :reader snmp-response-error-response)))

(define-condition snmp-malformed-response-pdu-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Malformed response PDU"))))

(define-condition snmpv1-malformed-response-pdu-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Malformed SNMPv1 response PDU"))))

(define-condition snmp-response-id-mismatch-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (format stream "Request ID mismatch: ~S does not match query ~S"
		     (snmp-response-error-response c)
		     (snmp-query-error-query c)))))

(define-condition snmp-response-attribute-mismatch-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (format stream "Attribute mismatch: ~S does not match query ~S"
		     (snmp-response-error-response c)
		     (snmp-query-error-query c)))))

(define-condition snmp-response-too-short-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Response too short"))))

(define-condition snmp-response-too-long-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Response too long"))))

(define-condition snmp-response-too-big-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Response too big"))))

(define-condition snmp-response-specific-variable-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (let ((response (snmp-response-error-response c)))
	       (report-variable-error
		c stream
		(and (> (pdu-error-index response) 0)
		     (first (elt (pdu-bindings response)
				 (1- (pdu-error-index response))))))))))

(define-condition snmp-no-such-name-error (snmp-response-specific-variable-error) ())

(defmethod report-variable-error ((c snmp-no-such-name-error) s v)
  (format s "No such name: ~S" v))

(define-condition snmp-read-only-error (snmp-response-specific-variable-error) ())

(defmethod report-variable-error ((c snmp-read-only-error) s v)
  (format s "~S is read-only" v))

(define-condition snmp-bad-value-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (let* ((response (snmp-response-error-response c))
		    (binding (elt (pdu-bindings response)
				  (pdu-error-index response))))
	       (format stream "~S is a bad value for ~S"
		       (second binding) (first binding))))))

(define-condition snmp-unknown-error-status-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (format stream "Response with unknown error status ~S"
		     (pdu-error-status (snmp-response-error-response c))))))

(define-condition snmp-generic-error (snmp-response-specific-variable-error) ())

(defmethod report-variable-error ((c snmp-generic-error) s v)
  (format s "Generic error~@[ for variable ~S~]" v v))

(define-condition snmp-reponse--match-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (format stream "Response ~S does not match query ~S"
		     (snmp-response-error-response c)
		     (snmp-query-error-query c)))))

(defun make-snmp-response-error (session query response)
  (make-condition
   (case (pdu-error-status response)
     ((#.+error-status-too-big+)
      'snmp-too-big-error)
     ((#.+error-status-no-such-name+)
      'snmp-no-such-name-error)
     ((#.+error-status-bad-value+)
      'snmp-bad-value-error)
     ((#.+error-status-read-only+)
      'snmp-read-only-error)
     ((#.+error-status-generic-error+)
      'snmp-generic-error)
     (otherwise
      'snmp-unknown-error-status-error))
   :session session :query query :response response))
