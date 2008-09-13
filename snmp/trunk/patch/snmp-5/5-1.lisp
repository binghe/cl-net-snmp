;;;; -*- Mode: Lisp -*-

(in-package :snmp)

(defun close-session (session)
  (declare (type session session))
  (when (slot-boundp session 'socket)
    (socket-close (socket-of session))))
