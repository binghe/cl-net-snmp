(in-package :snmp.system)

(defpackage mib
  (:use :common-lisp
        :asn.1 :smi :zebu)
  (:export *mib-tree* *mib-index*
           tree-id tree-name tree-object tree-node
           insert-node resolve
           reset-tree build-tree
           read-mib parse
           #+lispworks browser))

(in-package :mib)

(defparameter *version* 1)
