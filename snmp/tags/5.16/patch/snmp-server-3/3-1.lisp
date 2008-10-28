;;; Bugfix in FIND-FIRST: it's argument (OID) maybe NIL when the whole MIB tree is end.

(in-package :snmp)

(defparameter *server-version* 3.1)

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
