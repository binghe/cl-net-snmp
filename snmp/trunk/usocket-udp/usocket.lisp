;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: usocket; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  UDP support patch for USOCKET project. This file should sync with usocket-svn at

    svn://common-lisp.net/project/usocket/svn/usocket/trunk

  Waiting for USOCKET author to merge us.

  I'm good at hacking package of others.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/usocket-udp/usocket.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080317'>create USOCKET UDP patch file "patch-usocket.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :usocket)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(stream-datagram-usocket
            socket-connect/udp
            socket-send
            socket-receive)))

(defclass stream-datagram-usocket (stream-usocket datagram-usocket)
  ()
  (:documentation "connected datagram-usocket with a lisp stream interface"))

(defun stream-datagram-usocket-p (socket)
  (typep socket 'stream-datagram-usocket))

(defun make-stream-datagram-socket (socket stream)
  (unless socket
    (error 'invalid-socket))
  (unless stream
    (error 'invalid-socket-stream-error))
  (make-instance 'stream-datagram-usocket
                 :socket socket
                 :stream stream
                 :connected-p t))

(defun make-datagram-socket (socket)
  (unless socket
    (error 'invalid-socket))
  (make-instance 'datagram-usocket
                 :socket socket
                 :connected-p nil))

:eof
