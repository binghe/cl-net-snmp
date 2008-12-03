;;;; Patch 3.12

(in-package :snmp)

(def-scalar-variable "lispMachineVersion" (agent)
  (or (machine-version) ""))

(defparameter *server-major-version* 3)
(defparameter *server-minor-version* 12)
