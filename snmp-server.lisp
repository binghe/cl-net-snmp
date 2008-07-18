(in-package :snmp)

(defvar *server-dispatch-table* (make-hash-table :test #'equal)
  "SNMP server dispatch table")

#+ignore
(defmacro defoid (oid (var) &body body)
  (let ((h (gensym)) (o (*->oid oid)))
    `(let ((,h #'(lambda (,var) ,@body)))
       (setf (gethash ',(oid-revid o) *server-dispatch-table*) ,h))))

(defun undefine-oid-handler (revid)
  (setf (gethash revid *server-dispatch-table*) nil))

(defun process-oid-request (oid)
  "Process a OID request, do the real server work and reply a result (not implemented)"
  (declare (type object-id oid))
  (process-oid (oid-revid oid)))

(defun process-oid (revid &optional (base revid))
  (declare (type list revid))
  (let ((handler (gethash revid *server-dispatch-table*)))
    (if handler
      (funcall handler base)
      (process-oid (cdr revid) base))))

(defvar *snmp-server-log* nil)

(defun snmp-server-function (input)
  "Main function in UDP loop
   accept input as vector, decode, call process-message, encode into vector and return"
  (push (format nil "[~A] ~A:~A~%"
                (get-universal-time) comm:*client-address* comm:*client-port*)
        *snmp-server-log*)
  (let ((output (process-message (ber-decode input))))
    (when output
      (coerce (ber-encode output)
              '(simple-array (unsigned-byte 8) (*))))))

(defun process-message (message-list)
  "return a message sequence"
  (process-message-internal (elt message-list 0) message-list))

(defgeneric process-message-internal (version message-list)
  (:documentation "Process SNMP Message"))

(defmethod process-message-internal ((version (eql +snmp-version-1+)) (message-list sequence))
  "Process SNMP v1 message"
  (process-message-v1/v2c message-list))

(defmethod process-message-internal ((version (eql +snmp-version-2c+)) (message-list sequence))
  "Process SNMP v2c message"
  (process-message-v1/v2c message-list))

(defun process-message-v1/v2c (message-list)
  (dbind (version community pdu) message-list
    (let ((reply-pdu (process-pdu pdu)))
      (when reply-pdu
        (list version community reply-pdu)))))

(defmethod process-message-internal ((version (eql +snmp-version-3+)) (message-list sequence))
  "Process SNMP v3 message, not implemented"
  nil)

(defgeneric process-pdu (pdu)
  (:documentation "Process SNMP PDU"))

(defmethod process-pdu ((pdu pdu))
  "Default PDU process function, as a fallback, we don't reply it"
  nil)

(defmethod process-pdu ((pdu get-request-pdu))
  "Process SNMP Get-Request-PDU
   call oid handler and return a correct Response-PDU"
  (with-slots (request-id variable-bindings) pdu
    (let ((vb (mapcar #'(lambda (vb) (list (car vb)
                                           (process-oid-request (car vb))))
                      variable-bindings)))
      (make-instance 'response-pdu
                     :request-id request-id
                     :variable-bindings vb))))

(defmethod process-pdu ((pdu get-next-request-pdu))
  "Process SNMP Get-Next-Request-PDU
   search for next oid, call handler and return Response-PDU"
  nil)

(defclass snmp-server ()
  ((process :accessor server-process
            :initform nil)
   (address :accessor server-address
            :type (or string vector)
            :initarg :address
            :initform nil
            :documentation "Server listening address, nil for add local address")
   (port :accessor server-port
         :type (or string integer)
         :initarg :port
         :initform 8161
         :documentation "Server listening UDP service/port")
   (function :accessor server-function
             :type (function ((simple-array (unsigned-byte 8) (*)))
                             (simple-array (unsigned-byte 8) (*)))
             :initarg :function
             :initform #'snmp-server-function))
  (:documentation "SNMP Server"))

(defvar *snmp-server* nil)

(defmethod control ((server snmp-server) (action (eql :start)))
  "SNMP server start"
  (with-slots (process address port function) server
    (unless process
      (setf process (comm:start-udp-server :address address
                                           :service port
                                           :announce nil
                                           :process-name (format nil "SNMP Server (~A:~A)"
                                                                 (or address "*") port)
                                           :function function)))))

(defmethod control ((server snmp-server) (action (eql :stop)))
  "SNMP server stop"
  (with-slots (process) server
    (when process
      (comm:stop-udp-server process :wait t)
      (setf process nil))))

(defun enable-snmp-service (&optional (port 8161))
  (unless *snmp-server*
    (let ((snmpd (make-instance 'snmp-server :port port)))
      (control snmpd :start)
      (setf *snmp-server* snmpd))))

(defun disable-snmp-service ()
  (when *snmp-server*
    (control *snmp-server* :stop)
    (setf *snmp-server* nil)))
