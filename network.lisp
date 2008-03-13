;;;; Network.lisp, UDP timeout & rtt support for SNMP client

(in-package :snmp)

(defgeneric send-snmp-message (session message &key))

#+lispworks
(defun send-until (action socket &key (times 6) (wait-time 2))
  (loop with result = nil
        for i from 0 below times
        until result
        do (progn
             (when (plusp i)
               (format t "resend times: ~A at ~A.~%" i (get-internal-real-time)))
             (funcall action)
             #-win32 (mp:notice-fd socket)
             (setf result
                   (mp:process-wait-with-timeout "Waiting for a socket to become active"
                                                 wait-time
                                                 #'(lambda () (comm::socket-listen socket))))
             #-win32 (mp:unnotice-fd socket))
        finally (return result)))

#+lispworks
(defun recv-until (action stop-reason)
  (loop as message = (funcall action)
        until (funcall stop-reason message)
        do (format t "give up one packet at ~A.~%" (get-internal-real-time))
        finally (return message)))
  
(defmethod send-snmp-message ((session session) (message message) &key (receive t))
  (let ((socket (socket-of session))
        (data (ber-encode message)))
    (labels ((send ()
               #+lispworks
               (progn 
                 (write-sequence data socket)
                 (force-output socket))
               #+sbcl
               (sb-bsd-sockets:socket-send socket
                                           (coerce data '(simple-array (unsigned-byte 8) (*)))
                                           (length data)))
             (recv ()
               #+lispworks
               (decode-message session socket)
               #+sbcl
               (let ((buffer (sb-bsd-sockets:socket-receive socket nil 65507)))
                 (decode-message session (make-instance 'ber-stream
                                                        :seq (map 'vector #'char-code buffer))))))
      (if (not receive)
        (send)
	#+lispworks
        (progn
          (if (send-until #'send (socket-stream-socket socket)
                          #+ignore #'(lambda () (listen socket)))
	    (recv-until #'recv #'(lambda (x) (= (request-id-of (pdu-of message))
                                                (request-id-of (pdu-of x)))))
            (error "cannot got a reply")))
	#+sbcl
	(progn
	  (send)
	  (recv))))))

#+sbcl
(defun open-udp-stream (host port &key element-type &allow-other-keys)
  (declare (type integer port)
	   (type (or vector string) host))
  (let ((socket (make-instance 'sb-bsd-sockets:inet-socket :type :datagram :protocol :udp
			       :element-type element-type))
	(address (if (stringp host)
		     (sb-bsd-sockets:host-ent-address (sb-bsd-sockets:get-host-by-name host)) host)))
    (sb-bsd-sockets:socket-connect socket address port)
    socket))

#+cmu
(defun open-udp-stream (host port &key &allow-other-keys)
  nil)
