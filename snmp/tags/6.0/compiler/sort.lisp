;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

;;; RTL structure:
;;;          rtl -> (i i i ...)
;;;            i -> (def dependency-list)
;;;   dependency -> (name parent)

(defun sort-definitions (rtl)
  ;; Make a new hash-table
  (let ((name->rtl (make-hash-table))
        (name->parent (make-hash-table))
        (name-list nil))
    ;; Put all RTLs into hash-table, (x y) become x -> y
    (dolist (i rtl)
      (if (null (cdr i))
          ;; no-depends_line that we must keep
          (let ((name (gensym)))
            (setf (gethash name name->rtl) (car i))
            (push name name-list))
        (destructuring-bind (name parent) (second i) ;; dependency-list
          (setf (gethash name name->rtl) (car i))
          (setf (gethash name name->parent) parent)
          (push name name-list))))
    (setf name-list (nreverse name-list))
    ;; sorting (not implemented)
    (let ((xxx (reorder-name name-list name->parent)))
      ;;(format t "result: ~A" xxx)
      ;; output results
      (mapcar #'(lambda (x) (gethash x name->rtl))
              xxx))))

(defun reorder-name (name-list name->parent)
  (declare (type list name-list)
           (type hash-table name->parent))
  ;;(format t "GO into reorder-name~%")
  (loop with nlist = (copy-list name-list)
        with passed-names = nil
        with insert-table = (make-hash-table)
        for current-node in nlist
        when (let ((p (gethash current-node name->parent)))
               ;;(format t "current: ~A, parent: ~A~%" current-node p)
               (and p                               ; if current-node has a parent (not nil),
                    (member p name-list)            ; and it's a name defined in current file,
                    (not (member p passed-names)))) ; but haven't appeared,
        do (progn ; then, found the parent node and insert current-node after it:
             ;;(format t "YYYYYYYYYYYYYYYYYYY~%")
             (setf (gethash (gethash current-node name->parent)
                            insert-table)
                   current-node))
        else
        do (progn
             (push current-node passed-names)
             (let ((c (gethash current-node insert-table)))
               (if c (progn
                       ;;(format t "XXXXXXXXXXXXXXX~%")
                       (push c passed-names)))))
        finally (return (nreverse passed-names))))
