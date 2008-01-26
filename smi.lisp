(in-package :snmp)

;;; used by counter, gauge and opaque
(defclass general-type ()
  ((value :accessor value-of :initarg :value)))

(defmethod print-object ((obj general-type) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (value-of obj))))

(defgeneric plain-value (object))
(defmethod plain-value ((object general-type))
  (value-of object))
