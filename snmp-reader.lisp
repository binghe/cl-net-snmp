;;;; $Id$

(in-package :snmp)

(defvar *snmp-readtable* (copy-readtable nil))

(defun oid-reader (stream char)
  (declare (ignore char))
  (let* ((*package* (find-package :asn.1))
         (tokens-list
          (loop for i = (read-char stream nil #\] t)
                until (char= i #\])
                collect i)))
    (oid (coerce tokens-list 'string))))

(eval-when (:load-toplevel :execute)
  (set-macro-character #\] (get-macro-character #\)) nil *snmp-readtable*)
  (set-macro-character #\[ #'oid-reader nil *snmp-readtable*))
