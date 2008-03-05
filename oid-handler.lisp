(in-package :snmp)

;;; iso.org.dod.internet.mgmt.mib-2.system (1.3.6.1.2.1.1)

(defoid "sysDescr.0" (o)
  "iso.org.dod.internet.mgmt.mib-2.system.sysDescr (1.3.6.1.2.1.1.1)"
  (declare (ignore o))
  (format nil "~A ~A" (lisp-implementation-type) (lisp-implementation-version)))

(defoid "sysContact.0" (o)
  "iso.org.dod.internet.mgmt.mib-2.system.sysContact (1.3.6.1.2.1.1.4)"
  (declare (ignore o))
  #+lispworks lispworks:*phone-home*
  #-lispworks "unknown")

(defoid "sysName.0" (o)
  "iso.org.dod.internet.mgmt.mib-2.system.sysName (1.3.6.1.2.1.1.5)"
  (declare (ignore o))
  (long-site-name))

(defoid "sysLocation.0" (o)
  "iso.org.dod.internet.mgmt.mib-2.system.sysLocation (1.3.6.1.2.1.1.6)
   We define it to `the host machine of lisp image'"
  (declare (ignore o))
  (format nil "~A ~A ~A" (machine-instance) (machine-type) (machine-version)))

(defoid "system" (o)
  "xxx")
