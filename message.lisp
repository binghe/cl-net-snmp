(in-package :snmp)

(defclass message ()
  ((msg-version :type integer
                :initarg :version
                :accessor msg-version-of)
   (msg-pdu     :type pdu
                :initarg :pdu
                :accessor msg-pdu-of))
  (:documentation "Common SNMP Message"))

(defclass v1-message (message)
  ((msg-community :type string
                  :initarg :community
                  :accessor msg-comminity-of))
  (:documentation "Community-based SNMP v1 Message"))

(defclass v2c-message (v1-message)
  ()
  (:documentation "Community-based SNMP v2c Message"))

(defmethod ber-encode ((msg v1-message))
  (with-slots (msg-version msg-community msg-pdu) msg
    (ber-encode (list msg-version msg-community msg-pdu))))

(defgeneric decode-message (stream version))

(defmethod decode-message ((stream stream) fake-version)
  (declare (ignore fake-version))
  (let ((message-list (ber-decode stream)))
    (let ((version (first message-list)))
      (decode-message message-list version))))

(defmethod decode-message ((message-list list) (version integer))
  (destructuring-bind (msg-version msg-community msg-pdu) message-list
    (make-instance 'v1-message
                   :version msg-version
                   :community msg-community
                   :pdu msg-pdu)))

(defclass v3-message (message)
  ((msg-id-counter     :type integer ;; Message ID counter, always increase
                       :initform 0
                       :allocation :class)
   (msg-id             :type integer
                       :initarg :id
                       :accessor msg-id-of)
   (msg-user-name      :type string
                       :accessor msg-user-name-of
                       :initarg :user-name
                       :initform "")
   (msg-security-level :type (unsigned-byte 8)
                       :initarg :security-level
                       :initform 0)
   (msg-engine-id      :type string
                       :initarg :engine-id
                       :initform ""
                       :accessor msg-engine-id-of)
   (msg-engine-boots   :type integer
                       :initarg :engine-boots
                       :initform 0
                       :accessor msg-engine-boots-of)
   (msg-engine-time    :type integer
                       :initarg :engine-time
                       :initform 0
                       :accessor msg-engine-time-of)
   (msg-auth-key       :type string
                       :initarg :auth-key
                       :accessor msg-auth-key-of)
   (msg-priv-key       :type string
                       :initarg :priv-key
                       :accessor msg-priv-key-of))
  (:documentation "User-based SNMP v3 Message"))

(defun generate-msg-id (message)
  (with-slots (msg-id-counter) message
    (incf msg-id-counter)))

(defmethod initialize-instance :after ((message v3-message)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (msg-version-of message) +snmp-version-3+)
  (unless (slot-boundp message 'msg-id)
    (setf (msg-id-of message)
          (generate-msg-id message))))

(defun list->string (list)
  (concatenate 'string (mapcar #'code-char list)))

(defun string->vector (str)
  (map 'vector #'char-code str)) 

;;; SNMPv3 Message Encode
(defmethod ber-encode ((msg v3-message))
  (with-slots (msg-version msg-pdu msg-id
                           msg-user-name
                           msg-security-level
                           msg-engine-id
                           msg-engine-boots
                           msg-engine-time) msg
    (let ((global-data (list msg-id
                             ;; msgMaxSize 65507 (hardcode now, I must encode info 3 bytes?)
                             (raw-data (list #x02 #x03 #x00 #xff #xe3))
                             ;; msgFlags: security-level + reportable flag
                             (make-string 1
                                          :initial-element (code-char
                                                            (logior #b100 ; reportable
                                                                    msg-security-level)))
                             +snmp-sec-model-usm+)) ; msgSecurityModel: USM (3)
          (msg-data (list msg-engine-id ; contextEngineID, not support yet.
                          ""            ; contextName, not support yet.
                          msg-pdu)))    ; data
      (let ((msg-authentication-parameters "")      ; not support auth yet.
            (msg-privacy-parameters ""))            ; not support priv yet.
        (let ((security-data (list->string
                              (ber-encode (list msg-engine-id
                                                msg-engine-boots
                                                msg-engine-time
                                                msg-user-name
                                                msg-authentication-parameters
                                                msg-privacy-parameters)))))
          (ber-encode (list msg-version
                            global-data
                            security-data
                            msg-data)))))))

;;; SNMPv3 Message Decode
(defmethod decode-message ((message-list list) (version (eql 3)))
  (destructuring-bind (ver (id max-size sec-level-str sec-model) sec-string data) message-list
    (declare (ignore ver sec-model max-size))
    (let ((pdu (third data)))
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
          (ber-decode (map 'vector #'char-code sec-string))
        (declare (ignore auth priv))
        (make-instance 'v3-message
                       :pdu pdu
                       :id id
                       :security-level (char-code (elt sec-level-str 0))
                       :engine-id engine-id
                       :engine-boots engine-boots
                       :engine-time engine-time
                       :user-name user)))))
