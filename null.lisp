;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASN.1 NULL Type support
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/null.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "null.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defmethod plain-value ((object (eql nil)))
  (declare (ignore object))
  nil)

(defmethod ber-equal ((a (eql nil)) (b (eql nil)))
  (declare (ignore a b))
  t)

;;; NULL (:null)
(defmethod ber-encode ((value (eql nil)))
  (declare (ignore value))
  (concatenate 'vector
               (ber-encode-type 0 0 5)
               (ber-encode-length 0)))

(defmethod ber-decode-value ((stream stream) (type (eql :null)) length)
  "Eat bytes and return a NIL"
  (declare (type fixnum length) (ignore type))
  (dotimes (i length nil) (read-byte stream)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :null 0 0 5))

:eof
