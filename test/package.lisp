;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(defpackage snmp.test
  (:use :common-lisp :snmp))

(in-package :snmp.test)

(defmacro with-open-snmp-server (() &body body)
  `(progn (enable-snmp-service)
     (sleep 1)
     (unwind-protect
         (progn ,@body)
       (disable-snmp-service))))

(defun do-tests ()
  )
