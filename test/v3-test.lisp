;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun snmp-test-1 ()
  (snmp:with-open-session (s "2950.lab.163.org"
                             :version :v3
                             :user "md5"
                             :auth "vHunxJXPRdUyAzjY")
    (snmp:snmp-get s "sysDescr.0")))

(defun snmp-test-2 ()
  (snmp:with-open-session (s "localhost"
                             :version :v3
                             :user "readonly"
                             :auth "ABCDEFGHABCDEFGH")
    (snmp:snmp-get s "sysContact.0")))
