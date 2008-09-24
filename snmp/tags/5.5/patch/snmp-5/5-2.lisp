(in-package :snmp)

(eval-when (:load-toplevel :execute)
  (delete-object (oid "lispFeatures"))
  (makunbound 'asn.1::|lispFeatures|))
