;;;; Network.lisp, UDP timeout & rtt support for SNMP client

(in-package :snmp)

(defparameter *snmp-send-times* 3)
(defparameter *snmp-wait-timeout* 1)

(defgeneric send-snmp-message (session message &key &allow-other-keys))

(defun send-until (action socket &key (times *snmp-send-times*) (wait-time *snmp-wait-timeout*))
  (loop with result = nil
        for i from 0 below times
        until (car result)
        do (progn
             (when (plusp i)
               (format t "resend times: ~A at ~A.~%" i (get-internal-real-time)))
             (funcall action)
             (setf result (wait-for-input (list socket) :timeout wait-time)))
        finally (return result)))

(defun recv-until (action stop-reason)
  (loop as message = (funcall action)
        until (funcall stop-reason message)
        do (format t "give up one packet at ~A.~%" (get-internal-real-time))
        finally (return message)))
  
(defmethod send-snmp-message ((session session) (message message) &key (receive t) (report nil))
  (let ((socket (socket-of session))
        (data (coerce (ber-encode message) '(simple-array (unsigned-byte 8) (*)))))
    (labels ((send ()
               #+lispworks (send-message socket data (length data)
                                         (host-of session) (port-of session))
               #-lispworks (socket-send socket data (length data)
                                        :address (host-of session)
                                        :port (port-of session)))
             (recv ()
               (decode-message session #+lispworks (receive-message socket)
                                       #-lispworks (socket-receive socket nil 65507))))
      (if receive
        ;; receive = t
        (if #-(and lispworks win32) (send-until #'send socket)
            #+(and lispworks win32) (send)
          (recv-until #'recv #'(lambda (x) (= (request-id-of (pdu-of message))
                                              (request-id-of (pdu-of x)))))
          (error "cannot got a reply"))
        ;; receive = nil
        (if report
          (unless (send-until #'send socket)
            (error "cannot got a reply when report"))
          (send))))))
