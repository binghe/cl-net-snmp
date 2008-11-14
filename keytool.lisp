;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant +usm-length-expanded-passphrase+ #.(* 1024 1024) "1M Bytes")
  (defconstant +usm-length-ku-hashblock+ 64 "In bytes.")
  (defconstant +usm-length-p-min+ 8 "In characters."))

(defun generate-ku (key-string &key (hash-type :md5))
  (declare (optimize (speed 3) safety)
           (type string key-string)
           (type (member :md5 :sha1) hash-type))
  (let ((password (map 'octets #'char-code key-string))
        (password-length (length key-string))
        (digest (ironclad:make-digest hash-type))
        (password-buffer (make-sequence 'octets
                                        (case hash-type (:md5 64) (:sha1 72))
                                        :initial-element 0))
        (password-index 0))
    (assert (>= password-length +usm-length-p-min+))
    (dotimes (i (/ +usm-length-expanded-passphrase+ +usm-length-ku-hashblock+))
      (loop for j fixnum from 0 below +usm-length-ku-hashblock+
            do (progn
                 (setf (elt password-buffer j)
                       (elt password (mod password-index password-length)))
                 (incf password-index)))
      ;;; UPDATE-DIGEST is too slow on 32bit lispworks
      (ironclad:update-digest digest password-buffer))
    (ironclad:produce-digest digest)))

(defun generate-kul (engine-id ku &key (hash-type :md5))
  (declare (type octets engine-id ku))
  (let ((digest (ironclad:make-digest hash-type))
        (password-buffer (concatenate 'octets ku engine-id ku)))
    (ironclad:update-digest digest password-buffer)
    (ironclad:produce-digest digest)))
