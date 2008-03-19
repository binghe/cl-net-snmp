;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: usocket; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  UDP support patch for USOCKET project. This file should sync with usocket-svn at

    svn://common-lisp.net/project/usocket/svn/usocket/trunk

  Waiting for USOCKET author to merge us.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/usocket-udp/usocket-clozure.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080317'>create USOCKET UDP patch file "usocket-clozure.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :usocket)

(defun socket-connect/udp (host port &key (stream nil) (element-type 'base-char))
  (let ((socket (openmcl-socket:make-socket :address-family :internet
					    :type :datagram)))
    (if (and host port)
	(progn
	  (ccl::inet-connect (ccl::socket-device socket)
			     (ccl::host-as-inet-host host)
			     (ccl::port-as-inet-port port "udp"))
	  (if stream
	      (let ((stream (ccl::make-fd-stream (ccl::socket-device socket)
						 :class 'ccl::tcp-stream
						 :direction :io
						 :element-type element-type
						 :character-p nil)))
		(make-stream-datagram-socket socket stream))
	      (make-datagram-socket socket)))
	(make-datagram-socket socket))))

(defmethod socket-send ((socket datagram-usocket) buffer length &key address port)
  (let ((s (socket socket)))
    (openmcl-socket:send-to s buffer length
			    :remote-host (ccl::host-as-inet-host address)
			    :remote-port (ccl::port-as-inet-port port "udp"))))

(defmethod socket-receive ((socket datagram-usocket) buffer length)
  (let ((s (socket socket)))
    (openmcl-socket:receive-from s length :buffer buffer)))

:eof
