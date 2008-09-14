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
    (let ((next-oid (oid-find-next oid)))
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
  (let ((oid (intern name (find-package :asn.1))))
    `(progn
       (defun ,oid (,agent)
         (declare (ignorable ,agent))
         ,@body)
       (eval-when (:load-toplevel :execute)
         (register-variable (oid (list (oid ,name) 0)) #',oid)))))

(defun register-mib-table (oid table-function)
  "This function won't be called at runtime, only LOAD-TIME."
  (declare (type object-id oid))
  (let ((flist (funcall table-function )))
    (dotimes (i (list-length flist))
      (register-variable (oid (list oid (1+ i))) (nth i flist)))))

(defmacro def-listy-mib-table (name () &body body)
  (let ((oid (intern name (find-package :asn.1))))
    `(progn
       (defun ,oid () ,@body)
       (eval-when (:load-toplevel :execute)
         (register-mib-table (oid ,name) #',oid)))))
