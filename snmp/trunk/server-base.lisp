;;;; $Id$

(in-package :snmp)

(defmacro def-scalar-variable (oid (arg) &body body)
  (let* ((name (symbol-name oid))
         (symbol (intern name (find-package :asn.1))))
    `(progn
       (defun ,symbol (,arg) (declare (ignorable ,arg)) ,@body)
       (setf (gethash (oid ,name) *default-dispatch-table*)
             #',symbol))))

(defmacro def-listy-mib-table (table-oid &rest keys)
  `(def-list-based-mib-table ,table-oid (,(gensym)) ,@keys))

(defmacro def-list-based-mib-table (table-oid (arg) &rest keys)
  (let ((list-form (cdr (assoc :list keys)))
	(entry-oid (cdr (assoc :entry keys)))
	(index-function (cadr (assoc :index keys)))
	(test-if (cdr (assoc :test-if keys)))
	(test-if-not (cdr (assoc :test-if-not keys)))
	(key-fn (or (cdr (assoc :key keys)) #'identity)))
    (declare (type (or null (function (t) t))
		   test-if
		   test-if-not
		   key-fn))
    ))
