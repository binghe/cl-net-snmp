;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; BER Base Support ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :snmp)

(let ((dispatch-table (make-hash-table :test #'equal)))
  (defun get-asn.1-type (class p/c tags)
    (gethash (list class p/c tags) dispatch-table :unknown))
  (defun install-asn.1-type (type class p/c tags)
    (setf (gethash (list class p/c tags) dispatch-table) type)))

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
  (assert (and (<= 0 class 3) (<= 0 p/c 1) (<= 0 tags)))
  (labels ((iter (n p acc)
             (if (zerop n) acc
               (multiple-value-bind (q r) (floor n 128)
                 (iter q 1 (cons (logior (ash p 7) r) acc))))))
    (if (< tags 31)
        (list (logior (ash class 6) (ash p/c 5) tags))
      (cons (logior (ash class 6) (ash p/c 5) 31)
            (iter tags 0 nil)))))

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
    (if (< length 128) (list length)
      (iter length nil 0))))

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
  
(defgeneric ber-encode (data))
(defgeneric ber-decode (data))

(defmethod ber-decode ((data stream))
  (let ((type (ber-decode-type data))
        (length (ber-decode-length data)))
    (ber-decode-value data type length)))

(defmethod ber-decode ((value sequence))
  (let ((stream (make-instance 'ber-stream :seq value)))
    (ber-decode stream)))

(defgeneric ber-decode-value (stream type length))

(defmethod ber-decode-value ((stream stream) (type (eql :unknown)) length)
  (declare (type stream stream)
           (type fixnum length)
           (ignore type))
  (dotimes (i length) (read-byte stream))
  nil)

(defclass ber-stream (fundamental-input-stream)
  ((sequence :type sequence :initarg :seq :reader ber-sequence)
   (length :type integer :accessor ber-length)
   (position :type integer :initform 0 :accessor ber-position)))

(defmethod shared-initialize :after ((obj ber-stream) slot-names &rest initargs)
  (declare (ignore slot-names initargs))
  (setf (ber-length obj) (length (ber-sequence obj))))

(defmethod stream-read-byte ((instance ber-stream))
  (if (= (ber-position instance) (ber-length instance))
      :eof
    (let ((byte (elt (ber-sequence instance) (ber-position instance))))
      (incf (ber-position instance))
      byte)))

(defclass raw-data ()
  ((data :accessor raw-data-of
         :initarg :data 
         :type list
         :initform nil)))

(defun raw-data-p (data)
  (typep 'raw-data data))

(defun raw-data (data)
  (make-instance 'raw-data :data data))

(defmethod ber-encode ((value raw-data))
  (raw-data-of value))

(defun ber-encode->string (data)
  (concatenate 'string (mapcar #'code-char (ber-encode data))))

(defun ber-decode<-string (data)
  (declare (type string data))
  (ber-decode (map 'vector #'char-code data)))

;;; Test Code

(defun ber-test (x)
  (let ((code (ber-encode x)))
    (format t "~A -> ~A~%~{~8,'0B ~}~%~{~D ~}~%"
            x (ber-decode (make-instance 'ber-stream :seq code))
            code code)
    x))
