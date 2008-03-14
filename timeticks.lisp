(in-package :snmp)

(defclass timeticks (general-type)
  ()
  (:documentation "Timeticks: per second/100"))

(defmethod plain-value ((object timeticks))
  (/ (value-of object 100.0)))

(defmethod print-object ((object timeticks) stream)
  (let (hours minutes seconds seconds/100 (ticks (value-of object)))
    (multiple-value-bind (s s/100) (floor ticks 100)
      (setf seconds/100 s/100)
      (multiple-value-bind (h s) (floor s 3600) ; hours
        (setf hours h)
        (multiple-value-bind (m s) (floor s 60) ; minutes
          (setf minutes m
                seconds s))))
    (print-unreadable-object (object stream :type t)
      (format stream "(~D) ~D:~2,'0D:~2,'0D.~2,'0D"
              ticks hours minutes seconds seconds/100))))

(defmethod ber-encode ((tvalue timeticks))
  (let ((value (value-of tvalue)))
    (multiple-value-bind (v l) (ber-encode-integer value)
      (nconc (ber-encode-type 1 0 3)
             (ber-encode-length l)
             v))))

(defmethod ber-decode-value ((stream stream) (type (eql :timeticks)) length)
  (declare (type fixnum length) (ignore type))
  (make-instance 'timeticks :value (ber-decode-integer-value stream length)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :timeticks 1 0 3))
