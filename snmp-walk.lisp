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

(defgeneric snmp-get-next (object vars &key)
  (:documentation "SNMP Get"))

(defmethod snmp-get-next ((host string) (vars list) &key (context ""))
  (when vars
    (with-open-session (s host)
      (snmp-get-next s vars :context context))))

(defmethod snmp-get-next ((session session) (vars list) &key (context ""))
  "SNMP Get-Next-Request for v1, v2c and v3"
  (when vars
    (let ((vb (mapcar #'(lambda (x) (list (*->oid x) nil)) vars)))
      ;; Get a report first if the session is new created
      (when (and (= +snmp-version-3+ (version-of session))
                 (need-report-p session))
        (snmp-report session))
      (let ((message (make-instance (gethash (type-of session) *session->message*)
                                    :session session
                                    :context context
                                    :pdu (make-instance 'get-next-request-pdu
                                                        :variable-bindings vb))))
        (let ((reply (send-snmp-message session message)))
          (when reply
            (map 'list #'(lambda (x) (coerce x 'list))
                 (variable-bindings-of (pdu-of reply)))))))))

(defmethod snmp-get-next ((host string) (var string) &key (context ""))
  (car (snmp-get-next host (list var) :context context)))

(defmethod snmp-get-next ((host string) (var object-id) &key (context ""))
  (car (snmp-get-next host (list var) :context context)))

(defgeneric snmp-walk (object vars &key)
  (:documentation "SNMP Walk"))

(defmethod snmp-walk ((host string) (vars list) &key (context ""))
  (with-open-session (s host)
    (snmp-walk s vars :context context)))

(defmethod snmp-walk ((session session) (vars list) &key (context ""))
  "SNMP Walk for v1, v2c and v3"
  (when vars
    (let ((base-vars (mapcar #'*->oid vars)))
      (labels ((iter (current-vars acc)
                 (let* ((temp (snmp-get-next session current-vars :context context))
                        (new-vars (mapcar #'first temp)))
                   (if (some #'oid->= new-vars base-vars)
                     (mapcar #'nreverse acc)
                     (iter new-vars (mapcar #'cons temp acc))))))
        (iter base-vars (make-list (length vars)))))))

(defmethod snmp-walk (object (var string) &key (context ""))
  (car (snmp-walk object (list var) :context context)))

(defmethod snmp-walk (object (var object-id) &key (context ""))
  (car (snmp-walk object (list var) :context context)))

:eof
