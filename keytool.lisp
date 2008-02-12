;;;; Net-SNMP compatible generateKu() [snmplib/keytools.c]
;;;; binghe: I haven't finished, it buggy and VERY slow.

(in-package :snmp)

;;; Goal: translate "vHunxJXPRdUyAzjY" into
;;;       #(#xe4 #xf8 #x9c #x71 #x71 #x75 #xbd #x88 #x47 #x78 #xc3 #x6f #x54 #x97 #xf0 #x8d)
;;; (generate-ku "vHunxJXPRdUyAzjY")

(defconstant +usm-length-expanded-passphrase+ #.(* 1024 1024) "1Meg.")
(defconstant +usm-length-ku-hashblock+ 64 "In bytes.")
(defconstant +usm-length-p-min+ 8 "In characters.")

(defun generate-ku (key-string &key (hash-type :md5))
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let ((password (map '(simple-array (unsigned-byte 8) (*)) #'char-code key-string))
        (password-length (length key-string))
        (digest (ironclad:make-digest hash-type))
        (password-buffer (make-sequence '(simple-array (unsigned-byte 8) (*))
                                        +usm-length-ku-hashblock+ :initial-element 0))
        (password-index 0))
    (assert (>= password-length +usm-length-p-min+))
    (dotimes (i (/ +usm-length-expanded-passphrase+ +usm-length-ku-hashblock+))
      (loop for j fixnum from 0 below +usm-length-ku-hashblock+
            do (progn
                 (setf (elt password-buffer j)
                       (elt password (mod password-index password-length)))
                 (incf password-index)))
      (ironclad:update-digest digest password-buffer))
    (let ((key (ironclad:produce-digest digest)))
      key)))
