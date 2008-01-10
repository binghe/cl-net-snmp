(in-package :snmp)

(defvar *default-version* +snmp-version-1+)
(defvar *default-port* 161)
(defvar *default-community* "public")
(defvar *default-class* 'v1-session)

(defclass session ()
  ((socket            :type #+lispworks socket-stream #-lispworks socket
		      :accessor socket-of
		      :initarg :socket)
   (version           :type integer
		      :accessor version-of
		      :initarg :version
		      :initform *default-version*))
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
		      :accessor security-name
		      :initarg :security-name)
   (security-level    :type string
		      :accessor security-level
		      :initarg :security-level)
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
		      :accessor priv-key-of)
   (context-engine-id :type string
		      :initarg :context-engine-id
		      :accessor context-engine-id-of)
   (context-name      :type string
		      :initarg :context-name
		      :accessor context-name-of))
  (:documentation "SNMP v3 session, user security model"))

(defmethod initialize-instance :after ((session v1-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (version-of session) +snmp-version-1+))

(defmethod initialize-instance :after ((session v2c-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (version-of session) +snmp-version-2c+))

(defmethod initialize-instance :after ((session v3-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (version-of session) +snmp-version-3+)
  (princ initargs))

(defun open-session (host &key (class *default-class*)
                               (port *default-port*)
                               (community *default-community*)
                               (read-timeout 1))
  (let ((s #-lispworks (make-socket :remote-host host
				    :remote-port port
				    :type :datagram
				    :ipv6 nil)
	   #+lispworks (open-udp-stream host port
					:element-type '(unsigned-byte 8)
					:read-timeout read-timeout
					:errorp t)))
    #-lispworks
    (set-socket-option s :receive-timeout :sec read-timeout :usec 0)
    (make-instance class :socket s :community community)))

(defmethod close-session ((session session))
  (close (socket-of session)))
