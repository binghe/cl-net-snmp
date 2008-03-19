;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: asdf; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASDF system definition for USOCKET-UDP

  This asdf file is NOT used by cl-net-snmp
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/usocket-udp.asd'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "usocket-udp.asd"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :asdf)

(defsystem usocket-udp
  :description "UDP support for the USOCKET project"
  :version "0.1"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:usocket
               #+lispworks :lispworks-udp)
  :serial t
  :components ((:file "usocket")
               #+clozure   (:file "usocket-clozure")
               #+clisp     (:file "usocket-clisp")
               #+cmu       (:file "usocket-cmucl")
               #+sbcl      (:file "usocket-sbcl")
               #+lispworks (:file "usocket-lispworks")
               (:file "udp-server")))

:eof
