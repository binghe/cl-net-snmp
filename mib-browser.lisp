(in-package :snmp)

(defvar *nodes* nil)

(defun children-function (x)
  (let ((children (tree-nodes x)))
    (and children children)))

(defun print-child (x)
  (when x
    (let ((name (car (tree-name x)))
          (id (car (tree-id x))))
      (format nil "~A(~D)" name id))))

(defclass mib-browser-node (capi:expandable-item-pinboard-object)
  ()
  (:default-initargs))

(capi:define-interface mib-browser ()
  ()
  (:panes
   (mib-graph capi:graph-pane
              :node-pinboard-class 'mib-browser-node
              :children-function 'children-function
              :print-function 'print-child
              :reader mib-browser-mib-graph
              :roots (tree-nodes *mib-tree*)
              :callback-type :interface-data
              :selection-callback 'display-graph-selection
              :visible-min-height 300)
   (search capi:text-input-pane
           :title "Search:"
           :text "system"
           :callback 'search-callback
           :buttons (list :ok t)
           :callback-type :interface-data
           :visible-min-width '(:character 10))
   (title-pane-name capi:title-pane :text "Name (OID):")
   (display-pane-name capi:display-pane))
  (:layouts
   (main-layout capi:column-layout
                '(head-layout mib-graph))
   (head-layout capi:row-layout
                '(search title-pane-name display-pane-name)
                :y-adjust :center))
  (:default-initargs
   :layout 'main-layout
   :title "MIB Browser"
   :best-width 800
   :best-height 600))

(defmethod capi:interface-display :before ((self mib-browser))
  (let ((g (mib-browser-mib-graph self))
        (start-node (gethash "internet" *mib-index*)))
    (setf (capi:choice-selected-item g) start-node
          *nodes* (capi:graph-pane-nodes g))
    (display-graph-selection self start-node)))

(defun display-graph-selection (self data)
  (let ((name (reverse (tree-name data)))
        (oid (reverse (tree-id data))))
    (with-slots (display-pane-name) self
      (setf (capi:display-pane-text display-pane-name)
            (format nil "~A~{.~A~} (~A~{.~A~})"
                    (car name) (cdr name)
                    (car oid) (cdr oid))))))

(defun search-callback (interface data)
  (let ((g (mib-browser-mib-graph interface))
        (current-node (gethash data *mib-index*)))
    (when current-node
      (setf (capi:choice-selected-item g) current-node)
      (display-graph-selection interface current-node))))

(defun mib-browser ()
  (capi:display (make-instance 'mib-browser)))
