(in-package :snmp)

(defparameter *asn.1-source* #p"snmp:asn1;asn1.zb")
(defparameter *asn.1-syntax* #p"snmp:asn1;asn1.tab")

(defun generate-print-function (item stream level)
  (declare (ignore item level))
  (format stream "<GPF>"))

(eval-when (:load-toplevel :execute)
  (zebu-load-file *asn.1-syntax*))
