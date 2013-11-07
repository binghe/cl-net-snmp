;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defvar *smi-value->symbol-table* (make-hash-table))
(defvar *smi-symbol->value-table* (make-hash-table))

(eval-when (:load-toplevel :execute)
  (mapcar #'(lambda (x)
	      (setf (gethash (car x) *smi-value->symbol-table*)
                    (cdr x)
                    (gethash (cdr x) *smi-symbol->value-table*)
                    (car x)))
          *smi-map*))

(defgeneric smi (object))

(defmethod smi ((value integer))
  (make-instance 'smi :value value))

(defmethod smi ((symbol symbol))
  (let ((value (gethash symbol *smi-symbol->value-table*)))
    (when value
      (make-instance 'smi :value value))))

(defclass smi (number-type) ())

(defun smi-p (object)
  (typep object 'smi))

(defmethod plain-value ((object smi) &key default)
  (gethash (value-of object) *smi-value->symbol-table* default))

(defmethod print-object ((obj smi) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A (~D)" (plain-value obj) (value-of obj))))

(defmethod ber-encode ((value smi))
  (concatenate 'vector
               (ber-encode-type 2 0 (value-of value))
               (ber-encode-length 0)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-smi (symbol value)
    `(progn
       (defmethod ber-decode-value ((stream stream) (type (eql ,symbol)) length)
         (declare (type fixnum length) (ignore type))
         (dotimes (i length (smi ,symbol))
           (read-byte stream)))
       (install-asn.1-type ,symbol 2 0 ,value))))

(macrolet ((install-smi-value ()
             `(progn
                ,@(mapcar #'(lambda (x)
                              `(def-smi ,(cdr x) ,(car x)))
                          *smi-map*))))
  (install-smi-value))
