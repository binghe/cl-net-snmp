;;;; -*- Mode:Common-Lisp; Package:PORTABLE-THREADS; Syntax:common-lisp -*-
;;;; *-* File: /usr/local/gbbopen/source/tools/portable-threads.lisp *-*
;;;; *-* Edited-By: cork *-*
;;;; *-* Last-Edit: Tue Jul  8 05:55:15 2008 *-*
;;;; *-* Machine: cyclone.cs.umass.edu *-*

;;;; **************************************************************************
;;;; **************************************************************************
;;;; *
;;;; *             Portable Threads (Multiprocessing) Interface
;;;; *
;;;; **************************************************************************
;;;; **************************************************************************
;;;
;;; Written by: Dan Corkill
;;;
;;; Copyright (C) 2003-2008, Dan Corkill <corkill@GBBopen.org> 
;;;
;;; Developed and supported by the GBBopen Project (http://GBBopen.org) and
;;; donated to the CL Gardeners portable threads initiative
;;; (http://wiki.alu.org/Portable_Threads).  (Licenced under the Apache 2.0
;;; license, see http://GBBopen.org/downloads/LICENSE for license details.)
;;;
;;; Bug reports, suggestions, enhancements, and extensions should be sent to
;;; corkill@GBBopen.org.
;;;
;;; On-line documentation for these portable thread interface entities is
;;; available at http://gbbopen.org/hyperdoc/index.html
;;;
;;; This file can be used stand-alone on the supported CLs (no additional
;;; libraries are requried).
;;;
;;; Porting Notice:
;;;
;;;   The semantics of these interface entities must be maintained when
;;;   porting to new CL implementations/versions
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;;;
;;;  11-21-03 File created.  (Corkill)
;;;  03-20-04 Added process-yield, kill, hibernate/awaken.  (Corkill)
;;;  03-21-04 Added atomic operations.  (Corkill)
;;;  06-11-05 Clean up best attempts for non-threaded CLs.  (Corkill)
;;;  10-21-05 Added polling functions for non-threaded CLs.  (Corkill)
;;;  12-22-05 Removed without-interrupts support (incompatible with
;;;           preemptive scheduling models).  (Corkill)
;;;  12-27-05 Added process-name.  (Corkill)
;;;  01-02-06 Separated from GBBopen, moved polling-functions into separate
;;;           polling-functions.lisp file and module.  (Corkill)
;;;  01-12-06 Added as-atomic-operation support, but only as a mechanism
;;;           for implementing very brief atomic operations.  (Corkill)
;;;  05-08-06 Added support for the Scieneer CL. (dtc)
;;;  07-28-07 V2.0 naming changes, full condition variable support.  (Corkill)
;;;  08-20-07 V2.1: Added scheduled functions, thread-alive-p, 
;;;           encode-time-of-day. (Corkill)
;;;  08-27-07 V2.2: Added periodic functions.  (Corkill)
;;;  10-23-07 Fixed 64-bit CL sleep issues (thanks Antony!).  (Corkill)
;;;  11-20-07 V2.3: Remove V1.0 compatabilty; resupport Digitool MCL.
;;;           (Corkill)
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package ':portable-threads)
    (make-package ':portable-threads
                  :use '(:common-lisp))))

(in-package :portable-threads)

;; Support for threads in Corman Common Lisp is under development and is 
;; incomplete, so we consider it threadless, for now:
#+cormanlisp-is-not-ready
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'threads))

;;; ===========================================================================
;;; Add a single feature to identify sufficiently new Digitool MCL
;;; implementations (both Digitool MCL and pre-1.2 Clozure CL include the
;;; feature mcl):

#+(and digitool ccl-5.1)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew ':digitool-mcl *features*))

;;; ---------------------------------------------------------------------------
;;; Add clozure feature to legacy OpenMCL:

#+(and openmcl (not clozure))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew ':clozure *features*))

;;; ---------------------------------------------------------------------------
;;; Add a feature to identify new lock structure for Lispworks:

#+lispworks
(eval-when (:compile-toplevel :load-toplevel :execute)
  (when (fboundp 'mp::lock-i-name)
    (pushnew ':new-locks *features*)))

;;; ---------------------------------------------------------------------------
;;;  Warn if sb-thread support is missing on SBCL/Linux

#+(and sbcl linux (not sb-thread))
(warn "Thread support on ~a is not present.~@
       (Add the ~s feature in SBCL's customize-target-features.lisp ~
        and rebuild)"
      (lisp-implementation-type)
      :sb-thread)

;;;  Error if threads support is outdated in user's SBCL
#+(and sbcl sb-thread)
(unless (fboundp 'sb-thread::thread-yield)
  (error "A newer SBCL release is required."))

;;; ---------------------------------------------------------------------------
;;;  Warn if threads support is missing in ECL

#+(and ecl (not threads)) 
(warn "Thread support on ~a is not present.~@
       (Use configure option --enable-threads and remake to provide threads ~
        support.)"
      (lisp-implementation-version))

;;;  Error if threads support is outdated in user's ECL 
#+(and ecl threads)
(unless (fboundp 'mp::process-yield)
  (error "The latest CVS checkout of ECL is required."))

;;; ---------------------------------------------------------------------------
;;;  Defcm (conditional define-compiler-macro form)
;;;  (Copied from GBBopen Tools declarations.lisp to allow stand-alone 
;;;   portable threads)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (macro-function 'defcm)
    (defmacro defcm (&body body)
      ;;; Shorthand conditional compiler-macro:
      (unless (or (member (symbol-name ':full-safety) *features*
                          :test 'string=)
                  (member (symbol-name ':disable-compiler-macros) *features*
                          :test 'string=))
        `(define-compiler-macro ,@body)))))

;;; ===========================================================================
;;; Import the CL-implementation's threading symbols, as needed:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (import
   #+allegro 
   '(sys:with-timeout)
   #+clisp
   '()
   #+clozure
   '()
   #+(and cmu mp)
   '(mp:atomic-decf
     mp:atomic-incf
     mp:atomic-pop
     mp:atomic-push
     mp::recursive-lock
     mp:with-timeout)
   #+(and cmu (not mp))
   '()
   #+cormanlisp
   '()
   #+digitool-mcl
   '()
   #+(and ecl threads)
   '()
   #+(and ecl (not threads))
   '()
   #+gcl
   '()
   #+lispworks
   '(mp:make-lock
     mp::initialize-multiprocessing)
   #+(and sbcl sb-thread)
   '(sb-thread:thread-alive-p
     sb-thread:thread-name
     sb-thread:thread-yield)
   #+(and sbcl (not sb-thread))
   '()
   #+scl
   '(mp:atomic-decf
     mp:atomic-incf
     mp:atomic-pop
     mp:atomic-push
     thread:make-cond-var
     thread:cond-var-wait
     thread:cond-var-timedwait
     thread:cond-var-signal
     thread:cond-var-broadcast)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(*nearly-forever-seconds*             ; not documented
            *non-threaded-polling-function-hook* ; not documented
            *periodic-function-verbose*
            *schedule-function-verbose*
            all-scheduled-functions
            all-threads
            as-atomic-operation
            atomic-decf
            atomic-delete
            atomic-flush
            atomic-incf
            atomic-pop
            atomic-push
            atomic-pushnew
            awaken-thread
            condition-variable
            condition-variable-broadcast
            condition-variable-signal
            condition-variable-wait
            condition-variable-wait-with-timeout
            current-thread
            encode-time-of-day
            hibernate-thread
            #+lispworks
            initialize-multiprocessing
            kill-periodic-function
            kill-thread
            make-condition-variable
            make-lock
            make-recursive-lock
            make-scheduled-function
            portable-threads-implementation-version ; not documented
            restart-scheduled-function-scheduler
            run-in-thread
            schedule-function
            schedule-function-relative
            scheduled-function          ; structure (not documented)
            scheduled-function-name
            scheduled-function-repeat-interval
            spawn-periodic-function
            spawn-thread
            #+(and cmu mp)
            start-multiprocessing       ; easier to remember/type!
            symbol-value-in-thread
            threadp
            threads-not-available       ; not documented
            thread-alive-p
            thread-condition-variables-not-available ; not documented
            thread-holds-lock-p
            thread-name
            thread-whostate
            thread-yield
            unschedule-function
            with-lock-held
            with-timeout
            with-timeout-not-available  ; not documented
            without-lock-held))
  #+(and cmu mp)
  (import '(start-multiprocessing) ':cl-user))

;;; ---------------------------------------------------------------------------
;;;  Warn if the idle process is not running on CMUCL

#+(and cmu mp)
(defun start-multiprocessing ()
  ;; easier to remember and type than the following:
  (mp::startup-idle-and-top-level-loops))

#+(and cmu mp)
(defun check-idle-process (&optional errorp)
  (unless mp::*idle-process*
    (funcall (if errorp 'error 'warn)
             "You must start CMUCL's idle process by calling~
              ~%~3t(~s)~
              ~%for ~s and other thread operations to function properly."
             'start-multiprocessing
             'with-timeout)))

#+(and cmu mp)
(check-idle-process)

;;; ---------------------------------------------------------------------------
;;;  Warn if multiprocessing is not running on Lispworks

#+lispworks
(defun check-for-multiprocessing-started (&optional errorp)
  (unless mp:*current-process*
    (funcall (if errorp 'error 'warn)
             "You must start multiprocessing on Lispworks by calling~
              ~%~3t(~s)~
              ~%for ~s, locks, and other thread operations to function ~
              properly."
             'initialize-multiprocessing
             'with-timeout)))

#+lispworks
(check-for-multiprocessing-started)

;;; ===========================================================================
;;;  Features & warnings

#+(or clisp
      cormanlisp
      (and cmu (not mp)) 
      (and ecl (not threads))
      gcl
      (and sbcl (not sb-thread)))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew ':threads-not-available *features*))

;;; ---------------------------------------------------------------------------

#+threads-not-available
(defun threads-not-available (operation)
  (warn "Threads are not available in ~a running on ~a; ~s was used."
        (lisp-implementation-type) 
        (machine-type)
        operation))

#+threads-not-available
(defun thread-condition-variables-not-available (operation)
  (warn "Thread condition variables are not available in ~a running on ~a; ~
        ~s was used."
        (lisp-implementation-type) 
        (machine-type)
        operation))

#+threads-not-available
(defun not-a-thread (thread)
  (error "~s is not a thread object" thread))

;;; ---------------------------------------------------------------------------

#+(and threads-not-available
       ;; With-timeout is supported on non-threaded SBCL
       (not sbcl))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew ':with-timeout-not-available *features*))

;;; ---------------------------------------------------------------------------

#+with-timeout-not-available
(defun with-timeout-not-available ()
  (warn "~s is not available in ~a running on ~a."
        'with-timeout
        (lisp-implementation-type) 
        (machine-type)))

;;; ===========================================================================

(defun portable-threads-implementation-version ()
  "2.3")

;;; Added to *features* at the end of this file:
(defparameter *portable-threads-version-keyword* 
    ;; Support cross-case mode CLs:
    (read-from-string (format nil ":portable-threads-~a" 
                              (portable-threads-implementation-version))))

;;; ---------------------------------------------------------------------------

(defun print-portable-threads-herald ()
  (format t "~%;;; ~72,,,'-<-~>
;;;  Portable Threads Interface ~a~@
;;;
;;;    Developed and supported by the GBBopen Project (http:/GBBopen.org/)
;;;    (See http://GBBopen.org/downloads/LICENSE for license details.)
;;; ~72,,,'-<-~>~2%"
          (portable-threads-implementation-version)))
  
(eval-when (:load-toplevel)
  (print-portable-threads-herald))

;;; ===========================================================================
;;;  Thread-wait hook for non-threaded CLs (for example, GBBopen's
;;;  polling functions)

#+threads-not-available
(defvar *non-threaded-polling-function-hook* nil)

;;; ===========================================================================
;;;   Current-Thread (returns :threads-not-available on CLs without threads)

(defun current-thread ()
  #+allegro
  mp:*current-process*
  #+clozure
  ccl:*current-process*
  #+(and cmu mp)
  mp:*current-process*
  #+(and ecl threads)
  mp:*current-process*
  #+digitool-mcl
  ccl:*current-process*
  #+lispworks
  mp:*current-process*
  #+(and sbcl sb-thread)
  sb-thread:*current-thread*
  #+scl
  (mp:current-process)
  #+threads-not-available
  ':threads-not-available)

(defcm current-thread ()
  #+allegro
  'mp:*current-process*
  #+clozure
  'ccl:*current-process*
  #+(and cmu mp)
  'mp:*current-process*
  #+digitool-mcl
  'ccl:*current-process*
  #+(and ecl threads)
  'mp:*current-process*
  #+lispworks
  'mp:*current-process*
  #+(and sbcl sb-thread)
  'sb-thread:*current-thread*
  #+scl
  '(mp:current-process)
  #+threads-not-available
  ':threads-not-available)
 
;;; ===========================================================================
;;;   All-Threads (returns nil on CLs without threads)

(defun all-threads ()
  #+allegro
  mp:*all-processes*
  #+clozure
  (ccl:all-processes)
  #+(and cmu mp)
  (mp:all-processes)
  #+digitool-mcl
  ccl:*all-processes*
  #+(and ecl threads)
  (mp:all-processes)
  #+lispworks
  (mp:list-all-processes)
  #+(and sbcl sb-thread)
  sb-thread::*all-threads*
  #+scl
  (mp:all-processes)
  #+threads-not-available
  nil)
  
(defcm all-threads ()
  #+allegro
  'mp:*all-processes*
  #+clozure
  '(ccl:all-processes)
  #+(and cmu mp)
  '(mp:all-processes)
  #+digitool-mcl
  'ccl:*all-processes*
  #+(and ecl threads)
  '(mp:all-processes)
  #+lispworks
  '(mp:list-all-processes)
  #+(and sbcl sb-thread)
  'sb-thread::*all-threads*
  #+scl
  '(mp:all-processes)
  #+threads-not-available
  nil)

;;; ---------------------------------------------------------------------------
;;;   Threadp

(defun threadp (obj)
  #+allegro
  (mp:process-p obj)
  #+clozure
  (ccl::processp obj)
  #+(and cmu mp)
  (mp:processp obj)
  #+digitool-mcl
  (ccl::processp obj)
  #+(and ecl threads)
  (typep obj 'mp:process)
  #+lispworks
  (mp:process-p obj)
  #+(and sbcl sb-thread)
  (sb-thread::thread-p obj)
  #+scl
  (mp:processp obj)
  #+threads-not-available
  (declare (ignore obj))
  #+threads-not-available
  nil)

(defcm threadp (obj)
  #+allegro
  `(mp:process-p ,obj)
  #+clozure
  `(ccl::processp ,obj)
  #+(and cmu mp)
  `(mp:processp ,obj)
  #+digitool-mcl
  `(ccl::processp ,obj)
  #+(and ecl threads)
  `(typep ,obj 'mp:process)
  #+lispworks
  `(mp:process-p ,obj)
  #+(and sbcl sb-thread)
  `(sb-thread::thread-p ,obj)
  #+scl
  `(mp:processp ,obj)
  #+threads-not-available
  (declare (ignore obj))
  #+threads-not-available
  nil)

;;; ---------------------------------------------------------------------------
;;;   Thread-alive-p (threaded SBCL is native)

#-(and sbcl sb-thread)
(defun thread-alive-p (obj)
  #+allegro
  (mp:process-alive-p obj)
  #+clozure
  (ccl::process-active-p obj)
  #+(and cmu mp)
  (mp:process-alive-p obj)
  #+digitool-mcl
  (ccl::process-active-p obj)
  #+(and ecl threads)
  (mp:process-active-p obj)
  #+lispworks
  (mp:process-alive-p obj)
  #+scl
  (mp:process-alive-p obj)
  #+threads-not-available
  (declare (ignore obj))
  #+threads-not-available
  nil)

#-(or threads-not-available 
      (and sbcl sb-thread))
(defcm thread-alive-p (obj)
  #+allegro
  `(mp:process-alive-p ,obj)
  #+clozure
  `(ccl::process-active-p ,obj)
  #+(and cmu mp)
  `(mp:process-alive-p ,obj)
  #+digitool-mcl
  `(ccl::process-active-p ,obj)
  #+(and ecl threads)
  `(mp:process-active-p ,obj)
  #+lispworks
  `(mp:process-alive-p ,obj)
  #+scl
  `(mp:process-alive-p ,obj)
  #+threads-not-available
  (declare (ignore obj))
  #+threads-not-available
  nil)

;;; ---------------------------------------------------------------------------
;;;   Thread-name (threaded SBCL is native)

#-(and sbcl sb-thread)
(defun thread-name (thread)
  #+allegro
  (mp:process-name thread)
  #+clozure
  (ccl:process-name thread)
  #+(and cmu mp)
  (mp:process-name thread)
  #+digitool-mcl
  (ccl:process-name thread)
  #+(and ecl threads)
  (mp:process-name thread)
  #+lispworks
  (mp:process-name thread)
  #+scl
  (mp:process-name thread)
  #+threads-not-available
  (not-a-thread thread))

#-(or threads-not-available 
      (and sbcl sb-thread))
(defcm thread-name (thread)
  #+allegro
  `(mp:process-name ,thread)
  #+clozure
  `(ccl:process-name ,thread)
  #+(and cmu mp)
  `(mp:process-name ,thread)
  #+digitool-mcl
  `(ccl:process-name ,thread)
  #+(and ecl threads)
  `(mp:process-name ,thread)
  #+lispworks
  `(mp:process-name ,thread)
  #+scl
  `(mp:process-name ,thread))

;;; ---------------------------------------------------------------------------

#-(and sbcl sb-thread)
(defun (setf thread-name) (name thread)
  #+allegro
  (setf (mp:process-name thread) name)
  #+clozure
  (setf (ccl:process-name thread) name)
  #+(and cmu mp)
  (setf (mp:process-name thread) name)
  #+digitool-mcl
  (setf (ccl::process.name thread) name)
  #+(and ecl threads)
  (setf (mp:process-name thread) name)
  #+lispworks
  (setf (mp:process-name thread) name)
  #+scl
  (setf (mp:process-name thread) name)
  #+threads-not-available
  (declare (ignore name))
  #+threads-not-available
  (not-a-thread thread))

;;; ---------------------------------------------------------------------------
;;;   Thread-whostate (values and capabilities vary among CLs)

(defun thread-whostate (thread)
  #+allegro
  (mp:process-whostate thread)
  #+clozure
  (ccl:process-whostate thread)     
  #+(and cmu mp)
  (mp:process-whostate thread)
  #+digitool-mcl
  (ccl:process-whostate thread)
  ;; We fake a basic whostate for ECL/threads:
  #+(and ecl threads)
  (if (mp:process-active-p thread) "Active" "Inactive")
  #+lispworks
  (mp:process-whostate thread)  
  ;; We fake a basic whostate for SBCL/sb-threads:
  #+(and sbcl sb-thread)
  (if (sb-thread:thread-alive-p thread) "Alive" "Dead")
  #+scl
  (mp:process-whostate thread)
  #+threads-not-available
  (not-a-thread thread))

#-(or threads-not-available
      (and ecl threads)
      (and sbcl sb-thread))
(defcm thread-whostate (thread)
  #+allegro
  `(mp:process-whostate ,thread)
  #+clozure
  `(ccl:process-whostate ,thread)     
  #+(and cmu mp)
  `(mp:process-whostate ,thread)
  #+digitool-mcl
  `(ccl:process-whostate ,thread)
  #+lispworks
  `(mp:process-whostate ,thread)
  #+scl
  `(mp:process-whostate ,thread))

(defun (setf thread-whostate) (whostate thread)
  ;;; Only Allegro, Clozure CL, and Digitool MCL support user-settable 
  ;;; whostates; this function is a NOOP on other CLs.
  #+allegro
  (setf (mp:process-whostate thread) whostate)
  #+clozure
  (setf (ccl:process-whostate thread) whostate)
  #+(and cmu mp)
  (declare (ignore thread))
  #+(and cmu mp)
  whostate                              ; no-op
  #+digitool-mcl
  (setf (ccl:process-whostate thread) whostate)
  ;; We fake a basic whostate for ECL/threads:
  #+(and ecl threads)
  (declare (ignore thread))
  #+(and ecl threads)
  whostate                              ; no-op
  #+lispworks
  (declare (ignore thread))
  #+lispworks
  whostate                              ; no-op
  ;; We fake a basic whostate for SBCL/sb-threads:
  #+(and sbcl sb-thread)
  (declare (ignore thread))
  #+(and sbcl sb-thread)
  whostate                              ; no-op
  #+scl
  (declare (ignore thread))
  #+scl
  whostate                              ; no-op
  #+threads-not-available
  (declare (ignore whostate))
  #+threads-not-available
  (not-a-thread thread))

;;; ===========================================================================
;;;  With-timeout

#-(or allegro (and cmu mp))
(defmacro with-timeout ((seconds &body timeout-body) &body timed-body)
  #+(and ecl threads)
  (let ((timer-process-sym (gensym)))
    ;; No timers in ECL, so we use sleep in a separate "timer" process:
    `(catch 'with-timeout
       (let ((,timer-process-sym
              (mp:process-run-function 
                  "with-timeout timer"
                #'(lambda (process seconds)
                    (sleep seconds)
                    (mp:interrupt-process
                     process
                     #'(lambda ()
                         (ignore-errors
                          (throw 'with-timeout
                            (progn ,@timeout-body))))))
                mp:*current-process*
                ,seconds)))
         (sleep 0)
         (unwind-protect (progn ,@timed-body)
           (when (mp:process-active-p ,timer-process-sym)
             (mp:process-kill ,timer-process-sym)
             (sleep 0))))))
  #+lispworks
  (let ((timer-sym (gensym)))
    ;; Note that Lispworks runs the timer function in the process that is
    ;; running when the timeout occurs, so we have to use some cruft to get
    ;; back to the with-timeout process:
    `(catch 'with-timeout
       (let ((,timer-sym (mp:make-timer
                          #'(lambda (process)
                              (mp:process-interrupt 
                               process
                               #'(lambda ()
                                   (throw 'with-timeout
                                     (progn ,@timeout-body)))))
                          mp:*current-process*)))
         (mp:schedule-timer-relative ,timer-sym ,seconds)
         (unwind-protect (progn ,@timed-body)
           (mp:unschedule-timer ,timer-sym)))))
  #+(or clozure
        digitool-mcl)
  (let ((timer-process-sym (gensym)))
    ;; No timers in Clozure or Digitool MCL, so we use sleep in a separate
    ;; "timer" process:
    `(catch 'with-timeout
       (let ((,timer-process-sym
              (ccl:process-run-function 
                  "with-timeout timer"
                #'(lambda (process seconds)
                    (sleep seconds)
                    (ccl:process-interrupt
                     process
                     #'(lambda ()
                         (ignore-errors
                          (throw 'with-timeout
                            (progn ,@timeout-body))))))
                ccl:*current-process*
                ,seconds)))
         (ccl:process-allow-schedule)
         (unwind-protect (progn ,@timed-body)
           (ccl:process-kill ,timer-process-sym)
           (ccl:process-allow-schedule)))))
  #+sbcl
  (let ((timer-sym (gensym)))
    `(block with-timeout
       (let ((,timer-sym (sb-ext:make-timer
                          #'(lambda () (return-from with-timeout
                                         (progn ,@timeout-body))))))
         (sb-ext:schedule-timer ,timer-sym ,seconds)
         (unwind-protect (progn ,@timed-body)
           (sb-ext:unschedule-timer ,timer-sym)))))
  #+with-timeout-not-available
  (declare (ignore seconds timeout-body timed-body))
  #+with-timeout-not-available
  (progn
    (with-timeout-not-available)
    '(with-timeout-not-available)))

;;; ===========================================================================
;;;   Thread-yield (runs *non-threaded-polling-function-hook* functions on
;;;                non-threaded CLs)

#-(and sbcl sb-thread)
(defun thread-yield ()
  #+allegro
  (mp:process-allow-schedule)
  #+clozure
  (ccl:process-allow-schedule)
  #+(and cmu mp)
  (mp:process-yield)
  #+digitool-mcl
  (ccl:process-allow-schedule)
  #+(and ecl threads)
  (mp:process-yield)
  #+lispworks
  (mp:process-allow-scheduling)
  #+scl
  (mp:process-yield)
  #+threads-not-available
  (mapc #'funcall *non-threaded-polling-function-hook*))

#-(and sbcl sb-thread)
(defcm thread-yield ()
  #+allegro  
  '(mp:process-allow-schedule)
  #+clozure
  '(ccl:process-allow-schedule)
  #+(and cmu mp)
  '(mp:process-yield)
  #+digitool-mcl
  '(ccl:process-allow-schedule)
  #+(and ecl threads)
  '(mp:process-yield)
  '(sleep 0)
  #+lispworks
  '(mp:process-allow-scheduling)
  #+scl
  '(mp:process-yield)
  #+threads-not-available
  '(mapc #'funcall *non-threaded-polling-function-hook*))

;;; ===========================================================================
;;;   Locks

#+allegro
(defstruct (recursive-lock
            (:include mp:process-lock)
            (:copier nil)))

;; Clozure Common Lisp only has a recursive lock object:
#+clozure
(progn
  (defstruct (lock
              (:copier nil)
              (:constructor %make-lock))                
    (ccl-lock))

  (defstruct (recursive-lock 
              (:include lock)
              (:copier nil)
              (:constructor %make-recursive-lock)))

  (defmethod print-object ((lock lock) stream)
    (if *print-readably*
        (call-next-method)
        (print-unreadable-object (lock stream :type t)
          (format stream "~s" 
                  (let ((ccl-lock (lock-ccl-lock lock)))
                    (if ccl-lock
                        (ccl:lock-name ccl-lock)
                        "[No ccl-lock]")))))))

;; Digitool's MCL only has a recursive lock object:
#+digitool-mcl
(progn
  (defstruct (lock
              (:copier nil)
              (:constructor %make-lock))                
    (ccl-lock))

  (defstruct (recursive-lock 
              (:include lock)
              (:copier nil)
              (:constructor %make-recursive-lock)))

  (defmethod print-object ((lock lock) stream)
    (if *print-readably*
        (call-next-method)
        (print-unreadable-object (lock stream :type t)
          (format stream "~s" 
                  (let ((ccl-lock (lock-ccl-lock lock)))
                    (if ccl-lock
                        (ccl:lock-name ccl-lock)
                        "[No ccl-lock]")))))))

#+(and lispworks new-locks)
(defstruct (nonrecursive-lock
            (:include mp:lock)
            (:copier nil)
            (:constructor %make-nonrecursive-lock)))

#+lispworks
(defstruct (recursive-lock
            (:include mp:lock)
            (:copier nil)
            #+new-locks
            (:constructor %make-recursive-lock)))

#+(and sbcl sb-thread)
(defstruct (recursive-lock 
            (:include sb-thread:mutex))
  (:copier nil))

#+threads-not-available
(progn
  (defstruct (lock (:copier nil))
    (count 0 :type fixnum)
    (name "Lock" :type string))

  (defstruct (recursive-lock
              (:include lock)
              (:copier nil))))

;;; ---------------------------------------------------------------------------
;;; It would have been great if various CL's lock and condition-variable
;;; objects were CLOS classes.  Without multiple inheritance, we have to hack
;;; a delegated lock-extraction dispatch level into with-lock-held:

(defgeneric %%get-lock%% (obj))

(defmethod %%get-lock%% (obj)
  ;; Regular lock & recursive-lock objects
  obj)

;;; ---------------------------------------------------------------------------

(defun wrong-lock-type-error (lock needed-lock-type operator)
  (error "A ~a lock is needed by ~s, a ~s was supplied"
         needed-lock-type
         operator
         (type-of lock)))
         
;;; ---------------------------------------------------------------------------

#+(or allegro
      clozure
      digitool-mcl
      lispworks)
(defun recursive-lock-attempt-error (lock requesting-thread holding-thread)
  (error "A recursive attempt was made by ~s to hold lock ~s (held by ~s)"
         requesting-thread
         lock
         holding-thread))
         
;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun non-holder-lock-release-error (lock requesting-thread holding-thread)
  (error "An attempt was made by ~s to release lock ~s (held by ~s)"
         requesting-thread
         lock
         holding-thread))
         
;;; ---------------------------------------------------------------------------

#+threads-not-available
(defun non-threaded-lock-deadlock-error (lock)
  (error "Attempt to grab the locked lock ~s on a non-threaded Common Lisp"
         lock))
  
;;; ---------------------------------------------------------------------------
;;;   Make-lock

#-(or lispworks                         ; simply imported
      threads-not-available
      cormanlisp)                       ; CLL 3.0 can't handle this one
(defun make-lock (&key name)
  #+allegro
  (mp:make-process-lock :name name)
  #+(and cmu mp)
  (mp:make-lock name :kind ':error-check)
  #+(and ecl threads)
  (mp:make-lock :name name :recursive nil)
  #+(or clozure
        digitool-mcl)
  (%make-lock :ccl-lock (ccl:make-lock name))
  #+(and sbcl sb-thread)
  (sb-thread:make-mutex :name name)
  #+scl
  (mp:make-lock name :type :recursive))

;;; ---------------------------------------------------------------------------
;;;   Make-recursive-lock

#-(or allegro 
      (and lispworks (not new-locks))
      (and sbcl sb-thread)
      threads-not-available)
(defun make-recursive-lock (&key name)
  #+(and cmu mp)
  (mp:make-lock name)
  #+(and ecl threads)
  (mp:make-lock :name name :recursive t)
  #+(or clozure
        digitool-mcl)
  (%make-recursive-lock :ccl-lock (ccl:make-lock name))
  #+(and lispworks new-locks)
  (%make-recursive-lock :i-name name)
  #+scl
  (mp:make-lock name :type :recursive))
  
;;; ---------------------------------------------------------------------------
;;;   With-Lock-held

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro with-lock-held ((lock &key (whostate "With Lock Held"))
                            &body body)
    #+(or (and ecl threads)
          (and sbcl sb-thread)
          threads-not-available)
    (declare (ignore whostate))
    (let ((lock-sym (gensym)))
      `(let ((,lock-sym (%%get-lock%% ,lock)))
         #+allegro
         (progn
           ;; Allegro's mp:with-process-lock doesn't evaluate its :norecursive
           ;; option, so we roll our own recursive check:
           (unless (recursive-lock-p ,lock-sym)
             (let ((.current-thread. system:*current-process*)
                   (.holding-thread. (mp:process-lock-locker ,lock-sym)))
               (when (eq .current-thread. .holding-thread.)
                 (recursive-lock-attempt-error 
                  ,lock-sym .current-thread. .holding-thread.))))
           (mp:with-process-lock 
               (,lock-sym :norecursive nil
                          :whostate ,whostate)
             ,@body))
         #+clozure
         (let ((.ccl-lock. (and (lock-p ,lock-sym)
                                (lock-ccl-lock (the lock ,lock-sym)))))
           (unless (recursive-lock-p ,lock-sym)
             (let ((.current-thread. ccl:*current-process*)
                   (.holding-thread. (ccl::%%lock-owner .ccl-lock.)))
               (when (eq .current-thread. .holding-thread.)
                 (recursive-lock-attempt-error
                  ,lock-sym .current-thread. .holding-thread.))))
           (ccl:with-lock-grabbed (.ccl-lock. ,whostate)
             ,@body))
         #+(and cmu mp)
         (mp:with-lock-held (,lock-sym ,whostate) ,@body) 
         #+digitool-mcl
         (let ((.ccl-lock. (and (lock-p ,lock-sym)
                                (lock-ccl-lock (the lock ,lock-sym)))))
           (unless (recursive-lock-p ,lock-sym)
             (let ((.current-thread. ccl:*current-process*)
                   (.holding-thread. (ccl::lock.value .ccl-lock.)))
               (when (eq .current-thread. .holding-thread.)
                 (recursive-lock-attempt-error 
                  ,lock-sym .current-thread. .holding-thread.))))
           (ccl:with-lock-grabbed (.ccl-lock. ccl:*current-process*
                                              ,whostate)
             ,@body))
         #+(and ecl threads)
         (mp:with-lock (,lock-sym)
           ,@body)
         #+lispworks
         (progn
           (unless (recursive-lock-p ,lock-sym)
             (let ((.current-thread. mp:*current-process*)
                   (.holding-thread. (mp:lock-owner ,lock-sym)))
               (when (eq .current-thread. .holding-thread.)
                 (recursive-lock-attempt-error 
                  ,lock-sym .current-thread. .holding-thread.))))
           (mp:with-lock (,lock-sym ,whostate) 
             ,@body))
         ;; sb-thread:with-recursive-lock is heavy handed, we roll our own
         ;; with sb-thread:with-mutex (non-recursive) instead:
         #+(and sbcl sb-thread)
         (flet ((body-fn () ,@body))
           (if (and (recursive-lock-p ,lock-sym)
                    (eq (sb-thread:mutex-value ,lock-sym)
                        sb-thread::*current-thread*))
               (body-fn)
               (if (sb-thread::mutex-p ,lock-sym)
                   (sb-thread:with-mutex (,lock-sym) (body-fn))
                   (error "~s is not a lock" ,lock-sym))))
         #+scl
         (mp:with-lock-held (,lock-sym ,whostate) ,@body) 
         ;; Note that polling functions complicate non-threaded CL locking;
         ;; the following does not deal with polling functions:
         #+threads-not-available
         (cond
          ;; The lock is available:
          ((or (recursive-lock-p ,lock-sym)
               (zerop (the fixnum (lock-count ,lock-sym))))
           (unwind-protect (progn (incf (the fixnum (lock-count ,lock-sym)))
                                  ,@body)
             (decf (the fixnum (lock-count ,lock-sym)))))
          ;; Deadlocked:
          (t (non-threaded-lock-deadlock-error ,lock-sym)))))))

;;; ---------------------------------------------------------------------------

(defun thread-holds-lock-p (lock)
  (let ((lock (%%get-lock%% lock)))
    #+allegro
    (eq (mp:process-lock-locker lock) system:*current-process*)
    #+clozure
    (eq (ccl::%%lock-owner (lock-ccl-lock lock)) ccl:*current-process*)
    #+(and cmu mp)
    (eq (mp::lock-process lock) mp:*current-process*)
    #+digitool-mcl
    (eq (ccl::lock.value (lock-ccl-lock lock)) ccl:*current-process*)
    #+(and ecl threads)
    (eq (mp:lock-holder lock) mp:*current-process*)
    #+lispworks
    (eq (mp:lock-owner lock) mp:*current-process*)
    #+(and sbcl sb-thread)
    (eq (sb-thread:mutex-value lock) sb-thread:*current-thread*)
    ;; Note that polling functions complicate non-threaded CL locking;
    ;; the following does not deal with polling functions:
    #+threads-not-available
    (plusp (the fixnum (lock-count lock)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defcm thread-holds-lock-p (lock)
    (let ((lock-sym (gensym)))
      `(let ((,lock-sym (%%get-lock%% ,lock)))
         #+allegro
         (eq (mp:process-lock-locker ,lock-sym) system:*current-process*)
         #+clozure
         (eq (ccl::%%lock-owner (lock-ccl-lock ,lock-sym))
             ccl:*current-process*)
         #+(and cmu mp)
         (eq (mp::lock-process ,lock-sym) mp:*current-process*)
         #+digitool-mcl 
         (eq (ccl::lock.value (lock-ccl-lock ,lock-sym))
             ccl:*current-process*)
         #+(and ecl threads)
         (eq (mp:lock-holder ,lock-sym) mp:*current-process*)
         #+lispworks
         (eq (mp:lock-owner ,lock-sym) mp:*current-process*)
         #+(and sbcl sb-thread)
         (eq (sb-thread:mutex-value ,lock-sym) sb-thread:*current-thread*)
         #+threads-not-available
         (plusp (the fixnum (lock-count ,lock-sym)))))))

;;; ===========================================================================
;;;   As-atomic-operation 
;;;
;;;  (used to implement atomic operations; for very brief operations only)
;;;
;;; We use native without-scheduling on Allegro, CMUCL/mp, and SCL, and we use
;;; native without-interrupts on Digitool MCL, ECL/threads, and Lispworks.  
;;;
;;; Clozure's without-interrupts doesn't control thread scheduling, so we have
;;; to use a lock.

#-(or allegro
      (and cmu mp)
      digitool-mcl
      (and ecl threads) 
      lispworks
      scl)
(defvar *atomic-operation-lock* (make-lock :name "Atomic operation"))

#-(or allegro
      (and cmu mp)
      digitool-mcl
      lispworks
      scl)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro as-atomic-operation (&body body)
    `(with-lock-held (*atomic-operation-lock*)
       ,@body)))

#+(or allegro
      (and cmu mp)
      digitool-mcl 
      (and ecl threads) 
      lispworks
      scl)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro as-atomic-operation (&body body)
    `(#+allegro mp:without-scheduling
      #+(and cmu mp) mp:without-scheduling
      #+digitool-mcl ccl:without-interrupts
      #+(and ecl threads) mp:without-interrupts
      #+lispworks mp:without-preemption
      #+scl mp:without-scheduling
      ,@body)))

;;; ===========================================================================
;;;   Atomic Operations (defined here unless imported from the CL
;;;   implementation)

#-(or (and cmu mp) scl)
(defmacro atomic-push (value place)
  `(as-atomic-operation (push ,value ,place)))

#-scl
(defmacro atomic-pushnew (value place &rest args)
  `(as-atomic-operation (pushnew ,value ,place ,@args)))

#+scl
(defmacro atomic-pushnew (value place &rest args)
  (let ((list (gensym)))
    (ext:once-only ((value value))
      `(kernel:with-atomic-modification (,list ,place)
         (if (member ,value ,list ,@args)
             ,list
             (cons ,value ,list))))))

#-(or (and cmu mp) scl)
(defmacro atomic-pop (place)
  `(as-atomic-operation (pop ,place)))

#-(or (and cmu mp) scl)
(defmacro atomic-incf (place &optional (delta 1))
  `(as-atomic-operation (incf ,place ,delta)))

#-(or (and cmu mp) scl)
(defmacro atomic-decf (place &optional (delta 1))
  `(as-atomic-operation (decf ,place ,delta)))

(defmacro atomic-delete (item place &rest args &environment env)
  #-scl
  (if (symbolp place)
      `(as-atomic-operation
         (setf ,place (delete ,item ,place ,@args)))
      (multiple-value-bind (vars vals store-vars writer-form reader-form)
          (get-setf-expansion place env)
        (let ((item-var (gensym)))
          `(as-atomic-operation
             (let* ((,item-var ,item)
                    ,@(mapcar #'list vars vals)
                    (,(first store-vars)
                     (delete ,item-var ,reader-form ,@args)))
               ,writer-form)))))
  #+scl
  (let ((list (gensym)))
    (ext:once-only ((item item))
      `(kernel:with-atomic-modification (,list ,place)
         ;; Question for dtc: Why is remove used rather than delete?
         (remove ,item ,list ,@args)))))

(defmacro atomic-flush (place)
  ;;; Set place to nil, returning the original value:
  #-scl
  `(as-atomic-operation (prog1 ,place (setf ,place nil)))
  #+scl
  `(loop
     (let ((value ,place))
       (when (eq (kernel:setf-conditional ,place value nil) value)
         (return value)))))

;;; ---------------------------------------------------------------------------
;;;   Without-Lock-held

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro without-lock-held ((lock &key (whostate "Without Lock Held"))
                               &body body)
    #-(or allegro
          closure
          digitool-mcl)
    (declare (ignore whostate))
    (let ((lock-sym (gensym))
          #+(or allegro
                clozure
                digitool-mcl)
          (saved-whostate (gensym)))
      `(let ((,lock-sym (%%get-lock%% ,lock)))
         #+allegro
         (let ((.current-thread. system:*current-process*)
               ,saved-whostate)
           (excl:without-interrupts
             (let ((.holding-thread. (mp:process-lock-locker ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (setf ,saved-whostate (thread-whostate .current-thread.))
               (setf (thread-whostate .current-thread.) ,whostate)
               (mp:process-unlock ,lock-sym)))
           (multiple-value-prog1
               (progn ,@body)
             (mp:process-lock ,lock-sym .current-thread. ,saved-whostate)))
         #+clozure
         (let ((.ccl-lock. (and (lock-p ,lock-sym)
                                (lock-ccl-lock (the lock ,lock-sym))))
               (.current-thread. ccl:*current-process*)
               ,saved-whostate)
           (ccl:without-interrupts
             (let ((.holding-thread. (ccl::%%lock-owner .ccl-lock.)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (setf ,saved-whostate (thread-whostate .current-thread.))
               (setf (thread-whostate .current-thread.) ,whostate)
               (ccl:release-lock .ccl-lock.)))
           (multiple-value-prog1
               (progn ,@body)
             (ccl:without-interrupts
               (ccl:grab-lock .ccl-lock.)
               (setf (thread-whostate .current-thread.) ,saved-whostate))))
         #+(and cmu mp)
         (progn
           (mp:without-scheduling
             (let ((.current-thread. mp:*current-process*)
                   (.holding-thread. (mp::lock-process ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (%%lock-release ,lock-sym)))
           (multiple-value-prog1
               (progn ,@body)
             (mp::lock-wait ,lock-sym "Reaquiring lock")))
         #+digitool-mcl
         (let ((.ccl-lock. (and (lock-p ,lock-sym)
                                (lock-ccl-lock (the lock ,lock-sym))))
               (.current-thread. ccl:*current-process*)
               ,saved-whostate)
           (ccl:without-interrupts
             (let ((.holding-thread. (ccl::%%lock-owner .ccl-lock.)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (setf ,saved-whostate (thread-whostate .current-thread.))
               (setf (thread-whostate .current-thread.) ,whostate)
               (ccl:release-lock .ccl-lock.)))
           (multiple-value-prog1
               (progn ,@body)
             (ccl:without-interrupts
               (ccl:grab-lock .ccl-lock.)
               (setf (thread-whostate .current-thread.) ,saved-whostate))))
         #+(and ecl threads)
         (progn
           (mp:giveup-lock ,lock-sym)   ; performs valid holder check
           (multiple-value-prog1
               (progn ,@body)
             (mp:get-lock ,lock-sym)))
         #+lispworks
         (progn
           (mp:without-preemption
             (let ((.current-thread. mp:*current-process*)
                   (.holding-thread. (mp:lock-owner ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (mp::in-process-unlock ,lock-sym)))
           (multiple-value-prog1
               (progn ,@body)
             (mp:process-lock ,lock-sym)))
         #+(and sbcl sb-thread)
         (progn
           (as-atomic-operation
             (let ((.current-thread. sb-thread::*current-thread*)
                   (.holding-thread. (sb-thread:mutex-value ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (sb-thread:release-mutex ,lock-sym)))
           (multiple-value-prog1
               (progn ,@body)
             (sb-thread:get-mutex ,lock-sym)))
         #+scl
         (progn
           (mp:without-scheduling
             (let ((.current-thread. mp:*current-process*)
                   (.holding-thread. (mp::lock-process ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (%%lock-release ,lock-sym)))
           (multiple-value-prog1
               (progn ,@body)
             (mp::lock-wait ,lock-sym "Reaquiring lock")))
         #+threads-not-available
         (progn ,@body)))))

;;; Internal release-lock function for CMUCL:
#+(and cmu mp)
(defun %%lock-release (lock)
  (declare (type mp:lock lock))
  #-i486
  (setf (mp:lock-process lock) nil)
  #+i486
  (null (kernel:%instance-set-conditional
         lock 2 mp:*current-process* nil)))

;;; ===========================================================================
;;;   Spawn-Thread

(defun spawn-thread (name function &rest args)
  #-(or (and cmu mp) cormanlisp (and sbcl sb-thread))
  (declare (dynamic-extent args))
  #+allegro
  (apply #'mp:process-run-function name function args)
  #+clozure
  (apply #'ccl:process-run-function name function args)
  #+(and cmu mp)
  (mp:make-process #'(lambda () (apply function args)) :name name)
  #+digitool-mcl
  (apply #'ccl:process-run-function name function args)
  #+(and ecl threads)
  (apply #'mp:process-run-function name function args)
  #+lispworks
  (apply #'mp:process-run-function name nil function args)
  #+(and sbcl sb-thread)
  (sb-thread:make-thread #'(lambda () (apply function args))
                         :name name)
  #+scl
  (mp:make-process #'(lambda () (apply function args)) :name name)
  #+threads-not-available
  (declare (ignore name function args))
  #+threads-not-available
  (threads-not-available 'spawn-thread))

;;; ---------------------------------------------------------------------------
;;;   Kill-Thread

(defun kill-thread (thread)
  #+allegro
  (mp:process-kill thread)
  #+clozure
  (ccl:process-kill thread)
  #+(and cmu mp)
  (mp:destroy-process thread)
  #+digitool-mcl
  (ccl:process-kill thread)
  #+(and ecl threads)
  (mp:process-kill thread)
  #+lispworks
  (mp:process-kill thread)
  #+(and sbcl sb-thread)
  (sb-thread:terminate-thread thread)
  #+scl
  (mp:destroy-process thread)
  #+threads-not-available
  (declare (ignore thread))
  #+threads-not-available
  (threads-not-available 'kill-thread))

(defcm kill-thread (thread)
  #+allegro
  `(mp:process-kill ,thread)
  #+clozure
  `(ccl:process-kill ,thread)
  #+(and cmu mp)
  `(mp:destroy-process ,thread)
  #+digitool-mcl
  `(ccl:process-kill ,thread)
  #+(and ecl threads)
  `(mp:process-kill ,thread)
  #+lispworks
  `(mp:process-kill ,thread)
  #+(and sbcl sb-thread)
  `(sb-thread:terminate-thread ,thread)
  #+scl
  `(mp:destroy-process ,thread)
  #+threads-not-available
  (declare (ignore thread))
  #+threads-not-available
  '(threads-not-available 'kill-thread))

;;; ---------------------------------------------------------------------------
;;;  Run-in-thread

(defun run-in-thread (thread function &rest args)
  #-threads-not-available
  (declare (dynamic-extent args))
  #+allegro
  (apply #'multiprocessing:process-interrupt thread function args)
  #+clozure
  (apply #'ccl:process-interrupt thread function args)
  #+(and cmu mp)
  (multiprocessing:process-interrupt thread 
                                     #'(lambda () (apply function args)))
  #+(and ecl threads)
  (mp:interrupt-process thread #'(lambda () (apply function args)))
  #+digitool-mcl
  (apply #'ccl:process-interrupt thread function args)
  #+lispworks
  (progn
    (apply #'mp:process-interrupt thread function args)
    ;; Help Lispworks be more aggressive in running function promptly:
    (mp:process-allow-scheduling))
  #+(and sbcl sb-thread)
  (sb-thread:interrupt-thread thread #'(lambda () (apply function args)))
  #+scl
  (multiprocessing:process-interrupt thread
                                     #'(lambda () (apply function args)))
  #+threads-not-available
  (declare (ignore thread function args))
  #+threads-not-available
  (threads-not-available 'run-in-thread))
  
;;; ---------------------------------------------------------------------------
;;;   Symbol-value-in-thread

(defun symbol-value-in-thread (symbol thread)
  ;; Returns two values:
  ;;  1. the symbol value (or nil if it is unbound)
  ;;  2. true if the symbol is bound; nil otherwise
  ;; The global symbol value is returned if no thread-local value is
  ;; bound.
  #+allegro
  (multiple-value-bind (value boundp)
      (mp:symeval-in-process symbol thread)
    (if boundp
        (values value (eq boundp 't))
        (if (boundp symbol)
            (values (symbol-value symbol) 't)
            (values nil nil))))
  #+clozure
  (let ((value (ccl:symbol-value-in-process symbol thread)))
    (if (eq value (ccl::%unbound-marker))
        (values nil nil)
        (values value 't)))
  #+(and cmu mp)
  (let ((result nil))
    (mp:process-interrupt
     thread
     #'(lambda ()
         (setf result (if (boundp symbol)
                          `(,(symbol-value symbol) t)
                          '(nil nil)))))
    ;; Wait for result:
    (loop until result do (mp:process-yield))
    (apply #'values result))
  #+digitool-mcl
  (handler-case
      (let ((value (ccl:symbol-value-in-process symbol thread)))
        (if (eq value (ccl::%unbound-marker))
            (values nil nil)
            (values value 't)))
    (error (condition)
      (declare (ignore condition))
      (values nil nil)))
  #+(and ecl threads)
  (let ((result nil))
    (mp:interrupt-process
     thread
     #'(lambda () (setf result (if (boundp symbol)
                                   `(,(symbol-value symbol) t)
                                   '(nil nil)))))
    ;; Wait for result:
    (loop until result do (sleep 0))
    (apply #'values result))
  #+lispworks
  (mp:read-special-in-process thread symbol)
  #+(and sbcl sb-thread)
  ;; We can't figure out how to use (sb-thread::symbol-value-in-thread
  ;; symbol thread-sap), so:
  (let ((result nil))
    (sb-thread:interrupt-thread 
     thread
     #'(lambda () (setf result
                        (if (boundp symbol)
                            `(,(symbol-value symbol) t)
                            '(nil nil)))))
    ;; Wait for result:
    (loop until result do (sleep 0.05))
    (apply #'values result))
  #+scl
  (handler-case 
      (values (kernel:thread-symbol-dynamic-value thread symbol) t)
    (unbound-variable (condition)
      (declare (ignore condition))
      (handler-case
          (values (kernel:symbol-global-value symbol) t)
        (unbound-variable () (values nil nil)))))
  #+threads-not-available
  (declare (ignore thread))
  #+threads-not-available
  (if (boundp symbol)
      (values (symbol-value symbol) t)
      (values nil nil)))

;;; ===========================================================================
;;;   Hibernate/Awaken Thread
;;;
;;;  Hibernating threads need to be able to perform run-in-thread and
;;;  symbol-value-in-thread operations.  We also want to allow:
;;;      (with-timeout (n) (hibernate-thread))
;;;
;;;  Using scheduler mechanisms, such as process-arrest-reasons, often
;;;  interferes with these operations.  Instead we use sleeping which
;;;  works like a charm in most CLs!

(defparameter *nearly-forever-seconds* 
    #.(min most-positive-fixnum
           ;; Keep well within a 32-bit word on 64-bit CLs:
           (1- (expt 2 29))))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun throwable-sleep-forever ()
  ;; In most CLs, sleep allows run-in-thread, symbol-value-in-thread,
  ;; and throws to be processed while sleeping, and sleep is often
  ;; well optimized.  So, we use it whenever possible.
  (catch 'throwable-sleep-forever
    (sleep *nearly-forever-seconds*)))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun awaken-throwable-sleeper (thread)
  (flet ((awake-fn ()
           (ignore-errors
            (throw 'throwable-sleep-forever nil))))
    (run-in-thread thread #'awake-fn)
    (thread-yield)))

;;; ---------------------------------------------------------------------------

(defun hibernate-thread ()
  #-threads-not-available
  (throwable-sleep-forever)
  #+threads-not-available
  (threads-not-available 'hibernate-thread))

;;; ---------------------------------------------------------------------------

(defun awaken-thread (thread)
  #-threads-not-available
  (awaken-throwable-sleeper thread)
  #+threads-not-available
  (declare (ignore thread))
  #+threads-not-available
  (threads-not-available 'awaken-thread))
  
;;; ===========================================================================
;;;   Condition variables

#+allegro
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (mp:make-process-lock :name "CV Lock")
         :reader condition-variable-lock)
   (queue :initform nil
          :accessor condition-variable-queue)))

#+clozure
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (make-lock :name "CV Lock")
         :reader condition-variable-lock)
   (semaphore :initform (ccl:make-semaphore)
              :reader condition-variable-semaphore)
   (queue :initform nil
          :accessor condition-variable-queue)))

#+(and cmu mp)
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (mp:make-lock "CV Lock" :kind ':error-check)
         :reader condition-variable-lock)
   (queue :initform nil
          :accessor condition-variable-queue)))

#+digitool-mcl
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (make-lock :name "CV Lock")
         :reader condition-variable-lock)
   (queue :initform nil
          :accessor condition-variable-queue)))

#+(and ecl threads)
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (make-lock :name "CV Lock")
         :reader condition-variable-lock)
   (cv :initform (mp:make-condition-variable)
       :reader condition-variable-cv)))

#+lispworks
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (mp:make-lock :name "CV Lock")
         :reader condition-variable-lock)
   (queue :initform nil
          :accessor condition-variable-queue)))

#+(and sbcl sb-thread)
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (sb-thread:make-mutex :name "CV Lock")
         :reader condition-variable-lock)
   (cv :initform (sb-thread:make-waitqueue)
       :reader condition-variable-cv)))

#+threads-not-available
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (make-lock :name "CV Lock")
         :reader condition-variable-lock)))
  
(defmethod %%get-lock%% ((obj condition-variable))
  (condition-variable-lock obj))

;;; ---------------------------------------------------------------------------
;;; Syntactic sugar: make-condition-variable

(defun make-condition-variable (&rest initargs 
                                &key (class 'condition-variable)
                                &allow-other-keys)
  (declare (dynamic-extent initargs))
  (flet ((remove-property (plist indicator)
           (do* ((ptr plist (cddr ptr))
                 (ind (car ptr) (car ptr))
                 (result nil))
               ;; Only when nothing was found:
               ((null ptr) plist)
             (cond ((atom (cdr ptr))
                    (error "~s is a malformed property list." plist))
                   ((eq ind indicator)
                    (return (nreconc result (cddr ptr)))))
             (setq result (list* (second ptr) ind result)))))
    (apply #'make-instance class (remove-property initargs ':class))))

;;; ---------------------------------------------------------------------------

(defun condition-variable-lock-needed-error (condition-variable operation)
  (error "The condition-variable lock is required by ~s: ~s"
         operation
         condition-variable))

;;; ---------------------------------------------------------------------------

(defun condition-variable-wait (condition-variable)
  #-threads-not-available
  (let ((lock (condition-variable-lock condition-variable)))
    (unless (thread-holds-lock-p lock)
      (condition-variable-lock-needed-error
       condition-variable 'condition-variable-wait))
    #+allegro
    (progn
      (push system:*current-process* 
            (condition-variable-queue condition-variable))
      (mp::process-unlock lock)
      (throwable-sleep-forever)
      (mp::process-lock lock))
    #+clozure
    (let ((ccl-lock (lock-ccl-lock lock)))
      (unwind-protect
          (progn
            (push ccl:*current-process* 
                  (condition-variable-queue condition-variable))
            (ccl:release-lock ccl-lock)
            (ccl:wait-on-semaphore 
             (condition-variable-semaphore condition-variable)))
        (ccl:grab-lock ccl-lock)))
    #+(and cmu mp)
    (progn
      (push mp:*current-process*
            (condition-variable-queue condition-variable))
      (setf (mp::lock-process lock) nil)
      (throwable-sleep-forever)
      (mp::lock-wait lock nil))
    #+digitool-mcl
    (let ((ccl-lock (lock-ccl-lock lock)))
      (push ccl:*current-process*
            (condition-variable-queue condition-variable))
      (ccl:process-unlock ccl-lock)
      (throwable-sleep-forever)
      (ccl:process-lock ccl-lock ccl:*current-process*))
    #+(and ecl threads)
    (mp:condition-variable-wait (condition-variable-cv condition-variable) lock)
    #+lispworks
    (progn
      (push mp:*current-process*
            (condition-variable-queue condition-variable))
      (mp:process-unlock lock)
      (throwable-sleep-forever)
      (mp:process-allow-scheduling)
      (mp:process-lock lock))
    #+(and sbcl sb-thread)
    (sb-thread:condition-wait (condition-variable-cv condition-variable) lock))
  #+threads-not-available
  (declare (ignore condition-variable))
  #+threads-not-available
  (thread-condition-variables-not-available 'condition-variable-wait))

;;; ---------------------------------------------------------------------------

(defun condition-variable-wait-with-timeout (condition-variable seconds)
  #-threads-not-available
  (let ((lock (condition-variable-lock condition-variable)))
    (unless (thread-holds-lock-p lock)
      (condition-variable-lock-needed-error
       condition-variable 'condition-variable-wait-with-timeout))
    #+allegro
    (progn
      (push system:*current-process*
            (condition-variable-queue condition-variable))
      (mp::process-unlock lock)
      (prog1
          (with-timeout 
              (seconds 
               (as-atomic-operation
                (setf (condition-variable-queue condition-variable)
                      (remove system:*current-process*
                              (condition-variable-queue
                               condition-variable))))
               nil)
            (throwable-sleep-forever)
            't)
        (mp::process-lock lock)))
    #+clozure
    (let ((ccl-lock (lock-ccl-lock lock)))
      (unwind-protect
          (progn
            (push ccl:*current-process* 
                  (condition-variable-queue condition-variable))
            (ccl:release-lock ccl-lock)
            (ccl:timed-wait-on-semaphore 
             (condition-variable-semaphore condition-variable) seconds))
        (ccl:grab-lock ccl-lock)
        (setf (condition-variable-queue condition-variable)
              (remove ccl:*current-process*
                      (condition-variable-queue condition-variable)))))
    #+(and cmu mp)
    (progn
      (push mp:*current-process*
            (condition-variable-queue condition-variable))
      (setf (mp::lock-process lock) nil)
      (prog1
          (with-timeout 
              (seconds 
               (as-atomic-operation
                (setf (condition-variable-queue condition-variable)
                      (remove mp:*current-process*
                              (condition-variable-queue condition-variable))))
               nil)
            (throwable-sleep-forever)
            't)
        (mp::lock-wait lock nil)))
    #+digitool-mcl
    (let ((ccl-lock (lock-ccl-lock lock)))
      (push ccl:*current-process*
            (condition-variable-queue condition-variable))
      (ccl:process-unlock ccl-lock)
      (prog1
          (with-timeout 
              (seconds 
               (as-atomic-operation
                (setf (condition-variable-queue condition-variable)
                      (remove ccl:*current-process*
                              (condition-variable-queue condition-variable))))
               nil)
            (throwable-sleep-forever)
            't)
        (ccl:process-lock ccl-lock ccl:*current-process*)))
    #+(and ecl threads)
    (mp:condition-variable-timedwait
     (condition-variable-cv condition-variable) lock seconds)
    #+lispworks
    (progn
      (push mp:*current-process* 
            (condition-variable-queue condition-variable))
      (mp:process-unlock lock)
      (prog1
          (with-timeout 
              (seconds 
               (as-atomic-operation
                (setf (condition-variable-queue condition-variable)
                      (remove mp:*current-process*
                              (condition-variable-queue condition-variable))))
               nil)
            (throwable-sleep-forever)
            't)
        (mp:process-lock lock)))
    #+(and sbcl sb-thread)
    (sb-ext:with-timeout seconds
      (handler-case (progn
                      (sb-thread:condition-wait 
                       (condition-variable-cv condition-variable) lock)
                      't)
        (sb-ext:timeout () nil))))
  #+threads-not-available
  (declare (ignore condition-variable seconds))
  #+threads-not-available
  (thread-condition-variables-not-available
   'condition-variable-wait-with-timeout))

;;; ---------------------------------------------------------------------------

(defun condition-variable-signal (condition-variable)
  (unless (thread-holds-lock-p (condition-variable-lock condition-variable))
    (condition-variable-lock-needed-error
     condition-variable 'condition-variable-signal))
  #+(or allegro
        (and cmu mp)
        digitool-mcl
        lispworks)
  (let ((thread (pop (condition-variable-queue condition-variable))))
    (when (and thread (thread-alive-p thread))
      (awaken-throwable-sleeper thread)))
  #+clozure
  (ccl:signal-semaphore (condition-variable-semaphore condition-variable))
  #+(and ecl threads)
  (mp:condition-variable-signal (condition-variable-cv condition-variable))
  #+(and sbcl sb-thread)
  (sb-thread:condition-notify (condition-variable-cv condition-variable)))
  
;;; ---------------------------------------------------------------------------

(defun condition-variable-broadcast (condition-variable)
  (unless (thread-holds-lock-p (condition-variable-lock condition-variable))
    (condition-variable-lock-needed-error
     condition-variable 'condition-variable-broadcast))
  #+(or allegro
        (and cmu mp)
        digitool-mcl
        lispworks)
  (let ((queue (condition-variable-queue condition-variable)))
    (setf (condition-variable-queue condition-variable) nil)
    (dolist (thread queue)
      (when (thread-alive-p thread)
        (awaken-throwable-sleeper thread))))
  #+clozure
  (let ((queue-length (length (condition-variable-queue condition-variable)))
        (semaphore (condition-variable-semaphore condition-variable)))
    (dotimes (i queue-length)
      (declare (fixnum i))
      (ccl:signal-semaphore semaphore)
      ;; Let each thread respond:
      (ccl:process-allow-schedule)))
  #+(and ecl threads)
  (mp:condition-variable-broadcast (condition-variable-cv condition-variable))
  #+(and sbcl sb-thread)
  (sb-thread:condition-broadcast (condition-variable-cv condition-variable)))

;;; ===========================================================================
;;;  Scheduled Functions (built entirely on top of Portable Threads substrate)

(defstruct (scheduled-function
            (:constructor %make-scheduled-function (function name))
            (:copier nil))
  name
  function
  invocation-time
  repeat-interval
  verbose)

(defmethod print-object ((obj scheduled-function) stream)
  (if *print-readably*
      (call-next-method)
      (print-unreadable-object (obj stream :type t)
        (format stream "~s [" (scheduled-function-name obj))
        (pretty-invocation-time (scheduled-function-invocation-time obj)
                                stream)
        (format stream "]"))))

;;; ---------------------------------------------------------------------------

(defvar *month-name-vector* 
    (vector "Jan" "Feb" "Mar" "Apr" "May" "Jun"
            "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"))

;;; ---------------------------------------------------------------------------

(defun pretty-invocation-time (ut stream)
  (if ut
      (multiple-value-bind (isecond iminute ihour idate imonth iyear)
          (decode-universal-time ut)
        (declare (fixnum isecond iminute ihour idate imonth iyear))
        (multiple-value-bind (second minute hour date month year)
            (decode-universal-time (get-universal-time))
          (declare (ignore second minute hour)
                   (fixnum date month year))
          (cond 
           ;; today?
           ((and (= date idate)
                 (= month imonth)
                 (= year iyear))
            (format stream "~2,'0d:~2,'0d:~2,'0d"
                    ihour
                    iminute
                    isecond))
           ;; someday:
           (t (let ((imonth-name (svref (the (simple-array t (*))
                                          *month-name-vector*)
                                        (the fixnum (1- imonth)))))
                (format stream "~a ~d, ~d ~2,'0d:~2,'0d:~2,'0d"
                        imonth-name
                        idate
                        iyear
                        ihour
                        iminute
                        isecond))))))
      (format stream "unscheduled")))
  
;;; ---------------------------------------------------------------------------

(defvar *scheduled-functions* nil)
(defvar *schedule-function-verbose* nil)
#-threads-not-available
(defvar *scheduled-functions-cv* (make-condition-variable))
(defvar *scheduled-function-scheduler-thread* nil)

;;; ---------------------------------------------------------------------------

(defun all-scheduled-functions ()
  ;;; Returns the (unprotected) list of scheduled scheduled-functions.
  *scheduled-functions*)

;;; ---------------------------------------------------------------------------

(defun make-scheduled-function (function &key                                      
                                         (name (and (symbolp function)
                                                    function)))
  #-threads-not-available
  (%make-scheduled-function function name)
  #+threads-not-available
  (declare (ignore name))
  #+threads-not-available
  (threads-not-available 'make-scheduled-function))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun invoke-scheduled-function (scheduled-function)
  (with-simple-restart (continue "Resume scheduled-function scheduling")
    (funcall (scheduled-function-function scheduled-function)
             scheduled-function)))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun scheduled-function-scheduler ()
  ;;; The scheduled-function scheduler (run by the scheduled-function-scheduler
  ;;; thread)
  (let ((scheduled-function-to-run nil))
    (loop
      (with-lock-held (*scheduled-functions-cv*)
        (cond 
         ;; nothing to schedule, wait until signaled:
         ((null *scheduled-functions*)
          (condition-variable-wait *scheduled-functions-cv*))
         ;; something to schedule:
         (t (let ((invocation-time (scheduled-function-invocation-time
                                    (first *scheduled-functions*)))
                  (now (get-universal-time)))
              (cond 
               ;; wait until invocation-time arrives or until signaled:
               ((> invocation-time now)
                (condition-variable-wait-with-timeout 
                 *scheduled-functions-cv*
                 (- invocation-time now))
                ;; recheck that any scheduled functions remain (in case we
                ;; have been awakened due to unscheduling the only
                ;; scheduled-function)--thanks to Wendall Marvel for reporting
                ;; this bug:
                (when *scheduled-functions* 
                  ;; recheck that it's actually time to run the first
                  ;; scheduled function (in case we have been awakened due to
                  ;; a schedule change rather than due to reaching the
                  ;; originally scheduled time of the next
                  ;; scheduled-function):
                  (let ((invocation-time (scheduled-function-invocation-time
                                          (first *scheduled-functions*)))
                        (now (get-universal-time)))
                    (when (<= invocation-time now)
                      (setf scheduled-function-to-run
                            (pop *scheduled-functions*))))))
               ;; no need to wait:
               (t (setf scheduled-function-to-run
                        (pop *scheduled-functions*))))))))
      ;; funcall the scheduled function (outside of the CV lock):
      (when scheduled-function-to-run
        (unwind-protect (invoke-scheduled-function scheduled-function-to-run)
          (with-lock-held (*scheduled-functions-cv*)
            (let ((repeat-interval (scheduled-function-repeat-interval
                                    scheduled-function-to-run)))
              (cond 
               ;; reschedule, if a repeat interval was specified:
               (repeat-interval
                ;; The following keeps invocations closest to intended, but
                ;; leads to rapidly repeating "catch up" invocations if the
                ;; scheduler has been blocked or terminated/restarted:
                #+this-keeps-times-in-alignment
                (incf (scheduled-function-invocation-time
                       scheduled-function-to-run)
                      repeat-interval)
                ;; This version avoids "catch up" invocations, but can drift
                ;; over time (we use this version):
                #-this-keeps-times-in-alignment
                (setf (scheduled-function-invocation-time
                       scheduled-function-to-run)
                      (+ (get-universal-time) repeat-interval))
                ;; Be verbose (it would be better to do this output outside of
                ;; the CV lock):
                (when (or *schedule-function-verbose*
                          (scheduled-function-verbose scheduled-function-to-run))
                  (format *trace-output* 
                          "~&;; Scheduling ~s at repeat-interval ~s...~%"
                          scheduled-function-to-run
                          repeat-interval)
                  (force-output *trace-output*))
                (insert-scheduled-function scheduled-function-to-run nil))
               ;; otherwise, clear the invocation time:
               (t (setf (scheduled-function-invocation-time 
                         scheduled-function-to-run)
                        nil))))
            (setf scheduled-function-to-run nil)))))))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun awaken-scheduled-function-scheduler ()
  ;;; Awaken the scheduled-function-scheduler thread due to a change.
  ;;; If the thread isn't alive, start (or restart) it up.
  (if (and (threadp *scheduled-function-scheduler-thread*)
           (thread-alive-p *scheduled-function-scheduler-thread*))
      (condition-variable-signal *scheduled-functions-cv*)
      (setf *scheduled-function-scheduler-thread*
            (spawn-thread "Scheduled-Function Scheduler"
                          'scheduled-function-scheduler))))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun insert-scheduled-function (scheduled-function verbose)
  ;;; Do the work of inserting a scheduled function into the list of
  ;;; *scheduled-functions*.  The *scheduled-function-cv* lock must be held
  ;;; when calling this function.
  (cond
   ;; empty list:
   ((null *scheduled-functions*)
    (when verbose
      (format *trace-output* 
              "~&;; Scheduling ~s as the next scheduled-function...~%"
              scheduled-function)
      (force-output *trace-output*))
    (setf *scheduled-functions* (list scheduled-function))
    ;; schedule it:
    (awaken-scheduled-function-scheduler))
   ;; find position in list:
   (t (let ((invocation-time
             (scheduled-function-invocation-time scheduled-function)))
        (cond
         ;; front insertion:
         ((< invocation-time (scheduled-function-invocation-time 
                              (car *scheduled-functions*)))
          (when verbose
            (format *trace-output* 
                    "~&;; Scheduling ~s as the next scheduled-function...~%"
                    scheduled-function)
            (force-output *trace-output*))
          (setf *scheduled-functions*
                (cons scheduled-function *scheduled-functions*))
          ;; schedule it:
          (awaken-scheduled-function-scheduler))
         ;; splice into the list:
         (t (when verbose
              (format *trace-output* 
                      "~&;; Adding ~s as a scheduled-function...~%"
                      scheduled-function)
              (force-output *trace-output*))
            (do ((sublist *scheduled-functions* (cdr sublist)))
                ((null (cdr sublist))
                 (setf (cdr sublist) (list scheduled-function)))
              (when (< invocation-time 
                       (scheduled-function-invocation-time (cadr sublist)))
                (setf (cdr sublist) (cons scheduled-function (cdr sublist)))
                (return)))))))))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun delete-scheduled-function (name-or-scheduled-function verbose)
  ;;; Do the work of deleting a scheduled function from the list of
  ;;; *scheduled-functions*.  The *scheduled-function-cv* lock must be held
  ;;; when calling this function.
  (let ((the-deleted-scheduled-function nil))
    (flet ((on-deletion (scheduled-function)
             (when verbose
               (format *trace-output* "~&;; Unscheduling ~s...~%"
                       scheduled-function)
               (force-output *trace-output*))
             ;; Clear the invocation and repeat-interval values:
             (setf (scheduled-function-invocation-time scheduled-function)
                   nil)
             (setf (scheduled-function-repeat-interval scheduled-function) 
                   nil)
             ;; Record the deleted function (which also returns true):
             (setf the-deleted-scheduled-function scheduled-function)))
      (setf *scheduled-functions* 
            (delete-if
             (if (scheduled-function-p name-or-scheduled-function)
                 #'(lambda (scheduled-function)
                     (when (eq scheduled-function name-or-scheduled-function)
                       (on-deletion scheduled-function)))
               #'(lambda (scheduled-function)
                   (when (equal (scheduled-function-name scheduled-function)
                                name-or-scheduled-function)
                       (on-deletion scheduled-function))))
             *scheduled-functions*)))
    ;; return the deleted scheduled-function (or nil, if unsuccessful):
    the-deleted-scheduled-function))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun schedule-function-internal (name-or-scheduled-function invocation-time
                                   repeat-interval verbose)
  (or (with-lock-held (*scheduled-functions-cv*)
        (let* ((next-scheduled-function (first *scheduled-functions*))
               (unscheduled-scheduled-function 
                (delete-scheduled-function name-or-scheduled-function verbose))
               (scheduled-function (or unscheduled-scheduled-function 
                                       name-or-scheduled-function)))
          ;; Was the specified function scheduled?
          (when (scheduled-function-p scheduled-function)
            (setf (scheduled-function-invocation-time scheduled-function)
                  invocation-time)
            (setf (scheduled-function-repeat-interval scheduled-function)
                  repeat-interval)
            (setf (scheduled-function-verbose scheduled-function) verbose)
            (insert-scheduled-function scheduled-function verbose)
            ;; awaken scheduler if this scheduled-function was the next to be
            ;; run and now it is not the next to be run:
            (when (and (eq next-scheduled-function scheduled-function)
                       (not (eq (first *scheduled-functions*)
                                scheduled-function)))
              (awaken-scheduled-function-scheduler)))))
      ;; warn if unable to find the scheduled function (outside of the lock):
      (warn "Unable to find scheduled-function ~s."
            name-or-scheduled-function)))

;;; ---------------------------------------------------------------------------

(defun schedule-function (name-or-scheduled-function invocation-time
                          &key repeat-interval
                               (verbose *schedule-function-verbose*))
  #-threads-not-available
  (progn
    (check-type invocation-time integer)
    (check-type repeat-interval (or null integer))
    (schedule-function-internal name-or-scheduled-function invocation-time
                                repeat-interval verbose)
    (values))
  #+threads-not-available
  (declare (ignore name-or-scheduled-function invocation-time repeat-interval
                   verbose))
  #+threads-not-available
  (threads-not-available 'schedule-function))

;;; ---------------------------------------------------------------------------

(defun schedule-function-relative (name-or-scheduled-function interval
                                   &key repeat-interval 
                                        (verbose *schedule-function-verbose*))
  ;;; Syntactic sugar that simply adds `interval' to the current time before
  ;;; scheduling the scheduled-function.
  #-threads-not-available
  (progn
    (check-type interval integer)
    (check-type repeat-interval (or null integer))
    (schedule-function-internal name-or-scheduled-function 
                                (+ (get-universal-time) interval)
                                repeat-interval verbose)
    (values))
  #+threads-not-available
  (declare (ignore name-or-scheduled-function interval repeat-interval
                   verbose))
  #+threads-not-available
  (threads-not-available 'schedule-function-relative))

;;; ---------------------------------------------------------------------------

(defun unschedule-function (name-or-scheduled-function 
                            &key (verbose *schedule-function-verbose*))
  #-threads-not-available
  (or (with-lock-held (*scheduled-functions-cv*)
        (let* ((next-scheduled-function (first *scheduled-functions*))
               (unscheduled-function
                (delete-scheduled-function name-or-scheduled-function verbose)))
          ;; when unscheduled successfully: 
          (when unscheduled-function
            ;; awaken the scheduler if the next-scheduled-function became the
            ;; first one due to the unscheduling:
            (unless (eq next-scheduled-function (first *scheduled-functions*))
              (awaken-scheduled-function-scheduler))
            ;; return the unscheduled function if we unscheduled:
            unscheduled-function)))
      ;; warn if unable to find the scheduled function (outside of the lock):
      (warn "Scheduled-function ~s was not scheduled; no action taken."
            name-or-scheduled-function))
  #+threads-not-available
  (declare (ignore name-or-scheduled-function verbose))
  #+threads-not-available
  (threads-not-available 'unschedule-function))

;;; ---------------------------------------------------------------------------

(defun restart-scheduled-function-scheduler ()
  #-threads-not-available
  (if (and (threadp *scheduled-function-scheduler-thread*)
           (thread-alive-p *scheduled-function-scheduler-thread*))
      (format t "~%;; The scheduled-function scheduler is already running.~%")
      (with-lock-held (*scheduled-functions-cv*)
        (awaken-scheduled-function-scheduler)))
  #+threads-not-available
  (threads-not-available 'restart-scheduled-function-scheduler))

;;; ---------------------------------------------------------------------------
;;;  Handy utility to encode (hour minute second) time of day into a universal
;;;  time.  If that time has already passed, the next day is assumed.

(defun encode-time-of-day (hour minute second
                           &optional (universal-time (get-universal-time)))
  ;; get the decoded current time of day:
  (multiple-value-bind (current-second current-minute current-hour
                        date month year)
      (decode-universal-time universal-time)
    ;; substitute the supplied hour, minute, and second values:
    (let ((tentative-result
           (encode-universal-time second minute hour date month year)))
      (flet ((seconds-into-day (hour minute second)
               (the fixnum (+ (the fixnum (* (the fixnum hour) 3600))
                              (the fixnum (* (the fixnum minute) 60))
                              (the fixnum second)))))
        ;; if the time of day has already passed for today, assume
        ;; tomorrow is intended:
        (if (> (seconds-into-day current-hour current-minute current-second)
               (seconds-into-day hour minute second))
            (+ tentative-result #.(* 60 60 24))
            tentative-result)))))

;;; ===========================================================================
;;;  Periodic Functions (also built entirely on top of Portable Threads)

(defvar *periodic-function-verbose* nil)

;;; ---------------------------------------------------------------------------

(defun spawn-periodic-function (function interval 
                                &key (count nil)
                                     (name (and (symbolp function)
                                                function))
                                     (verbose *periodic-function-verbose*))
  #-threads-not-available
  (flet ((fn ()
           (let ((*periodic-function-verbose* verbose)
                 (*periodic-function-name* name))
             (declare (special *periodic-function-name*))
             (catch 'kill-periodic-function
               (loop
                 (when (and count (minusp (decf count)))
                   (return))
                 (sleep interval)
                 (with-simple-restart (continue "Resume periodic-function")
                   (funcall function))))
             (when *periodic-function-verbose*
               (format *trace-output* 
                       "~&;; Exiting periodic-function thread~@[ ~s~]~%"
                       name)
               (force-output *trace-output*)))))
    (when verbose
      (format *trace-output* 
              "~&;; Spawning periodic-function thread for~@[ ~s~]...~%"
              name)
      (force-output *trace-output*))
    (spawn-thread (format nil "Periodic Function~@[ ~a~]" name)
                  #'fn))
  #+threads-not-available
  (declare (ignore interval count name verbose))
  #+threads-not-available
  (threads-not-available 'spawn-periodic-function))

;;; ---------------------------------------------------------------------------

(defun kill-periodic-function ()
  #-threads-not-available
  (locally (declare (special *periodic-function-name*))
    (handler-case 
        (progn
          (when *periodic-function-verbose*
            (format *trace-output* 
                    "~&;; Killing periodic-function~@[ ~s~]...~%"
                    (and (boundp '*periodic-function-name*)
                         *periodic-function-name*))
            (force-output *trace-output*))
          (throw 'kill-periodic-function nil))
      (control-error ()
        (error "~s must be called within a periodic function"
               'kill-periodic-function))))
  #+threads-not-available
  (threads-not-available 'kill-periodic-function))

;;; ===========================================================================
;;;  Portable threads interface is fully loaded:

(pushnew ':portable-threads *features*)
(pushnew *portable-threads-version-keyword* *features*)

;;; ===========================================================================
;;;                               End of File
;;; ===========================================================================
