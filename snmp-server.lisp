;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; This is a simple SNMP server implementation with no access control yet.
;;;; It accepts any SNMPv2 and SNMPv2c request.

(in-package :snmp)

(defvar *default-snmp-server-address* "localhost")
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

            (server-port object))))

(defmethod initialize-instance :after ((instance snmp-server)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (server-process instance)
        #+(and lispworks win32)
        (comm:start-udp-server :process-name (format nil "SNMP Server at ~A:~D"
                                                     (server-address instance)
                                                     (server-port instance))
                               :function (server-function instance)
                               :arguments (list instance)
                               :address (server-address instance)
                               :service (server-port instance))
        #-(and lispworks win32)
        (spawn-thread
	 (format nil "SNMP Server at ~A:~D"
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
  (when *default-snmp-server*
    #+(and lispworks win32)
    (comm:stop-udp-server (server-process *default-snmp-server*)
                          :wait t)
    #-(and lispworks win32)
    (kill-thread
     (server-process *default-snmp-server*))
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
  (let* ((dispatch-table (server-dispatch-table *server*))
         (handler (gethash oid dispatch-table)))
    (list oid
          (if handler
              (funcall handler *server*)
            :no-such-instance))))

(defun oid-find-next (oid &optional (dispatch-table *default-dispatch-table*))
  "Find next dispatched object-id or nil"
  (declare (type object-id oid)
           (type hash-table dispatch-table))
  (labels ((iter (oid)
             (unless (null oid)
               (let ((next (oid-next oid)))
                 (if (gethash next dispatch-table)
                     next
                   (iter next))))))
    (iter oid)))

(defmethod process-object-id ((oid object-id) (flag (eql :get-next)))
  (let* ((dispatch-table (server-dispatch-table *server*))
         (walk-table (server-walk-table *server*))
         (walk-list (gethash oid walk-table)))
    (let ((next-oid (if walk-list
                        (cadr walk-list)
                      (oid-find-next oid dispatch-table))))
      (if next-oid
          (list next-oid
                (funcall (gethash next-oid dispatch-table) *server*))
        (list oid :end-of-mibview)))))
