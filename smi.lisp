;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  SMI base support
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/smi.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "smi.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defclass general-type ()
  ((value :accessor value-of
          :initarg :value))
  (:documentation "General Container Type, used by counter, gauge and opaque, etc."))

(defmethod print-object ((obj general-type) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (value-of obj))))

(defgeneric plain-value (object)
  (:documentation "Plain value: map a ASN.1 object into plain lisp values"))

(defmethod plain-value ((object general-type))
  (value-of object))

(defmethod ber-equal ((a general-type) (b general-type))
  (= (value-of a) (value-of b)))

:eof
