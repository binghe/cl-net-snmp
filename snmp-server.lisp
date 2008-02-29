(in-package :snmp)

(defvar *server-dispatch-table* (make-hash-table :test #'equal)
  "SNMP server dispatch table")

(defclass snmp-server ()
  ((process :accessor server-process
            :initform nil)
   (address :accessor server-address
            :type (or string vector)
            :initarg :address
            :initform nil
            :documentation "Server listening address, nil for add local address")
   (service :accessor server-service
            :type (or string integer)
            :initarg :service
            :initform 8161
            :documentation "Server listening UDP service/port")
   (function))
  (:documentation "SNMP Server"))

(defmethod control ((server snmp-server) (action (eql :start)))
  (with-slots (process address service) server
    (unless process
      (setf process (start-udp-server :address address
                                      :service service
                                      :announce nil
                                      :process-name (format nil "SNMP Server (~A:~A)"
                                                            (or address "*") service)
                                      :function #'identity)))))

(defmethod control ((server snmp-server) (action (eql :stop)))
  (with-slots (process) server
    (when process
      (mp:process-kill process)
      (setf process nil))))
