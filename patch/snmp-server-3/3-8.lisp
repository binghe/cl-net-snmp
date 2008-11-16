;;;; Patch 3.8, fix for SCL

(in-package :snmp)

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
                                         (list instance))
                          #+scl (thread:thread-exit)))))
