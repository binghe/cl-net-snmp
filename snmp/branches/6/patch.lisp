(in-package :snmp)

(defun compute-patch-directory-pathname (system major-version)
  (let ((directory-name
         (format nil "~A-~D" (asdf:component-name system) major-version))
        (system-pathname (asdf:component-pathname system)))
    (make-pathname :directory (append (pathname-directory system-pathname)
                                      (list "patch" directory-name))
                   :defaults system-pathname)))

(defun compute-patch-file-pathname (system major-version minor-version &optional (type "lisp"))
  (let ((name (format nil "~A-~D-~D"
                      (string-upcase (asdf:component-name system)) major-version minor-version)))
    (make-pathname :name name
                   :type type
                   :defaults (compute-patch-directory-pathname system major-version))))

(defun split-version (version-string)
  (let ((major-version (parse-integer version-string :junk-allowed t))
        (minor-version (parse-integer (subseq version-string
                                              (1+ (position #\. version-string)))
                                      :junk-allowed t)))
    (values major-version minor-version)))

(defparameter *patch-format-string*
  "~&;; ~[No~:;~:*~D~] patch~:*~[es~;~:;es~] loaded, new version is ~D.~D~%")

(defun load-all-patches (system)
  (multiple-value-bind (major-version minor-version)
      (split-version (asdf:component-version system))
    (let ((*major-version* major-version)
          (*minor-version* minor-version))
      (declare (special *major-version* *minor-version*))
      (loop for version from (1+ *minor-version*) ; search from next minor version
            as file = (compute-patch-file-pathname system *major-version* version)
            while (probe-file file)
            do (load (compile-file file))
            count file into count
            finally (format t *patch-format-string*
                            count *major-version* *minor-version*))
      (setf (asdf:component-version system)
            (format nil "~D.~D" *major-version* *minor-version*))
      (unless (= major-version *major-version*)
        (load-all-patches system)))))
