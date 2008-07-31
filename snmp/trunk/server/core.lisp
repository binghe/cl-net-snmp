;;;; $Id$

(in-package :snmp)

(defvar *snmp-server-contact* "Chun Tian (binghe) <binghe.lisp@gmail.com>")

;;; system tree
(def-scalar-variable "sysDescr" (o)
  (format nil "~A ~A"
          (lisp-implementation-type) (lisp-implementation-version)))

(def-scalar-variable "sysContact" (o)
  *snmp-server-contact*)

(def-scalar-variable "sysName" (o)
  (long-site-name))

(def-scalar-variable "sysLocation" (o)
  (machine-instance))

(def-scalar-variable "sysORLastChange" (o)
  (timeticks 0))

;;; |sysORID|, |sysORDescr|, |sysORUpTime| from 1 to 9 is not implemented.
