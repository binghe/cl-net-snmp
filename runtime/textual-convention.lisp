;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

(defmacro define-textual-convention (name type &rest options)
  (def-tc-internal name type options))

(defgeneric def-tc-internal (name type options))

(defmethod def-tc-internal ((name symbol) type options)
  "default method"
  (declare (ignore type options))
  `(deftype ,name () 't))

;;; DISPLAY-HINT Support (RFC 2579)

(defclass display-hint ()
  ((display-format              :accessor display-format))
  (:documentation "display-hint base class"))

(defclass integer-format (display-hint)
  ((implied-decimal-point       :accessor implied-decimal-point))
  (:documentation "integer format of display-hint"))

(defclass octet-string-format (display-hint)
  ((repeat-indicator            :accessor repeat-indicator
                                :type boolean
                                :initform nil
                                :documentation "optional")
   (octet-length                :accessor octet-length
                                :type (integer 0)
                                :initform 0)
   (display-separator-character :accessor display-separator-character)  ; optional
   (repeat-terminator-character :accessor repeat-terminator-character)) ; optional
  (:documentation "octet format of display-hint"))

(defun parse-integer-format (display-hint)
  (declare (type string display-hint))
  display-hint) ; not implemented

;;; MacAddress: "1x:" -> "~X:"
;;; DateAndTime: "2d-1d-1d,1d:1d:1d.1d,1a1d:1d" -> "~D-~D-~D,~D:~D:~D.~D,~A~D:~D"
;;; TransportAddressIPv6: "0a[2x:2x:2x:2x:2x:2x:2x:2x]0a:2d"
;;; SnmpOSIAddress: "*1x:/1x:"
;;;            "Represents an OSI transport-address:
;;;
;;;          octets   contents           encoding
;;;             1     length of NSAP     'n' as an unsigned-integer
;;;                                         (either 0 or from 3 to 20)
;;;          2..(n+1) NSAP                concrete binary representation
;;;          (n+2)..m TSEL                string of (up to 64) octets
;;;            "
;;;    SYNTAX       OCTET STRING (SIZE (1 | 4..85))

(defun parse-octet-string-format (display-hint)
  (declare (type string display-hint))
  (with-input-from-string (s display-hint)
    (read-one-octet-string-format s)))

(defun read-one-octet-string-format (stream)
  (declare (type stream stream))
  (let ((o (make-instance 'octet-string-format)))
    (parse-repeat-indicator o stream)
    (parse-octet-length o stream)
    (parse-display-format o stream)
    (parse-display-separator-character o stream)
    (parse-repeat-terminator-character o stream)))

(defconstant +repeat-indicator-character+ #\*
  "The repeat indicator character defined in RFC 2579")

(defun parse-repeat-indicator (object stream)
  (declare (type octet-string-format object)
           (type stream stream))
  (let ((possible-char (read-char stream)))
    (if (char= possible-char
               +repeat-indicator-character+)
        (setf (repeat-indicator object) t)
      (unread-char possible-char stream))
    (values)))

(defun parse-octet-length (object stream)
  (declare (type octet-string-format object)
           (type stream stream))
  (let ((octet-length (labels ((iter (acc)
                                 (let ((c (read-char stream)))
                                   (if (not (digit-char-p c))
                                       (prog1 acc
                                         (unread-char c stream))
                                     (iter (+ (* 10 acc)
                                              (- (char-code c) #.(char-code #\0))))))))
                        (iter 0))))
    (when (plusp octet-length)
      (setf (octet-length object) octet-length))
    (values)))

(defun parse-display-format (object stream)
  (declare (type octet-string-format object)
           (type stream stream))
  (let ((char (read-char stream)))
    (setf (display-format object) char)
    (values)))

(defun parse-display-separator-character (object stream)
  (declare (type octet-string-format object)
           (type stream stream))
  (let ((possible-char (read-char stream)))
    (if (or (char= possible-char +repeat-indicator-character+)
            (digit-char-p possible-char))
        (unread-char possible-char stream)
      (setf (display-separator-character object) possible-char))
    (values)))

(defun parse-repeat-terminator-character (object stream)
  (declare (type octet-string-format object)
           (type stream stream))
  (let ((possible-char (read-char stream)))
    (if (or (char= possible-char +repeat-indicator-character+)
            (digit-char-p possible-char))
        (unread-char possible-char stream)
      (setf (repeat-terminator-character object) possible-char))
    (values)))
