(in-package :cl-user)

(load-all-patches)

;;; Where we are going to deliver the image. 

(defvar *delivered-image-name* "~/mibrowser")

;;; Load the "application". 

(clc:clc-require :net-snmp)

;;(defun main ()
;;  (princ
;;   (snmp:snmp-walk "localhost" "system")))

;;(compile 'main)

;;(mib:browser)

;; Deliver.

(deliver 'mib:browser *delivered-image-name* 5 :interface :capi)
