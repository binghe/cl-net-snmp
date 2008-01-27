(in-package :snmp)

(defclass message ()
  ((session :type session
            :initarg :session
            :initform nil
            :accessor session-of)
   (pdu     :type pdu
            :initarg :pdu
            :accessor pdu-of))
  (:documentation "Common SNMP Message"))

(defclass v1-message (message)
  ()
  (:documentation "Community-based SNMP v1 Message"))

(defclass v2c-message (v1-message)
  ()
  (:documentation "Community-based SNMP v2c Message"))

(defmethod ber-encode ((message v1-message))
  (ber-encode (list (version-of (session-of message))
                    (community-of (session-of message))
                    (pdu-of message))))

(defgeneric decode-message (stream version))

(defmethod decode-message ((stream stream) fake-version)
  (declare (ignore fake-version))
  (let ((message-list (ber-decode stream)))
    (let ((version (first message-list)))
      (decode-message message-list version))))

(defmethod decode-message ((message-list list) (version integer))
  (destructuring-bind (version community pdu) message-list
    (declare (ignore version community))
    (make-instance 'v1-message :pdu pdu)))

(defclass v3-message (message)
  ;; start msgID must be big, or net-snmp cannot decode our message
  ((msg-id-counter     :type integer
                       :initform #x01000000
                       :allocation :class)
   (msg-id             :type integer
                       :initarg :id
                       :accessor msg-id-of)
   (report-flag        :type boolean
                       :initform nil
                       :initarg :report
                       :accessor report-flag))
  (:documentation "User-based SNMP v3 Message"))

(defun generate-msg-id (message)
  (with-slots (msg-id-counter) message
    (incf msg-id-counter)))

(defmethod initialize-instance :after ((message v3-message) &rest initargs)
  (declare (ignore initargs))
  (unless (slot-boundp message 'msg-id)
    (setf (msg-id-of message) (generate-msg-id message))))

(defun generate-global-data (id level)
  (list id
        ;; msgMaxSize 65507 (hardcode now, must encode info 3 bytes or net-snmp cannot decode
        (raw-data (list #x02 #x03 #x00 #xff #xe3))
        ;; msgFlags: security-level + reportable flag
        (make-string 1 :initial-element (code-char (logior #b100 level)))
        ;; msgSecurityModel: USM (3)
        +snmp-sec-model-usm+))

;;; SNMPv3 Message Encode
(defmethod ber-encode ((message v3-message))
  (let* ((session (session-of message))
         (global-data (generate-global-data (msg-id-of message)
                                            (if (report-flag message) 0
                                              (security-level-of session))))
         (msg-data (list (engine-id-of session) ; contextEngineID, not support yet.
                         ""                     ; contextName, not support yet.
                         (pdu-of message)))     ; PDU
         (msg-authentication-parameters
          ;; RFC 2574 (USM for SNMPv3), 7.3.1:
          ;; 1) The msgAuthenticationParameters field is set to the
          ;;    serialization, according to the rules in [RFC1906], of an OCTET
          ;;    STRING containing 12 zero octets.
          (if (and (not (report-flag message))
                   (auth-protocol-of session))
            (make-string 12 :initial-element (code-char 0)) ""))
         (msg-privacy-parameters ""))  ; not support priv yet.
    (labels ((encode-v3-message (auth)
               (ber-encode (list (version-of session)
                                 global-data
                                 (ber-encode->string (list (engine-id-of session)
                                                           (engine-boots-of session)
                                                           (engine-time-of session)
                                                           (if (report-flag message) ""
                                                             (security-name-of session))
                                                           auth
                                                           msg-privacy-parameters))
                                 msg-data))))
      (let ((tmp (encode-v3-message msg-authentication-parameters)))
        (if (or (report-flag message)
                (not (auth-protocol-of session))) tmp
          ;; authencate the encode-data and re-encode it
          (encode-v3-message (authenticate-message tmp
                                                   (auth-key-of session)
                                                   (auth-protocol-of session))))))))

;;; need ironclad package for hmac/md5 and hmac/sha
(defun authenticate-message (message key digest)
  (declare (type (simple-array (unsigned-byte 8) (*)) key)
           (type (member :md5 :sha1) digest))
  (let ((hmac (ironclad:make-hmac key digest)))
    (ironclad:update-hmac hmac (princ (*->key message)))
    (map 'string #'code-char
         (subseq (ironclad:hmac-digest hmac) 0 12))))

;;; SNMPv3 Message Decode
(defmethod decode-message ((message-list list) (version (eql 3)))
  (destructuring-bind (version global-data security-string data) message-list
    (declare (ignore version global-data security-string))
    (let ((pdu (third data)))
      (make-instance 'v3-message :pdu pdu))))
