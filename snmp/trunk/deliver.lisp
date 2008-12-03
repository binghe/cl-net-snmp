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
(deliver 'asn.1:mibrowser #p"SNMP:DIST;MIBROWSER.EXE" 5
         :interface :capi
         :keep-pretty-printer t
         :kill-dspec-table nil
         :packages-to-keep-symbol-names '(asn.1)
         :keep-symbol-names '(capi:graph-pane
                              capi:text-input-pane
                              capi:display-pane
                              asn.1:mibrowser))
