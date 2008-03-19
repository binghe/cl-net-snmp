;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: usocket; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  UDP support patch for USOCKET project. This file should sync with usocket-svn at

    svn://common-lisp.net/project/usocket/svn/usocket/trunk

  Waiting for USOCKET author to merge us.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/usocket-udp/usocket-cmucl.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080317'>create USOCKET UDP patch file "usocket-cmucl.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :usocket)

(defun socket-connect/udp (host port &key (stream nil) (element-type '(unsigned-byte 8)))
  (if (and host port)
      (let ((socket (extensions:connect-to-inet-socket host port :datagram)))
	(if stream
	    (make-stream-datagram-socket socket
					 (system:make-fd-stream socket
								:input t :output t
								:buffering :full
								:element-type element-type))
	    (make-datagram-socket socket)))
      (make-datagram-socket (extensions:create-inet-socket :datagram))))

(defmethod socket-send ((socket datagram-usocket) buffer length &key address port)
  (let ((s (socket socket)))
    (extensions:inet-sendto s buffer length address port)))

(defmethod socket-receive ((socket datagram-usocket) buffer length)
  (let ((s (socket socket)))
    (extensions:inet-recvfrom s buffer length)))

:eof
