;;;; Patch 3.7: server-side patch after snmp-5.18

(in-package :snmp)

;;; snmp-server.lisp

(defmethod process-object-id ((oid object-id) (flag (eql :get)))
  (let ((dispatch-table (server-dispatch-table *server*)))
    (cond ((oid-scalar-variable-p oid)
           (let ((handler (gethash (oid-parent oid) dispatch-table)))
             (if handler
               (list oid (funcall handler *server* t))
               (list oid (smi :no-such-instance)))))
          ((oid-trunk-p oid)
           (list oid (smi :no-such-instance))) ; no value
          ((oid-leaf-p oid)
           (list oid (smi :no-such-instance))) ; no value
          (t (multiple-value-bind (leaf ids) (oid-find-leaf oid)
               (if leaf
                 (let ((handler (gethash leaf dispatch-table)))
                   (if handler
                     (list oid (funcall handler *server* ids))))
                 (list oid (smi :no-such-instance))))))))

;;; server-walk.lisp

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
