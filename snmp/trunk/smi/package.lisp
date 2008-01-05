(in-package :snmp.system)

(defpackage smi
  (:use :common-lisp :asn.1 #-lispworks :net.sockets #+lispworks :comm)
  (:export ;; general
           value-of general-type plain-value
           ;; object-id
           object-id oid make-object-id rev-ids rev-names
	   oid-length oid-revid oid-name
           oid-<
           *oid-print-name* *oid-print-id* *oid-print-short*
           *oid-print-length*
           ;; sequence
           empty-sequence-p
           ;; pdu
           get-request-pdu
           get-next-request-pdu
           response-pdu
           set-request-pdu
           inform-request-pdu
           snmpv2-trap-pdu
           report-pdu
           error-status
           error-index
           ;; message
           v1-message
           v3-message
           decode-message
           variable-bindings
           msg-data-of
           request-id
           ;; timeticks
           timeticks ticks hours minutes seconds s/100
           ;; other
           opaque gauge counter counter32 counter64))

(in-package :smi)

;;; used by counter, gauge and opaque
(defclass general-type ()
  ((value :accessor value-of :initarg :value)))

(defmethod print-object ((obj general-type) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (value-of obj))))

(defgeneric plain-value (object))
(defmethod plain-value ((object general-type))
  (value-of object))

(defparameter *version* 3)
