(in-package :snmp)

(defparameter *mib-list*
  '("SNMPv2-SMI"
    "SNMPv2-MIB"))

(defun update-mib ()
  (dolist (i *mib-list* t)
    (let ((mib-file (merge-pathnames (make-pathname :name i)
                                     #p"MIB:"))
          (lisp-file (merge-pathnames (make-pathname :name i
                                                     :type "LISP"
                                                     :directory '(:relative "mib"))
                                      #p"SNMP:")))
      (compile-asn.1 mib-file :to lisp-file))))
