;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

;;; Replace some unsafe functions in SNMP-BASE system.

;; thread-safe implementation
(defmethod generate-request-id :around ((pdu common-pdu))
  (with-slots (request-id-counter) pdu
    (the (unsigned-byte 32)
         (logand (portable-threads:atomic-incf request-id-counter) #xffffffff))))

;; thread-safe implementation
(defmethod generate-msg-id :around ((message v3-message))
  (with-slots (msg-id-counter) message
    (the (unsigned-byte 32)
         (logand (portable-threads:atomic-incf msg-id-counter) #xffffffff))))
