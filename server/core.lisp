;;;; $Id$

(in-package :snmp)

(defvar *snmp-server-contact* "Chun Tian (binghe) <binghe.lisp@gmail.com>")

;;; system tree
(def-scalar-variable "sysDescr" (agent)
  (format nil "~A ~A"
          (lisp-implementation-type) (lisp-implementation-version)))

(def-scalar-variable "sysUpTimeInstance" (agent)
  (make-timeticks (truncate (* #.(/ 100 internal-time-units-per-second)
                               (- (get-internal-real-time)
                                  (slot-value agent 'start-up-time))))))

(def-scalar-variable "sysContact" (agent)
  *snmp-server-contact*)

(def-scalar-variable "sysName" (agent)
  (long-site-name))

(def-scalar-variable "sysLocation" (agent)
  (machine-instance))

(def-scalar-variable "sysORLastChange" (agent)
  (make-timeticks 0))

;;; |sysORID|, |sysORDescr|, |sysORUpTime| from 1 to 9 is not implemented.
