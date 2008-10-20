;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defclass snmp-operation ()
  ((session   :type session
              :reader session-of
              :initarg :session)
   (pdu       :type pdu
              :reader pdu-of
              :initarg :pdu)
   (context   :type string
              :accessor context-of
              :initarg :context
              :initform *default-context*)
   (send-time :type integer
              :accessor send-time-of
              :initform 0))
  (:documentation "SNMP Operation class used by SNMP-WORKER"))

;;; SNMP-WORKER is a low-level API for sync lots of SNMP messages once.

(defun snmp-worker (op-list)
  (declare (type list op-list)) ; each item is (session . pdu-list)
  (let ((operation-list
         (mapcan #'(lambda (item)
                     (destructuring-bind (session . pdu-list) item
                       (mapcar #'(lambda (x)
                                   (make-instance 'snmp-operation :session session :pdu x))
                               pdu-list)))
                 op-list)))
    (mapcar #'(lambda (o) (process-operation o :push))
            operation-list)))

(defgeneric process-operation (object action))

(defmethod process-operation ((operation snmp-operation) (action (eql :push)))
  (with-slots (session pdu context send-time) operation
    (let ((message (make-instance (gethash (type-of session) *session->message*)
                                  :session session
                                  :context context
                                  :pdu pdu)))
      (setf send-time (get-internal-real-time))
      (send-snmp-message session message :receive nil))))
