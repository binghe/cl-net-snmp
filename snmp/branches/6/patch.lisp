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
  "~&;; ~[No~:;~:*~D~] patch~:*~[~:;es~] loaded, ~:*~[current~:;new~] ~A version is ~D.~D~%")

(defgeneric load-all-patches (system))

(defmethod load-all-patches ((system t))
  (let ((system-instance (asdf:find-system system)))
    (when system-instance
      (load-all-patches system-instance))))

(defmethod load-all-patches ((system asdf:system))
  (multiple-value-bind (major-version minor-version)
      (split-version (asdf:component-version system))
    (loop for version from (1+ minor-version) ; search from next minor version
       as file = (compute-patch-file-pathname system major-version version)
       while (probe-file file)
       do (load (compile-file file))
       count file into count
       finally
	 (format t *patch-format-string*
		 count (asdf:component-name system) major-version (+ minor-version count))
	 (unless (zerop count)
	   (setf (asdf:component-version system)
		 (format nil "~D.~D" major-version (+ minor-version count)))))))
