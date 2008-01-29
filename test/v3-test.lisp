(in-package :snmp)

(defparameter *key*
  #(#x64 #xa6 #x63 #x58 #x6d #x30 #x79 #xb3 #x56 #x7d #xf7 #x88 #xf8 #x28 #x99 #x21))

(defun v3-test ()
  (let ((oid (list 1 3 6 1 2 1 1)))
    (with-open-session (s "debian.local" :user "md5user" :auth *key*)
      (snmp-walk s oid))))

(defparameter *authenticate-data*
  #(                                                             #x30 #x81 #x83 #x02
    #x01 #x03 #x30 #x11 #x02 #x04 #x29 #x77  #xb1 #x57 #x02 #x03 #x00 #xff #xe3 #x04
    #x01 #x05 #x02 #x01 #x03 #x04 #x36 #x30  #x34 #x04 #x11 #x80 #x00 #x1f #x88 #x80
    #xe1 #xfb #x08 #x5e #x3b #x0a #x91 #x47  #x00 #x00 #x00 #x00 #x02 #x01 #x18 #x02
    #x03 #x00 #x99 #xc6 #x04 #x07 #x6d #x64  #x35 #x75 #x73 #x65 #x72 #x04 #x0c #x0f
    ;;                                                                          ^^^^
    #x0e #x38 #x38 #x7b #x80 #xa7 #x27 #x5c  #x5f #x9c #xec #x04 #x00 #x30 #x33 #x04
    ;;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    #x11 #x80 #x00 #x1f #x88 #x80 #xe1 #xfb  #x08 #x5e #x3b #x0a #x91 #x47 #x00 #x00
    #x00 #x00 #x04 #x00 #xa0 #x1c #x02 #x04  #x1b #xd4 #xce #xf0 #x02 #x01 #x00 #x02
    #x01 #x00 #x30 #x0e #x30 #x0c #x06 #x08  #x2b #x06 #x01 #x02 #x01 #x01 #x01 #x00
    #x05 #x00))

(defparameter *data*
  #(                                                             #x30 #x81 #x83 #x02
    #x01 #x03 #x30 #x11 #x02 #x04 #x29 #x77  #xb1 #x57 #x02 #x03 #x00 #xff #xe3 #x04
    #x01 #x05 #x02 #x01 #x03 #x04 #x36 #x30  #x34 #x04 #x11 #x80 #x00 #x1f #x88 #x80
    #xe1 #xfb #x08 #x5e #x3b #x0a #x91 #x47  #x00 #x00 #x00 #x00 #x02 #x01 #x18 #x02
    #x03 #x00 #x99 #xc6 #x04 #x07 #x6d #x64  #x35 #x75 #x73 #x65 #x72 #x04 #x0c #x00
    ;;                                                                          ^^^^
    #x00 #x00 #x00 #x00 #x00 #x00 #x00 #x00  #x00 #x00 #x00 #x04 #x00 #x30 #x33 #x04
    ;;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    #x11 #x80 #x00 #x1f #x88 #x80 #xe1 #xfb  #x08 #x5e #x3b #x0a #x91 #x47 #x00 #x00
    #x00 #x00 #x04 #x00 #xa0 #x1c #x02 #x04  #x1b #xd4 #xce #xf0 #x02 #x01 #x00 #x02
    #x01 #x00 #x30 #x0e #x30 #x0c #x06 #x08  #x2b #x06 #x01 #x02 #x01 #x01 #x01 #x00
    #x05 #x00))

(defun hmac-test ()
  (let ((hmac (ironclad:make-hmac *key* :md5)))
    (ironclad:update-hmac hmac *data*)
    (format t "~X~%" (ironclad:hmac-digest hmac))))

;;; SNMP 6 > (hmac-test)
;;; #(F E 38 38 7B 80 A7 27 5C 5F 9C EC 3 A6 D3 68)
;;; NIL

(defun 2950-test ()
  (let ((oid (list 1 3 6 1 2 1 1 1 0))
        (host "2950.lab.163.org")
        (md5-key  #(#xf3 #xd8 #xbe #xae #xb1 #x84 #xf2 #xb0
                    #x5c #x26 #xfa #xc3 #x8d #x72 #x47 #x12))
        (sha1-key #(#xf5 #x7f #x4d #x6e #xaf #xd4 #x34 #x3f #xa7 #xdf
                    #x17 #xc7 #xeb #x66 #x56 #x4a #x9a #xee #x0b #x26))
        (des-key  #(#xf3 #xd8 #xbe #xae #xb1 #x84 #xf2 #xb0
                    #x5c #x26 #xfa #xc3 #x8d #x72 #x47 #x12))
        (aes-key  #(#xf5 #x7f #x4d #x6e #xaf #xd4 #x34 #x3f
                    #xa7 #xdf #x17 #xc7 #xeb #x66 #x56 #x4a)))
    (with-open-session (s host :user "md5" :auth `(:md5 ,md5-key))
      (format t "MD5: ~A~%" (car (snmp-get s oid))))
    (with-open-session (s host :user "sha" :auth `(:sha1 ,sha1-key))
      (format t "SHA1: ~A~%" (car (snmp-get s oid))))
    (with-open-session (s host :user "md5des" :auth `(:md5 ,md5-key) :priv `(:des ,des-key))
      (format t "MD5/DES: ~A~%" (car (snmp-get s oid))))))

(defparameter *encrypted-data*
  #(#x9f #xfd #x95 #xf2 #x78 #x15 #x51 #x58  #x1e #xab #xee #x20 #x89 #x17 #xc6 #x18
    #xee #x3f #xe9 #xf0 #xa1 #x81 #xb0 #x9b  #x40 #x21 #xfc #x9c #xb3 #xe5 #xef #xd5
    #xff #x7b #x47 #xfe #x1d #xc8 #xc9 #x9e  #x94 #xd0 #x88 #x3f #xb2 #x7c #xaf #x6f))

(defparameter *iv*
  (concatenate '(simple-array (unsigned-byte 8) (*))
               (mapcar #'logxor '(#x00 #x00 #x00 #x01 #x31 #xba #x81 #x87)
                                '(#x5c #x26 #xfa #xc3 #x8d #x72 #x47 #x12))))
(defparameter *key*
  (concatenate '(simple-array (unsigned-byte 8) (*))
               #(#xf3 #xd8 #xbe #xae #xb1 #x84 #xf2 #xb0)))

(defun priv-test ()
  (let ((cipher (ironclad:make-cipher :des
                                      :mode :cbc
                                      :key *key*
                                      :initialization-vector *iv*))
        (data (copy-seq *encrypted-data*)))
    (format t "~X~%" data)
    (ironclad:encrypt-in-place cipher data)
    (format t "~X~%" data)
    (ironclad:decrypt-in-place cipher data)
    (format t "~X~%" data)))
