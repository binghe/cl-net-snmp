;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; BER Base Support ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :snmp)

(defconstant +asn-universal+   0)
(defconstant +asn-application+ 1)
(defconstant +asn-context+     2)
(defconstant +asn-private+     3)

(defconstant +asn-primitive+   0)
(defconstant +asn-constructor+ 1)

(defvar *ber-dispatch-table* (make-hash-table :test #'equal))

(defun get-asn.1-type (class p/c tags)
  (gethash (list class p/c tags) *ber-dispatch-table* nil))

(defun install-asn.1-type (type class p/c tags)
  (setf (gethash (list class p/c tags) *ber-dispatch-table*) type))

(defun uninstall-asn.1-type (class p/c tags)
  (setf (gethash (list class p/c tags) *ber-dispatch-table*) nil))

;;;;   8   7    6    5 4 3 2 1
;;;; +-------+-----+-----------+
;;;; | class | P/C |    tags   |
;;;; +-------+-----+-----------+
;;;; ^             ^
;;;; 00=universal  0=primitive
;;;; 01=app.       1=construct
;;;; 10=context.
;;;; 11=private
;;;;                (type domain (tag = 0-30)

;;;; |<-------head byte------->| |<---------------other bytes---------------->|
;;;;                              1st byte                           last byte
;;;;                             |<------>|                          |<------>|
;;;;   8   7    6    5 4 3 2 1
;;;; +-------+-----+-----------+ +---+----+ +---+----+    +---+----+ +---+----+
;;;; | class | P/C | 1 1 1 1 1 | | 1 |////| | 1 |////|... | 1 |////| | 0 |////|
;;;; +-------+-----+-----------+ +---+----+ +---+----+    +---+----+ +---+----+
;;;;                                 +----+     +----+        +----+     +----+
;;;;                         tags =  |////|  +  |////|...  +  |////|  +  |////|
;;;;                                 +----+     +----+        +----+     +----+
;;;;                (type domain (tag >= 31)

(defun ber-encode-type (class p/c tags)
  "Encode BER Type Domain"
  (declare (type (integer 0 3) class)
           (type (integer 0 1) p/c)
           (type (integer 0) tags))
  (labels ((iter (n p acc)
             (if (zerop n) acc
               (multiple-value-bind (q r) (floor n 128)
                 (iter q 1 (cons (logior (ash p 7) r) acc))))))
    (coerce (if (< tags 31)
              (list (logior (ash class 6) (ash p/c 5) tags))
              (cons (logior (ash class 6) (ash p/c 5) 31)
                    (iter tags 0 nil)))
            'vector)))

(defun ber-decode-type (stream)
  "Decode BER Type Domain"
  (declare (type stream stream))
  (let ((byte (read-byte stream))
        (type-length 1))
    (let ((class (ldb (byte 2 6) byte))
          (p/c (ldb (byte 1 5) byte))
          (tags (ldb (byte 5 0) byte)))
      (when (= tags 31)
        (setf tags (labels ((iter (acc)
                              (setf byte (read-byte stream))
                              (incf type-length)
                              (let ((temp (logior (ash acc 7)
						  (ldb (byte 7 0) byte))))
                                (if (= (ldb (byte 1 7) byte) 1)
				    (iter temp)
				    temp))))
                     (iter 0))))
      (values (get-asn.1-type class p/c tags)
              type-length))))

;;;;   8  7 6 5 4 3 2 1
;;;; +---+-+-+-+-+-+-+-+
;;;; | 0               |
;;;; +---+-+-+-+-+-+-+-+
;;;;                (short form: Length = 0-127 octets)

;;;;   8  7 6 5 4 3 2 1   8 7 6 5 4 3 2 1       8 7 6 5 4 3 2 1
;;;; +---+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+     +-+-+-+-+-+-+-+-+
;;;; | 1               | |               | ... |               |
;;;; +---+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+     +-+-+-+-+-+-+-+-+
;;;;     |<--number--->|  ^                                   ^
;;;;        of other     byte 1: MSB                         byte n: MLB
;;;;         bytes
;;;;       (0<n<127)
;;;;                (long form: Length = 0-(2^1008-1) octets)

(defun ber-encode-length (length)
  "Encode BER Length Domain"
  (declare (type (integer 0) length))
  (assert (<= 0 length (1- (expt 2 1008))))
  (labels ((iter (n acc l)
             (if (zerop n) (cons (mod (logior 128 l) 256) acc)
               (multiple-value-bind (q r) (floor n 256)
                 (iter q (cons r acc) (1+ l))))))
    (coerce (if (< length 128) (list length) (iter length nil 0)) 'vector)))

(defun ber-decode-length (stream)
  "Decode BER Length Domain"
  (declare (type stream stream))
  (let ((byte (read-byte stream))
        (length-length 1))
    (let ((flag (ldb (byte 1 7) byte))
          (l-or-n (ldb (byte 7 0) byte)))
      (let ((res (if (zerop flag) l-or-n
                   (let ((acc 0))
                     (dotimes (i l-or-n)
                       (setf acc (logior (ash acc 8)
                                         (read-byte stream)))
                       (incf length-length))
                     acc))))
        (values res length-length)))))
  
(defgeneric ber-encode (data)
  (:documentation "BER encode a ASN.1 object into VECTOR (not LIST)"))

(defgeneric ber-decode (data)
  (:documentation "BER decode data into a ASN.1 object"))

(defgeneric ber-equal (a b)
  (:documentation "BER equal predication function"))

(defmethod ber-decode ((data stream))
  (let ((type (ber-decode-type data))
        (length (ber-decode-length data)))
    (ber-decode-value data type length)))

(defmethod ber-decode ((value sequence))
  (let ((stream (make-instance 'ber-stream :sequence value)))
    (ber-decode stream)))

(defgeneric ber-decode-value (stream type length))

(defmethod ber-decode-value ((stream stream) (type (eql nil)) length)
  "Note: A UNKNOWN BER data will be decoded as NIL"
  (declare (type fixnum length) (ignore type))
  (dotimes (i length nil) (read-byte stream)))

;;; BER Stream: make stream from sequence
;;; TODO: port this into CLs other than LispWorks, SBCL and OpenMCL

(defclass ber-stream (fundamental-input-stream)
  ((sequence :type sequence :initarg :sequence :reader ber-sequence)
   (length :type integer :accessor ber-length)
   (position :type integer :initform 0 :accessor ber-position))
  (:documentation "A helper Gray Stream which used for make a sequence into STREAM"))

(defmethod initialize-instance :after ((obj ber-stream) &rest initargs &key &allow-other-keys)
  (declare (ignore slot-names initargs))
  (setf (ber-length obj) (length (ber-sequence obj))))

(defmethod stream-read-byte ((instance ber-stream))
  (with-slots (sequence position length) instance
    (if (= position length) :eof
      (prog1 (elt sequence position)
        (incf (ber-position instance))))))

;;; RAW BER data: can be encoded to anything but anything cannot be decoded into RAW

(defclass raw ()
  ((data :accessor data-of
         :initarg :data
         :type sequence
         :initform nil)))

(defun raw-p (data)
  (typep 'raw data))

(defun raw (data)
  (make-instance 'raw :data data))

(defmethod ber-encode ((value raw))
  (coerce (data-of value) 'vector))

;;; other BER utility

(defun ber-encode->string (data)
  (map 'string #'code-char (ber-encode data)))

(defun ber-decode<-string (data)
  (declare (type string data))
  (ber-decode (map 'vector #'char-code data)))

;;; Test Code

(defun ber-test (x)
  (let* ((code (coerce (ber-encode x) 'list))
         (xx (ber-decode code)))
    (format t "~A -> ~A~%~{~8,'0B ~}~%~{~D ~}~%"
            x xx code code)
    (ber-equal x xx)))
