;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: usocket; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  UDP support patch for USOCKET project. This file should sync with usocket-svn at

    svn://common-lisp.net/project/usocket/svn/usocket/trunk

  Waiting for USOCKET author to merge us.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/usocket-udp/usocket-sbcl.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080317'>create USOCKET UDP patch file "usocket-sbcl.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :usocket)

(defun socket-connect/udp (host port &key (stream nil) (element-type '(unsigned-byte 8)))
  (let ((socket (make-instance 'sb-bsd-sockets:inet-socket
			       :type :datagram :protocol :udp)))
    (if (and host port)
	(let ((address (if (stringp host)
			   (sb-bsd-sockets:host-ent-address
			    (sb-bsd-sockets:get-host-by-name host))
			   host)))
	  (sb-bsd-sockets:socket-connect socket address port)
	  (if stream
	      (let ((stream (sb-bsd-sockets:socket-make-stream socket
							       :input t :output t
							       :buffering :full
							       :element-type element-type)))
		(make-stream-datagram-socket socket stream))
	      (make-datagram-socket socket)))
	(make-datagram-socket socket))))

(defmethod socket-send ((socket datagram-usocket) buffer length &key address port)
  (let ((s (socket socket))
	(dest (if (and address port) (list address port) nil)))
    (sb-bsd-sockets:socket-send socket buffer length :address dest)))

(defmethod socket-receive ((socket datagram-usocket) buffer length)
  (let ((s (socket socket)))
    (sb-bsd-sockets:socket-receive socket buffer length :element-type '(unsigned-byte 8))))

:eof
