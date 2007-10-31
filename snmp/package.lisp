(in-package :snmp.system)

(defpackage snmp
  (:use :common-lisp :smi :asn.1 :mib
	#-win32 :net.sockets #-win32 :io.streams)
  (:export v1-session v2c-session v3-session make-session
           *default-version* *default-community* *default-port*
           snmp-get snmp-walk))

(in-package :snmp)

(defparameter *version* 1)
