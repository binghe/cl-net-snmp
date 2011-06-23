;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(load-all-patches)

#+linux
(require "capi-ps-lib")

#+:cocoa
(compile-file-if-needed
  (sys:example-file "configuration/macos-application-bundle")
                   :load t)

;;; Load the "application".
(load *init-file-name*)

;;; Load SNMP Package
(asdf:load-system :snmp-ui)

(defvar *mib-packages*
  (mapcar #'(lambda (x)
              (find-package (symbol-name x)))
          asn.1:*mib-modules*))

;;; Deliver the MIB Browser
(deliver 'snmp-ui:mibrowser
         #+mswindows #p"SNMP:DIST;MIBROWSER.EXE"
         #+linux #p"SNMP:DIST;MIBROWSER"
         #+cocoa (write-macos-application-bundle
                  (make-pathname :name "MIB Browser"
                                 :defaults (translate-logical-pathname #p"SNMP:DIST;"))
                  :executable-name "mibrowser"
                  :version "6.0"
                  :application-icns #p"SNMP:INTERFACE;ICONS;MIBROWSER.ICNS")
         4
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
