;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(load-all-patches)

#+linux
(require "capi-ps-lib")

;;; Load the "application".
(load *init-file-name*)

;;; Load SNMP Package
(asdf:load-system :snmp-ui)

(defvar *mib-packages*
  (mapcar #'(lambda (x)
              (find-package (symbol-name x)))
          asn.1:*mib-modules*))

;;; Deliver the MIB Browser
(deliver 'snmp-ui:mibrowser #p"SNMP:DIST;MIBROWSER.EXE" 4
         :interface :capi
         :keep-pretty-printer t
         :kill-dspec-table nil
         :keep-eval t
         :packages-to-keep-symbol-names (cons (find-package :asn.1)
                                              *mib-packages*)
         :keep-symbol-names '(capi:graph-pane
                              capi:text-input-pane
                              capi:display-pane
                              snmp-ui:mibrowser))
