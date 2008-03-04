;;;; Network.lisp, UDP timeout & rtt support for SNMP client

(in-package :snmp)

(defgeneric send-snmp-message (session message &key))

(defmethod send-snmp-message ((session session) (message message) &key (receive t))
  (let ((socket (socket-of session))
        (data-send (ber-encode message)))
    (write-sequence data-send socket)
    (force-output socket)
    ;;; time goes up ...
    (when receive
      (decode-message session socket))))
