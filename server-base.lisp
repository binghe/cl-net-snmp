;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun clear-default-dispatch ()
  (clrhash *default-walk-table*)
  (clrhash *default-dispatch-table*)
  (setf *default-walk-list* nil))

(defun register-variable (oid function)
  "This function won't be called at runtime, only LOAD-TIME."
  (declare (type object-id oid))
  ;; register process function into dispatch-table
  (setf (gethash oid *default-dispatch-table*) function)
  ;; register oid into walk-table and walk-list (if haven't registed)
  (unless (gethash oid *default-walk-table*)
    (let ((next-oid (find-next oid *default-dispatch-table*)))
      (cond ((or (null *default-walk-list*)
                 (eq next-oid (car *default-walk-list*)))
             ;; for null *default-walk-list*, we just add current one.
             (push oid *default-walk-list*)
             (setf (gethash oid *default-walk-table*)
                   *default-walk-list*))
            ((not (member next-oid *default-walk-list*))
             ;; if none in *default-walk-list* is the next oid of current oid,
             ;; append current one to the last
             (nconc *default-walk-list* (list oid))
             (setf (gethash oid *default-walk-table*)
                   (last *default-walk-list*)))
            (t ; find the right node in *default-walk-list* and insert after it
             (labels ((iter (i l)
                        (if (null i)
                            (error "REGISTER-VARIABLE: impossible...")
                          (if (eq (car i) next-oid)
                              ;; make a new node and insert into middle
                              (let ((new-i (cons oid i)))
                                (setf (cdr l) new-i)
                                (setf (gethash oid *default-walk-table*) new-i))
                            (iter (cdr i) i)))))
               (iter *default-walk-list* nil)))))))

(defmacro def-scalar-variable (name (agent) &body body)
  (let ((oid (intern name (find-package :asn.1)))
        (ids (gensym)))
    `(progn
       (defun ,oid (,agent &optional ,ids)
         (declare (ignorable ,agent))
         (if (null ,ids) 0
           ,@body))
       (eval-when (:load-toplevel :execute)
         (register-variable (oid ,name) #',oid)))))

(defmacro def-listy-mib-table (name (agent ids) &body body)
  "The IDs argument is used for passing sub-ids of a MIB table, when called with NIL,
   this user-defined OID handler function should return all possible keys to the table:
   * single number n: means valid keys are number 1~n;
   * list of numbers (1 2 3 ... n): means valid keys are numbers in the list;
   * list of list of numbers ((1 2) (3 4) (5 6)): means valid keys are sub-ids in the list."
  (let ((oid (intern name (find-package :asn.1))))
    `(progn
       (defun ,oid (,agent &optional ,ids)
         (declare (ignorable ,agent ,ids))
         ,@body)
       (eval-when (:load-toplevel :execute)
         (register-variable (oid ,name) #',oid)))))
