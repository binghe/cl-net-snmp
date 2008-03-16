;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASN.1 'OCTET STRING' Type support
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/string.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "string.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defmethod plain-value ((object string)) object)
(defmethod ber-equal ((a string) (b string)) (string= a b))

;;; OCTET STRING (:octet-string)

(defmethod ber-encode ((value string))
  (concatenate 'vector
               (ber-encode-type 0 0 4)
               (ber-encode-length (length value))
               (map 'vector #'char-code value)))

(defmethod ber-decode-value ((stream stream) (type (eql :octet-string)) length)
  (declare (type fixnum length) (ignore type))
  (let ((str (make-string length)))
    (map-into str #'(lambda () (code-char (read-byte stream))))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :octet-string 0 0 4))

:eof
