;;;; Patch 3.4: return more :no-such-instance

(in-package :snmp)

(defmethod process-object-id ((oid object-id) (flag (eql :get)))
  (let ((dispatch-table (server-dispatch-table *server*)))
    (cond ((oid-scalar-variable-p oid)
           (let ((handler (gethash (oid-parent oid) dispatch-table)))
             (if handler
               (list oid (funcall handler *server* t))
               (list oid :no-such-instance))))
          ((oid-trunk-p oid)
           (list oid :no-such-instance)) ; no value
          ((oid-leaf-p oid)
           (list oid :no-such-instance)) ; no value
          (t (multiple-value-bind (leaf ids) (find-leaf oid)
               (if leaf
                 (let ((handler (gethash leaf dispatch-table)))
                   (if handler
                     (list oid (funcall handler *server* ids))))
                 (list oid :no-such-instance)))))))
