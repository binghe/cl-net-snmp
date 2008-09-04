;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant +usm-length-expanded-passphrase+ #.(* 1024 1024) "1M Bytes")
  (defconstant +usm-length-ku-hashblock+ 64 "In bytes.")
  (defconstant +usm-length-p-min+ 8 "In characters."))

;;; BER Stream: make stream from sequence

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

(defun generate-ku (key-string &key (hash-type :md5))
  (declare (optimize (speed 3) safety)
           (type string key-string)
           (type (member :md5 :sha1) hash-type))
  (let ((password (make-instance 'ku-stream
                                 :password (map 'simple-vector #'char-code key-string))))
    (ironclad:digest-stream hash-type password)))

(defun generate-ku-no-stream (key-string &key (hash-type :md5))
  (declare (optimize (speed 3) safety)
           (type string key-string)
           (type (member :md5 :sha1) hash-type))
  (let ((password (map '(simple-array (unsigned-byte 8) (*)) #'char-code key-string))
        (password-length (length key-string))
        (digest (ironclad:make-digest hash-type))
        (password-buffer (make-sequence '(simple-array (unsigned-byte 8) (*))
                                        (case hash-type (:md5 64) (:sha1 72))
                                        :initial-element 0))
        (password-index 0))
    (assert (>= password-length +usm-length-p-min+))
    (format t "generating key ... ")
    (dotimes (i (/ +usm-length-expanded-passphrase+ +usm-length-ku-hashblock+))
      (loop for j fixnum from 0 below +usm-length-ku-hashblock+
            do (progn
                 (setf (elt password-buffer j)
                       (elt password (mod password-index password-length)))
                 (incf password-index)))
      ;;; UPDATE-DIGEST is too slow on 32bit lispworks
      (ironclad:update-digest digest password-buffer))
    (format t "done.")
    (ironclad:produce-digest digest)))

(defun generate-kul (engine-id ku &key (hash-type :md5))
  (declare (type (simple-array (unsigned-byte 8) (*)) engine-id ku))
  (let ((digest (ironclad:make-digest hash-type))
        (password-buffer (concatenate '(simple-array (unsigned-byte 8) (*))
                                      ku engine-id ku)))
    (ironclad:update-digest digest password-buffer)
    (ironclad:produce-digest digest)))
