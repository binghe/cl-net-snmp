;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

(defun htable-keys (htable)
  (declare (type hash-table htable))
  (let (keys)
    (maphash #'(lambda (k v)
                 (declare (ignore v))
                 (push k keys))
             htable)
    keys))

(defun oid-next-in (oid)
  (declare (type object-id oid))
  (let ((children (oid-children oid)))
    (if (zerop (hash-table-count children))
        ;; zero children, go next sibling
        (if (oid-parent-p oid)
            ;; has parent, so we walk to next sibling
            (let* ((parent (oid-parent oid))
                   (sibling (oid-children parent))
                   (broders (remove-if #'(lambda (x) (<= x (oid-value oid)))
                                       (htable-keys sibling))))
              (if broders
                  ;; have broders, choose smallest one
                  (values (gethash (apply #'min broders) sibling) t)
                  ;; single child and it's me...
                  (values parent nil))) ; return parent
            ;; no parent? just return nil.
            (values nil nil))
        ;; or, go into first (min number) child.
        (values (gethash (apply #'min (htable-keys children)) children)
                t))))

(defun oid-next-out (oid)
  (declare (type object-id oid))
  (if (oid-parent-p oid) ; has parent
      (let* ((parent (oid-parent oid))
             (sibling (oid-children parent))
             (broders (remove-if #'(lambda (x) (<= x (oid-value oid)))
                                 (htable-keys sibling))))
        (if broders ;; if have broders call oid-next-in.
            (values (gethash (apply #'min broders) sibling) t)
            (values parent nil)))
      (values nil nil)))

(defun oid-next (oid)
  (declare (type object-id oid))
  (labels ((iter (current flag)
             (when current
               (multiple-value-bind (next new-flag)
                   (funcall (if flag #'oid-next-in #'oid-next-out) current)
                 (if new-flag
                     next
                   (iter next new-flag))))))
    (iter oid t)))

(defun oid-walk (oid oper)
  (declare (type object-id oid))
  (labels ((iter (current)
             (let ((next (oid-next current)))
               (when (oid-< next oid)
                 (funcall oper next)
                 (iter next)))))
    (iter oid)))

(defgeneric oid-scalar-variable-p (oid)
  (:documentation "Upgraded to generic function"))

(defmethod oid-scalar-variable-p ((oid object-id))
  (and (zerop (oid-value oid))
       (oid-parent-p oid)
       (slot-boundp (oid-parent oid) 'name)))

(defmethod oid-scalar-variable-p ((oid simple-oid))
  (equal (nthcdr (oid-length (oid-parent oid))
                 (oid-number-list oid))
         '(0)))

(defgeneric oid-leaf-p (oid)
  (:method ((oid object-id))
   (and (slot-boundp oid 'name)
        (zerop (hash-table-count (oid-children oid)))))
  (:method ((oid simple-oid))
   nil))

(defgeneric oid-trunk-p (oid)
  (:method ((oid object-id))
   (and (slot-boundp oid 'name)
        (plusp (hash-table-count (oid-children oid)))))
  (:method ((oid simple-oid))
   nil))

(defun oid-find-base (oid)
  (labels ((iter (o acc)
             (typecase o
               (null (values nil acc))
               (object-id
                (if (slot-boundp o 'name)
                    (values o acc)
                  (let ((p (oid-parent o))
                        (v (oid-value o)))
                    (iter p (cons v acc)))))
               (simple-oid
                (iter (when (oid-parent-p o) (oid-parent o))
                      (append (oid-number-sublist o) acc))))))
    (iter oid nil)))

(defun oid-find-leaf (oid)
  "Find the leaf node in a oid's all parents"
  (declare (type object-id oid))
  (unless (oid-trunk-p oid)
    (labels ((iter (o acc)
               (if (slot-boundp o 'name)
                 (values o acc)
                 (let ((p (oid-parent o))
                       (v (oid-value o)))
                   (iter p (cons v acc))))))
      (iter oid nil))))

(defmethod print-object ((object object-id) stream)
  (print-unreadable-object (object stream :type t)
    (cond ((and (slot-boundp object 'name)
                (slot-boundp object 'value))
           (if (slot-boundp object 'module)
             (format stream "~A::" (oid-module object)))
           (format stream "~A (~D) [~D]"
                   (oid-name object)
                   (oid-value object)
                   (hash-table-count (oid-children object))))
          ((slot-boundp object 'value)
           (multiple-value-bind (base-oid others) (oid-find-leaf object)
             (if (slot-boundp base-oid 'module)
               (format stream "~A::" (oid-module base-oid)))
             (format stream "~A~{.~A~}" (oid-name base-oid) others)))
          (t (format stream ".")))))

(defmethod print-object ((object simple-oid) stream)
  (print-unreadable-object (object stream :type t)
    (if (oid-parent-p object)
      (let ((p (oid-parent object)))
        (when (and (slot-boundp p 'name)
                   (slot-boundp p 'value))
          (when (slot-boundp p 'module)
            (format stream "~A::" (oid-module p)))
          (format stream "~A" (oid-name p))
          (format stream "~{.~D~}" (nthcdr (oid-length p) (oid-number-list object)))))
      (format stream "~{.~D~}"
              (oid-number-list object)))))
