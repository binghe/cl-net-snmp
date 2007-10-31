(in-package :smi)

(defclass message ()
  ((version :type integer
            :initarg :version
            :reader message-version)
   (community :type string
              :initarg :community
              :reader message-comminity)
   (data :initarg :data
         :accessor message-data)))

(defmethod ber-encode ((value message))
  (with-slots (version community data) value
    (ber-encode (list version community data))))

(defmethod decode-message (stream)
  (declare (type stream stream))
  (destructuring-bind (version community pdu) (ber-decode stream)
    (make-instance 'message
                   :version version
                   :community community
                   :data pdu)))
