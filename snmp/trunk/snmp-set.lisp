;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  SNMP SET
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/snmp-set.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080317'>bugfix: SNMP-SET's vars format contain value data, not nil</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defgeneric snmp-set (object vars)
  (:documentation "SNMP Set"))

(defmethod snmp-set ((host string) (vars list))
  (when vars
    (with-open-session (s host)
      (snmp-set s vars))))

(defmethod snmp-set ((session session) (vars list))
  "SNMP SET for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid (car x)) (cdr x))) vars)))
      ;; Set a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :pdu (make-instance 'set-request-pdu
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (elt x 1))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-set ((host string) (var string))
  (car (snmp-set host (list var))))

(defmethod snmp-set ((host string) (var object-id))
  (car (snmp-set host (list var))))

:eof
