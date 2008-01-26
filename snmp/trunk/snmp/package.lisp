(in-package :snmp.system)

(defpackage snmp
  (:use :common-lisp :smi :asn.1 :mib
   	#-lispworks :net.sockets #-lispworks :io.streams
        #+lispworks :comm)
  (:export v1-session v2c-session v3-session make-session
           *default-version* *default-community* *default-port*
           snmp-get snmp-walk
           ;; message
           v1-message
           v2c-message
           v3-message
           decode-message
           variable-bindings
           msg-version-of
           msg-pdu-of
           msg-security-name-of
           msg-security-level-of
           msg-engine-id-of
           msg-engine-boots-of
           msg-engine-time-of
           msg-auth-key-of
           msg-priv-key-of
           msg-context-engine-id-of
           msg-context-name-of))

(in-package :snmp)

(defparameter *version* 3)
