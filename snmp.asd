;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: asdf; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASDF system definition for SNMP
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/snmp.asd'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "snmp.asd"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :asdf)

;;; Load networking support
#+sbcl (require :sb-bsd-sockets)
#+cmucl (require :gray-streams)

#+lispworks
(pushnew :mib *features*)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:ieee-floats
               :ironclad
               #+lispworks :lispworks-udp
               #-lispworks :split-sequence
               :usocket
               #+mib :zebu-compiler)
  :components ((:module "usocket-udp"
                :components ((:file "usocket")
                             #+clozure   (:file "usocket-clozure")
                             #+clisp     (:file "usocket-clisp")
                             #+cmu       (:file "usocket-cmucl")
                             #+sbcl      (:file "usocket-sbcl")
                             #+lispworks (:file "usocket-lispworks")))
               (:file "package")
               (:file "ber"		:depends-on ("package"))
	       (:file "smi"		:depends-on ("ber"))
               (:file "null"		:depends-on ("smi"))
	       (:file "integer"		:depends-on ("smi"))
	       (:file "string"		:depends-on ("smi"))
	       (:file "sequence"	:depends-on ("smi"))
	       (:file "timeticks"	:depends-on ("integer"))
	       (:file "opaque"		:depends-on ("integer"))
	       (:file "counter"		:depends-on ("integer"))
	       (:file "gauge"		:depends-on ("integer"))
	       (:file "ipaddress"	:depends-on ("smi"))
	       (:file "oid"		:depends-on ("smi"))
	       (:file "pdu"		:depends-on ("sequence" "oid" "timeticks"))
	       #+mib
               (:file "syntax"		:depends-on ("package"))
	       #+mib
               (:file "mib-tree"	:depends-on ("syntax" "oid"))
	       #+mib
               (:file "mib-build"	:depends-on ("mib-tree"))
               (:file "print-oid"	:depends-on ("oid" #+mib "mib-tree"))
	       (:file "constants"	:depends-on ("package"))
               (:file "keytool"		:depends-on ("package"))
	       #+(or sbcl lispworks)
	       (:file "session"		:depends-on ("keytool" "constants"))
	       #+(or sbcl lispworks)
               (:file "message"		:depends-on ("pdu" "session"))
	       #+(or sbcl lispworks)
               (:file "network"		:depends-on ("usocket-udp"
						     "session" "message"))
	       #+(or sbcl lispworks)
               (:file "report"		:depends-on ("sequence" "session" "message"))
	       #+(or sbcl lispworks)
               (:file "snmp-get"	:depends-on ("oid" "pdu" "network" "report"))
	       #+(or sbcl lispworks)
               (:file "snmp-set"	:depends-on ("oid" "pdu" "network" "report"))
	       #+(or sbcl lispworks)
               (:file "snmp-walk"	:depends-on ("oid" "pdu" "network" "report"))
	       #+(or sbcl lispworks)
               (:file "snmp-trap"	:depends-on ("oid" "pdu" "network" "report"))
	       #+lispworks
               (:file "snmp-server"	:depends-on ("oid" "message" "pdu"))
	       #+(and mib lispworks)
               (:file "oid-handler"	:depends-on ("snmp-server" "mib-build"))
               #+(and mib lispworks)
	       (:file "snmp-utility"	:depends-on ("snmp-get" "snmp-walk" "mib-tree"))))

:eof
