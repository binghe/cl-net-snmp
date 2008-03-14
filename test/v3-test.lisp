(in-package :snmp)

(defun v2-test ()
  (with-open-session (s "2950.lab.163.org" :port 161 :version +snmp-version-2c+ :community "public")
    (snmp-walk s '("system"))))

(defun rtt-test ()
  (with-open-session (s "cf.space.163.org" :port 161 :version +snmp-version-2c+ :community "private")
    (snmp-walk s '("system"))))

(defun trap-test ()
  (with-open-session (s "2950.lab.163.org" :port 162 :version +snmp-version-1+ :community "public")
    (snmp-trap s '(("laLoadInt.0" 3)))))

(defparameter *key-1*
  #(#x64 #xa6 #x63 #x58 #x6d #x30 #x79 #xb3 #x56 #x7d #xf7 #x88 #xf8 #x28 #x99 #x21))

(defun v3-test ()
  (let ((oid "system"))
    (with-open-session (s "debian-amd64.local" :port 161 :user "md5user" :auth *key-1*)
      (snmp-walk s (list oid)))))

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

(defun cipher ()
  (ironclad:make-cipher :des
                        :mode :cbc
                        :key *key*
                        :initialization-vector *iv*))

(defun priv-test ()
  (let ((data (copy-seq *encrypted-data*)))
    (format t "~X~%" data)
    (ironclad:decrypt-in-place (cipher) data)
    (format t "~X~%" data)
    (ironclad:encrypt-in-place (cipher) data)
    (format t "~X~%" data)))

(defun decrypt-test ()
  (let ((salt (coerce #(#x00 #x00 #x00 #x01 #x4f #xc5 #xe6 #x2a)
                      '(simple-array (unsigned-byte 8) (*))))
        ;; 0xe4f89c717175bd884778c36f5497f08d
        (des-key (coerce #(#xe4 #xf8 #x9c #x71 #x71 #x75 #xbd #x88)
                         '(simple-array (unsigned-byte 8) (*))))
        (pre-iv (coerce #(#x47 #x78 #xc3 #x6f #x54 #x97 #xf0 #x8d)
                        '(simple-array (unsigned-byte 8) (*))))
        (data (coerce #(                         #x08 #xa5 #xe1  #xf9 #xb4 #x38 #xc3 #x0e #x79 #x20 #xe8
                        #xb2 #x8e #xb5 #x0f #x14 #xf5 #xb8 #x7c  #x20 #x26 #xa9 #x9a #xea #x3f #x81 #xcf
                        #x73 #x56 #x2d #x34 #x93 #x82 #xd7 #x21  #x66 #x3d #x4a #xb8 #x2d #xd1 #x39 #xc9
                        #xc8 #x31 #x02 #x07 #x5b #x13 #xd7 #x51  #x31 #x26 #x20 #x6b #x6a)
                      '(simple-array (unsigned-byte 8) (*)))))
    (let* ((iv (map '(simple-array (unsigned-byte 8) (*))
                    #'logxor pre-iv salt))
           (cipher (ironclad:make-cipher :des
                                         :mode :cbc
                                         :key des-key 
                                         :initialization-vector iv)))
      (format t "~X~%~X~%" pre-iv iv)
      (format t "~X~%" (map '(simple-array (unsigned-byte 8) (*)) #'logxor iv salt))
      (ironclad:decrypt-in-place cipher data)
      (format t "~X~%" data))))

(defun v3-priv ()
  (let ((key #(#xe4 #xf8 #x9c #x71 #x71 #x75 #xbd #x88
               #x47 #x78 #xc3 #x6f #x54 #x97 #xf0 #x8d))
        (oid "sysDescr.0"))
    (with-open-session (s "debian.local" :user "md5des" :auth key :priv key)
      (snmp-get s oid))))
