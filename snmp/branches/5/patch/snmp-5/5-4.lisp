(in-package :snmp-system)

(defun mklist (obj)
  (if (listp obj) obj (list obj)))

(export 'mklist)

(in-package :snmp)

(defparameter *version* 5.4)

(eval-when (:load-toplevel :execute)
  (assert (>= asn.1::*version* 4.5)))
