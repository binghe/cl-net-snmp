;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp-system)

#+(and lispworks4 win32)
(pushnew :mswindows *features*)

(defpackage snmp-features
  (:use :common-lisp)
  (:export
   ;; networking package
   #:usocket
   #:iolib
   ;; multi-threading
   #:portable-threads
   #:bordeaux-threads
   ;; rule engine
   #:knowledgeworks
   #:lisa))

(defparameter *snmp-features*
  (with-open-file
      (s (merge-pathnames #p"features.lisp-expr" *load-truename*)
         :direction :input)
    (let ((*package* (find-package :snmp-features)))
      (read s))))

(eval-when (:load-toplevel :execute)
  (dolist (i *snmp-features*)
    (pushnew i *features*)))
