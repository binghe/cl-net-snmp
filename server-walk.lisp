;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; snmp-walk (get-next) support for snmp-server

;;; [C]        [B]          [A]
;;; system +-> sysDescr --> sysDescr.0
;;;        |   
;;;        +-> sysORID  +-> sysORID.1 [G]
;;;        |   [F]      |
;;;        |            +-> sysORID.2 [D]
;;;        |            |
;;;        |            +-> sysORID.3 [E]
;;;        +-> sysXXX
;;;            [H]

;;; binghe: snmp-walk (get-next) on server-side is quite comlicated, I find five types:
;;;
;;; 1. GetNext an "scalar-variable" (sysDescr.0):
;;;    we should walk from A to B, then call the dispatch function on sysDescr
;;;
;;; 2. GetNext on "oid leaf" (sysDescr or sysORID):
;;;    we should detect this leaf is a scalar-variable or table by call its dispatch
;;;    on NIL, then decide return sysDescr.0 or sysORID.1
;;;
;;; 3. GetNext on "oid trunk" (system):
;;;    we should find next dispatched oid (from C to B), and then go to "Type 2"
;;;
;;; 4. GetNext in a table (sysORID.1 or sysORID.2):
;;;    we should find its table leaf (sysORID) first, then list all its table enties
;;;    (by call leaf's dispatch on NIL), then find the next entry of current entry
;;;    and return it.
;;;
;;; 5. GetNext in a table's last entry (sysORID.3):
;;;    To detect this case, we should use Type 4's method, when the next entry of current
;;;    entry is out of current table, we go to "Type 3"

(in-package :snmp)

(defun mklist (obj)
  (if (listp obj) obj (list obj)))

(defmethod process-object-id ((oid object-id) (flag (eql :get-next)))
  ;; First, find the target oid
  (destructuring-bind (next-oid dispatch-function args)
      (cond ((oid-scalar-variable-p oid) ; Type 1
             (find-first (find-sibling (oid-parent oid))))
            ((oid-leaf-p oid)            ; Type 2
             (or (find-first oid)
                 (find-first (find-sibling oid))))
            ((oid-trunk-p oid)           ; Type 3
             (find-first (find-next oid)))
            (t (find-next-entry oid)))   ; Type 4 or 5
    (if next-oid
      (list next-oid (funcall dispatch-function *server* args))
      (list oid (smi :end-of-mibview)))))

;;; B -> F
(defun find-sibling (oid)
  (declare (type object-id oid))
  (let* ((walk-table (server-walk-table *server*))
         (walk-list (gethash oid walk-table)))
    (if walk-list
      (cadr walk-list)
      (find-next oid))))

;;; (B -> A) or (F -> G)
(defun find-first (oid)
  (declare (type (or object-id null) oid))
  (let* ((dispatch-table (server-dispatch-table *server*))
         (dispatch-function (gethash oid dispatch-table)))
    (if (null dispatch-function)
      (list nil nil nil)
      (let ((entries (funcall dispatch-function *server*)))
        (etypecase entries
          (integer
           (cond ((zerop entries) ; B -> A
                  (list (oid (list oid 0))
                        dispatch-function
                        t))
                 (t               ; F -> G
                  (list (oid (list oid 1))
                        dispatch-function
                        (list 1)))))
          (list                   ; F -> G
           (let ((first-entry (mklist (car entries))))
             (list (oid (cons oid first-entry))
                   dispatch-function
                   first-entry))))))))

;;; (C -> B)
(defun find-next (oid &optional (dispatch-table
                                 (server-dispatch-table *server*)))
  "Find next dispatched object-id or nil"
  (declare (type object-id oid))
  (labels ((iter (oid)
             (unless (null oid)
               (let ((next (oid-next oid)))
                 (if (gethash next dispatch-table)
                   next
                   (iter next))))))
    (iter oid)))

;;; (G -> D) or (E -> H)
(defun find-next-entry (oid)
  (declare (type object-id oid))
  (let ((dispatch-table (server-dispatch-table *server*)))
    (multiple-value-bind (leaf ids) (oid-find-leaf oid)
      (let ((dispatch-function (gethash leaf dispatch-table)))
        (if (null dispatch-function)
          (find-first (find-next leaf))
          (let* ((entries (funcall dispatch-function *server*)))
            (etypecase entries
              (integer
               (let ((current-entry (car ids)))
                 (if (< current-entry entries)
                   (let ((next-entry (1+ current-entry)))
                     (list (oid (list leaf next-entry))
                           dispatch-function
                           (list next-entry)))
                   (find-first (find-sibling leaf)))))
              (list
               (let ((current-entry (find-in-list ids entries)))
                 (if current-entry
                   ;; find in middle or last
                   (let ((next-entry (mklist (cadr current-entry))))
                     (if next-entry
                       ;; find in middle: return next
                       (list (oid (cons leaf next-entry))
                             dispatch-function
                             next-entry)
                       ;; find in last: byebye
                       (find-first (find-sibling leaf))))
                   ;; invalid entry, just go first
                   (find-first leaf)))))))))))

;;; used by find-next-entry
(defun find-in-list (current all)
  (declare (type list current all))
  (labels ((iter (e)
             (if (null e)
               nil
               (if (equal (mklist (car e))
                          current)
                 e
                 (iter (cdr e))))))
    (iter all)))
