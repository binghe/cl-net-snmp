;;;; Patch 5.19: use no-stream version of GENERATE-KU to support all CL platform

(in-package :snmp)

;;; keytool.lisp

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

;;; report.lisp

(defun snmp-report (session &key context)
  (declare (type v3-session session))
  (let ((message (make-instance 'v3-message
                                :report t
                                :session session
                                :context (or context *default-context*)
                                :pdu (make-instance 'get-request-pdu
                                                    :variable-bindings #()))))
    (let ((reply (send-snmp-message session message)))
      (map 'list #'(lambda (x) (coerce x 'list))
           (variable-bindings-of (pdu-of reply))))))

(setf *minor-version* 19)
