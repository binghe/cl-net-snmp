;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun clean-default-dispatch ()
  (clrhash *default-dispatch-table*)
  (clrhash *default-walk-table*)
  (setf *default-walk-list* (list nil)))

(defun register-variable (oid function &key
                              (dispatch-table *default-dispatch-table*)
                              (walk-table *default-walk-table*)
                              (walk-list *default-walk-list*))
  "This function won't be called at runtime, only LOAD-TIME."
  (declare (type object-id oid))
  ;; register process function into dispatch-table
  (setf (gethash oid dispatch-table) function)
  ;; register oid into walk-table and walk-list (if haven't registed)
  (unless (gethash oid walk-table)
    (let ((next-oid (find-next oid dispatch-table)))
      (cond ((null (car walk-list))
             ;; for empty walk-list, add current one
             (setf (car walk-list) oid
                   (gethash oid walk-table) walk-list))
            ((eq next-oid (car walk-list))
             ;; if current node should be in head of walk-list, just push it
             (push oid walk-list)
             (setf (gethash oid walk-table)
                   walk-list))
            ((not (member next-oid walk-list))
             ;; if none in walk-list is the next oid of current oid,
             ;; append current one to the last
             (nconc walk-list (list oid))
             (setf (gethash oid walk-table)
                   (last walk-list)))
            (t ; find the right node in walk-list and insert after it
             (labels ((iter (i l)
                        (if (null i)
                            (error "REGISTER-VARIABLE: impossible...")
                          (if (eq (car i) next-oid)
                              ;; make a new node and insert into middle
                              (let ((new-i (cons oid i)))
                                (setf (cdr l) new-i)
                                (setf (gethash oid walk-table) new-i))
                            (iter (cdr i) i)))))
               (iter walk-list nil)))))))

(defmacro def-scalar-variable (name (agent) &body body)
  (let ((oid (oid-name (oid name)))
        (ids (gensym)))
    `(progn
       (defun ,oid (,agent &optional ,ids)
         (declare (ignorable ,agent))
         (if (null ,ids) 0
           (progn
             ,@body)))
       (eval-when (:load-toplevel :execute)
         (register-variable (oid ,name) #',oid)
         ,oid))))

(defmacro def-listy-mib-table (name (agent ids) &body body)
  "The IDs argument is used for passing sub-ids of a MIB table, when called with NIL,
   this user-defined OID handler function should return all possible keys to the table:
   * single number n: means valid keys are number 1~n;
   * list of numbers (1 2 3 ... n): means valid keys are numbers in the list;
   * list of list of numbers ((1 2) (3 4) (5 6)): means valid keys are sub-ids in the list."
  (let ((oid (oid-name (oid name))))
    `(progn
       (defun ,oid (,agent &optional ,ids)
         (declare (ignorable ,agent ,ids))
         ,@body)
       (eval-when (:load-toplevel :execute)
         (register-variable (oid ,name) #',oid)
         ,oid))))
