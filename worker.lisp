;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

;;; SNMP-WORKER is a low-level API for sync lots of SNMP messages once.

(defun snmp-worker (op-list)
  (declare (type list op-list)) ; each item is (session . pdu-list)
  0
  )
