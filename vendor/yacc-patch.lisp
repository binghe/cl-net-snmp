;;;; -*- Mode: Lisp -*-
;;;; $Id: yacc.lisp 737 2009-02-06 16:04:09Z binghe $

;;;; Patch to CL-YACC, made by John Fremlin from MSI <jf@msi.co.jp>, waiting for merge

(in-package :snmp.yacc)

(define-condition conflict-warning (yacc-compile-warning simple-warning)
  ((kind :initarg :kind :reader conflict-warning-kind)
   (state :initarg :state :reader conflict-warning-state)
   (terminal :initarg :terminal :reader conflict-warning-terminal)
   (chosen-action :initarg :chosen-action :reader conflict-warning-chosen-action :initform nil))
  (:report (lambda (w stream)
             (format stream "~A conflict on terminal ~S in state ~A, ~_~?, ~@[taking action ~A~]"
                     (case (conflict-warning-kind w)
                       (:shift-reduce "Shift/Reduce")
                       (:reduce-reduce "Reduce/Reduce")
                       (t (conflict-warning-kind w)))
                     (conflict-warning-terminal w)
                     (conflict-warning-state w)
                     (simple-condition-format-control w)
                     (simple-condition-format-arguments w)
		     (conflict-warning-chosen-action w)))))

(defun handle-conflict (a1 a2 grammar action-productions id s
                        &optional muffle-conflicts)
  "Decide what to do with a conflict between A1 and A2 in state ID on symbol S.
Returns three actions: the chosen action, the number of new sr and rr."
  (declare (type action a1 a2) (type grammar grammar)
           (type index id) (symbol s))
  (when (action-equal-p a1 a2)
    (return-from handle-conflict (values a1 0 0)))
  (when (and (shift-action-p a2) (reduce-action-p a1))
    (psetq a1 a2 a2 a1))
  (let ((p1 (cdr (assoc a1 action-productions)))
        (p2 (cdr (assoc a2 action-productions))))
    ;; operator precedence and associativity
    (when (and (shift-action-p a1) (reduce-action-p a2))
      (let* ((op1 (find-single-terminal (production-derives p1) grammar))
             (op2 (find-single-terminal (production-derives p2) grammar))
             (op1-tail (find-precedence op1 (grammar-precedence grammar)))
             (op2-tail (find-precedence op2 (grammar-precedence grammar))))
        (when (and (eq s op1) op1-tail op2-tail)
          (cond
            ((eq op1-tail op2-tail)
             (return-from handle-conflict
               (ecase (caar op1-tail)
                 ((:left) (values a2 0 0))
                 ((:right) (values a1 0 0))
                 ((:nonassoc) (values nil 0 0)))))
            (t
             (return-from handle-conflict
               (if (tailp op2-tail (cdr op1-tail))
                   (values a1 0 0)
                   (values a2 0 0))))))))
    ;; default: prefer first defined production
    (let ((kind (typecase a1
                  (shift-action :shift-reduce)
                  (t :reduce-reduce)))
	  (chosen-action
	   (if (production< p1 p2)
	       a1
             a2)))
      (unless muffle-conflicts
	(warn (make-condition
               'conflict-warning
               :kind kind
               :state id :terminal s
               :format-control "~S and ~S~@[ ~_~A~]~@[ ~_~A~]"
               :format-arguments (list a1 a2 p1 p2)
               :chosen-action chosen-action)))
      (values chosen-action
	      (if (eq kind :shift-reduce) 1 0)
	      (if (eq kind :reduce-reduce) 1 0)))))

