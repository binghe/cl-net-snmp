(in-package :snmp)

(defun v2-test ()
  (with-open-session (s "debian-amd64.local" :port 161 :version +snmp-version-2c+ :community "public")
    (snmp-walk s '(#(1 3 6 1 2 1 1)))))

(defun rtt-test ()
  (with-open-session (s "cf.space.163.org" :port 161 :version +snmp-version-2c+ :community "private")
    (snmp-walk s '("system"))))

(defun trap-test ()
  (with-open-session (s "2950.lab.163.org" :port 162 :version +snmp-version-1+ :community "public")
    (snmp-trap s nil)))

(defun v2trap-test ()
  (with-open-session (s "debian.local" :port 162 :version +snmp-version-2c+ :community "public")
    (snmp-trap s nil)))

(defun inform-test ()
  (with-open-session (s "debian.local" :port 162 :version +snmp-version-2c+ :community "public")
    (snmp-inform s nil)))

(defun v3-test ()
  (let ((oid #(1 3 6 1 2 1 1)))
    (with-open-session (s "debian.local" :port 161 :user "md5user" :auth "ABCDEFGH")
      (snmp-walk s (list oid)))))

(defun v3-test-2 ()
  (let ((oid #(1 3 6 1 2 1 1)))
    (with-open-session (s "debian.local"
                          :port 161 :user "md5des"
                          :auth "vHunxJXPRdUyAzjY"
                          :priv "vHunxJXPRdUyAzjY")
      (snmp-walk s (list oid)))))

(defun 2950-test ()
  (let ((oid (list #(1 3 6 1 2 1 1 1 0)))
        (host "2950.lab.163.org")
        (md5-key #+ignore #(#xf3 #xd8 #xbe #xae #xb1 #x84 #xf2 #xb0
                            #x5c #x26 #xfa #xc3 #x8d #x72 #x47 #x12)
                 "vHunxJXPRdUyAzjY")
        (sha1-key #+ignore #(#xf5 #x7f #x4d #x6e #xaf #xd4 #x34 #x3f #xa7 #xdf
                             #x17 #xc7 #xeb #x66 #x56 #x4a #x9a #xee #x0b #x26)
                  "vHunxJXPRdUyAzjY")
        (des-key #+ignore #(#xf3 #xd8 #xbe #xae #xb1 #x84 #xf2 #xb0
                            #x5c #x26 #xfa #xc3 #x8d #x72 #x47 #x12)
                 "vHunxJXPRdUyAzjY")
        (aes-key  #(#xf5 #x7f #x4d #x6e #xaf #xd4 #x34 #x3f
                    #xa7 #xdf #x17 #xc7 #xeb #x66 #x56 #x4a)))
    (with-open-session (s host :user "md5"
                          :auth `(:md5 ,md5-key))
      (format t "MD5: ~A~%" (snmp-get s oid)))
    (with-open-session (s host :user "sha"
                          :auth `(:sha1 ,sha1-key))
      (format t "SHA1: ~A~%" (snmp-get s oid)))
    (with-open-session (s host :user "md5des"
                          :auth `(:md5 ,md5-key)
                          :priv `(:des ,des-key))
      (format t "MD5/DES: ~A~%" (snmp-get s oid)))))
