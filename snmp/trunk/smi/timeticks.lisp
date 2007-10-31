(in-package :smi)

(defclass timeticks ()
  ((ticks :type fixnum :initarg :ticks :initform 0 :reader ticks)
   (hours :type fixnum)
   (minutes :type fixnum)
   (seconds :type fixnum)
   (seconds/100 :type fixnum)))

(defmethod plain-value ((object timeticks))
  (ticks object))

(defmethod print-object ((obj timeticks) stream)
  (with-slots (ticks hours minutes seconds seconds/100) obj
    (print-unreadable-object (obj stream :type t)
      (format stream "(~D) ~D:~2,'0D:~2,'0D.~2,'0D"
              ticks hours minutes seconds seconds/100))))

(defmethod initialize-instance :after ((instance timeticks)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (ticks hours minutes seconds seconds/100) instance
    (multiple-value-bind (s s/100) (floor ticks 100)
      (setf seconds/100 s/100)
      (multiple-value-bind (h s) (floor s 3600) ; hours
        (setf hours h)
        (multiple-value-bind (m s) (floor s 60) ; minutes
          (setf minutes m
                seconds s))))))

(defmethod ber-encode ((tvalue timeticks))
  (let ((value (ticks tvalue)))
    (labels ((iter (n acc l)
               (if (zerop n) (values acc l)
                 (multiple-value-bind (q r) (floor n 256)
                   (iter q (cons r acc) (1+ l))))))
      (multiple-value-bind (v l) (if (zerop value)
                                     (values (list 0) 1)
                                   (iter value nil 0))
        (nconc (ber-encode-type 1 0 3)
               (ber-encode-length l)
               v)))))

(defmethod ber-decode-value ((stream stream) (type (eql :timeticks)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (labels ((iter (i acc)
             (if (= i length) acc
               (iter (1+ i) (logior (ash acc 8) (read-byte stream))))))
    (make-instance 'timeticks :ticks (iter 0 0))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :timeticks 1 0 3))
