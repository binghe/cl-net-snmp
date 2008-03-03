(in-package :snmp)

(define-oid-handler (o '(1 1 2 1 6 3 1))
  "iso.org.dod.internet.mgmt.mib-2.system (1.3.6.1.2.1.1)"
  (declare (ignore o))
  (lisp-implementation-type))
