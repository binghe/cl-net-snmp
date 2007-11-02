(in-package :snmp)

(defgeneric snmp-get (object &rest vars)
  (:documentation "SNMP Get"))

(defmethod snmp-get ((host string) &rest vars)
  (let ((session (open-session host)))
    (unwind-protect
        (apply #'snmp-get session vars)
      (close-session session))))

(defmethod snmp-get ((session v1-session) &rest vars)
  (let ((vb (mapcar #'(lambda (x) (list (etypecase x
                                          (object-id x)
                                          (string (resolve x))) nil)) vars)))
    (let ((message (make-instance 'message
                                  :version (version-of session)
                                  :community (community-of session)
                                  :data (make-instance 'get-request-pdu
                                                       :request-id 0
                                                       :variable-bindings vb))))
      (let ((data (ber-encode message))
            (socket (socket-of session)))
        #-lispworks
        (socket-send (make-array (length data)
                                 :element-type '(unsigned-byte 8)
                                 :adjustable nil
                                 :initial-contents data)
                     socket)
        #+lispworks (progn (write-sequence data socket) (force-output socket))
        (let ((message (decode-message socket)))
          (mapcar #'second
                  (variable-bindings
                   (message-data message))))))))
