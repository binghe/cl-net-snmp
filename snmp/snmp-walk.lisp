(in-package :snmp)

(defgeneric snmp-walk (object var)
  (:documentation "SNMP Walk"))

(defmethod snmp-walk ((host string) var)
  (let ((session (make-session host)))
    (unwind-protect
        (snmp-walk (make-session host) var)
      (close (socket-of session)))))

#-win32
(defmethod snmp-walk ((session v1-session) (var object-id))
  "SNMP Walk for v1 and v2c"
  (let ((message (make-instance 'message
                                :version (version-of session)
                                :community (community-of session)
                                :data (make-instance 'get-next-request-pdu
                                                     :request-id 0
                                                     :variable-bindings (list nil)))))
    (labels ((iter (v id acc)
               (setf (car (variable-bindings (message-data message))) (list v nil)
                     (request-id (message-data message)) id)
               (let ((data (ber-encode message))
                     (socket (socket-of session)))
                 (socket-send (make-array (length data)
                                          :element-type '(unsigned-byte 8)
                                          :adjustable nil
                                          :initial-contents data
                                          #+lispworks :allocation #+lispworks :static)
                              socket)
                 (let ((result (decode-message socket)))
                   (let ((vb (car (variable-bindings (message-data result)))))
                     (if (not (oid-< (car vb) var))
                       (nreverse acc)
                       (iter (first vb) (1+ id) (cons vb acc))))))))
      (iter var 0 nil))))

(defmethod snmp-walk ((session v1-session) (var string))
  (let ((oid (resolve var)))
    (when oid (snmp-walk session oid))))
