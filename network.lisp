;;;; Network.lisp, UDP timeout & rtt support for SNMP client

(in-package :snmp)

(defgeneric send-snmp-message (session message &key))

(defmethod send-snmp-message ((session session) (message message) &key (receive t))
  (let ((socket (socket-of session))
        (data (ber-encode message)))
    #+sbcl
    (socket-send socket
		 (coerce data '(simple-array (unsigned-byte 8) (*)))
		 (length data))
    #+lispworks
    (progn
      (write-sequence data socket)
      (force-output socket))
    ;;; time goes up ...
    (when receive
      #+sbcl
      (let ((buffer (socket-receive socket nil 65507)))
	(decode-message session (make-instance 'ber-stream :seq (map 'vector #'char-code buffer))))
      #+lispworks
      (decode-message session socket))))

#+sbcl
(defun open-udp-stream (host port &key element-type &allow-other-keys)
  (declare (type integer port)
	   (type (or vector string) host))
  (let ((socket (make-instance 'inet-socket :type :datagram :protocol :udp
			       :element-type element-type))
	(address (if (stringp host)
		     (host-ent-address (get-host-by-name host)) host)))
    (socket-connect socket address port)
    socket))

#+cmu
(defun open-udp-stream (host port &key &allow-other-keys)
  (declare (type integer port)
	   (type (or vector string) host))
  (let ((socket (make-instance 'inet-socket :type :datagram :protocol :udp
			       :element-type element-type))
	(address (if (stringp host)
		     (host-ent-address (get-host-by-name host)) host)))
    (socket-connect socket address port)
    socket))
