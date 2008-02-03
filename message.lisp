(in-package :snmp)

(defclass message ()
  ((session :type session
            :initarg :session
            :initform nil
            :accessor session-of)
   (pdu     :type pdu
            :initarg :pdu
            :accessor pdu-of))
  (:documentation "SNMP message base class"))

;;; SNMPv1 and SNMPv2c

(defclass v1-message (message) ()
  (:documentation "Community-based SNMP v1 Message"))

(defclass v2c-message (v1-message) ()
  (:documentation "Community-based SNMP v2c Message"))

(defmethod ber-encode ((message v1-message))
  (ber-encode (list (version-of (session-of message))
                    (community-of (session-of message))
                    (pdu-of message))))

(defgeneric decode-message (session stream))

(defmethod decode-message ((s session) (stream stream))
  (let ((message-list (ber-decode stream)))
    (decode-message s message-list)))

(defmethod decode-message ((s v1-session) (message-list list))
  (destructuring-bind (version community pdu) message-list
    (declare (ignore version community))
    (make-instance 'v1-message :pdu pdu)))

;;; SNMP v3

(defclass v3-message (message)
  ;; start msgID must be big, or net-snmp cannot decode our message
  ((msg-id-counter :type (unsigned-byte 32)
                   :initform #x01000000
                   :allocation :class)
   (msg-id         :type (unsigned-byte 32)
                   :initarg :id
                   :accessor msg-id-of)
   ;;; Report flag, for SNMP report use.
   (report-flag    :type boolean
                   :initform nil
                   :initarg :report
                   :accessor report-flag))
  (:documentation "User-based SNMP v3 Message"))

(defmethod generate-msg-id ((message v3-message))
  (with-slots (msg-id-counter) message
    (the (unsigned-byte 32) (logand (incf msg-id-counter) #xffffffff))))

(defmethod generate-salt ((message v3-message))
  (with-slots (salt-counter) message
    (the (unsigned-byte 32) (logand (incf salt-counter) #xffffffff))))

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
         (need-auth-p (and (not (report-flag message))
                           (auth-protocol-of session)))
         (need-priv-p (and (not (report-flag message))
                           (priv-protocol-of session)))
         ;; RFC 2574 (USM for SNMPv3), 7.3.1.
         ;; 1) The msgAuthenticationParameters field is set to the
         ;;    serialization, according to the rules in [RFC1906], of an OCTET
         ;;    STRING containing 12 zero octets.
         (msg-authentication-parameters (if need-auth-p
                                          (make-string 12 :initial-element (code-char 0))
                                          ""))
         ;; RFC 2574 (USM for SNMPv3), 8.1.1.1. DES key and Initialization Vector
         ;; Now it's a list, not string, as we do this later.
         (msg-privacy-parameters (if need-priv-p
                                   (generate-privacy-parameters message)
                                   nil)))
    ;; Privacy support (we encrypt and replace msg-data here)
    (when need-priv-p
      (setf msg-data (encrypt-message message msg-privacy-parameters msg-data)))
    ;; Authentication support
    (labels ((encode-v3-message (auth)
               (ber-encode (list (version-of session)
                                 global-data
                                 (ber-encode->string (list (engine-id-of session)
                                                           (engine-boots-of session)
                                                           (engine-time-of session)
                                                           (if (report-flag message)
                                                             ""
                                                             (security-name-of session))
                                                           auth
                                                           (map 'string #'code-char
                                                                msg-privacy-parameters)))
                                 msg-data))))
      (let ((unauth-data (encode-v3-message msg-authentication-parameters)))
        (if (not need-auth-p) unauth-data
          ;; authencate the encode-data and re-encode it
          (encode-v3-message (authenticate-message unauth-data
                                                   (auth-key-of session)
                                                   (auth-protocol-of session))))))))

;;; need ironclad package for hmac/md5 and hmac/sha
(defun authenticate-message (message key digest)
  (declare (type (simple-array (unsigned-byte 8) (*)) key)
           (type (member :md5 :sha1) digest))
  (let ((hmac (ironclad:make-hmac key digest)))
    (ironclad:update-hmac hmac (*->key message))
    ;; TODO, use a raw-data instead, for efficiency
    (map 'string #'code-char
         (subseq (ironclad:hmac-digest hmac) 0 12))))

;;; SNMPv3 Message Decode
(defmethod decode-message ((s v3-session) (message-list list))
  (destructuring-bind (version global-data security-string data) message-list
    (declare (ignore version global-data))
    (if (not (priv-protocol-of s))
      (let ((pdu (third data)))
        (make-instance 'v3-message :pdu pdu))
      ;;; decrypt message
      (let ((salt (map '(simple-array (unsigned-byte 8) (*)) #'char-code
                       (nth 5 (ber-decode<-string security-string))))
            (des-key (subseq (priv-key-of s) 0 8))
            (pre-iv (subseq (priv-key-of s) 8 16))
            (data (map '(simple-array (unsigned-byte 8) (*)) #'char-code data)))
        (let* ((iv (map '(simple-array (unsigned-byte 8) (*)) #'logxor
                        pre-iv salt))
               (cipher (ironclad:make-cipher :des ; (priv-protocol-of s)
                                             :mode :cbc
                                             :key des-key 
                                             :initialization-vector iv)))
          (ironclad:decrypt-in-place cipher data)
          (let ((pdu (third (ber-decode data))))
            (make-instance 'v3-message :pdu pdu)))))))

;;; RFC 2574 (USM for SNMPv3), 8.1.1.1. DES key and Initialization Vector
(defmethod generate-privacy-parameters ((message v3-message))
  "generate a 8-bytes privacy-parameters string for use by message encrypt"
  (let ((left  (engine-boots-of (session-of message))) ; octets 0~3
        (right (msg-id-of message)))                   ; octets 4~7 (we just reuse msgID)
    (let ((salt (logior (ash left 32) right))
          (result nil))
      (dotimes (i 8 result)
        (push (logand salt #xff) result)
        (setf salt (ash salt -8))))))

;;; Encrypt msgData
(defmethod encrypt-message ((message v3-message)
                            (msg-privacy-parameters list) (msg-data list))
  (let ((salt (coerce msg-privacy-parameters '(simple-array (unsigned-byte 8) (*))))
        (pre-iv (subseq (priv-key-of (session-of message)) 8 16))
        (des-key (subseq (priv-key-of (session-of message)) 0 8))
        (data (coerce (ber-encode msg-data) '(simple-array (unsigned-byte 8) (*)))))
    (let ((iv (map '(simple-array (unsigned-byte 8) (*)) #'logxor pre-iv salt))
          (result-length (* (1+ (floor (length data) 8)) 8))) ;; extend length to (mod 8)
      (let ((cipher (ironclad:make-cipher :des ; (priv-protocol-of (session-of message))
                                          :key des-key
                                          :mode :cbc
                                          :initialization-vector iv))
            (result-data (make-array result-length
                                     :element-type '(unsigned-byte 8) :initial-element 0)))
        (replace result-data data)
        (ironclad:encrypt-in-place cipher result-data)
        (map 'string #'code-char result-data)))))

(defvar *session->message* (make-hash-table))

(eval-when (:load-toplevel :execute)
  (setf (gethash 'v1-session *session->message*) 'v1-message
        (gethash 'v2c-session *session->message*) 'v2c-message
        (gethash 'v3-session *session->message*) 'v3-message))
