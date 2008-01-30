(in-package :snmp)

(defun update-syntax (&optional (zb *asn.1-syntax-source*) (tab *asn.1-syntax*))
  (let ((*warn-conflicts* t)
        (*allow-conflicts* t))
    (zebu-compile-file zb :output-file tab)
    (zebu-load-file tab)))

;;(eval-when (:load-toplevel :execute)
;;  (update-syntax))
