;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(load-all-patches)

#-cocoa
(require "capi-ps-lib")

;;; Load the "application".
(load *init-file-name*)

;;; Load SNMP Package
(asdf:setup :snmp)

;;; Where we are going to deliver the image. 
(defvar *delivered-image-name* #p"SNMP:DIST;MIBROWSER.BIN")

;;; Deliver.
(deliver 'asn.1:mibrowser *delivered-image-name* 5
         :interface :capi
         :keep-pretty-printer t
         :keep-symbol-names '(capi:graph-pane
                              capi:text-input-pane
                              capi:display-pane
                              asn.1:mibrowser))
