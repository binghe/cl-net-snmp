;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp-system)

#+(and lispworks4 win32)
(pushnew :mswindows *features*)

(defparameter *snmp-features*
  (with-open-file
      (s (merge-pathnames #p"features.lisp-expr" *load-truename*)
         :direction :input)
    (read s)))

(eval-when (:load-toplevel :execute)
  (dolist (i *snmp-features*)
    (pushnew i *features*))
  (pushnew :snmp *features*))
