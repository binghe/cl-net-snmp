;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defparameter *patch-directory-name* "patch")

(defun compute-patch-directory-pathname (system major-version)
  (let ((directory-name
         (format nil "~A-~D" (string-downcase (asdf:component-name system)) major-version))
        (system-pathname (asdf:component-pathname system)))
    (make-pathname :directory (append (pathname-directory system-pathname)
                                      (list *patch-directory-name* directory-name))
                   :defaults system-pathname)))

(defun compute-patch-file-pathname (system major-version minor-version &optional (type "lisp"))
  (let ((name (format nil "~A-~D-~D"
                      (string-downcase (asdf:component-name system)) major-version minor-version)))
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
  "~&;; ~[No~:;~:*~D~] patch~:*~[~:;~:;es~] loaded, ~:*~[current~:;new~] ~A version is ~D.~D~%")

(defgeneric load-all-patches (system))

(defmethod load-all-patches ((system t))
  (let ((system-instance (asdf:find-system system)))
    (when system-instance
      (load-all-patches system-instance))))

(defun load-one-patch-file (file)
  (let ((output-file #+asdf2 (asdf:compile-file-pathname* file)
                     #-asdf2 (compile-file-pathname file)))
    (if (and (probe-file output-file)
             #+asdf2
             (< (asdf::safe-file-write-date file)
                (asdf::safe-file-write-date output-file))
             #-asdf2 t)
        (load output-file)
      (progn
        (ensure-directories-exist output-file)
        (load (compile-file file :output-file output-file))))))

(defmethod load-all-patches ((system asdf:system))
  (multiple-value-bind (major-version minor-version)
      (split-version (asdf:component-version system))
    (loop for version from (1+ minor-version) ; search from next minor version
       as file = (compute-patch-file-pathname system major-version version)
       while (probe-file file)
       do (load-one-patch-file file)
       count file into count
       finally
	 (format t
	         *patch-format-string*
		     count
		     (string-upcase (asdf:component-name system))
             major-version
             (+ minor-version count))
	 (unless (zerop count)
	   (setf (asdf:component-version system)
		 (format nil "~D.~D" major-version (+ minor-version count)))))))
