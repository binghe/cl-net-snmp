(in-package :smi)

(defclass base-pdu ()
  ((request-id        :type (unsigned-byte 32)
                      :accessor request-id
                      :initform 0
                      :initarg :request-id)
   (variable-bindings :type list
                      :accessor variable-bindings
                      :initform nil
                      :initarg :variable-bindings)))

(defclass pdu (base-pdu)
  ((error-status      :type integer
                      :reader error-status
                      :initform 0
                      :initarg :error-status)
   (error-index       :type integer
                      :reader error-index
                      :initform 0
                      :initarg :error-index))
  (:documentation "SNMP Generate PDU Class"))

(defmethod print-object ((obj pdu) stream)
  (with-slots (request-id error-status error-index variable-bindings) obj
    (print-unreadable-object (obj stream :type t)
      (format stream "(~D (~D ~D)) ~A"
              request-id error-status error-index variable-bindings))))

(defclass get-request-pdu      (pdu) () (:documentation "SNMP Get-Request PDU"))
(defclass get-next-request-pdu (pdu) () (:documentation "SNMP Get-Next-Request PDU"))
(defclass response-pdu         (pdu) () (:documentation "SNMP Response PDU"))
(defclass set-request-pdu      (pdu) () (:documentation "SNMP Set-Request PDU"))
(defclass inform-request-pdu   (pdu) () (:documentation "SNMP Inform-Request PDU"))
(defclass snmpv2-trap-pdu      (pdu) () (:documentation "SNMP V2 Trap PDU"))
(defclass report-pdu           (pdu) () (:documentation "SNMP Report PDU"))

(defun ber-encode-pdu (value tag)
  (declare (type pdu value)
           (type fixnum tag))
  (with-slots (request-id error-status error-index variable-bindings) value
    (let ((sub-encode (apply #'nconc
                             (map 'list #'ber-encode (nconc (list request-id
                                                                  error-status
                                                                  error-index
                                                                  variable-bindings))))))
      (nconc (ber-encode-type 2 1 tag)
             (ber-encode-length (length sub-encode))
             sub-encode))))

(defmethod ber-encode ((value get-request-pdu))      (ber-encode-pdu value 0))
(defmethod ber-encode ((value get-next-request-pdu)) (ber-encode-pdu value 1))
(defmethod ber-encode ((value response-pdu))         (ber-encode-pdu value 2))
(defmethod ber-encode ((value set-request-pdu))      (ber-encode-pdu value 3))
(defmethod ber-encode ((value inform-request-pdu))   (ber-encode-pdu value 6))
(defmethod ber-encode ((value snmpv2-trap-pdu))      (ber-encode-pdu value 7))
(defmethod ber-encode ((value report-pdu))           (ber-encode-pdu value 8))

(defun ber-decode-pdu (stream length class)
  (declare (type stream stream)
           (type fixnum length))
  (let ((data (ber-decode-value stream :sequence length)))
    (destructuring-bind (request-id error-status error-index variable-bindings) data
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
  (ber-decode-pdu stream length 'get-request-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :response-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'response-pdu))

(defmethod ber-decode-value ((stream stream) (type (eql :set-request-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (ber-decode-pdu stream length 'set-request-pdu))

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
  (install-asn.1-type :get-request-pdu      2 1 0)
  (install-asn.1-type :get-next-request-pdu 2 1 1)
  (install-asn.1-type :response-pdu         2 1 2)
  (install-asn.1-type :set-request-pdu      2 1 3)
  (install-asn.1-type :inform-request-pdu   2 1 6)
  (install-asn.1-type :snmpv2-trap-pdu      2 1 7)
  (install-asn.1-type :report-pdu           2 1 8))
