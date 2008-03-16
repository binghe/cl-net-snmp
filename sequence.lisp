;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASN.1 SEQUENCE Structure support
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/sequence.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "sequence.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

(defmethod plain-value ((object sequence))
  (coerce object 'vector))

(defmethod ber-equal ((a sequence) (b sequence))
  (every #'ber-equal a b))

;;; used by pdu.lisp
(defun ber-encode-list (list)
  (apply #'concatenate 'vector (mapcar #'ber-encode list)))

;; for non-null sequence
(defmethod ber-encode ((value sequence))
  "Encode any VECTOR and non-nil LIST into ASN.1 sequence"
  (let ((sub-encode (apply #'concatenate 'vector
                           (map 'list #'ber-encode value))))
    (concatenate 'vector
                 (ber-encode-type 0 1 16)
                 (ber-encode-length (length sub-encode))
                 sub-encode)))

(defmethod ber-decode-value ((stream stream) (type (eql :sequence)) length)
  (declare (type fixnum length) (ignore type))
  "Decode ASN.1 sequence data and return a VECTOR"
  (if (zerop length) #()
    ;; for non-null sequence
    (labels ((iter (length-left acc)
               (if (zerop length-left)
                 (nreverse acc)
                 (multiple-value-bind (sub-type sub-type-length)
                     (ber-decode-type stream)
                   (multiple-value-bind (sub-length sub-length-length)
                       (ber-decode-length stream)
                     (iter (- length-left
                              sub-type-length
                              sub-length-length
                              sub-length)
                           (cons (ber-decode-value stream sub-type sub-length) acc)))))))
      (coerce (iter length nil) 'vector))))

(eval-when (:load-toplevel :execute)
  (install-asn.1-type :sequence 0 1 16))

:eof
