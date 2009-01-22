;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export 'snmp-select))

;;; SNMP-SELECT, A high-level SNMP query language.

#|

> (snmp-select "tcpConnTable" :from session)
(#<TcpConnEntry 1>
 #<TcpConnEntry 2>
 #<TcpConnEntry 3>
 ...)

|#

(defun snmp-select (identifier &key from &allow-other-keys)
  ;; handle string-like session first
  (if (stringp from)
      (with-open-session (s from)
        (funcall #'snmp-select identifier :from s))
    ;; get the mib table
    (let ((table (process-identifier identifier))
          (session from))
      (let ((class (mib-table-class table))
            (slots (mib-table-slots table))
            (lines (detect-mib-table-lines session table))
            (results nil))
        (loop for i from 1 upto lines
              do (let ((current-slots (mapcar #'(lambda (x) (oid (list x i))) slots))
                       (object (make-instance class)))
                   (let ((response (snmp-get session current-slots)))
                     (mapcar #'(lambda (s v)
                                 (setf (slot-value object (oid-name s)) v))
                             slots response)
                     (push object results))))
        (nreverse results)))))

(defgeneric process-identifier (identifier)
  (:documentation "process identifiers of snmp-select form"))

(defmethod process-identifier ((identifier string))
  (oid identifier))

(defmethod process-identifier ((identifier object-id))
  identifier)

(defun mib-table-p (oid)
  (declare (type object-id oid))
  (when (oid-syntax-p oid)
    (let ((syntax (oid-syntax oid)))
      (and (listp syntax)
           (= 2 (list-length syntax))
           (eq 'vector (car syntax))))))

(defun mib-table-class (oid)
  (declare (type object-id oid))
  (find-class (second (oid-syntax oid))))

(defun mib-table-entry (oid)
  (declare (type object-id oid))
  (oid (list oid 1)))

(defun mib-table-slots (oid)
  (declare (type object-id oid))
  (let ((entry (mib-table-entry oid)))
    (list-children entry)))

(defun detect-mib-table-lines (session oid)
  (list-length (snmp-walk session (car (mib-table-slots oid)))))
