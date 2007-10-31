(in-package :mib)

(defun children-function (x)
  (let ((children (tree-nodes x)))
    (and children children)))

(defun print-child (x)
  (when x
    (let ((name (car (tree-name x)))
          (id (car (tree-id x))))
      (format nil "~A(~D)" name id))))

(capi:define-interface mib-browser ()
  ()
  (:panes
   (mib-graph
    capi:graph-pane
    :children-function 'children-function
    :directed t
    :print-function 'print-child
    :reader graph-reader
    :roots (tree-nodes *mib-tree*)
    :callback-type :interface-data
    :selection-callback 'display-graph-selection)
   (title-pane-name
    capi:title-pane
    :text "Name:")
   (display-pane-name
    capi:display-pane
    :text "")
   (title-pane-oid
    capi:title-pane
    :text "OID:")
   (display-pane-oid
    capi:display-pane
    :text ""))
  (:layouts
   (main-layout
    capi:column-layout
    '(mib-graph grid-layout))
   (grid-layout
    capi:grid-layout
    '(title-pane-name display-pane-name title-pane-oid display-pane-oid)
    :y-adjust :center))
  (:default-initargs
   :best-height 768
   :best-width 1024
   :layout 'main-layout
   :title "MIB Browser"))

(defun display-graph-selection (self data)
  (let ((name (reverse (tree-name data)))
        (oid (reverse (tree-id data))))
    (with-slots (display-pane-name display-pane-oid) self
      (setf (capi:display-pane-text display-pane-name)
            (format nil "~A~{.~A~}" (car name) (cdr name))
            (capi:display-pane-text display-pane-oid)
            (format nil "~A~{.~A~}" (car oid) (cdr oid))))))

(defun browser ()
  (capi:display (make-instance 'mib-browser)))

