(in-package :snmp)

(defparameter *default-snmp-server-address* 0)
(defparameter *default-snmp-server-port*    8161)
(defvar       *default-snmp-server*         nil)
(defvar       *default-dispatch-table*      (make-hash-table))

(defclass snmp-server ()
  ((process        :accessor server-process
                   :type mp:process
                   :documentation "Server process/thread")
   (address        :accessor server-address
                   :type (or string vector integer)
                   :initarg :address
                   :initform *default-snmp-server-address*
                   :documentation "Server listening address")
   (port           :accessor server-port
                   :type (or string integer)
                   :initarg :port
                   :initform *default-snmp-server-port*
                   :documentation "Server listening port")
   (function       :accessor server-function
                   :type (function (t) t)
                   :initarg :function
                   :initform #'snmp-server-function
                   :documentation "Message processing function")
   (dispatch-table :accessor server-dispatch-table
                   :type hash-table
                   :initarg :dispatch-table
                   :initform *default-dispatch-table*
                   :documentation "Object ID dispatch table"))
  (:documentation "SNMP server class"))

(defmethod print-object ((object snmp-server) stream)
  (print-unreadable-object (object stream :type t)
    (format stream "SNMP Server ~A:~D"
            (server-address object) (server-port object))))

(defmethod initialize-instance :after ((instance snmp-server)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (server-process instance)
        (comm:start-udp-server :address (server-address instance)
                               :service (server-port instance)
                               :announce nil
                               :process-name (format nil "SNMP Server ~A:~D"
                                                     (server-address instance)
                                                     (server-port instance))
                               :function (server-function instance)
                               :arguments (list (server-dispatch-table instance)))))
        
(defun enable-snmp-service (&optional (port *default-snmp-server-port*))
  (if (null *default-snmp-server*)
      (setf *default-snmp-server*
            (make-instance 'snmp-server :port port))))

(defun disable-snmp-service ()
  (when *default-snmp-server*
    (comm:stop-udp-server (server-process *default-snmp-server*) :wait t)
    (setf *default-snmp-server* nil)))

(defvar *dispatch-table*)

(defun snmp-server-function (input dispatch-table)
  "Main function in UDP loop"
  (let ((*dispatch-table* dispatch-table))
    (let ((output (process-message (ber-decode input))))
      (when output
        (ber-encode output)))))

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
  (declare (ignore pdu))
  nil)

(defmethod process-pdu ((pdu get-request-pdu))
  "Process SNMP Get-Request-PDU
   call oid handler and return a correct Response-PDU"
  (with-slots (request-id variable-bindings) pdu
    (let ((vb (mapcar #'(lambda (vb) (list (elt vb 0)
                                           (process-object-id (elt vb 0) nil)))
                      (coerce variable-bindings 'list))))
      (make-instance 'response-pdu
                     :request-id request-id
                     :variable-bindings vb))))

(defmethod process-pdu ((pdu get-next-request-pdu))
  "Process SNMP Get-Next-Request-PDU
   search for next oid, call handler and return Response-PDU"
  (declare (ignore pdu))
  (error "not implemented"))

(defgeneric process-object-id (oid original))

(defmethod process-object-id ((oid object-id) original)
  (process-object-id oid oid))

(defmethod process-object-id ((oid object-id) (original object-id))
  (if (not (oid-parent-p oid))
      original
    (let ((handler (gethash oid *dispatch-table*)))
      (if handler
          (funcall handler original)
        (process-object-id (oid-parent oid) original)))))

(defun export-object-id (oid function &optional (dispatch-table *default-dispatch-table*))
  (setf (gethash oid dispatch-table) function))

(defun unexport-object-id (oid &optional (dispatch-table *default-dispatch-table*))
  (setf (gethash oid dispatch-table) nil))

(defmacro define-object-id (name (o) &body body)
  (declare (ignore o))
  (let ((oid (gensym)))
    `(let ((,oid (oid ,name)))
       (export-object-id ,oid #'(lambda (o) (declare (ignorable o)) ,@body)))))

(eval-when (:load-toplevel :execute)
  ;; sysDescr
  (define-object-id "sysDescr" (o)
    (format nil "~A ~A"
            (lisp-implementation-type) (lisp-implementation-version)))
  ;; sysContact
  (define-object-id "sysContact" (o) lispworks:*phone-home*)
  ;; sysName
  (define-object-id "sysName" (o) (long-site-name))
  ;; sysLocation
  (define-object-id "sysLocation" (o)
    (format nil "~A ~A ~A" (machine-instance) (machine-type) (machine-version))))
