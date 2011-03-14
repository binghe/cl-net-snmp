;;;; -*- Mode: Lisp -*-
;;;; $Id$
;;;; ASN.1 Readtable

(in-package :asn.1)

(defvar *asn.1-readtable*)

(defun |--reader| (stream char)
  (let ((next-char (read-char stream t nil t)))
    (case next-char
      (#\- (|---reader| stream char next-char))
      ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)
       (unread-char next-char stream)
       (let ((possible-number (read stream t nil t)))
         (etypecase possible-number
           (number (- possible-number))
           (symbol (intern (concatenate 'string "-"
                                        (symbol-name possible-number)))))))
      (t (unread-char next-char stream)
         '|-|))))

(defun |---reader| (stream char1 char2)
  (declare (ignore char1 char2))
  (do ((last-char #\Null char)
       (char (read-char stream nil #\Newline t)
             (read-char stream nil #\Newline t)))
      ((or (and (char= char #\-) (char= last-char #\-))
           (char= char #\Newline))
       (values))))

(defun |/-reader| (stream char)
  (let ((next-char (read-char stream t nil t)))
    (case next-char
      (#\* (|/*-reader| stream char next-char))
      (#\> '|/>|)
      (t (unread-char next-char stream)
         '|/|))))

(defun |/*-reader| (stream char1 char2)
  (declare (ignore char1 char2))
  (do ((last-char #\Null char)
       (char (read-char stream t nil t)
             (read-char stream t nil t)))
      ((and (char= last-char #\*) (char= char #\/))
       (values))))

(defun |<-reader| (stream char)
  (declare (ignore char))
  (let ((next-char (read-char stream t nil t)))
    (case next-char
      (#\/ '|</|)
      (t (unread-char next-char stream)
         '|<|))))

(defun |'-reader| (stream char)
  (declare (ignore char))
  (let ((number-list
         (loop for i = (read-char stream nil #\' t)
               until (char= i #\')
               collect i))
        (radix-char (ecase (read-char stream t nil t)
                      ((#\H #\h) #\X)
                      ((#\O #\o) #\O)
                      ((#\B #\b) #\B))))
    (if (null number-list)
        "" ; the empty string (''H)
      (with-input-from-string (s (coerce number-list 'string))
        (funcall (get-dispatch-macro-character #\# radix-char)
                 s nil nil)))))

(defun |:-reader| (stream char)
  (let ((next-char (read-char stream t nil t)))
    (case next-char
      (#\: (|::-reader| stream char next-char))
      (#\b :b) ; for lisp
      (#\c :c) ; for lisp
      (t (unread-char next-char stream)
         '|:|))))

(defun |::-reader| (stream char1 char2)
  (declare (ignore char1 char2))
  (let ((next-char (read-char stream nil nil t)))
    (case next-char
      (#\= (intern "::="))
      (t (unread-char next-char stream)
         (intern "::")))))

(defun single-macro-character (stream char)
  (declare (ignore stream))
  (intern (string char)))

(defun single-or-double-macro-character (stream char)
  (let ((next-char (read-char stream nil nil t)))
    (cond ((null next-char) (intern (string char)))
          ((char= next-char char)
           (intern (make-string 2 :initial-element char)))
          (t (unread-char next-char stream)
             (intern (string char))))))

(defun |.-reader| (stream char)
  (let ((next-char (read-char stream t nil t)))
    (case next-char
      (#\. (|..-reader| stream char next-char))
      (t (unread-char next-char stream)
         '|.|))))

(defun |..-reader| (stream char1 char2)
  (declare (ignore char1 char2))
  (let ((next-char (read-char stream nil nil t)))
    (cond ((null next-char) '|..|)
          ((char= next-char #\.) '|...|)
          (t (unread-char next-char stream)
             '|..|))))

(defun make-asn.1-readtable ()
  ;; Create a new readtable
  (setf *asn.1-readtable* (copy-readtable nil))
  ;; Case-Sensitivity
  (setf (readtable-case *asn.1-readtable*) :preserve)
  ;; ASN.1 One-Line Comment
  (set-macro-character #\- #'|--reader| t *asn.1-readtable*)
  ;; ASN.1 Multi-Line Comment
  (set-macro-character #\/ #'|/-reader| nil *asn.1-readtable*)
  ;; Asn.1 Non-Decimal Number
  (set-macro-character #\' #'|'-reader| nil *asn.1-readtable*)
  ;; Special Combine Symbol (::=)
  (set-macro-character #\: #'|:-reader| nil *asn.1-readtable*)
  ;; Special Combine Symbol (.. and ...)
  (set-macro-character #\. #'|.-reader| nil *asn.1-readtable*)
  ;; Special Combine Symbol (</ and <)
  (set-macro-character #\< #'|<-reader| nil *asn.1-readtable*)
  ;; Special Combine Symbol ([, [[, ], ]])
  (set-macro-character #\[ #'single-or-double-macro-character
                       nil *asn.1-readtable*)
  (set-macro-character #\] #'single-or-double-macro-character
                       nil *asn.1-readtable*)
  ;; ASN.1 Single Character Symbol
  (set-macro-character #\, #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\{ #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\} #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\> #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\( #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\) #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\; #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\@ #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\! #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\^ #'single-macro-character nil *asn.1-readtable*)
  (set-macro-character #\| #'single-macro-character nil *asn.1-readtable*))

(eval-when (:load-toplevel :execute)
  (make-asn.1-readtable))

(defgeneric display (source))

(defmethod display ((source string))
  (with-input-from-string (s source)
    (display s)))

(defmethod display ((source pathname))
  (with-open-file (s source :direction :input)
    (display s)))

(defmethod display ((source stream))
  (let ((*readtable* *asn.1-readtable*))
    (loop for i = (read source nil nil nil)
          until (null i)
          collect i)))

(defmethod display ((source t))
  (error "Unknown Display Source"))
