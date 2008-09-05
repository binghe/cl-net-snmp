;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defun v2-test-1 ()
  (with-open-session (s "bend-10.space.163.org"
                        :version :v2c
                        :community "private"
                        :port 161)
    (snmp-walk s "system")))

(defun v2-test-2 ()
  (with-open-session (s "bend-10.space.163.org"
                        :version :v2c
                        :community "private"
                        :port 1185)
    (snmp-walk s "system")))
