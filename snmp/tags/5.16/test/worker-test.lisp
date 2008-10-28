;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun worker-test-1 ()
  (let ((session-1 (make-instance 'session))
        (session-2 (make-instance 'session))
        (pdu-1 (make-instance 'pdu))
        (pdu-2 (make-instance 'pdu))
        (pdu-3 (make-instance 'pdu)))
    (snmp-worker (list (list session-1 pdu-1)
                       (list session-2 pdu-2 pdu-3)))))
