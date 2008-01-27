(in-package :snmp)

(defun report-test ()
  (let ((session (open-session "debian.local"
                               :class 'v3-session
                               :security-name "user")))
    (snmp-report session)
    (with-slots (engine-id engine-boots engine-time) session
      (format t "Engine ID: ~{~X~}~%Engine Boots: ~A~%Engine Time: ~A~%"
              (map 'list #'char-code engine-id) engine-boots engine-time))
    (close-session session)))

(defun v3-get-test ()
  (let ((session (open-session "debian.local"
                               :class 'v3-session
                               :security-name "user")))
    (prog1 (snmp-get session '(1 3 6 1 2 1 1 1 0))
      (close-session session))))

(defun v3-walk-test ()
  (let ((session (open-session "debian.local"
                               :class 'v3-session
                               :security-name "user")))
    (prog1 (snmp-walk session '(1 3 6 1 2 1 1))
      (close-session session))))
