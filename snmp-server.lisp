;;;; $Id$

(in-package :snmp)

(defparameter *default-snmp-server-address* 0)
(defparameter *default-snmp-server-port*    8161)
(defvar       *default-snmp-server*         nil)
(defvar       *default-dispatch-table*      (make-hash-table))

(defclass snmp-agent-state-mixin ()
  ((start-up-time          :type (unsigned-byte 32) :initform 0)
   (in-pkts                :type (unsigned-byte 32) :initform 0)
   (out-pkts               :type (unsigned-byte 32) :initform 0)
   (in-bad-versions        :type (unsigned-byte 32) :initform 0)
   (in-bad-community-names :type (unsigned-byte 32) :initform 0)
   (in-bad-community-uses  :type (unsigned-byte 32) :initform 0)
   (in-asn-parse-errs      :type (unsigned-byte 32) :initform 0)
   (in-too-bigs            :type (unsigned-byte 32) :initform 0)
   (in-no-such-names       :type (unsigned-byte 32) :initform 0)
   (in-bad-values          :type (unsigned-byte 32) :initform 0)
   (in-read-onlys          :type (unsigned-byte 32) :initform 0)
   (in-gen-errs            :type (unsigned-byte 32) :initform 0)
   (in-total-req-vars      :type (unsigned-byte 32) :initform 0)
   (in-total-set-vars      :type (unsigned-byte 32) :initform 0)
   (in-get-requests        :type (unsigned-byte 32) :initform 0)
   (in-get-nexts           :type (unsigned-byte 32) :initform 0)
   (in-set-requests        :type (unsigned-byte 32) :initform 0)
   (in-get-responses       :type (unsigned-byte 32) :initform 0)
   (in-traps               :type (unsigned-byte 32) :initform 0)
   (out-too-bigs           :type (unsigned-byte 32) :initform 0)
   (out-no-such-names      :type (unsigned-byte 32) :initform 0)
   (out-bad-values         :type (unsigned-byte 32) :initform 0)
   (out-gen-errs           :type (unsigned-byte 32) :initform 0)
   (out-get-requests       :type (unsigned-byte 32) :initform 0)
   (out-get-nexts          :type (unsigned-byte 32) :initform 0)
   (out-set-requests       :type (unsigned-byte 32) :initform 0)
   (out-get-responses      :type (unsigned-byte 32) :initform 0)
   (out-traps              :type (unsigned-byte 32) :initform 0))
  (:documentation "SNMP Agent State"))

;;; p.50, Solaris System Management Agent Administration Guide
(defclass snmp-vacm-mixin ()
  ((group-table   :type hash-table
                  :initform (make-hash-table :test #'equal)
                  :accessor snmp-vacm-group-table)
   (context-table :type hash-table
                  :initform (make-hash-table :test #'equal)
                  :accessor snmp-vacm-context-table)
   (access-table  :type hash-table
                  :initform (make-hash-table :test #'equal)
                  :accessor snmp-vacm-access-table)
   (view-table    :type hash-table
                  :initform (make-hash-table :test #'equal)
                  :accessor snmp-vacm-view-table)))

(defclass snmp-server (snmp-agent-state-mixin snmp-vacm-mixin)
  ((process        :accessor server-process
                   :documentation "Server process/thread")
   (address        :accessor server-address
                   :type (or null string vector integer)
                   :initarg :address
                   :documentation "Server listening address")
   (port           :accessor server-port
                   :type (or string integer)
                   :initarg :port
                   :documentation "Server listening port")
   (function       :accessor server-function
                   :type function
                   :initarg :function
                   :documentation "Message processing function")
   (dispatch-table :accessor server-dispatch-table
                   :type hash-table
                   :initarg :dispatch-table
                   :documentation "Object ID dispatch table")
   (engine-id      :reader server-engine-id
                   :type string)
   (engine-boots   :reader server-engine-boots
                   :type integer
                   :initform 0)
   (engine-time    :reader server-engine-time
                   :type integer
                   :initform 0))
  (:documentation "SNMP server class"))

(defmethod print-object ((object snmp-server) stream)
  (print-unreadable-object (object stream :type t)
    (format stream "SNMP Server ~A:~D"
            (hbo-to-dotted-quad (server-address object))
            (server-port object))))

(defmethod initialize-instance :after ((instance snmp-server)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (server-process instance)
        (spawn-thread
	 (format nil "SNMP Server at ~A:~D"
                 (hbo-to-dotted-quad (server-address instance))
                 (server-port instance))
	 #'(lambda ()
	     (socket-server (server-address instance)
			    (server-port instance)
			    (server-function instance)
			    (list instance))))))
        
(defun enable-snmp-service (&optional (port *default-snmp-server-port*))
  (if (null *default-snmp-server*)
      (setf *default-snmp-server*
            (make-instance 'snmp-server
			   :address *default-snmp-server-address*
			   :port port
			   :function #'snmp-server-function
			   :dispatch-table *default-dispatch-table*))))

(defun disable-snmp-service ()
  (when *default-snmp-server*
    (kill-thread
     (server-process *default-snmp-server*))
    (setf *default-snmp-server* nil)))

(defun reload-snmp-service ()
  (disable-snmp-service)
  (sleep 1)
  (enable-snmp-service))

(defvar *server*)

(defun snmp-server-function (input server)
  "Main function in UDP loop"
  (declare (type array input)
           (type snmp-server))
  (let ((*server* server))
    (let ((output (process-message (ber-decode input))))
      (when output
        (ber-encode output)))))

(defun process-message (message)
  "return a message sequence"
  (declare (type sequence message))
  (process-message-internal (elt message 0) message))

(defgeneric process-message-internal (version message)
  (:documentation "Process SNMP Message"))

(defmethod process-message-internal ((version t) (message sequence))
  "Process unknown message"
  (declare (ignore version message))
  nil)

(defmethod process-message-internal ((version (eql +snmp-version-1+)) (message sequence))
  "Process SNMP v1 message"
  (declare (ignore version))
  (process-message-v1/v2c message))

(defmethod process-message-internal ((version (eql +snmp-version-2c+)) (message sequence))
  "Process SNMP v2c message"
  (declare (ignore version))
  (process-message-v1/v2c message))

(defmethod process-message-internal ((version (eql +snmp-version-3+)) (message sequence))
  "Process SNMP v3 message"
  (declare (ignore version))
  (process-message-v3 message))

(defun process-message-v1/v2c (message)
  (dbind (version community pdu) message
    (let ((reply-pdu (process-pdu pdu)))
      (when reply-pdu
        (list version community reply-pdu)))))

(defun process-message-v3 (message)
  (declare (ignore message))
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
    (let ((vb (mapcar #'(lambda (vb) (process-object-id (elt vb 0) :get))
                      (coerce variable-bindings 'list))))
      (make-instance 'response-pdu
                     :request-id request-id
                     :variable-bindings vb))))

(defmethod process-pdu ((pdu get-next-request-pdu))
  "Process SNMP Get-Next-Request-PDU
   search for next oid, call handler and return Response-PDU"
  (with-slots (request-id variable-bindings) pdu
    (let ((vb (mapcar #'(lambda (vb) (process-object-id (elt vb 0) :get-next))
                      (coerce variable-bindings 'list))))
      (make-instance 'response-pdu
                     :request-id request-id
                     :variable-bindings vb))))

(defgeneric process-object-id (oid flag))

(defmethod process-object-id ((oid object-id) (flag (eql :get)))
  (cond ((oid-scalar-variable-p oid)
         (list oid
               (let ((handler (gethash (oid-parent oid) (server-dispatch-table *server*))))
                 (if handler
                     (funcall handler *server*)
                   :no-such-instance))))
        (t (list oid :no-such-instance))))

(defmethod process-object-id ((oid object-id) (flag (eql :get-next)))
  (labels ((find-next (oid)
             (if (null oid)
                 nil
               (let ((next (oid-next oid)))
                 (if (gethash next (server-dispatch-table *server*))
                     next
                   (find-next next))))))
    (cond ((oid-leaf-p oid)
           (let ((handler (gethash oid (server-dispatch-table *server*))))
             (when (null handler)
               (let ((next (find-next oid)))
                 (setf oid next
                       handler (gethash next
                                        (server-dispatch-table *server*)))))
             (if handler
                 (let ((o (make-instance 'object-id :parent oid :value 0)))
                   (list o (funcall handler *server*)))
               (list (oid-next oid) :end-of-mibview))))
          (t (let ((next-oid (find-next oid)))
               (if next-oid
                   (process-object-id next-oid :get-next)
                 (list (oid-next oid) :end-of-mibview)))))))
