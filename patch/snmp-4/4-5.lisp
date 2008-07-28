(in-package :snmp)

(defun send-until (action socket &key (times *snmp-send-times*)
                                      (wait-time *snmp-wait-timeout*))
  (loop with result = nil
        for i from 0 below times
        until result
        do (progn
             (when (plusp i)
               (format t "resend times: ~A at ~A.~%" i (get-internal-real-time)))
             (funcall action)
             (setf result (wait-for-input socket :timeout wait-time)))
        finally (return result)))
