;;;; Network.lisp, UDP timeout & rtt support for SNMP client

(in-package :snmp)

(defgeneric send-snmp-message (session message &key))

(defun send-until (action socket &key (times 6) (wait-time 2))
  (loop with result = nil
        for i from 0 below times
        until (car result)
        do (progn
             (when (plusp i)
               (format t "resend times: ~A at ~A.~%" i (get-internal-real-time)))
             (funcall action)
             (setf result (wait-for-input socket :timeout wait-time)))
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
               (if *udp-stream-interface*
                 (progn
                   (write-sequence data (socket-stream socket))
                   (force-output (socket-stream socket)))
                 (socket-send socket data (length data)
                              :address (host-of session)
                              :port (port-of session))))
             (recv ()
               (if *udp-stream-interface*
                 (decode-message session (socket-stream socket))
                 (decode-message session (socket-receive socket nil 65507)))))
      (if receive
        (if (send-until #'send socket)
          (recv-until #'recv #'(lambda (x) (= (request-id-of (pdu-of message))
                                              (request-id-of (pdu-of x)))))
          (error "cannot got a reply"))
        (if report
          (unless (send-until #'send socket)
            (error "cannot got a reply when report"))
          (send))))))
