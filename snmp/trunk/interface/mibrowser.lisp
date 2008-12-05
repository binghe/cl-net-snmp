;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp-ui)

(defvar *default-enabled-modules* '(asn.1::|SNMPv2-SMI|))
(defvar *mibrowser-nodes* nil)
(defvar *switched-modules* nil)
(defvar *enabled-modules*)

(defun make-switched-modules ()
  (setf *switched-modules* (copy-list asn.1::*mib-modules*)
        *enabled-modules*  (copy-list *default-enabled-modules*))
  (delete 'asn.1::|SNMPv2-SMI| *switched-modules*)
  (sort *switched-modules*
        #'(lambda (a b) (string< (symbol-name a)
                                 (symbol-name b)))))

(defun children-function (x)
  (let ((children (mapcar #'(lambda (x) (if (slot-boundp x 'asn.1::name) x nil))
                          (asn.1::list-children x))))
    (sort (delete-if-not #'(lambda (x)
                             (or (not (asn.1::oid-module-p x))
                                 (member (asn.1::oid-module x) *enabled-modules*)))
                         (delete nil children))
          #'(lambda (a b) (< (oid-value a) (oid-value b))))))

(defun print-child (x)
  (when x
    (let ((name (if (slot-boundp x 'asn.1::name) (oid-name x) nil))
          (value (oid-value x)))
      (if name
          (format nil "~A (~D)" name value)
        (format nil "~D" value)))))

(defun display-graph-selection (interface data)
  (with-slots (display oid-type oid-syntax oid-max-access oid-status) interface
    (capi:with-atomic-redisplay ()
      (setf (capi:display-pane-text display)
            (format nil "~{.~A~} (~{.~D~})"
                    (oid-name-list data) (oid-number-list data)))
      (setf (capi:display-pane-text oid-type)
            (if (slot-boundp data 'asn.1::type)
                (format nil "~A" (asn.1::oid-type data)))
            (capi:display-pane-text oid-syntax)
            (if (slot-boundp data 'asn.1::syntax)
                (format nil "~A" (asn.1::oid-syntax data)))
            (capi:display-pane-text oid-max-access)
            (if (slot-boundp data 'asn.1::max-access)
                (format nil "~A" (asn.1::oid-max-access data)))
            (capi:display-pane-text oid-status)
            (if (slot-boundp data 'asn.1::status)
                (format nil "~A" (asn.1::oid-status data)))))))

(defun search-callback (interface data)
  (let ((g (mibrowser-mib-graph interface))
        (current-node (oid data)))
    (when current-node
      (capi:with-atomic-redisplay ()
        (setf (capi:text-input-pane-text (mibrowser-search interface))
              (oid-name current-node))
        (capi:apply-in-pane-process g #'(setf capi:choice-selected-item)
                                    current-node g)
        (display-graph-selection interface current-node)))))

(defclass mibrowser-node (capi:expandable-item-pinboard-object)
  ()
  (:default-initargs))

(defun module-select (interface data)
  (pushnew data *enabled-modules*)
  (setf (capi:graph-pane-roots (mibrowser-mib-graph interface))
        (children-function asn.1::*root-object-id*)))

(defun module-retract (interface data)
  (setf *enabled-modules* (delete data *enabled-modules*))
  (setf (capi:graph-pane-roots (mibrowser-mib-graph interface))
        (children-function asn.1::*root-object-id*)))

(capi:define-interface mibrowser (#+ignore capi:cocoa-default-application-interface)
  ()
  (:panes
   (mib-graph capi:graph-pane
              :node-pinboard-class 'mibrowser-node
              :children-function 'children-function
              :print-function 'print-child
              :reader mibrowser-mib-graph
              :roots (children-function asn.1::*root-object-id*)
              :callback-type :interface-data
              :selection-callback 'display-graph-selection
              :visible-min-height 300)
   (search capi:text-input-pane
           :reader mibrowser-search
           :title "Search:"
           :text "iso"
           :callback 'search-callback
           :buttons (list :ok t)
           :callback-type :interface-data
           :visible-min-width '(:character 10))
   (title capi:title-pane :text "Object: ")
   (display capi:display-pane)
   (module-list capi:list-panel
                :items *switched-modules*
                :interaction :multiple-selection
                :visible-max-width '(:character 20)
                :callback-type :interface-data
                :selection-callback 'module-select
                :retract-callback 'module-retract)
   (oid-type-label capi:title-pane :text "Type: ")
   (oid-type capi:display-pane :visible-min-width '(:character 20))
   (oid-syntax-label capi:title-pane :text "Syntax: ")
   (oid-syntax capi:display-pane :visible-min-width '(:character 20))
   (oid-max-access-label capi:title-pane :text "Max Access: ")
   (oid-max-access capi:display-pane :visible-min-width '(:character 20))
   (oid-status-label capi:title-pane :text "Status: ")
   (oid-status capi:display-pane :visible-min-width '(:character 20)))
  (:layouts
   (mibrowser-layout capi:column-layout '(head-layout main-layout))
   (head-layout capi:row-layout '(search title display)
                :y-adjust :center)
   (main-layout capi:row-layout '(module-list :divider mib-graph-and-oid))
   (mib-graph-and-oid capi:column-layout '(mib-graph oid-layout))
   (oid-layout capi:grid-layout '(oid-type-label oid-type
                                  oid-syntax-label oid-syntax
                                  oid-max-access-label oid-max-access
                                  oid-status-label oid-status)
               :y-adjust :center
               :columns 4))
  (:menu-bar #+ignore application-menu file help)
  (:menus (file "File" (("Quit" :selection-callback 'lw:quit
                                :callback-type :none)))
          (help "Help" (("About" :selection-callback 'mibrowser-about
                                 :callback-type :none)))
          #+ignore
          (application-menu "MIB Browser"
                            ((:component
                              (("About MIB Browser"
                                :callback 'mibrowser-about
                                :callback-type :none))))))
  (:default-initargs
   #+ignore :application-menu
   #+ignore 'application-menu
   :layout 'mibrowser-layout
   :best-width 800
   :best-height 600
   :title "MIB Browser"))

(defun mibrowser-about ()
  (capi:display-message-on-screen
   (capi:convert-to-screen nil)
   "MIB Browser by Chun Tian (binghe) <binghe.lisp@gmail.com>
Copyright 2008."))

(defmethod capi:interface-display :before ((self mibrowser))
  (let ((g (mibrowser-mib-graph self))
        (start-node asn.1::|iso|))
    (setf *mibrowser-nodes* (capi:graph-pane-nodes g))
    (display-graph-selection self start-node)))

(defun mibrowser ()
  (make-switched-modules)
  (capi:display (make-instance 'mibrowser)))
