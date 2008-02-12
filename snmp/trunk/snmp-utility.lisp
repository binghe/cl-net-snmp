(in-package :snmp)

(capi:define-interface snmp-utility ()
  ()
  (:layouts
   (column-layout-1
    capi:column-layout
    '(tab-layout-1))
   (tab-layout-1
    capi:tab-layout
    ()
    :items '(("Item name" snmp-get-layout-1) ("Item name" snmp-walk-layout-1))
    :print-function 'car
    :visible-child-function 'second)
   (snmp-get-layout-1
    capi:column-layout
    ())
   (snmp-walk-layout-1
    capi:column-layout
    ()))
  (:menu-bar file)
  (:menus
   (file
    "File"
    ("Quit")))
  (:default-initargs
   :layout 'column-layout-1
   :best-height 284
   :best-width 438
   :title "SNMP Utility"))

(defun snmp-utility ()
  (capi:display (make-instance 'snmp-utility)))
