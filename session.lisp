(in-package :snmp)

(defconstant +snmp-version-1+  0)
(defconstant +snmp-version-2c+ 1)
(defconstant +snmp-version-3+  3)

(defparameter *default-version* +snmp-version-2c+)
(defparameter *default-port* 161)
(defparameter *default-community* "public")
(defparameter *default-auth-protocol* :md5)
(defparameter *default-priv-protocol* :des)

(defclass session ()
  ((socket            :type socket-stream
		      :accessor socket-of
		      :initarg :socket)
   (host              :type string
                      :accessor host-of
                      :initarg :host)
   (port              :type integer
                      :accessor port-of
                      :initarg :port)
   (version           :type integer
                      :accessor version-of
                      :initarg :version))
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
   (security-level    :type (unsigned-byte 8)
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
   (auth-local-key    :type (simple-array (unsigned-byte 8) (*))
                      :initarg :auth-local-key
                      :accessor auth-local-key-of)
   (priv-protocol     :type (member :des :aes nil)
                      :initarg :priv-protocol
                      :initform nil
                      :accessor priv-protocol-of)
   (priv-key          :type (simple-array (unsigned-byte 8) (*))
		      :initarg :priv-key
		      :accessor priv-key-of)
   (priv-local-key    :type (simple-array (unsigned-byte 8) (*))
                      :initarg :priv-local-key
                      :accessor priv-local-key-of))
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
          security-level (logior (if auth-protocol #b01 #b00)
                                 (if priv-protocol #b10 #b00)))))

(defvar *snmp-class-table* (make-hash-table))

(eval-when (:load-toplevel :execute)
  (setf (gethash +snmp-version-1+ *snmp-class-table*) 'v1-session
        (gethash +snmp-version-2c+ *snmp-class-table*) 'v2c-session
        (gethash +snmp-version-3+ *snmp-class-table*) 'v3-session))

(defun open-session (host &key port version community user auth priv)
  ;; first, what version we are talking about if version not been set?
  (let* ((real-version (or version
                           (if user +snmp-version-3+ *default-version*)))
         (socket (if *udp-stream-interface*
                   (socket-connect/udp host (or port *default-port*)
                                       :stream t :element-type '(unsigned-byte 8))
                   (socket-connect/udp nil nil)))
         (args (list (gethash real-version *snmp-class-table*)
                     :socket socket :host host :port port)))
    (if (/= real-version +snmp-version-3+)
      ;; for SNMPv1 and v2c, only set the community
      (nconc args (list :community (or community *default-community*)))
      ;; for SNMPv3, we detect the auth and priv parameters
      (progn
        (nconc args (list :security-name user))
        (when auth
          (if (atom auth)
            (nconc args (list :auth-protocol *default-auth-protocol*)
                   (if (stringp auth)
                     (list :auth-key (generate-ku auth :hash-type *default-auth-protocol*))
                     (list :auth-local-key
                           (coerce auth '(simple-array (unsigned-byte 8) (*))))))
            (destructuring-bind (auth-protocol . auth-key) auth
              (nconc args (list :auth-protocol auth-protocol)
                     (let ((key (if (atom auth-key) auth-key (car auth-key))))
                       (if (stringp key)
                         (list :auth-key (generate-ku key :hash-type auth-protocol))
                         (list :auth-local-key
                               (coerce key '(simple-array (unsigned-byte 8) (*))))))))))
        (when priv
          (if (atom priv)
            (nconc args (list :priv-protocol *default-priv-protocol*)
                   (if (stringp auth)
                     (list :priv-key (generate-ku priv :hash-type :md5))
                     (list :priv-local-key (coerce priv
                                                   '(simple-array (unsigned-byte 8) (*))))))
            (destructuring-bind (priv-protocol . priv-key) priv
              (nconc args (list :priv-protocol priv-protocol)
                     (let ((key (if (atom priv-key) priv-key (car priv-key))))
                       (if (stringp key)
                         (list :priv-key (generate-ku key :hash-type :md5))
                         (list :priv-local-key (coerce key
                                                       '(simple-array (unsigned-byte 8) (*))))))))))))
    (apply #'make-instance args)))

(defmethod close-session ((session session))
  (socket-close (socket-of session)))

(defmacro with-open-session ((session &rest args) &body body)
  `(let ((,session (open-session ,@args)))
     (unwind-protect
         (progn ,@body)
       (close-session ,session))))
