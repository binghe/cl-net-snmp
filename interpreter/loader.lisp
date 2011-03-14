;;;; -*- Mode: Lisp -*-
;;;; $Id$

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
                (load-asn.1-internal (car i) (cdr i))))))))))

;;; finished
(defmethod load-asn.1-internal ((type (eql :import)) (rtl list))
  (dolist (item rtl type)
    (destructuring-bind (symbols from module) item
      (assert (eq from :from))
      (when module
        (let ((package (module->package real-module)))
          (import (mapcar #'(lambda (s) (intern (symbol-name s)
                                                (find-package (symbol-name package))))
                            symbols)
                  *current-package*))))))

(defmethod load-asn.1-internal ((type (eql :type-assignment)) (rtl list))
  (values (load-ta (car rtl) (cdr rtl)) type))

(defmethod load-asn.1-internal ((type (eql :value-assignment)) (rtl list))
  (values (load-va (car rtl) (cdr rtl)) type))

(defmethod load-asn.1-internal ((type (eql :define)) (rtl list))
  (values (load-df (car rtl) (cdr rtl)) type))

(defgeneric load-va (type rtl))

(defmethod load-va ((type symbol) (rtl list))
  "default entry, do nothing"
  (values type rtl))

(defmethod load-va ((type (eql :object-identifier)) (rtl list))
  (destructuring-bind ((name value)) rtl
    (setf value (last value 2))
    (destructuring-bind (parent value) value
      (if (consp parent)
          (setf parent (car parent)))
      (let ((oid-symbol (intern (symbol-name name) *current-package*))
            (parent-oid (oid (intern (symbol-name parent) *current-package*))))
        (setf (symbol-value oid-symbol)
              (or (ensure-oid parent-oid value)
                  (make-instance 'object-id
                                 :name oid-symbol
                                 :value value
                                 :parent parent-oid
                                 :module *current-module*)))
        (register-oid (symbol-name oid-symbol) oid-symbol)
        (values type oid-symbol)))))

(defgeneric load-ta (type rtl))

(defmethod load-ta ((type symbol) (rtl list))
  "default entry, do nothing"
  (values type rtl))

(defgeneric load-df (type rtl))

(defmethod load-df ((type symbol) (rtl list))
  (destructuring-bind ((name options) (parent value)) rtl
    (values type rtl)))

(defmethod load-df ((type (eql 'OBJECT-IDENTITY)) (rtl list))
  (destructuring-bind ((name options) (parent value)) rtl
    (values type rtl)))

(defmethod load-df ((type (eql 'TRAP-TYPE)) (rtl list))
  "ignored entry, do nothing"
  (values type rtl))
