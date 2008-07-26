;;;; Network.lisp, UDP timeout & rtt support for SNMP client

(in-package :snmp)

(defparameter *snmp-send-times* 3)
(defparameter *snmp-wait-timeout* 1)

(defvar *default-socket* (socket-connect/udp nil nil :stream nil))

(defgeneric send-snmp-message (session message &key &allow-other-keys))

(defun send-until (action socket &key (times *snmp-send-times*)
                                      (wait-time *snmp-wait-timeout*))
  (loop with result = nil
        for i from 0 below times
        until (car result)
        do (progn
             (when (plusp i)
               (format t "resend times: ~A at ~A.~%" i (get-internal-real-time)))
             (funcall action)
             (setf result (wait-for-input socket :timeout wait-time)))
        finally (return result)))

(defun recv-until (action stop-reason)
  (loop as message = (funcall action)
        until (funcall stop-reason message)
        do (format t "give up one packet at ~A.~%" (get-internal-real-time))
        finally (return message)))

(defvar *current-socket* *default-socket*)

(defmethod send-snmp-message ((session session) (message message)
                              &key (receive t) (report nil) socket)
  (let ((socket (or socket
                    (and (slot-boundp session 'socket)
                         (socket-of session))
                    *current-socket*))
        (data (coerce (ber-encode message) '(simple-array (unsigned-byte 8) (*)))))
    (labels ((send ()
	       (let ((result
		      (socket-send socket data (length data)
				   :address (host-of session)
				   :port (port-of session))))
                 (declare (ignorable result))
                 #+ignore
		 (format t "socket-send result: ~A~%" result)))
             (recv ()
               (decode-message session (socket-receive socket nil
                                                       +max-snmp-packet-size+))))
      (if receive
        ;; receive = t
        (if (send-until #'send socket)
	    (recv-until #'recv #'(lambda (x) (= (request-id-of (pdu-of message))
						(request-id-of (pdu-of x)))))
	    (error "cannot got a reply"))
        ;; receive = nil
        (if report
          (unless (send-until #'send socket)
            (error "cannot got a reply when report"))
          (send))))))

;;; UNIX Network Programming v1 - Networking APIs: Sockets and XTI
;;;  Chapter 20: Advance UDP Sockets
;;;   Adding Reliability to a UDP Application

(defclass rtt-info ()
  ((rtt    :accessor rtt-of
           :type short-float
           :initform 0.0
           :documentation "most recent measured RTT, seconds")
   (srtt   :accessor srtt-of
           :type short-float
           :initform 0.0
           :documentation "smoothed RTT estimator, seconds")
   (rttvar :accessor rttvar-of
           :type short-float
           :initform 0.75
           :documentation "smoothed mean deviation, seconds")
   (rto    :accessor rto-of
           :type short-float
           :documentation "current RTO to use, seconds")
   (nrexmt :accessor nrexmt-of
           :type fixnum
           :documentation "#times retransmitted: 0, 1, 2, ...")
   (base   :accessor base-of
           :type integer
           :documentation "#sec since 1/1/1970 at start, but we use Lisp time here"))
  (:documentation "RTT Info Class"))

(defvar *rtt-rxtmin*   2 "min retransmit timeout value, seconds")
(defvar *rtt-rxtmax*  60 "max retransmit timeout value, seconds")
(defvar *rtt-maxrexmt* 3 "max #times to retransmit")

(defmethod rtt-rtocalc ((instance rtt-info))
  "Calculate the RTO value based on current estimators:
        smoothed RTT plus four times the deviation."
  (with-slots (srtt rttvar) instance
    (+ srtt (* 4.0 rttvar))))

(defun rtt-minmax (rto)
  "rtt-minmax makes certain that the RTO is between the upper and lower limits."
  (declare (type short-float rto))
  (cond ((< rto *rtt-rxtmin*) *rtt-rxtmin*)
        ((> rto *rtt-rxtmax*) *rtt-rxtmax*)
        (t rto)))

(defmethod initialize-instance :after ((instance rtt-info) &rest initargs
                                       &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (base rto) instance
    (setf base (get-internal-real-time)
          rto (rtt-minmax (rtt-rtocalc instance)))))

(defmethod rtt-ts ((instance rtt-info))
  (* (- (get-internal-real-time) (base-of instance))
     #.(/ 1000 internal-time-units-per-second)))

(defmethod rtt-start ((instance rtt-info))
  "return value can be used as: alarm(rtt_start(&foo))"
  (round (rto-of instance)))

(defmethod rtt-stop ((instance rtt-info) (ms integer))
  (with-slots (rtt srtt rttvar rto) instance
    (setf rtt (/ ms 1000.0))
    (let ((delta (- rtt srtt)))
      (incf srtt (/ delta 8.0))
      (setf delta (abs delta))
      (incf rttvar (/ (- delta rttvar) 4.0)))
    (setf rto (rtt-minmax (rtt-rtocalc instance)))))

(defmethod rtt-timeout ((instance rtt-info))
  (with-slots (rto nrexmt) instance
    (setf rto (* rto 2))
    (<= (incf nrexmt) *rtt-maxrexmt*)))

(defmethod rtt-newpack ((instance rtt-info))
  (setf (nrexmt-of instance) 0))
