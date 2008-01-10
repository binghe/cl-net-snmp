(in-package :smi)

(defclass message ()
  ((version       :type integer
                  :initarg :version
                  :reader msg-version-of)
   (pdu           :type pdu
                  :initarg :pdu
                  :accessor msg-pdu-of))
  (:documentation "Common SNMP Message"))

(defclass v1-message (message)
  ((community     :type string
                  :initarg :community
                  :accessor msg-comminity-of))
  (:documentation "Community-based SNMP v1 Message"))

(defclass v2c-message (v1-message)
  ()
  (:documentation "Community-based SNMP v2c Message"))

(defclass v3-message (message)
  ((global-data   :type list
                  :initarg :global-data
                  :accessor msg-glocal-data-of)
   (security-data :type string
                  :initarg :security-data
                  :accessor msg-security-data-of))
  (:documentation "User-based SNMP v3 Message"))

(defmethod ber-encode ((value v1-message))
  (with-slots (version community pdu) value
    (ber-encode (list version community pdu))))

;;; SNMPv3 Message Encode
(defmethod ber-encode ((value v3-message))
  (with-slots (version pdu global-data security-data) value
    (ber-encode (list version global-data security-data pdu))))

(defgeneric decode-message (stream version))

(defmethod decode-message ((stream stream) fake-version)
  (declare (ignore fake-version))
  (let ((message-list (ber-decode stream)))
    (let ((version (first message-list)))
      (decode-message message-list version))))

(defmethod decode-message ((message-list list) (version integer))
  (destructuring-bind (version community pdu) message-list
    (make-instance 'v1-message
                   :version version
                   :community community
                   :pdu pdu)))

;;; SNMPv3 Message Decode
(defmethod decode-message ((message-list list) (version (eql 3)))
  (destructuring-bind (version global-data security-data pdu) message-list
    (make-instance 'v3-message
                   :version version
                   :global-data global-data
                   :security-data security-data
                   :pdu pdu)))
