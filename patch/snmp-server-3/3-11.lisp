;;;; Patch 3.11: SNMP Server GET-PDU fix

(in-package :snmp)

(defmethod process-object-id ((oid object-id) (flag (eql :get)))
  (let ((dispatch-table (server-dispatch-table *server*)))
    (cond ((oid-scalar-variable-p oid)
           (let ((handler (gethash (oid-parent oid) dispatch-table)))
             (if handler
               (list oid (funcall handler *server* t))
               (list oid (smi :no-such-object)))))
          ((oid-trunk-p oid)
           (list oid (smi :no-such-object))) ; no value
          ((oid-leaf-p oid)
           (list oid (smi :no-such-object))) ; no value
          (t (multiple-value-bind (leaf ids) (oid-find-leaf oid)
               (if leaf
                 (let ((handler (gethash leaf dispatch-table)))
                   (if handler
                     (list oid (funcall handler *server* ids))
                     (list oid (smi :no-such-object))))
                 (list oid (smi :no-such-object))))))))

(setf *server-minor-version* 11)
