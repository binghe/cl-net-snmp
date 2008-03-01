(in-package :snmp)

(defvar *server-dispatch-table* (make-hash-table :test #'equal)
  "SNMP server dispatch table")

(defun process-oid-request (oid)
  "Process a OID request, do the real server work and reply a result (not implemented)"
  (declare (type object-id oid))
  oid)

(defun snmp-server-function (input)
  "Main function in UDP loop
   accept input as vector, decode, call process-message, encode into vector and return"
  (declare (type (simple-array (unsigned-byte 8) (*)) input))
  (let ((output (process-message (ber-decode input))))
    (when output
      (coerce (ber-encode output)
              '(simple-array (unsigned-byte 8) (*))))))

(defgeneric process-message (message)
  (:documentation "Process SNMP Message"))

(defmethod process-message ((message v1-message))
  "Process SNMP v1/v2c message"
  (with-slots (session pdu) message
    (let ((reply-pdu (process-pdu pdu)))
      (when reply-pdu
        (make-instance 'v1-message :session session :pdu reply-pdu)))))

(defmethod process-message ((message v3-message))
  "Process SNMP v3 message"
  (with-slots (session pdu msg-id) message
    (let ((reply-pdu (process-pdu pdu)))
      (when reply-pdu
        (make-instance 'v3-message :session session :pdu reply-pdu :id msg-id)))))

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

(defvar *snmp-server*)

(defmethod control ((server snmp-server) (action (eql :start)))
  "SNMP server start"
  (with-slots (process address port function) server
    (unless process
      (setf process (start-udp-server :address address
                                      :service port
                                      :announce nil
                                      :process-name (format nil "SNMP Server (~A:~A)"
                                                            (or address "*") port)
                                      :function function)))))

(defmethod control ((server snmp-server) (action (eql :stop)))
  "SNMP server stop"
  (with-slots (process) server
    (when process
      (mp:process-kill process)
      (setf process nil))))

(defun init-snmp-server ()
  (setf *snmp-server* (make-instance 'snmp-server)))
