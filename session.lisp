(in-package :snmp)

(defparameter *default-version* +snmp-version-1+)
(defparameter *default-port* 161)
(defparameter *default-community* "public")
(defparameter *default-security-name* "snmp")
(defparameter *default-auth-protocol* :md5)
(defparameter *default-priv-protocol* :des)

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
                      :initform ""
		      :accessor engine-id-of)
   (engine-boots      :type integer
		      :initarg :engine-boots
                      :initform 0
		      :accessor engine-boots-of)
   (engine-time       :type integer
		      :initarg :engine-time
                      :initform 0
		      :accessor engine-time-of)
   (auth-protocol     :type (member :md5 :sha1 nil)
                      :initarg :auth-protocol
                      :initform nil
                      :accessor auth-protocol-of)
   (auth-key          :type (simple-array (unsigned-byte 8) (*))
		      :initarg :auth-key
		      :accessor auth-key-of)
   (priv-protocol     :type (member :des :aes nil)
                      :initarg :priv-protocol
                      :initform nil
                      :accessor priv-protocol-of)
   (priv-key          :type (simple-array (unsigned-byte 8) (*))
		      :initarg :priv-key
		      :accessor priv-key-of))
  (:documentation "SNMP v3 session, user security model"))

(defmethod initialize-instance :after ((session v1-session) &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value session 'version) +snmp-version-1+))

(defmethod initialize-instance :after ((session v2c-session) &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value session 'version) +snmp-version-2c+))

(defmethod initialize-instance :after ((session v3-session) &rest initargs)
  (declare (ignore initargs))
  (with-slots (version security-level auth-protocol priv-protocol) session
    (setf version +snmp-version-3+
          ;; msgFlags = Security-Level + Reportable:
          ;; .... .1.. = Reportable: Set
          ;; .... ..1. = Encrypted: Set
          ;; .... ...1 = Authenticated: Set
          security-level (+ (if auth-protocol #b01 #b00)
                            (if priv-protocol #b10 #b00)))))

(defvar *snmp-class-table* (make-hash-table))

(eval-when (:load-toplevel :execute)
  (setf (gethash +snmp-version-1+ *snmp-class-table*) 'v1-session
        (gethash +snmp-version-2c+ *snmp-class-table*) 'v2c-session
        (gethash +snmp-version-3+ *snmp-class-table*) 'v3-session))

(defgeneric *->key (key))

(defmethod *->key ((key string))
  (map '(simple-array (unsigned-byte 8) (*)) #'char-code key))

(defmethod *->key ((key sequence))
  (concatenate '(simple-array (unsigned-byte 8) (*)) key))

(Defun open-session (host &key port version community user auth priv (read-timeout 1))
  ;; first, what version we are talking about if version not been set?
  (let* ((real-version (or version
                          (if user +snmp-version-3+ *default-version*)))
         (socket (open-udp-stream host (or port *default-port*)
                                  :element-type '(unsigned-byte 8)
                                  :read-timeout read-timeout
                                  :errorp t))
         (args (list (gethash real-version *snmp-class-table*)
                     :socket socket)))
    (if (/= real-version +snmp-version-3+)
      (nconc args (list :community (or community *default-community*)))
      ;; for SNMPv3, we detect the auth and priv parameters
      (progn
        (nconc args (list :security-name
                          (or user *default-security-name*)))
        (when auth
          (if (atom auth)
            (nconc args (list :auth-protocol *default-auth-protocol*
                              :auth-key (*->key auth)))
            (let ((auth-protocol (car auth))
                  (auth-key (cdr auth)))
              (nconc args (list :auth-protocol auth-protocol
                                :auth-key (*->key (if (atom auth-key) auth-key
                                                    (car auth-key))))))))
        (when priv
          (if (atom priv)
            (nconc args (list :priv-protocol *default-priv-protocol*
                              :priv-key (*->key priv)))
            (let ((priv-protocol (car priv))
                  (priv-key (cdr priv)))
              (nconc args (list :priv-protocol priv-protocol
                                :priv-key (*->key (if (atom priv-key) priv-key
                                                    (car priv-key))))))))))
    (apply #'make-instance args)))

(defmethod close-session ((session session))
  (close (socket-of session)))

(defmacro with-open-session ((session &rest args) &body body)
  `(let ((,session (open-session ,@args)))
     (unwind-protect
         (progn ,@body)
       (close-session ,session))))
