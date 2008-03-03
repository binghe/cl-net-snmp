(in-package :cl-user)

(load-all-patches)

#-cocoa
(require "capi-ps-lib")

;;; Where we are going to deliver the image. 
(defvar *delivered-image-name* "~/snmp-utility")

;;; Load the "application".
(load "~/.lispworks")
(asdf:setup 'snmp)


;;; Deliver.
(deliver 'snmp:snmp-utility *delivered-image-name* 5
         :interface :capi
         :keep-pretty-printer t
         :keep-symbol-names '(capi:graph-pane
                              capi:editor-pane
                              capi:display-pane
                              snmp:snmp-utility))
