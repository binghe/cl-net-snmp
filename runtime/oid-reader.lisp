;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

;; sysDescr.0 -> |sysDescr| and 0
;; 1.3.6.1.2.1.1.1.0 -> *root-object-id*, 1, 3, 6, 1, 2, 1, 1, 1, 0
(defvar *oid-readtable*)

(defun make-oid-readtable ()
  ;; Create a new readtable
  (setf *oid-readtable* (copy-readtable nil))
  ;; Case-Sensitivity
  (setf (readtable-case *oid-readtable*) :preserve)
  ;; #\. reader
  (set-macro-character #\. #'(lambda (stream char)
                               (declare (ignore stream char))
                               (values))
                       nil *oid-readtable*)
  ;; binghe: strange ... what does this mean?
  (set-macro-character #\} (get-macro-character #\))
                       t *oid-readtable*))

(eval-when (:load-toplevel :execute)
  (make-oid-readtable))

(defgeneric oid-parse (source))

(defmethod oid-parse ((source string))
  (with-input-from-string (s source)
    (oid-parse s)))

(defmethod oid-parse ((source stream))
  (let ((*readtable* *oid-readtable*)
        (*package* (find-package :asn.1)))
    (handler-case
        (loop for i = (read source nil nil nil)
              until (null i)
              collect i)
      (error (c)
        (values nil c)))))

(defgeneric oid (object)
  (:documentation "Convert anything to OBJECT-ID.

1. For single names, return all possible OIDs as multiple values:

   > (oid \"linux\")
   #<OBJECT-ID NET-SNMP-TC::linux (10) [0]>
   #<OBJECT-ID UCD-SNMP-MIB::linux (10) [0]>

2. For names plus numbers, create new OID instances:

   > (oid \"sysDescr.0\")
   #<OBJECT-ID SNMPv2-MIB::sysDescr.0>

3. For names list, validating every names:

   > (oid \"ucdSnmpAgent.linux\")
   #<OBJECT-ID UCD-SNMP-MIB::linux (10) [0]>

4. For pure number list, search and build OID from 'zero':

   > (oid \"0.2.3.4\")
   #<OBJECT-ID zero.2.3.4>
   > (oid \"1.2.3\")
   #<OBJECT-ID iso.2.3>
   > (oid \".1.2.3\")
   #<OBJECT-ID iso.2.3>

5. OID name with module is supported:

   > (oid \"NET-SNMP-TC::linux\")
   #<OBJECT-ID NET-SNMP-TC::linux (10) [0]>

"))

(defmethod oid ((oid-object simple-oid))
  oid-object)

(defmethod oid ((oid-vector vector))
  (oid (coerce oid-vector 'list)))

#+lispworks
(defvar *simple-oid-cache*
  (make-hash-table :test 'equal :weak-kind :value))

(defun oid-helper (tokens base)
  (declare (type list tokens)
           (type object-id base))
  (if (null tokens)
      base
    (let ((i (car tokens)))
      (typecase i
        (integer ; match the child number, or create new one
         (let ((b (gethash (car tokens)
                           (oid-children base))))
           (if b
               (oid-helper (cdr tokens) b)
             (let ((o (make-instance 'simple-oid :value tokens :parent base)))
               #+lispworks
               (setf (gethash (oid-number-list o) *simple-oid-cache*) o)
               o))))
        (symbol ; walk through children of base to find a child with the name
         (with-hash-table-iterator (get-child (oid-children base))
           (labels ((try (got-one &optional key value)
                      (declare (ignore key))
                      (when got-one
                        (if (string= (symbol-name (oid-name value))
                                     (symbol-name i))
                            (oid-helper (cdr tokens) value)
                          (multiple-value-call #'try (get-child))))))
             (multiple-value-call #'try (get-child)))))))))

(defmethod oid ((oid-tokens list))
  (let ((head (car oid-tokens)))
    (typecase head
      (integer
       (if (zerop head)
           (oid-helper (cdr oid-tokens) |zero|)
         ;; optimize: plain number list directly to simple-oid when possible         
         (if #+lispworks (every #'numberp (cdr oid-tokens))
             #-lispworks nil
             (let ((o (gethash oid-tokens *simple-oid-cache*)))
               (or o
                   (prog1 (oid-helper oid-tokens |zero|)
                     #+ignore
                     (format t "OID cache fault on ~A ~%" oid-tokens))))
             (oid-helper oid-tokens |zero|))))
      (symbol (if (endp (cdr oid-tokens))
                  (oid-symbol-value head)
                (let ((base (oid-symbol-value head)))
                  (when base
                    (oid-helper (cdr oid-tokens) base)))))
      (object-id (oid-helper (cdr oid-tokens) head)))))

(defmethod oid ((oid-string string))
  (oid (oid-parse oid-string)))

(defmethod oid ((oid-symbol symbol))
  (if (and (boundp oid-symbol)
           (typep (symbol-value oid-symbol) 'object-id))
      (symbol-value oid-symbol)
    (oid (symbol-name oid-symbol))))

(defmethod oid ((oid-fail null))
  (declare (ignore oid-fail))
  nil)

(defun oid-symbol-value (symbol)
  (if (and (boundp symbol)
           (typep (symbol-value symbol) 'object-id))
    (symbol-value symbol)
    ;; try to find it in *oid-database*
    (let* ((name (symbol-name symbol))
           (symbol (gethash name *oid-database*)))
      (typecase symbol
        (null nil)
        (list (apply #'values (mapcar #'symbol-value symbol)))
        (otherwise (symbol-value symbol))))))
