(in-package :cl-user)

(load-all-patches)

;;; Where we are going to deliver the image. 

(defvar *delivered-image-name* "~/mbrowse")

;;; Load the "application". 

(clc:clc-require :net-snmp)

;; Deliver.

(deliver 'mib:browser *delivered-image-name* 0 :interface :capi)
