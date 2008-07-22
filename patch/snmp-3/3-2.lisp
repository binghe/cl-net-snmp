;;; 3-2: Portable SNMP Server support added.

(in-package :snmp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:oos 'asdf:load-op :bordeaux-threads))

(defclass snmp-server ()
  ((process        :accessor server-process
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

(defmethod initialize-instance :after ((instance snmp-server)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (server-process instance)
        (bt:make-thread #'(lambda ()
                            (socket-server (server-address instance)
                                           (server-port instance)
                                           (server-function instance)
                                           (list (server-dispatch-table instance))))
                        :name (format nil "SNMP Server at ~A:~D"
                                      (server-address instance)
                                      (server-port instance)))))
        
(defun disable-snmp-service ()
  (when *default-snmp-server*
    (bt:destroy-thread (server-process *default-snmp-server*))
    (setf *default-snmp-server* nil)))

(eval-when (:load-toplevel :execute)
  (define-object-id "sysContact" (o) "Chun Tian (binghe) <binghe.lisp@gmail.com>"))
