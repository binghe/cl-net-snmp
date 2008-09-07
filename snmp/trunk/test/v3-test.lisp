;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp.test)

(defun v3-test-1 ()
  (with-open-session (s "2950.lab.163.org"
                        :version :v3
                        :user "md5"
                        :auth "vHunxJXPRdUyAzjY")
    (snmp-walk s "system")))

(defun v3-test-2 ()
  (with-open-session (s "localhost"
                        :version :v3
                        :user "readonly"
                        :auth "ABCDEFGHABCDEFGH")
    (snmp-walk s "system")))
