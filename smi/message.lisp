(in-package :smi)

(defclass message ()
  ((msg-version                    :type integer
                                   :initarg :version
                                   :reader msg-version-of)
   (msg-data                       :type pdu
                                   :initarg :data
                                   :accessor msg-data-of))
  (:documentation "Common SNMP Message"))

(defclass v1-message (message)
  ((msg-community                  :type string
                                   :initarg :community
                                   :accessor msg-comminity-of))
  (:documentation "Community-based SNMP v1 Message"))

(defclass v2c-message (v1-message)
  ()
  (:documentation "Community-based SNMP v2c Message"))

(defclass v3-message (message)
  ((msg-id                         :type integer
                                   :initarg :id
                                   :accessor msg-id-of)
   (msg-max-size                   :type integer
                                   :initarg :max-size
                                   :accessor msg-max-size-of)
   (msg-flags                      :type integer
                                   :initarg :flags
                                   :accessor msg-flags-of)
   (msg-security-model             :type integer
                                   :initarg :security-model
                                   :accessor msg-security-model-of)
   (msg-authoritative-engine-id    :type string
                                   :initarg :authoritative-engine-id
                                   :accessor msg-authoritative-engine-id-of)
   (msg-authoritative-engine-boots :type integer
                                   :initarg :authoritative-engine-boots
                                   :accessor msg-authoritative-engine-boots-of)
   (msg-authoritative-engine-time  :type integer
                                   :initarg :authoritative-engine-time
                                   :accessor msg-authoritative-engine-time-of)
   (msg-user-name                  :type string
                                   :initarg :user-name
                                   :accessor msg-user-name-of)
   (msg-authentication-parameters  :type string
                                   :initarg :authentication-parameters
                                   :accessor msg-authentication-parameters-of)
   (msg-privacy-parameters         :type string
                                   :initarg :privacy-parameters
                                   :accessor msg-privacy-parameters-of))
  (:documentation "User-based SNMP v3 Message"))

(defmethod ber-encode ((value v1-message))
  (with-slots (msg-version msg-community msg-data) value
    (ber-encode (list msg-version
                      msg-community
                      msg-data))))

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
                   :data pdu)))

(defmethod decode-message ((message-list list) (version (eql 3)))
  (destructuring-bind (version
                       global-data
                       authoritative-engine-id
                       authoritative-engine-boots
                       authoritative-engine-time
                       user-name
                       authentication-parameters
                       privacy-parameters
                       data)
      message-list
    (make-instance 'v3-message
                   :version version
                   :data data)))
