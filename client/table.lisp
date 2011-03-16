;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

;;; SNMP-SELECT, A high-level SNMP query language.

#| Sample Usage

> (snmp-select "tcpConnTable" :from session)
(#<TcpConnEntry 1>
 #<TcpConnEntry 2>
 #<TcpConnEntry 3>
 ...)

;;; Search Table
> (snmp-select "ifTable" :from session :where `(= ,(oid "ifDescr") "eth0"))
(#<IfEntry "eth0">)

;;; Automatic create new combined class
> (snmp-select '("ifTable" "ifXTable") :from session
               :where `(= (oid "ifDescr") (oid "ifName")))
(#<IfEntry + IfXEntry 1>
 #<IfEntry + IfXEntry 2>)

> (snmp-select '("ifInOctets" "ifOutOctets") :from session
               :where `(= (oid "ifDescr") "eth0"))
(#<Counter32 0> #<Counter32 0>)

|#

(defun snmp-select (identifiers &rest keys &key from &allow-other-keys)
  ;; handle string-like session first
  (if (stringp from)
      (with-open-session (session from)
        (apply #'snmp-select (list* identifiers :from session keys)))
    (apply #'snmp-select-internal (list* identifiers keys))))

(defun snmp-select-internal (identifiers &key from where)
  ;; get the mib table
  (let ((table (process-identifier identifiers))
        (session from))
    (if (atom table)
        (apply #'simple-select (list* session table (if where (process-where where))))
      (error "unsupported query"))))

(defun process-where (clause)
  (destructuring-bind (predicate key-part value-part) clause
    (unless (eq predicate '=)
      (error "unsupported predicate"))
    (list (oid key-part) value-part)))

(defun simple-select (session table &optional key value)
  (let ((class (mib-table-class table))
        (slots (mib-table-slots table))
        (lines (detect-mib-table-lines session table
                                       :key key :value value))
        (results nil))
    (dolist (i lines (nreverse results))
      (let ((current-slots (mapcar #'(lambda (x) (oid (cons x i))) slots))
            (object (make-instance class)))
        (let ((response (snmp-get session current-slots)))
          (mapcar #'(lambda (s v)
                      (when (not (smi-p v)) ; only set valid value
                        (setf (slot-value object (oid-name s)) v)))
                  slots response)
          (push object results))))))

(defgeneric process-identifier (identifier)
  (:documentation "process identifiers of snmp-select form"))

(defmethod process-identifier ((identifier string))
  (oid identifier))

(defmethod process-identifier ((identifier object-id))
  identifier)

(defmethod process-identifier ((identifier null))
  (declare (ignore identifier))
  nil)

(defun mib-table-p (oid)
  (declare (type object-id oid))
  (when (oid-syntax-p oid)
    (let ((syntax (oid-syntax oid)))
      (and (listp syntax)
           (= 2 (list-length syntax))
           (eq 'vector (car syntax))))))

(defun mib-table-class (oid)
  (declare (type object-id oid))
  (find-class (second (oid-syntax oid))))

(defun mib-table-entry (oid)
  (declare (type object-id oid))
  (oid (list oid 1)))

(defun mib-table-slots (oid)
  (declare (type object-id oid))
  (let ((entry (mib-table-entry oid)))
    (list-children entry)))

(defun detect-mib-table-lines (session oid &key key value)
  "Return a list of line number which match the given key/value or all of them"
  (declare (type session session)
           (type object-id oid))
  (let ((real-key (or key (car (mib-table-slots oid)))))
    (flet ((get-ids (item)
             (multiple-value-bind (parent ids) (oid-find-leaf (car item))
               (declare (ignore parent))
               ids)))
      (if value
          (loop for i = (snmp-get-next session real-key) then (snmp-get-next session (first i))
                and last = oid then i
                until (or (oid->= (first i) oid)      ; child test
                          (ber-equal (first i) last)) ; duplicate test
                do (if (ber-equal (second i) value)   ; match test
                       (return (mapcar #'get-ids (list i)))))
        (mapcar #'get-ids (snmp-walk session real-key))))))
