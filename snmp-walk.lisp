;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  SNMP GET-NEXT-REQUEST and high-level "WALK" support
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/snmp-walk.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "snmp-walk.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defgeneric snmp-get-next (object vars)
  (:documentation "SNMP Get"))

(defmethod snmp-get-next ((host string) (vars list))
  (when vars
    (with-open-session (s host)
      (snmp-get-next s vars))))

(defmethod snmp-get-next ((session session) (vars list))
  "SNMP Get-Next-Request for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :pdu (make-instance 'get-next-request-pdu
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (coerce x 'list))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-get-next ((host string) (var string))
  (car (snmp-get-next host (list var))))

(defmethod snmp-get-next ((host string) (var object-id))
  (car (snmp-get-next host (list var))))

(defgeneric snmp-walk (object vars)
  (:documentation "SNMP Walk"))

(defmethod snmp-walk ((host string) (vars list))
  (with-open-session (s host)
    (snmp-walk s vars)))

(defmethod snmp-walk ((session session) (vars list))
  "SNMP Walk for v1, v2c and v3"
  (when vars
    (let ((base-vars (mapcar #'*->oid vars)))
      (labels ((iter (current-vars acc)
                 (let* ((temp (snmp-get-next session current-vars))
                        (new-vars (mapcar #'first temp)))
                   (if (some #'oid->= new-vars base-vars)
                     (mapcar #'nreverse acc)
                     (iter new-vars (mapcar #'cons temp acc))))))
        (iter base-vars (make-list (length vars)))))))

(defmethod snmp-walk (object (var string))
  (car (snmp-walk object (list var))))

(defmethod snmp-walk (object (var object-id))
  (car (snmp-walk object (list var))))

:eof
