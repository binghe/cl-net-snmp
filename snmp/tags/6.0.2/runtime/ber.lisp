;;;; -*- Mode: Lisp -*-
;;;; $Id$
;;;; BER (Basic Encoding Rules) support

(in-package :asn.1)

(defvar *ber-dispatch-table* (make-hash-table :test #'equal))

(defun get-asn.1-type (class p/c tags)
  (gethash (list class p/c tags) *ber-dispatch-table*))

(defun install-asn.1-type (type class p/c tags)
  (setf (gethash (list class p/c tags) *ber-dispatch-table*) type))

(defun uninstall-asn.1-type (class p/c tags)
  (remhash (list class p/c tags) *ber-dispatch-table*))

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


(eval-when (:compile-toplevel :load-toplevel) 
  (declaim (inline ber-coerce-from-list))
  (defun ber-coerce-from-list (list)
    (declare (dynamic-extent list) (type list list) (optimize speed))
    (let ((array (make-array (length list) :element-type '(unsigned-byte 8))))
      (loop for i fixnum from 0 
            for e of-type (unsigned-byte 8) in list
	    do (setf (aref (the (simple-array (unsigned-byte 8)) array) i) e))
      array))

  (defun ber-encode-type-dynamic (class p/c tags)
    "Encode BER Type Domain"
    (declare (type (integer 0 3) class)
	     (type (integer 0 1) p/c)
	     (type (integer 0) tags))
    (labels ((iter (n p acc)
               (if (zerop n) acc
                 (multiple-value-bind (q r) (floor n 128)
                   (iter q 1 (cons (logior (ash p 7) r) acc))))))
      (ber-coerce-from-list 
       (if (< tags 31)
           (list (logior (ash class 6) (ash p/c 5) tags))
         (cons (logior (ash class 6) (ash p/c 5) 31)
               (iter tags 0 nil)))))))

(defun ber-encode-type (class p/c tags)
  "Encode BER Type Domain"
  (ber-encode-type-dynamic class p/c tags))

(define-compiler-macro ber-encode-type (class p/c tags &environment env)
  (if (and (constantp class env) (constantp p/c env) (constantp tags env))
      (coerce (ber-encode-type-dynamic (eval class) (eval p/c) (eval tags)) 
	      '(vector (unsigned-byte 8)))
      `(ber-encode-type-dynamic ,class ,p/c ,tags)))

(defun ber-decode-type (stream)
  "Decode BER Type Domain"
  (declare (type stream stream))
  (let ((byte (read-byte stream))
        (type-length 1))
    (let ((class (ldb (byte 2 6) byte))
          (p/c (ldb (byte 1 5) byte))
          (tags (ldb (byte 5 0) byte))
          (bytes (list byte)))
      (when (= tags 31)
        (setf tags (labels ((iter (acc)
                              (setf byte (read-byte stream))
                              (push byte bytes)
                              (incf type-length)
                              (let ((temp (logior (ash acc 7)
						  (ldb (byte 7 0) byte))))
                                (if (= (ldb (byte 1 7) byte) 1)
				    (iter temp)
				    temp))))
                     (iter 0))))
      (values (get-asn.1-type class p/c tags)
              type-length
              (nreverse bytes)))))

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

(defun ber-encode-length-slow (length)
  "Encode BER Length Domain"
  (declare (type (integer 0 #.(1- (expt 2 1008))) length))
  (labels ((iter (n acc l)
             (if (zerop n) (cons (mod (logior 128 l) 256) acc)
               (multiple-value-bind (q r) (floor n 256)
                 (iter q (cons r acc) (1+ l))))))
    (ber-coerce-from-list (if (< length 128) (list length) (iter length nil 0)))))


(eval-when (:load-toplevel :compile-toplevel)
 (defun ber-encode-length-dynamic (length)
   (declare (type fixnum length) (optimize speed))
   (let ((result (make-array +ber-encode-max-length+ 
			     :element-type '(unsigned-byte 8)))
	 (u (1- +ber-encode-max-length+)))
     (declare (type (simple-array (unsigned-byte 8)) result)
	      (type fixnum u))
     (labels ((w (n)
		(setf (aref result (the (integer 0 #.(1- +ber-encode-max-length+)) u)) n)
		(decf u)))
       (let ((n length))
	 (declare (type fixnum n))
	 (loop do
	       (multiple-value-bind (q r) (floor (the fixnum n) 256)
		 (w r)
		 (when (zerop q) (return))
		 (setf n q)))
	 (w (logior 128 (- (1- +ber-encode-max-length+) u )))
	 (subseq result (1+ u)))))))

(defun ber-encode-length (length)
  (declare (optimize speed))
  (let ((table 
	 #.(let ((table (make-array 1024)))
	     (loop for i below (length table)
		   do (setf (aref table i) (copy-seq (ber-encode-length-dynamic i))))
	     table)))
    (if (> (length table) length) 
	(aref table length)
      (ber-encode-length-dynamic length))))

(defun ber-decode-length (stream)
  "Decode BER Length Domain"
  (declare (type stream stream))
  (let ((byte (read-byte stream))
        (length-length 1))
    (let ((flag (ldb (byte 1 7) byte))
          (l-or-n (ldb (byte 7 0) byte))
          (bytes (list byte)))
      (let ((length (if (zerop flag) l-or-n
                      (let ((acc 0))
                        (dotimes (i l-or-n acc)
                          (setf byte (read-byte stream)
                                acc (logior (ash acc 8) byte))
                          (push byte bytes)
                          (incf length-length))))))
        (values length
                length-length
                (nreverse bytes))))))
  
(defgeneric ber-encode (data)
  (:documentation "BER encode a ASN.1 object into VECTOR (not LIST)"))

(defgeneric ber-decode (data)
  (:documentation "BER decode data into a ASN.1 object"))

(defgeneric ber-equal (a b)
  (:documentation "BER equal predication function"))

(defmethod ber-equal :around (a b)
  (or (eq a b)
      (call-next-method)))

(defmethod ber-equal (a b)
  "Fallback equal test"
  (declare (ignore a b))
  nil)

(defmethod ber-equal ((a general-type) (b general-type))
  (and (equalp (type-of a) (type-of b))
       (= (value-of a) (value-of b))))

(defmethod ber-decode ((stream stream))
  (multiple-value-bind (type type-bytes) (ber-decode-type stream)
    (multiple-value-bind (length length-bytes) (ber-decode-length stream)
      (if type
        (ber-decode-value stream type length)
        ;; When unknown type detected, recover whole data to a ASN.1 RAW object
        (ber-decode-value stream type (cons length
                                            (append type-bytes length-bytes)))))))

(defmethod ber-decode ((value sequence))
  (let ((stream (make-instance 'ber-stream :sequence value)))
    (ber-decode stream)))

(defgeneric ber-decode-value (stream type length))

;;; BER Stream: make stream from sequence
(defclass ber-stream (#-scl fundamental-binary-input-stream
		      #+scl binary-input-stream)
  ((sequence :type sequence :initarg :sequence :reader ber-sequence)
   (length :type fixnum :accessor ber-length)
   (position :type fixnum :initform 0 :accessor ber-position))
  (:documentation "A helper Gray Stream which used for make a sequence into STREAM"))

(defmethod initialize-instance :after ((instance ber-stream)
                                       &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (ber-length instance) (length (ber-sequence instance))))

(defmethod stream-read-byte ((instance ber-stream))
  (with-slots (sequence position length) instance
    (if (= position length) :eof
      (prog1 (elt sequence position)
        (incf (ber-position instance))))))

;;; RAW BER data: can be encoded to anything but anything cannot be decoded into RAW

(defclass raw (asn.1-type)
  ((data :accessor data-of
         :initarg :data
         :type sequence
         :initform nil)))

(defun raw-p (data)
  (typep 'raw data))

(defun raw (data)
  (make-instance 'raw :data data))

(defmethod print-object ((object raw) stream)
  (print-unreadable-object (object stream :type t)
    (format stream "~A" (data-of object))))

(defmethod ber-encode ((value raw))
  (coerce (data-of value) 'vector))

(defmethod ber-decode-value ((stream stream) (type (eql nil)) length)
  "Note: A UNKNOWN BER data will be decoded as NIL"
  (declare (type list length)
           (ignore type))
  (let (value)
    (raw (append (cdr length) ; type and length
                 (dotimes (i (car length) (nreverse value))
                   (push (read-byte stream) value))))))

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
