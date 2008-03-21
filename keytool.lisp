;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: snmp; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  SNMPv3 key generation algorithm

  The localized key method is defined in RFC2274, Sections 2.6 and A.2, and
  originally documented in:
        U. Blumenthal, N. C. Hien, B. Wijnen,
        "Key Derivation for Network Management Applications",
        IEEE Network Magazine, April/May issue, 1997.
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/keytool.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080320'>create tempplate file "keytool.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :snmp)

#| GOAL:

# createUser md5user MD5 ABCDEFGH
# createUser user
# createUser md5des MD5 vHunxJXPRdUyAzjY DES vHunxJXPRdUyAzjY

(Number One)

;; user
usmUser 1 3 0x80001f8880e1fb085e3b0a914700000000 0x7573657200 0x7573657200 NULL .1.3.6.1.6.3.10.1.1.1 0x .1.3.6.1.6.3.10.1.2.1 0x 0x00

;; md5des
usmUser 1 3 0x80001f8880e1fb085e3b0a914700000000 0x6d643564657300 0x6d643564657300 NULL .1.3.6.1.6.3.10.1.1.2 0xe4f89c717175bd884778c36f5497f08d .1.3.6.1.6.3.10.1.2.2 0xe4f89c717175bd884778c36f5497f08d 0x00

;; md5user
usmUser 1 3 0x80001f8880e1fb085e3b0a914700000000 0x6d64357573657200 0x6d64357573657200 NULL .1.3.6.1.6.3.10.1.1.2 0x64a663586d3079b3567df788f8289921 .1.3.6.1.6.3.10.1.2.1 0x 0x00

(Number Two)

;; user
usmUser 1 3 0x80001f888095db4b345604de47 0x7573657200 0x7573657200 NULL .1.3.6.1.6.3.10.1.1.1 0x .1.3.6.1.6.3.10.1.2.1 0x 0x00

;; md5des
usmUser 1 3 0x80001f888095db4b345604de47 0x6d643564657300 0x6d643564657300 NULL .1.3.6.1.6.3.10.1.1.2 0x92385cb85909c269151635a7c6def640 .1.3.6.1.6.3.10.1.2.2 0x92385cb85909c269151635a7c6def640 0x00

;; md5user
usmUser 1 3 0x80001f888095db4b345604de47 0x6d64357573657200 0x6d64357573657200 NULL .1.3.6.1.6.3.10.1.1.2 0xe864c78cc61edabfec555522af06f623 .1.3.6.1.6.3.10.1.2.1 0x 0x00

|#

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant +usm-length-expanded-passphrase+ #.(* 1024 1024) "1M Bytes")
  (defconstant +usm-length-ku-hashblock+ 64 "In bytes.")
  (defconstant +usm-length-p-min+ 8 "In characters."))

;;; BER Stream: make stream from sequence
;;; TODO: port this into CLs other than LispWorks, SBCL and OpenMCL

(defclass ku-stream (fundamental-binary-input-stream)
  ((password :type simple-vector :initarg :password :reader ku-password)
   (password-length :type fixnum :initform 0)
   (password-position :type fixnum :initform 0)
   (stream-position :type fixnum :initform 0))
  (:documentation "A helper Gray Stream"))

(defmethod initialize-instance :after ((instance ku-stream)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (password-length) instance
    (setf password-length (length (ku-password instance)))))

(defmethod stream-element-type ((stream ku-stream)) '(unsigned-byte 8))

(defmethod stream-read-byte ((stream ku-stream))
  (with-slots (password password-length password-position stream-position) stream
    (if (= stream-position +usm-length-expanded-passphrase+) :eof
      (prog1 (svref password password-position)
        (incf stream-position)
        (incf password-position)
        (if (= password-position password-length)
          (setf password-position 0))))))

;;;; (defmethod stream-read-sequece ((stream ku-stream) sequence start end)
;;;;   (with-slots (password password-length password-position stream-position) stream
;;;;     ))

(defun generate-ku (key-string &key (hash-type :md5))
  (declare (optimize (speed 3) safety)
           (type base-string key-string)
           (type (member :md5 :sha1) hash-type))
  (let ((password (make-instance 'ku-stream
                                 :password (map 'simple-vector #'char-code key-string))))
    (ironclad:digest-stream hash-type password)))

(defun generate-kul (engine-id ku &key (hash-type :md5))
  (declare (type (simple-array (unsigned-byte 8) (*)) engine-id ku))
  (let ((digest (ironclad:make-digest hash-type))
        (password-buffer (concatenate '(simple-array (unsigned-byte 8) (*))
                                      ku engine-id ku)))
    (ironclad:update-digest digest password-buffer)
    (ironclad:produce-digest digest)))

:key
