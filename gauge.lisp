;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASN.1 GAUGE Type support
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/gauge.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "gauge.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defclass gauge (general-type) ())

(defun gauge (v)
  (make-instance 'gauge :value v))

(defmethod ber-encode ((value gauge))
  (multiple-value-bind (v l) (ber-encode-integer (value-of value))
    (concatenate 'vector
                 (ber-encode-type 1 0 2)
                 (ber-encode-length l)
                 v)))

(defmethod ber-decode-value ((stream stream) (type (eql :gauge)) length)
  (declare (type fixnum length) (ignore type))
  (gauge (ber-decode-integer-value stream length)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :gauge 1 0 2))

:eof
