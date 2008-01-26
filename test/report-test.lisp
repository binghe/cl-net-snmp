(in-package :snmp)

(defun report-test ()
  (let ((session (open-session "debian.local"
                               :class 'v3-session
                               :security-name "user")))
    (snmp-report session)
    (with-slots (engine-id engine-boots engine-time) session
      (format t "Engine ID: ~A~%Engine Boots: ~A~%Engine Time: ~A~%"
              engine-id engine-boots engine-time))
    (close-session session)))
