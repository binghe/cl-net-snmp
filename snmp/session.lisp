(in-package :snmp)

(defvar *default-version* +snmp-version-1+)
(defvar *default-port* 161)
(defvar *default-community* "public")
(defvar *default-class* 'v1-session)

(defclass session ()
  ((socket :reader socket-of
           :initarg :socket
           :type #+lispworks socket-stream #-lispworks socket)
   (version :reader version-of
	    :initarg :version
	    :type integer
	    :initform *default-version*)))

(defclass v1-session (session)
  ((community :reader community-of
              :initarg :community
              :type string
              :initform *default-community*))
  (:documentation "SNMP v1 session, community based"))

(defmethod initialize-instance :after ((instance v1-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (slot-value instance 'version) +snmp-version-1+))

(defclass v2c-session (v1-session) ()
  (:documentation "SNMP v2c session, community based"))

(defmethod initialize-instance :after ((instance v2c-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (slot-value instance 'version) +snmp-version-2c+))

(defclass v3-session (session)
  ((security-name :reader security-name
                  :initarg :security-name
		  :type string)
   (security-level :reader security-level
		   :initarg :security-level
		   :type integer
		   :initform +snmp-sec-level-authnopriv+)
   (auth-proto :reader auth-proto
               :initarg :auth-proto
               :type (member :md5 :sha)
               :initform :md5)
   (priv-proto :reader priv-proto
               :initarg :priv-proto
               :type (member :des :aes)
               :initform :des)
   (passphrase :initarg :passphrase
	       :type string))
  (:documentation "SNMP v3 session, user security model"))

(defmethod initialize-instance :after ((instance v3-session)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (slot-value instance 'version) +snmp-version-3+))

(defun open-session (host &key (class *default-class*)
                               (port *default-port*)
                               (community *default-community*))
  #-lispworks
  (let ((s (make-socket :remote-host host
                        :remote-port port
                        :type :datagram
                        :ipv6 nil)))
    (set-socket-option s :receive-timeout :sec 1 :usec 0)
    (make-instance class :socket s :community community))
  #+lispworks
  (make-instance class
                 :socket (open-udp-stream host port
                                          :element-type '(unsigned-byte 8)
                                          :read-timeout 1
                                          :errorp t)
                 :community community))

(defmethod close-session ((instance session))
  (close (socket-of instance)))
