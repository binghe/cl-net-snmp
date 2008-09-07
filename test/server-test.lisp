;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp.test)

(defun server-test-1 ()
  (with-open-snmp-server ()
    (with-open-session (s *default-snmp-server-address*
                          :port *default-snmp-server-port*
                          :version :2c
                          :community "public") ; actually community could be any string
      (snmp-walk s "system"))))
