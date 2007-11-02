(in-package :cl-user)

(load-all-patches)

;;; Where we are going to deliver the image. 

(defvar *delivered-image-name* "/tmp/cl-snmp")

;;; Load the "application". 

(clc:clc-require :net-snmp)

(defun main ()
  (princ
   (snmp:snmp-walk "localhost" "system")))

(compile 'main)

;; Deliver.

(deliver 'main *delivered-image-name* 5)
