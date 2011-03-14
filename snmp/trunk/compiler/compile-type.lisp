;;;; -*- Mode: Lisp -*-
;;;; $Id: compile-type.lisp 727 2009-01-27 10:08:58Z binghe $

(in-package :asn.1)

(defvar *keyword-type-table* (make-hash-table))

(defparameter *keyword-type-map*
  '((:object-identifier . object-id)
    (:null              . null)
    (:integer           . integer)
    (:octet-string      . octet-string)
    (:number            . number)))
  
(eval-when (:load-toplevel :execute)
  (mapcar #'(lambda (x)
	      (setf (gethash (car x) *keyword-type-table*) (cdr x)))
          *keyword-type-map*))

(defun get-type (type)
  (gethash type *keyword-type-table* type))

(defgeneric compile-type (rtl))

(defmethod compile-type ((rtl symbol))
  (values (get-type rtl) t))

(defmethod compile-type ((rtl list))
  (compile-type-internal (car rtl) (cdr rtl)))

(defgeneric compile-type-internal (type rtl))

(defmethod compile-type-internal ((type symbol) (rtl list))
  (declare (ignore type rtl))
  (values t t))

(defmethod compile-type-internal ((type (eql :octet-string)) (rtl list))
  (declare (ignore rtl))
  (values 'octet-string nil))

(defmethod compile-type-internal ((type (eql :sequence)) (rtl list))
  (declare (ignore rtl))
  (values type nil))

(defmethod compile-type-internal ((type (eql :sequence-of)) (rtl list))
  (declare (ignore type))
  (values `(vector ,(car rtl)) t))

(defmethod compile-type-internal ((type (eql :textual-convention)) (rtl list))
  (declare (ignore rtl))
  (values type nil))

;;; How to extend it?
(defun compile-ta (name specifier)
  (multiple-value-bind (type simple-type-p)
      (compile-type specifier)
    (if simple-type-p
        `((deftype ,name () 't))
      (compile-ta-internal type name specifier))))

(defgeneric compile-ta-internal (type name specifier))

(defmethod compile-ta-internal ((type symbol) name specifier)
  `((deftype ,name () 't)))

(defmethod compile-ta-internal ((type (eql :sequence)) name specifier)
  (let ((slots (mapcar #'compile-sequence (cdr specifier))))
    `((defclass ,name (sequence-type) ,slots))))

(defun compile-sequence (slot)
  (destructuring-bind (name type) slot
    `(,name :type ,(compile-type type))))

;;; TEXTUAL-CONVENTION
(defmethod compile-ta-internal ((type (eql :textual-convention)) name specifier)
  (destructuring-bind (ta-options syntax) (cdr specifier)
    `((define-textual-convention ,name ,(compile-type (second syntax))
                                 ,@(compile-df-options ta-options)))))
