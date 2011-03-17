;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

(defun format-header (file stream)
  (format stream ";;;; -*- Mode: Lisp -*-~%;;;; Auto-generated from ~A by ASN.1 ~D.~D~%"
          file *major-version* *minor-version*))

(defgeneric compile-asn.1 (object &key &allow-other-keys))

(defmethod compile-asn.1 ((file t) &key to &allow-other-keys)
  (let ((result (compile-asn.1 (parse file))))
    (if (pathnamep to)
      (let ((head (merge-pathnames (make-pathname :type "lisp-expr")
                                   to))
            (*package* (find-package :asn.1))
            (*print-case* :downcase))
        (with-open-file (h head :direction :output :if-exists :supersede)
          (format-header file h)
          (pprint (car result) h)
          (terpri h))
        (with-open-file (s to :direction :output :if-exists :supersede)
          (format-header file s)
          (dolist (i (sort-definitions (cdr result)))
            (pprint i s)
            (terpri s))
          (terpri s)))
      result)))

(defmethod compile-asn.1 ((rtl list) &key &allow-other-keys)
  (if (atom rtl)
      rtl
    (compile-asn.1-internal (car rtl) (cdr rtl))))

(defgeneric compile-asn.1-internal (type rtl))

(defmethod compile-asn.1-internal ((type symbol) (rtl list))
  (declare (ignore rtl))
  `(defunknown ,type))

(defparameter *asn.1-package-prefix* "ASN.1/")

(defun module->package (module)
  (declare (type symbol module))
  (let ((package-symbol (intern (concatenate 'string
                                             *asn.1-package-prefix*
                                             (symbol-name module))
                                :keyword)))
    (the symbol package-symbol)))

(defmethod compile-asn.1-internal ((type (eql :module)) (rtl list))
  (declare (ignore type))
  (destructuring-bind (module-name xxx) rtl
    (let ((long-package-name (module->package module-name))
          #+snmp-system::short-name
          (short-package-name (intern (symbol-name module-name) :keyword)))
      (if (null xxx)
          `(()
            (in-package :asn.1))
        (destructuring-bind ((exports imports) body) xxx
          (declare (ignore exports))
          (append `((,module-name ,@(compile-imports imports))
                    ((in-package :asn.1))
                    ((eval-when (:load-toplevel :execute)
                       (setf *current-module* ',module-name)))
                    ((defpackage ,long-package-name
                       #+snmp-system::short-name
                       (:nicknames ,short-package-name)
                       (:use :common-lisp :asn.1)
                       ,@(compile-imports-full imports)))
                    ((in-package ,short-package-name)))
                  (mapcar #'compile-asn.1 body)
                  `(((in-package :asn.1)))
                  `(((eval-when (:load-toplevel :execute)
                       (pushnew ',module-name *mib-modules*)
                       (setf *current-module* nil))))))))))

(defun compile-imports (rtl)
  (when rtl
    (let ((imports (cdr rtl)))
      (mapcar #'(lambda (x) (car (last x)))
              imports))))

(defun compile-imports-full (rtl)
  (labels ((compile-import-from (x)
             (destructuring-bind (symbols from module) x
               (assert (eq from :from))
               (when module
                 (let ((package (module->package module)))
                   `(:import-from ,package
                     ,@(mapcar #'identity symbols)))))))
    (delete nil (mapcar #'compile-import-from (cdr rtl)))))

(defmethod compile-asn.1-internal ((type (eql :value-assignment)) (rtl list))
  (values (compile-va (car rtl) (cdr rtl)) type))

(defmethod compile-asn.1-internal ((type (eql :type-assignment)) (rtl list))
  (values (compile-ta (first rtl) (second rtl)) type))

(defmethod compile-asn.1-internal ((type (eql :define)) (rtl list))
  (values (compile-df (car rtl) (cdr rtl)) type))

(defmethod compile-asn.1-internal ((type (eql :macro)) (rtl list))
  (values `((defmacro ,(car rtl) ())) type))

(defgeneric compile-va (type rtl))

(defmethod compile-va ((type symbol) (rtl list))
  (declare (ignore rtl))
  `((defunknown ',type)))

(defmethod compile-va ((type (eql :object-identifier)) (rtl list))
  (destructuring-bind ((name value)) rtl
    (setf value (last value 2))
    (destructuring-bind (parent value) value
      (if (consp parent)
          (setf parent (car parent)))
      `((defoid ,name (,parent ,value)
          (:type 'OBJECT-IDENTITY))
        (,name ,parent)))))

(defgeneric compile-df (type rtl))

(defmethod compile-df ((type symbol) (rtl list))
  (destructuring-bind ((name options) (parent value)) rtl
    (let ((option-arguments (compile-df-options options)))
      `((defoid ,name (,parent ,value)
          (:type ',type)
          ,@option-arguments)
        (,name ,parent)))))

(defmethod compile-df ((type (eql 'OBJECT-IDENTITY)) (rtl list))
  (destructuring-bind ((name options) (parent value)) rtl
    (let ((option-arguments (compile-df-options options)))
      `((defoid ,name (,(if (and (numberp parent)
                                 (zerop parent))
                            '|zero| parent) ,value)
          (:type ',type)
          ,@option-arguments)
        (,name ,parent)))))

(defmethod compile-df ((type (eql 'TRAP-TYPE)) (rtl list))
  (declare (ignore type rtl))
  `((defunknown :trap-type)))

#|
((SYNTAX |Counter32|)
 (MAX-ACCESS |read-only|)
 (STATUS |obsolete|)
 (DESCRIPTION
  "The total number of SNMP Get-Next PDUs which have
   been generated by the SNMP protocol entity."))
-->
(:syntax integer
 :max-access :read-only
 :status :obsolete
 :description "The total number of SNMP Get-Next PDUs which have
               been generated by the SNMP protocol entity."
|#

(defun compile-df-options (options)
  (let ((description-p nil))
    (labels ((iter (o acc)
               (if (null o)
                   (nreverse acc)
                 (let ((o-item (car o)))
                   (iter (cdr o)
                         ;; make sure multi-description leave only first!
                         (let* ((compiled (compile-dfo-internal (first o-item)
                                                                (second o-item)))
                                (key (car compiled)))
                           (cond ((and (eq key :description)
                                       (not description-p))
                                  (prog1 (cons compiled acc)
                                    (setf description-p t)))
                                 ((and (eq key :description)
                                       description-p)
                                  acc)
                                 (t (cons compiled acc)))))))))
      (delete-if #'null (iter options nil)))))

(defgeneric compile-dfo-internal (key value))

(defmethod compile-dfo-internal ((key symbol) (value t))
  "Unknown df-option key"
  (declare (ignore key value))
  nil)

(defmethod compile-dfo-internal ((key (eql 'SYNTAX)) (value t))
  "Simple SYNTAX: only one symbol, map it into CL type"
  (declare (ignore key))
  `(:syntax ',(compile-type value)))

(defmethod compile-dfo-internal ((key (eql 'DESCRIPTION)) (value string))
  (declare (ignore key))
  `(:description ,value))

(defmethod compile-dfo-internal ((key (eql 'STATUS)) (value symbol))
  (declare (ignore key))
  `(:status ,value))

(defmethod compile-dfo-internal ((key (eql 'MAX-ACCESS)) (value symbol))
  (declare (ignore key))
  `(:max-access ,value))

(defmethod compile-dfo-internal ((key (eql 'DISPLAY-HINT)) (value string))
  (declare (ignore key))
  `(:display-hint ,value))

(defmethod compile-dfo-internal ((key (eql 'REFERENCE)) (value string))
  (declare (ignore key))
  `(:reference ,value))
