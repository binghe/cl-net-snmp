;;;; Patch 5.18: New SMI design

(in-package :snmp)

;;; package.lisp

(eval-when (:compile-toplevel :load-toplevel :execute)
  (if (and (boundp 'asn.1::*major-version*)
           (boundp 'asn.1::*minor-version*))
      (assert (or (> asn.1::*major-version* 4)
                  (and (= asn.1::*major-version* 4)
                       (>= asn.1::*minor-version* 14))))
      (error "Please use a newer version of ASN.1 package (>= 4.14)")))

;;; constants.lisp

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant +smi-no-such-object+   0)
  (defconstant +smi-no-such-instance+ 1)
  (defconstant +smi-end-of-mibview+   2))

(defvar *smi-value->symbol-table* (make-hash-table))
(defvar *smi-symbol->value-table* (make-hash-table))

(defvar *smi-map*
  `((,+smi-no-such-object+   . :no-such-object)
    (,+smi-no-such-instance+ . :no-such-instance)
    (,+smi-end-of-mibview+   . :end-of-mibview)))

(eval-when (:load-toplevel :execute)
  (mapcar #'(lambda (x)
	      (setf (gethash (car x) *smi-value->symbol-table*)
                    (cdr x)
                    (gethash (cdr x) *smi-symbol->value-table*)
                    (car x)))
          *smi-map*))

;;; snmp-smi.lisp

(defgeneric smi (object))

(defmethod smi ((value integer))
  (make-instance 'smi :value value))

(defmethod smi ((symbol symbol))
  (let ((value (gethash symbol *smi-symbol->value-table*)))
    (when value
      (make-instance 'smi :value value))))

(defclass smi (general-type) ())

(defmethod plain-value ((object smi))
  (gethash (value-of object) *smi-value->symbol-table*))

(defmethod print-object ((obj smi) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A (~D)" (plain-value obj) (value-of obj))))

(defmethod ber-encode ((value smi))
  (concatenate 'vector
               (ber-encode-type 2 0 (value-of value))
               (ber-encode-length 0)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-smi (symbol value)
    `(progn
       (defmethod ber-decode-value ((stream stream) (type (eql ,symbol)) length)
         (declare (type fixnum length) (ignore type))
         (dotimes (i length (smi ,symbol))
           (read-byte stream)))
       (install-asn.1-type ,symbol 2 0 ,value))))

(macrolet ((install-smi-value ()
             `(progn
                ,@(mapcar #'(lambda (x)
                              `(def-smi ,(cdr x) ,(car x)))
                          *smi-map*))))
  (install-smi-value))

;;; snmp-walk.lisp

(defmethod snmp-walk ((session session) (vars list) &key context)
  "SNMP Walk for v1, v2c and v3"
  (when vars
    (let ((base-vars (mapcar #'oid vars)))
      (labels ((iter (current-vars acc first-p)
                 (let* ((temp (snmp-get-next session current-vars :context context))
                        (new-vars (mapcar #'first temp))
                        (new-values (mapcar #'second temp)))
                   (if (or (some #'oid->= new-vars base-vars)
                           (member (smi :end-of-mibview) new-values
                                   :test #'ber-equal))
                       (if first-p
                         (snmp-get session vars)
                         (mapcar #'nreverse acc))
                     (iter new-vars (mapcar #'cons temp acc) nil)))))
        (iter base-vars (make-list (length vars)) t)))))

(setf *minor-version* 18)
