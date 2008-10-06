(in-package :snmp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (assert (>= *version* 5.7)))

(def-listy-mib-table "lispModuleName" (agent ids)
  (let* ((modules *modules*)
         (number-of-modules (list-length modules)))
    (if (null ids)
      number-of-modules
      (when (plusp (car ids))
        (->string (nth (mod (1- (car ids)) number-of-modules)
                       modules))))))

(defparameter *server-version* 3.2)
