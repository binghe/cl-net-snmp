;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  SNMPv3 REPORT
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/report.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "report.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defun need-report-p (session)
  "return true if a SNMPv3 session has no engine infomation set"
  (declare (type v3-session session))
  (zerop (engine-time-of session)))

(defun snmp-report (session)
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message :session session :report t
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (send-snmp-message session message :receive nil)
    (let ((ber-stream (socket-stream (socket-of session))))
      (destructuring-bind (engine-id engine-boots engine-time user auth priv)
	  ;; security-data: 3rd field of message list
	  (coerce (ber-decode<-string (elt (ber-decode ber-stream) 2)) 'list)
	(declare (ignore user auth priv))
	(setf (engine-id-of session) engine-id
	      (engine-boots-of session) engine-boots
	      (engine-time-of session) engine-time)
	session))))

:eof
