;;;; Patch 3.5: use ASN.1's new OID-FIND-LEAF instead of FIND-LEAF

(in-package :snmp)

(assert (>= asn.1::*version* 4.7))

(fmakunbound 'find-leaf)
(unintern 'find-leaf)

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
          (t (multiple-value-bind (leaf ids) (oid-find-leaf oid)
               (if leaf
                 (let ((handler (gethash leaf dispatch-table)))
                   (if handler
                     (list oid (funcall handler *server* ids))))
                 (list oid :no-such-instance)))))))
