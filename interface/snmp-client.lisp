;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(capi:define-interface snmp-client (mibrowser)
  ()
  (:layouts
   (main-tab-layout capi:tab-layout ()
                    :items '(("SNMP Get" snmp-get-layout)
                             ("SNMP Walk" snmp-walk-layout)
                             ("MIB Browser" asn.1::mibrowser-layout))
                    :print-function 'first
                    :visible-child-function 'second)
   (snmp-get-layout capi:column-layout ())
   (snmp-walk-layout capi:column-layout ()))
  (:default-initargs
   :layout 'main-tab-layout
   :best-width 1024
   :best-height 768
   :title "SNMP Client Utility"))

(defun snmp-client ()
  (asn.1::make-switched-modules)
  (capi:display (make-instance 'snmp-client)))
