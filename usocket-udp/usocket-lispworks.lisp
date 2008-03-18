;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: usocket; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  UDP support patch for USOCKET project. This file should sync with usocket-svn at

    svn://common-lisp.net/project/usocket/svn/usocket/trunk

  Waiting for USOCKET author to merge us.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/usocket-udp/usocket-lispworks.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080317'>create USOCKET UDP patch file "usocket-lispworks.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :usocket)

;;; Part One: bugfix for usocket-svn

(defun usocket-listen (usocket)
  (if (stream-usocket-p usocket)
    (when (listen (socket-stream usocket))
      usocket)
    (when (comm::socket-listen (socket usocket))
      usocket)))

#-win32
(defun wait-for-input-internal (sockets &key timeout)
  (with-mapped-conditions ()
    ;; unfortunately, it's impossible to share code between
    ;; non-win32 and win32 platforms...
    ;; Can we have a sane -pref. complete [UDP!?]- API next time, please?
    (mapcar #'(lambda (x) (mp:notice-fd (os-socket-handle x))) sockets)
    (mp:process-wait-with-timeout "Waiting for a socket to become active"
                                  (truncate timeout)
                                  #'(lambda (socks)
                                      (some #'usocket-listen socks))
                                  sockets)
    (mapcar #'(lambda (x) (mp:unnotice-fd (os-socket-handle x))) sockets)
    (remove nil (mapcar #'usocket-listen sockets))))

(defun socket-connect/udp (host port &key (stream nil) (element-type 'base-char))
  (if (and host port)
    (if stream
      (let ((stream (comm:open-udp-stream host port
                                          :element-type element-type
                                          :errorp nil)))
        (make-stream-datagram-socket
         (comm:socket-stream-socket stream) stream))
      (make-datagram-socket (comm:connect-to-udp-server host port :errorp nil)))
    (make-datagram-socket (comm:open-udp-socket :errorp nil))))

(defmethod socket-send ((socket datagram-usocket) buffer length &key address port)
  (let ((s (socket socket)))
    (comm:send-message s buffer length address port)))

(defmethod socket-receive ((socket datagram-usocket) buffer length)
  (let ((s (socket socket)))
    (comm:receive-message s buffer length)))

:eof
