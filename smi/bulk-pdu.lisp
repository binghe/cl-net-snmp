(in-package :smi)

(defclass bulk-pdu (base-pdu)
  ((non-repeaters     :type integer
                      :reader non-repeaters
                      :initform 0
                      :initarg :non-repeaters)
   (max-repetitions   :type integer
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

