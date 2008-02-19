(in-package :snmp)

(defclass bulk-pdu (base-pdu)
  ((non-repeaters   :type integer
                    :reader non-repeaters
                    :initform 0
                    :initarg :non-repeaters)
   (max-repetitions :type integer
                    :reader max-repetitions
                    :initform 0
                    :initarg :max-repetitions))
  (:documentation "SNMP Bulk PDU Class"))

(defclass get-bulk-request-pdu (bulk-pdu) ())

(defmethod print-object ((obj bulk-pdu) stream)
  (with-slots (request-id non-repeaters max-repetitions variable-bindings) obj
    (print-unreadable-object (obj stream :type t)
      (format stream "(~D (~D ~D)) ~A"
              request-id non-repeaters max-repetitions variable-bindings))))

(defmethod ber-encode ((value get-bulk-request-pdu))
  (with-slots (request-id non-repeaters max-repetitions variable-bindings) value
    (let ((sub-encode (apply #'nconc
                             (map 'list #'ber-encode (list request-id
                                                           non-repeaters
                                                           max-repetitions
                                                           variable-bindings)))))
      (nconc (ber-encode-type 2 1 5)
             (ber-encode-length (length sub-encode))
             sub-encode))))

(defmethod ber-decode-value ((stream stream) (type (eql :get-bulk-request-pdu)) length)
  (declare (type fixnum length) (ignore type))
  (let ((data (ber-decode-value stream :sequence length)))
    (destructuring-bind (request-id non-repeaters max-repetitions variable-bindings) data
      (make-instance 'get-bulk-request-pdu
                     :request-id request-id
                     :non-repeaters non-repeaters
                     :max-repetitions max-repetitions
                     :variable-bindings variable-bindings))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :get-bulk-request-pdu 2 1 5))
