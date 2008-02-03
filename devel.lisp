(in-package :snmp)

(defun update-syntax (&optional (zb *asn.1-source*) (tab *asn.1-syntax*))
  (let ((*warn-conflicts* t)
        (*allow-conflicts* t))
    (zebu-compile-file zb :output-file tab)
    (zebu-load-file tab)))
