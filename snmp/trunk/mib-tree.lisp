;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; MIB Base Support ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :snmp)

#|
MIB Tree Structure:

((NIL NIL NIL)
 (((1) ("iso") #<OBJECT-ID 1 {iso}>)
  (((3 1) ("org" "iso") #<OBJECT-ID 1.3 {iso.org}>)
   (((6 3 1) ("dod" "org" "iso") #<OBJECT-ID 1.3.6 {iso.org.dod}>)))))
|#

;;; Tree        -> ( Tree-Data . Tree-Nodes )
;;; Tree-Data   -> ( Tree-ID Tree-Name Tree-Object )
;;; Tree-ID     -> ( number . Tree-ID )
;;; Tree-Name   -> ( string . Tree-Name )
;;; Tree-Object -> Object-ID [ ID-List Name-List ]

(defvar *mib-tree*) ;; empty tree
(defvar *mib-index*)

(defun tree-data (node) (car node))
(defun tree-nodes (node) (cdr node))
(defun tree-id (node) (first (tree-data node)))
(defun tree-name (node) (second (tree-data node)))
(defun tree-object (node) (third (tree-data node)))

(defgeneric insert-node (parent id name))

(defmethod insert-node ((parent-name string) id name)
  (let ((node (gethash parent-name *mib-index*)))
    (when node
      (insert-node node id name))))

(defmethod insert-node ((parent-node list) id name)
  (unless (find-if #'(lambda (x) (= id (car (tree-id x))))
                   (tree-nodes parent-node))
    (let ((tree-id (cons id (tree-id parent-node)))
          (tree-name (cons name (tree-name parent-node))))
      (let ((tree-object
	     (make-instance 'object-id :id tree-id :name tree-name)))
        (let ((tree-data (list tree-id tree-name tree-object)))
          (let ((tree-node (cons tree-data nil)))
            (progn
              (unless (gethash name *mib-index*)
                (setf (gethash name *mib-index*) tree-node))
              (nconc parent-node (cons tree-node nil)))))))))

(defgeneric tree-node (id &optional node))

(defmethod tree-node ((id integer) &optional (node *mib-tree*))
  (find-if #'(lambda (x) (= id (car (tree-id x))))
           (tree-nodes node)))

(defmethod tree-node ((id list) &optional (node *mib-tree*))
  (labels ((iter (id-list node)
             (if (endp id-list)
               (values node nil)
               (let ((next (tree-node (car id-list) node)))
                 (if next
                   (iter (cdr id-list) next)
                   (values node id-list))))))
    (iter id node)))

(defmethod tree-node ((id string) &optional (node *mib-tree*))
  (declare (ignore node))
  (gethash id *mib-index*))

(defgeneric resolve (object))

(defmethod resolve ((name list))
  (multiple-value-bind (r v) (tree-node name)
    (if v
      (append (reverse (tree-name (tree-node
                                   (reverse (nthcdr (list-length r) (reverse name)))))) v)
      (reverse (tree-name r)))))

(defmethod resolve ((name string))
  (let ((names #+lispworks (lw:split-sequence "." name)
               #-lispworks (split-sequence:split-sequence #\. name)))
    (cond ((gethash (first names) *mib-index*)
           (make-instance 'object-id :id (nconc (reverse (mapcar #'parse-integer (cdr names)))
                                                (tree-id (gethash (first names) *mib-index*)))))
          ((= (list-length names) 1) (resolve "zeroDotZero"))
          ;; pure number id
          (t (progn (when (string= "" (first names)) ;; ".1.3.6"
                      (setf names (cdr names)))
               (multiple-value-bind (base-id others) (tree-node (mapcar #'parse-integer names))
                 (if (null others)
                   base-id
                   (make-instance 'object-id :id (nconc (reverse others)
                                                        (tree-id base-id))))))))))

(defun parse-mib (file &key (verbose nil))
  (let ((*comment-start* "--")
        (*comment-brackets* '(("/*" . "*/")))
        (*preserve-case* t))
    (file-parser file :grammar (find-grammar "ASN.1") :verbose verbose)))

(defun kb-sequence->list (kseq)
  (labels ((iter (kb-seq acc)
             (if (null (kb-sequence-rest kb-seq))
                 (nreverse (cons (kb-sequence-first kb-seq) acc))
               (iter (kb-sequence-rest kb-seq)
                     (cons (kb-sequence-first kb-seq) acc)))))
    (iter kseq nil)))

(defun test-syntax (name)
  (parse-mib (merge-pathnames
              (make-pathname :name name :type "asn"
                             :directory '(:relative "asn.1" "test"))
              (asdf:component-pathname (asdf:find-system :net-snmp)))))

(defun reset-tree ()
  (setf *mib-tree* (list (list nil nil nil)))
  (setf *mib-index* (make-hash-table :test #'equal))
  (insert-node *mib-tree* 0 "zero")
  (insert-node *mib-tree* 1 "iso")
  (values *mib-tree* *mib-index*))

(eval-when (:load-toplevel :execute)
  (reset-tree))

(defmethod *->oid ((x string)) (resolve x))
