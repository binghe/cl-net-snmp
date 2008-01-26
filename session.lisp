(in-package :snmp)

(defvar *default-version* +snmp-version-1+)
(defvar *default-port* 161)
(defvar *default-community* "public")
(defvar *default-class* 'v1-session)

(defclass session ()
  ((socket            :type socket-stream
		      :accessor socket-of
		      :initarg :socket)
   (version           :type integer
		      :accessor version-of))
  (:documentation "SNMP session base"))

(defclass v1-session (session)
  ((community         :type string
		      :accessor community-of
		      :initarg :community
		      :initform *default-community*))
  (:documentation "SNMP v1 session, community based"))

(defclass v2c-session (v1-session) ()
  (:documentation "SNMP v2c session, community based"))

(defclass v3-session (session)
  ((security-name     :type string
		      :reader security-name-of
		      :initarg :security-name)
   (security-level    :type fixnum
		      :accessor security-level-of)
   (engine-id         :type string
		      :initarg :engine-id
		      :accessor engine-id-of)
   (engine-boots      :type integer
		      :initarg :engine-boots
		      :accessor engine-boots-of)
   (engine-time       :type integer
		      :initarg :engine-time
		      :accessor engine-time-of)
   (auth-key          :type string
		      :initarg :auth-key
		      :accessor auth-key-of)
   (priv-key          :type string
		      :initarg :priv-key
		      :accessor priv-key-of))
  (:documentation "SNMP v3 session, user security model"))

(defmethod initialize-instance :after ((session v1-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (slot-value session 'version) +snmp-version-1+))

(defmethod initialize-instance :after ((session v2c-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (slot-value session 'version) +snmp-version-2c+))

(defmethod initialize-instance :after ((session v3-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (version security-level) session
    (setf version +snmp-version-3+
          ;; msgFlags = Security-Level + Reportable:
          ;; .... .1.. = Reportable: Set
          ;; .... ..1. = Encrypted: Set
          ;; .... ...1 = Authenticated: Set
          security-level (+ (if (slot-boundp session 'auth-key) 1 0)
                            (if (slot-boundp session 'priv-key) 2 0)))))

(defun open-session (host &key (class *default-class*)
                               (port *default-port*)
                               (read-timeout 1) ;; second
                               (community "public")
                               security-name
                               auth-key
                               priv-key)
  (let ((socket (open-udp-stream host port
                                 :element-type '(unsigned-byte 8)
                                 :read-timeout read-timeout
                                 :errorp t)))
    (make-instance class :socket socket
                   ;; SNMPv1, v2c
                   :community community
                   ;; SNMPv3
                   :security-name security-name
                   :auth-key auth-key
                   :priv-key priv-key)))

(defmethod close-session ((session session))
  (close (socket-of session)))
