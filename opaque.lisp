;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASN.1 OPAQUE Type, only SINGLE-FLOAT subtype is supported.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/opaque.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "opaque.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defclass opaque (general-type) ())

(defun opaque (value)
  (make-instance 'opaque :value value))

(defmethod print-object ((obj opaque) stream)
  (with-slots (value) obj
    (print-unreadable-object (obj stream :type t)
      (format stream "~A: ~A"
              (type-of value) value))))

(defgeneric opaque-length (instance))

(defmethod opaque-length ((o opaque))
  (opaque-length (value-of o)))

(defmethod opaque-length ((f single-float))
  (the fixnum 7))

(defmethod encode-opaque ((o single-float))
  (concatenate 'vector #(#x9f #x78 #x04)
               (let ((integer (ieee-floats:encode-float32 o)))
                 (let ((a (ash (logand integer #xff000000) -24))
                       (b (ash (logand integer #x00ff0000) -16))
                       (c (ash (logand integer #x0000ff00) -8))
                       (d      (logand integer #x000000ff)))
                   (vector a b c d)))))

(defmethod ber-encode ((value opaque))
  (concatenate 'vector
               (ber-encode-type 1 0 4)
               (ber-encode-length (opaque-length value))
               (encode-opaque (value-of value))))

(defmethod ber-decode-value ((stream stream) (type (eql :opaque)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (assert (= 7 length))
  (let ((b-1 (read-byte stream))
        (b-2 (read-byte stream))
        (b-3 (read-byte stream)))
    (declare (ignore b-1 b-2))
    (if (= b-3 4)
      (ber-decode-value stream :float 4)
      (make-instance 'opaque :value nil))))

(defmethod ber-decode-value ((stream stream) (type (eql :float)) length)
  (let ((f-0 (read-byte stream))
        (f-1 (read-byte stream))
        (f-2 (read-byte stream))
        (f-3 (read-byte stream)))
    (let ((integer (logior (ash f-0 24) (ash f-1 16) (ash f-2 8) f-3)))
      (opaque (ieee-floats:decode-float32 integer)))))

(defmethod ber-encode ((value single-float))
  (ber-encode (opaque value)))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :opaque 1 0 4))

:eof
