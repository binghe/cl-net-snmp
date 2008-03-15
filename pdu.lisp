;;;; ASN.1: SNMP PDU

(in-package :snmp)

;;; SNMP PDU Type
(defconstant +get-request-pdu+      0)
(defconstant +get-next-request-pdu+ 1)
(defconstant +response-pdu+         2)
(defconstant +set-request-pdu+      3)
(defconstant +trap-pdu+             4)
(defconstant +bulk-pdu+             5)
(defconstant +inform-request-pdu+   6)
(defconstant +snmpv2-trap-pdu+      7)
(defconstant +report-pdu+           8)

(defclass base-pdu ()
  ((variable-bindings  :type list
                       :accessor variable-bindings-of
                       :initform nil
                       :initarg :variable-bindings))
  (:documentation "All PDU type have a variable bindings"))

;;; generic trap type
(defconstant +cold-start+             0)
(defconstant +warm-start+             1)
(defconstant +link-down+              2)
(defconstant +link-up+                3)
(defconstant +authentication-failure+ 4)
(defconstant +egp-neighbor-loss+      5)
(defconstant +enterprise-specific+    6)

(defclass trap-pdu (base-pdu)
  ((enterprise    :type object-id
                  :initarg :enterprise)
   (agent-addr    :type ipaddress 
                  :initarg :agent-addr)
   (generic-trap  :type (integer 0 6)
                  :initarg :generic-trap)
   (specific-trap :type integer
                  :initarg :specific-trap)
   (timestamp     :type timeticks
                  :initarg :timestamp))
  (:documentation "SNMP v1 Trap PDU"))

(defclass common-pdu (base-pdu)
  ((request-id-counter :type integer
                       :initform 0
                       :allocation :class)
   (request-id         :type integer
                       :accessor request-id-of
                       :initarg :request-id))
  (:documentation "Common PDU which have a request ID part"))

(defmethod generate-request-id ((pdu common-pdu))
  (with-slots (request-id-counter) pdu
    (incf request-id-counter)))

(defmethod initialize-instance :after ((pdu common-pdu)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (unless (slot-boundp pdu 'request-id)
    (setf (slot-value pdu 'request-id) (generate-request-id pdu))))

;;; generate error status
(defconstant +no-error+     0)
(defconstant +too-big+      1)
(defconstant +no-such-name+ 2)
(defconstant +bad-value+    3)
(defconstant +read-only+    4)
(defconstant +gen-err+      5)

(defclass pdu (common-pdu)
  ((error-status :type (integer 0 5)
                 :accessor error-status-of
                 :initform 0
                 :initarg :error-status)
   (error-index  :type integer
                 :accessor error-index-of
                 :initform 0
                 :initarg :error-index))
  (:documentation "SNMP PDU, most PDU types are my subclass"))

(defmethod print-object ((instance pdu) stream)
  (with-slots (request-id error-status error-index variable-bindings) instance
    (print-unreadable-object (instance stream :type t)
      (format stream "(~D (~D ~D)) ~A"
              request-id error-status error-index variable-bindings))))

(defclass get-request-pdu      (pdu) () (:documentation "SNMP Get-Request PDU"))
(defclass get-next-request-pdu (pdu) () (:documentation "SNMP Get-Next-Request PDU"))
(defclass response-pdu         (pdu) () (:documentation "SNMP Response PDU"))
(defclass set-request-pdu      (pdu) () (:documentation "SNMP Set-Request PDU"))
(defclass inform-request-pdu   (pdu) () (:documentation "SNMP Inform-Request PDU"))
(defclass snmpv2-trap-pdu      (pdu) () (:documentation "SNMP V2 Trap PDU"))
(defclass report-pdu           (pdu) () (:documentation "SNMP Report PDU"))

(defclass bulk-pdu (common-pdu)
  ((non-repeaters   :type integer
                    :reader non-repeaters
                    :initform 0
                    :initarg :non-repeaters)
   (max-repetitions :type integer
                    :reader max-repetitions
                    :initform 0
                    :initarg :max-repetitions))
  (:documentation "SNMP Bulk PDU"))

(defmethod print-object ((instance bulk-pdu) stream)
  (with-slots (request-id non-repeaters max-repetitions variable-bindings) instance
    (print-unreadable-object (instance stream :type t)
      (format stream "(~D (~D ~D)) ~A"
              request-id non-repeaters max-repetitions variable-bindings))))

(defmethod ber-encode-pdu ((value pdu) tag)
  (declare (type fixnum tag))
  (with-slots (request-id error-status error-index variable-bindings) value
    (let ((sub-encode (ber-encode-list (list request-id
                                             error-status
                                             error-index
                                             variable-bindings))))
      (concatenate 'vector
                   (ber-encode-type 2 1 tag)
                   (ber-encode-length (length sub-encode))
                   sub-encode))))

(defmethod ber-encode ((value get-request-pdu))
  (ber-encode-pdu value +get-request-pdu+))

(defmethod ber-encode ((value get-next-request-pdu))
  (ber-encode-pdu value +get-next-request-pdu+))

(defmethod ber-encode ((value response-pdu))
  (ber-encode-pdu value +response-pdu+))

(defmethod ber-encode ((value set-request-pdu))
  (ber-encode-pdu value +set-request-pdu+))

(defmethod ber-encode ((value trap-pdu))
  (with-slots (enterprise agent-addr generic-trap specific-trap timestamp
                          variable-bindings) value
    (let ((sub-encode (ber-encode-list (list enterprise
                                             agent-addr
                                             generic-trap
                                             specific-trap
                                             timestamp
                                             variable-bindings))))
      (concatenate 'vector
                   (ber-encode-type 2 1 +trap-pdu+)
                   (ber-encode-length (length sub-encode))
                   sub-encode))))

(defmethod ber-encode ((value bulk-pdu))
  (with-slots (request-id non-repeaters max-repetitions variable-bindings) value
    (let ((sub-encode (ber-encode-list (list request-id
                                             non-repeaters
                                             max-repetitions
                                             variable-bindings))))
      (concatenate 'vector
                   (ber-encode-type 2 1 +bulk-pdu+)
                   (ber-encode-length (length sub-encode))
                   sub-encode))))

(defmethod ber-encode ((value inform-request-pdu))
  (ber-encode-pdu value +inform-request-pdu+))

(defmethod ber-encode ((value snmpv2-trap-pdu))
  (ber-encode-pdu value +snmpv2-trap-pdu+))

(defmethod ber-encode ((value report-pdu))
  (ber-encode-pdu value +report-pdu+))

(defun ber-decode-pdu (stream length class)
  (declare (type stream stream)
           (type fixnum length)
           (type symbol class))
  (let ((data (ber-decode-value stream :sequence length)))
    (destructuring-bind (request-id error-status error-index
                                    variable-bindings) (coerce data 'list)
      (make-instance class
                     :request-id request-id
                     :error-status error-status
                     :error-index error-index
                     :variable-bindings variable-bindings))))

(defmethod ber-decode-value ((stream stream) (type (eql :get-request-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'get-request-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :get-next-request-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'get-next-request-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :response-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'response-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :set-request-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'set-request-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :trap-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (let ((data (ber-decode-value stream :sequence length)))
    (destructuring-bind (enterprise agent-addr generic-trap specific-trap timestamp
                                    variable-bindings) (coerce data 'list)
      (make-instance 'trap-pdu
                     :enterprise enterprise
                     :agent-addr agent-addr
                     :generic-trap generic-trap
                     :specific-trap specific-trap
                     :timestamp timestamp
                     :variable-bindings variable-bindings))))

(defmethod ber-decode-value ((stream stream) (type (eql :bulk-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (let ((data (ber-decode-value stream :sequence length)))
    (destructuring-bind (request-id non-repeaters max-repetitions
                                    variable-bindings) (coerce data 'list)
      (make-instance 'get-bulk-request-pdu
                     :request-id request-id
                     :non-repeaters non-repeaters
                     :max-repetitions max-repetitions
                     :variable-bindings variable-bindings))))

(defmethod ber-decode-value ((stream stream) (type (eql :inform-request-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'inform-request-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :snmpv2-trap-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'snmpv2-trap-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :report-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'report-pdu))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :get-request-pdu      2 1 +get-request-pdu+)
  (install-asn.1-type :get-next-request-pdu 2 1 +get-next-request-pdu+)
  (install-asn.1-type :response-pdu         2 1 +response-pdu+)
  (install-asn.1-type :set-request-pdu      2 1 +set-request-pdu+)
  (install-asn.1-type :trap-pdu             2 1 +trap-pdu+)
  (install-asn.1-type :bulk-pdu             2 1 +bulk-pdu+)
  (install-asn.1-type :inform-request-pdu   2 1 +inform-request-pdu+)
  (install-asn.1-type :snmpv2-trap-pdu      2 1 +snmpv2-trap-pdu+)
  (install-asn.1-type :report-pdu           2 1 +report-pdu+))
