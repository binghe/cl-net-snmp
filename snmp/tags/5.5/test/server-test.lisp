;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp.test)

(defun server-test-1 ()
  (with-open-snmp-server ()
    (with-open-session (s (or *default-snmp-server-address* "localhost")
                          :port *default-snmp-server-port*
                          :version :2c
                          :community "public") ; actually community could be any string
      (snmp-walk s "system"))))

(defun server-test-2 ()
  (with-open-snmp-server ()
    (with-open-session (s (or *default-snmp-server-address* "localhost")
                          :port *default-snmp-server-port*
                          :version :2c
                          :community "public") ; actually community could be any string
      (snmp-walk s "common-lisp"))))

