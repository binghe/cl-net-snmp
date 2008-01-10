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

(require "capi-ps-lib")

(deliver 'mib:browser *delivered-image-name* 5
         :interface :capi
         :keep-symbol-names '(capi:graph-pane
                              mib:mib-browser))
