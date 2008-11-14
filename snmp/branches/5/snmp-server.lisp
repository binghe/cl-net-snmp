;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defvar *default-snmp-server-address* "0.0.0.0")
(defvar *default-snmp-server-port*    8161)
(defvar *default-snmp-server*         nil)
(defvar *default-dispatch-table*      (make-hash-table))
(defvar *default-walk-table*          (make-hash-table))
(defvar *default-walk-list*           nil)

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
                  :accessor snmp-vacm-view-table))
  (:documentation "SNMP VACM access control tables"))

(defclass snmp-server (snmp-agent-state-mixin snmp-vacm-mixin)
  ((process        :accessor server-process
                   :type (satisfies threadp)
                   :initarg :process
                   :documentation "Server process/thread")
   (address        :accessor server-address
                   :type (or string integer)
                   :initarg :address
                   :documentation "Server listening address")
   (port           :accessor server-port
                   :type integer
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
   (walk-table     :accessor server-walk-table
                   :type hash-table
                   :initarg :walk-table)
   (walk-list      :accessor server-walk-list
                   :type list
                   :initarg :walk-list)
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
    (format stream "SNMP Server at ~A:~D"
            (server-address object)
            (server-port object))))

(defmethod initialize-instance :after ((instance snmp-server)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (server-process instance)
        #+(and lispworks mswindows)
        (comm:start-udp-server :process-name (format nil "SNMP Server at ~A:~D"
                                                     (server-address instance)
                                                     (server-port instance))
                               :function (server-function instance)
                               :arguments (list instance)
                               :address (server-address instance)
                               :service (server-port instance))
        #-(and lispworks mswindows)
        (spawn-thread (format nil "SNMP Server at ~A:~D"
                              (server-address instance)
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
			   :dispatch-table *default-dispatch-table*
                           :walk-table *default-walk-table*
                           :walk-list *default-walk-list*))))

(defun disable-snmp-service ()
  "Kill server thread and clear variable"
  (when *default-snmp-server*
    #+(and lispworks mswindows)
    (comm:stop-udp-server (server-process *default-snmp-server*) :wait t)
    #-(and lispworks mswindows)
    (kill-thread (server-process *default-snmp-server*))
    ;; clear variable
    (setf *default-snmp-server* nil)))

(defun reload-snmp-service (&optional (stream t))
  (format stream "Restarting SNMP Service .")
  (disable-snmp-service)
  (format stream ".")
  (sleep 1)
  (format stream ".")
  (enable-snmp-service)
  (format stream " Done.~%"))

(defvar *server*)

(defun snmp-server-function (input server)
  "Main function in UDP loop"
  (declare (type array input)
           (type snmp-server server))
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
  (destructuring-bind (version community pdu) (coerce message 'list)
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
  (let ((dispatch-table (server-dispatch-table *server*)))
    (cond ((oid-scalar-variable-p oid)
           (let ((handler (gethash (oid-parent oid) dispatch-table)))
             (if handler
               (list oid (funcall handler *server* t))
               (list oid (smi :no-such-instance)))))
          ((oid-trunk-p oid)
           (list oid (smi :no-such-instance))) ; no value
          ((oid-leaf-p oid)
           (list oid (smi :no-such-instance))) ; no value
          (t (multiple-value-bind (leaf ids) (oid-find-leaf oid)
               (if leaf
                 (let ((handler (gethash leaf dispatch-table)))
                   (if handler
                     (list oid (funcall handler *server* ids))))
                 (list oid (smi :no-such-instance))))))))

;;; note: since get-next support is too large, it's moved to server-walk.lisp
