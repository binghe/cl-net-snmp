;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(load-all-patches)

#+linux
(require "capi-ps-lib")

;;; Load the "application".
(load *init-file-name*)

;;; Load SNMP Package
(asdf:setup :snmp)

;;; Deliver the MIB Browser
(deliver 'asn.1:mibrowser #p"SNMP:DIST;MIBROWSER.BIN" 5
         :interface :capi
         :keep-pretty-printer t
         :keep-symbol-names '(capi:graph-pane
                              capi:text-input-pane
                              capi:display-pane
                              asn.1:mibrowser))
