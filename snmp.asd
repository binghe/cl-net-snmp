;;;; -*- Mode: Lisp; Package: ASDF; -*-

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

#+lispworks
(pushnew :mib *features*)

(defsystem snmp
  :description "Simple Network Manangement Protocol"
  :version "2.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:ieee-floats          ; ASN.1 OPAQUE FLOAT encode/decode
               :ironclad             ; SNMPv3 authentication/encryption support
               :usocket-udp          ; portable UDP networking
               :trivial-gray-streams ; portable gray stream
               :split-sequence
               #+mib :zebu-compiler)
  :components ((:file "package")
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
	       (:file "session"		:depends-on ("keytool" "constants"))
               (:file "message"		:depends-on ("pdu" "session"))
               (:file "network"		:depends-on ("session" "message"))
               (:file "report"		:depends-on ("sequence" "session" "message"))
               (:file "snmp-get"	:depends-on ("oid" "pdu" "network" "report"))
               (:file "snmp-set"	:depends-on ("oid" "pdu" "network" "report"))
               (:file "snmp-walk"	:depends-on ("oid" "pdu" "network" "report"))
               (:file "snmp-trap"	:depends-on ("oid" "pdu" "network" "report"
                                                     "ipaddress"))
	       #+ignore
               (:file "snmp-server"	:depends-on ("oid" "message" "pdu"))
	       #+ignore
               (:file "oid-handler"	:depends-on ("snmp-server" "mib-build"))
               #+(and mib lispworks)
	       (:file "snmp-utility"	:depends-on ("snmp-get" "snmp-walk" "mib-tree"))))

:eof
