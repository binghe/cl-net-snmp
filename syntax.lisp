(in-package :snmp)

(defvar *asn.1-syntax-source*
  (merge-pathnames
   (make-pathname :name "asn.1" :type "zb"
		  :directory '(:relative "asn.1"))
   (asdf:component-pathname (asdf:find-system :snmp))))

(defparameter *asn.1-syntax*
  (merge-pathnames
   (make-pathname :name "asn.1" :type "tab"
		  :directory '(:relative "asn.1"))
   (asdf:component-pathname (asdf:find-system :snmp))))

(defun generate-print-function (item stream level)
  (declare (ignore item level))
  (format stream "<GPF>"))

(eval-when (:load-toplevel :execute)
  (zebu-load-file *asn.1-syntax*))
