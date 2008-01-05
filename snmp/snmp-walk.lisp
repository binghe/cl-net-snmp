(in-package :snmp)

(defgeneric snmp-walk (object var)
  (:documentation "SNMP Walk"))

(defmethod snmp-walk ((host string) var)
  (let ((session (open-session host)))
    (unwind-protect
        (snmp-walk session var)
      (close-session session))))

(defmethod snmp-walk ((session v1-session) (var object-id))
  "SNMP Walk for v1 and v2c"
  (let ((message (make-instance 'v1-message
                                :version (version-of session)
                                :community (community-of session)
                                :data (make-instance 'get-next-request-pdu
                                                     :request-id 0
                                                     :variable-bindings (list nil)))))
    (labels ((iter (v id acc)
               (setf (car (variable-bindings (msg-data-of message))) (list v nil)
                     (request-id (msg-data-of message)) id)
               (let ((data (ber-encode message))
                     (socket (socket-of session)))
                 #-lispworks
                 (socket-send (make-array (length data)
                                          :element-type '(unsigned-byte 8)
                                          :adjustable nil
                                          :initial-contents data)
                              socket)
                 #+lispworks
                 (progn
                   (write-sequence data socket)
                   (force-output socket))
                 (let ((result (decode-message socket 1)))
                   (let ((vb (car (variable-bindings (msg-data-of result)))))
                     (if (not (oid-< (car vb) var))
                       (nreverse acc)
                       (iter (first vb) (1+ id) (cons vb acc))))))))
      (iter var 0 nil))))

(defmethod snmp-walk ((session v1-session) (var string))
  (let ((oid (resolve var)))
    (when oid (snmp-walk session oid))))
