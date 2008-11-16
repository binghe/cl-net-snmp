;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(define-condition snmp-agent-error (snmp-error)
  ())

(define-condition snmp-agent-request-error (snmp-agent-error)
  ((request :initarg :request
	    :reader snmp-agent-request-error-request)))

(define-condition snmp-request-bad-community-error (snmp-agent-request-error)
  ((community :initarg :community
	      :reader snmp-error-community))
  (:report (lambda (c stream)
	     (format stream "Bad community ~S"
		     (snmp-error-community c)))))

(define-condition snmp-bad-version-error (snmp-agent-request-error)
  ((requested-version :initarg :requested-version
		      :reader snmp-error-requested-version))
  (:report (lambda (c stream)
	     (format stream "Requested version ~D not supported"
		     (snmp-error-requested-version c)))))

(define-condition snmp-agent-unrecognized-pdu-type-error (snmp-agent-request-error)
  ((pdu-type :initarg :pdu-type
	     :reader snmp-error-pdu-type))
  (:report (lambda (c stream)
	     (format stream "PDU type ~D not recognized"
		     (snmp-error-pdu-type c)))))

(define-condition snmp-malformed-pdu-error (snmp-agent-request-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Malformed PDU"))))

(define-condition snmpv1-malformed-pdu-error (snmp-agent-request-error)
  ()
  (:report (lambda (c stream)
	     (declare (ignore c))
	     (format stream "Malformed SNMPv1 PDU"))))

(define-condition snmp-get-bulk-illegal-max-repetitions (snmp-agent-request-error)
  ((max-repetitions :initarg :max-repetitions
		    :reader snmp-error-max-repetitions))
  (:report (lambda (c stream)
	     (let ((max-repetitions (snmp-error-max-repetitions c)))
	       (format stream "Illegal value ~D for max-repetitions:~%~
should never be less than zero"
		       max-repetitions)))))

(define-condition snmp-get-bulk-illegal-non-repeaters (snmp-agent-request-error)
  ((non-repeaters :initarg :non-repeaters :reader snmp-error-non-repeaters))
  (:report (lambda (c stream)
	     (let ((non-repeaters (snmp-error-non-repeaters c)))
	       (format stream "Illegal value ~D for non-repeaters:~%"
		       non-repeaters)
	       (cond ((< non-repeaters 0)
		      (format stream "non-repeaters should never be less than zero"))
		     (t (format stream "non-repeaters greater than number of bindings")))))))

(define-condition snmp-agent-specific-variable-error (snmp-agent-request-error)
  ((variable-index :initarg :index
		   :type integer
		   :reader snmp-agent-specific-variable-error-variable-index)))

(define-condition snmp-agent-no-such-name-error
    (snmp-agent-specific-variable-error)
  ()
  (:report (lambda (c stream)
	     (format stream "No such name for binding ~D (~D)"
		     (snmp-agent-specific-variable-error-variable-index c)
		     (request-id-of
		      (snmp-agent-request-error-request c))))))

(defmethod snmp-agent-specific-variable-error-error-status
           ((c snmp-agent-no-such-name-error))
  :no-such-name)
