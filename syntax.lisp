(in-package :snmp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *asn.1-source* #p"snmp:asn1;asn1.zb")
  (defparameter *asn.1-syntax* #p"snmp:asn1;asn1.tab")

  (defun generate-print-function (item stream level)
    (declare (ignore item level))
    (format stream "<GPF>")))

(defun update-syntax (&optional (zb *asn.1-source*) (tab *asn.1-syntax*))
  (let ((*warn-conflicts* t)
        (*allow-conflicts* t))
    (zebu-compile-file zb :output-file tab)
    (zebu-load-file tab)))

(eval-when (:compile-toplevel)
  (let ((*warn-conflicts* t)
        (*allow-conflicts* t))
    (zebu-compile-file *asn.1-source* :output-file *asn.1-syntax*)))

(eval-when (:load-toplevel :execute)
  (let ((*warn-conflicts* t)
        (*allow-conflicts* t))
    (zebu-load-file *asn.1-syntax*)))

