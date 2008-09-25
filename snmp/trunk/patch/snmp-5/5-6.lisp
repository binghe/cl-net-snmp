(in-package :snmp)

(define-condition snmp-response-match-error (snmp-response-error)
  ()
  (:report (lambda (c stream)
	     (format stream "Response ~S does not match query ~S"
		     (snmp-response-error-response c)
		     (snmp-query-error-query c)))))

(unintern 'snmp-reponse--match-error)

(defparameter *version* 5.6)
