(in-package :snmp)

(defparameter *asn.1-source* #p"snmp:asn1;asn1.zb")
(defparameter *asn.1-syntax* #p"snmp:asn1;asn1.tab")

(defun generate-print-function (item stream level)
  (declare (ignore item level))
  (format stream "<GPF>"))

(defun update-syntax (&optional (zb *asn.1-source*) (tab *asn.1-syntax*))
  (let ((*warn-conflicts* t)
        (*allow-conflicts* t))
    (zebu-compile-file zb :output-file tab)
    (zebu-load-file tab)))

(eval-when (:load-toplevel :execute)
  (update-syntax))
