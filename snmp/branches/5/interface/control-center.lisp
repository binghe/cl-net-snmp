;;;; $Id$

(in-package :snmp)

(capi:define-interface snmp-control-center ()
  ()
  (:layouts
   (main-layout capi:row-layout ()))
  (:default-initargs
   :layout 'main-layout
   :best-width 800
   :best-height 200
   :title "SNMP Control Center"))

(defun control-center ()
  (capi:display (make-instance 'snmp-control-center)))
