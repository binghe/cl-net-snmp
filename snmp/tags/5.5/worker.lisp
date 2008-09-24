;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defvar *send-worker-cv* (make-condition-variable))
(defvar *recv-worker-cv* (make-condition-variable))

(defun send-worker ()
  (loop (thread-yield)
        (sleep 1)))

(defun recv-worker ()
  (loop (thread-yield)
        (sleep 1)))

(defclass snmp-operation ()
  ((session :type session
            :accessor session-of)
   (oper    :type (member :get :report :set :get-next)
            :accessor oper-of)
   (args    :type list
            :accessor args-of))
  (:documentation "Single SNMP operation"))
