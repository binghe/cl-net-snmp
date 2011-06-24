;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; SNMP 6.1: SNMP/TCP support

(in-package :snmp)

(defun snmp-connect (host port &key (protocol :datagram))
  (labels ((map-protocol (p)
             (ecase p
               ((:stream :tcp) :stream)
               ((:datagram :udp) :datagram))))
    (usocket:socket-connect host port :protocol (map-protocol protocol))))

