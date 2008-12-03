;;;; Patch 3.12

(in-package :snmp)

(def-scalar-variable "lispMachineVersion" (agent)
  (or (machine-version) ""))

(setf *server-minor-version* 12)
