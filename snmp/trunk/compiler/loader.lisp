;;;; -*- Mode: Lisp -*-
;;;; $Id: loader.lisp 838 2011-03-14 17:45:50Z binghe $

(in-package :asn.1)

(defgeneric load-asn.1 (object))

(defmethod load-asn.1 ((file pathname))
  (load-asn.1 (parse file)))

(defmethod load-asn.1 ((file string))
  (load-asn.1 (parse file)))

(defmethod load-asn.1 ((rtl list))
  (if (atom rtl)
      rtl
    (load-asn.1-internal (car rtl) (cdr rtl))))

(defgeneric load-asn.1-internal (type rtl))

(defmethod load-asn.1-internal ((type symbol) (rtl list))
  "default entry, do nothing"
  (values type rtl))

(defvar *current-package*)

;;; finished
(defmethod load-asn.1-internal ((type (eql :module)) (rtl list))
  (destructuring-bind (module-name xxx) rtl
    (let ((long-package-name (module->package module-name))
          #+snmp-system::short-name
          (short-package-name (intern (symbol-name module-name) :keyword)))
      (unless (null xxx)
        (destructuring-bind ((exports imports) body) xxx
          (declare (ignore exports)) ; SNMP don't care exports
          (let ((*current-package* (or (find-package long-package-name)
                                       (make-package long-package-name
                                                     #+snmp-system::short-name
                                                     #+snmp-system::short-name
                                                     :nicknames (list short-package-name)
                                                     :use '(:common-lisp :asn.1))))
                (*current-module* module-name))
            ;; import symbols
            (when imports
              (load-asn.1-internal (car imports) (cdr imports)))
            ;; interpret assignments
            (when body
              (dolist (i body type)
                (load-asn.1-internal (car i) (cdr i))))
            (pushnew *current-module* *mib-modules*)))))))

;;; finished
(defmethod load-asn.1-internal ((type (eql :import)) (rtl list))
  (dolist (item rtl type)
    (destructuring-bind (symbols from module) item
      (assert (eq from :from))
      (when module
        (let ((package (module->package module)))
          (import (mapcar #'(lambda (symbol)
                              (intern (symbol-name symbol)
                                      (or (find-package (symbol-name package))
                                          (error "Cannot find depended module ~A" (symbol-name module)))))
                          symbols)
                  *current-package*))))))

(defmethod load-asn.1-internal ((type (eql :type-assignment)) (rtl list))
  (values (load-ta (car rtl) (cdr rtl)) type))

(defmethod load-asn.1-internal ((type (eql :value-assignment)) (rtl list))
  (values (load-va (car rtl) (cdr rtl)) type))

(defmethod load-asn.1-internal ((type (eql :define)) (rtl list))
  (values (load-df (car rtl) (cdr rtl)) type))

(defun normalized-name (thing)
  (typecase thing
    (integer (when (zerop thing) '|zero|))
    (list    (normalized-name (car thing)))
    (symbol  (intern (symbol-name thing) *current-package*))))

(defun load-object-id (name value parent &rest keyword-arguments)
  #+development
  (format *debug-io* "Load OID: ~A~%" name)
  (let ((oid-symbol (normalized-name name))
        (parent-oid (oid (normalized-name parent))))
    (setf (symbol-value oid-symbol)
          (or (ensure-oid parent-oid value)
              (apply #'make-instance 'object-id
                     :name oid-symbol
                     :value value
                     :parent parent-oid
                     :module *current-module*
                     keyword-arguments)))
    (register-oid (symbol-name oid-symbol) oid-symbol)
    oid-symbol))

(defgeneric load-va (type rtl)
  (:documentation "load a value assignment"))

(defmethod load-va ((type symbol) (rtl list))
  "default entry, do nothing"
  (values type rtl))

(defmethod load-va ((type (eql :object-identifier)) (rtl list))
  (destructuring-bind ((name value)) rtl
    (setf value (last value 2))
    (destructuring-bind (parent value) value
      (values type (load-object-id name value parent)))))

(defgeneric load-ta (name type)
  (:documentation "load a type assignment"))

(defmethod load-ta ((name symbol) (type list))
  (declare (ignore type))
  (intern (symbol-name name) *current-package*))

(defgeneric load-df (type rtl)
  (:documentation "load a general definition"))

(defmethod load-df ((type symbol) (rtl list))
  (destructuring-bind ((name options) (parent value)) rtl
    (let ((keyword-arguments (reduce #'append (compile-df-options options))))
      (values type
              (apply #'load-object-id name value parent keyword-arguments)))))
