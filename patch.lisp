(in-package :snmp)

(defparameter *patch-directory* #p"SNMP:PATCH;")

(defun compute-snmp-patch-directory-pathname ()
  (let ((directory-name
         (format nil "~A-~D" (package-name *snmp-package*) *major-version*)))
    (make-pathname :directory (append (pathname-directory *patch-directory*) (list directory-name))
                   :defaults *patch-directory*)))

(defun compute-snmp-patch-file-pathname (version &optional (type "lisp"))
  (declare (type integer version))
  (let ((name (format nil "~A-~D-~D" (package-name *snmp-package*) *major-version* version)))
    (make-pathname :name name
                   :type type
                   :defaults (compute-snmp-patch-directory-pathname))))

(defun load-all-patches ()
  (loop for version from (1+ *minor-version*)
        as file = (compute-snmp-patch-file-pathname version)
        while (probe-file file)
        do (load (compile-file file))
        count file into count
        finally (if (zerop count)
                    (format t "No patch loaded, current version is ~D.~D~%"
                            *major-version* *minor-version*)
                  (format t "~D patches loaded, new version is ~D.~D~%"
                          count *major-version* *minor-version*))))
