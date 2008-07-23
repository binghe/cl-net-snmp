(in-package :snmp)

;;; sysDescr
(define-object-id "sysDescr" (o)
  (format nil "~A ~A"
          (lisp-implementation-type) (lisp-implementation-version)))

;;; sysContact
(define-object-id "sysContact" (o)
  "Chun Tian (binghe) <binghe.lisp@gmail.com>")

;;; sysName
(define-object-id "sysName" (o) (long-site-name))

;;; sysLocation
(define-object-id "sysLocation" (o)
  (format nil "~A ~A ~A"
          (machine-instance) (machine-type) (machine-version)))
