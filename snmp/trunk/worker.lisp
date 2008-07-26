(in-package :snmp)

(defvar *send-worker-cv* (make-condition-variable))
(defvar *recv-worker-cv* (make-condition-variable))

(defun send-worker ()
  (loop (thread-yield)
        (sleep 1)))

(defun recv-worker ()
  (loop (thread-yield)
        (sleep 1)))
