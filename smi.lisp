(in-package :snmp)

(defclass general-type ()
  ((value :accessor value-of
          :initarg :value))
  (:documentation "General Container Type, used by counter, gauge and opaque, etc."))

(defmethod print-object ((obj general-type) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (value-of obj))))

(defgeneric plain-value (object)
  (:documentation "Plain value: map a ASN.1 object into plain lisp values"))

(defmethod plain-value ((object general-type))
  (value-of object))

(defmethod ber-equal ((a general-type) (b general-type))
  (= (value-of a) (value-of b)))
