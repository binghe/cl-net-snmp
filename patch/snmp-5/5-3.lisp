(in-package :snmp)

(defun snmp-connect (host port)
  (declare (ignore host port))
  (socket-connect/udp nil nil
                      :element-type '(unsigned-byte 8)
                      ;; On Win32, we must bind it to set socketopt
                      #+win32 :local-port #+win32 0
                      :stream nil))
