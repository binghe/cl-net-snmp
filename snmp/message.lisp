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

(defmethod ber-encode ((value v1-message))
  (with-slots (version community pdu) value
    (ber-encode (list version community pdu))))

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

(defclass v3-message (message)
  ((id-counter        :type integer
                          :initform 0
                          :allocation :class)
   (security-name     :type string
                          :accessor msg-security-name-of
                          :initarg :msg-security-name
                          :initform "")
   (security-level    :type string
                          :accessor msg-security-level-of
                          :initarg :msg-security-level)
   (engine-id         :type string
                          :initarg :msg-engine-id
                          :accessor msg-engine-id-of)
   (engine-boots      :type integer
                          :initarg :msg-engine-boots
                          :accessor msg-engine-boots-of)
   (engine-time       :type integer
                          :initarg :msg-engine-time
                          :accessor msg-engine-time-of)
   (auth-key          :type string
                          :initarg :msg-auth-key
                          :accessor msg-auth-key-of
                          :initform "")
   (priv-key          :type string
                          :initarg :msg-priv-key
                          :accessor msg-priv-key-of
                          :initform "")
   (context-engine-id :type string
                          :initarg :msg-context-engine-id
                          :accessor msg-context-engine-id-of)
   (context-name      :type string
                          :initarg :msg-context-name
                          :accessor msg-context-name-of
                          :initform ""))
  (:documentation "User-based SNMP v3 Message"))

(defun msg-id-of (msg)
  (with-slots (msg-id-counter) msg
    (incf msg-id-counter)))

;;; SNMPv3 Message Encode
(defmethod ber-encode ((msg v3-message))
  (with-slots (version pdu security-level) msg
    (let ((global-data (list (msg-id-of msg)
                             65537 ;; msgMaxSize, hardcode
                             (make-msg-flags-string security-level)
                             +snmp-sec-model-usm+)))
      (ber-encode (list version global-data)))))

;;; SNMPv3 Message Decode
(defmethod decode-message ((message-list list) (version (eql 3)))
  (destructuring-bind (version global-data security-data pdu) message-list
    (make-instance 'v3-message
                   :version version
                   :global-data global-data
                   :security-data security-data
                   :pdu pdu)))
