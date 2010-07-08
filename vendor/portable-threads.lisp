;;;; -*- Mode:Common-Lisp; Package:PORTABLE-THREADS; Syntax:common-lisp -*-
;;;; *-* File: /usr/local/gbbopen/source/tools/portable-threads.lisp *-*
;;;; *-* Edited-By: cork *-*
;;;; *-* Last-Edit: Wed Jun  2 14:01:21 2010 *-*
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
;;; Copyright (C) 2003-2010, Dan Corkill <corkill@GBBopen.org> 
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
;;; libraries are requried).  Support for scheduled and periodic function can
;;; be added by also including the file scheduled-periodic-functions.lisp.
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
;;;  12-22-05 Removed WITHOUT-INTERRUPTS support (incompatible with
;;;           preemptive scheduling models).  (Corkill)
;;;  12-27-05 Added PROCESS-NAME.  (Corkill)
;;;  01-02-06 Separated from GBBopen, moved polling-functions into separate
;;;           polling-functions.lisp file and module.  (Corkill)
;;;  01-12-06 Added AS-ATOMIC-OPERATION support, but only as a mechanism
;;;           for implementing very brief atomic operations.  (Corkill)
;;;  05-08-06 Added support for the Scieneer CL. (dtc)
;;;  07-28-07 V2.0 naming changes, full condition variable support.  (Corkill)
;;;  08-20-07 V2.1: Added scheduled functions, THREAD-ALIVE-P, 
;;;           ENCODE-TIME-OF-DAY. (Corkill)
;;;  08-27-07 V2.2: Added periodic functions.  (Corkill)
;;;  10-23-07 Fixed 64-bit CL sleep issues (thanks Antony!).  (Corkill)
;;;  11-20-07 V2.3: Remove V1.0 compatabilty; resupport Digitool MCL.
;;;           (Corkill)
;;;  06-18-09 Added CLISP multi-thread support (provided by Vladimir Tzankov; 
;;;           thanks!).
;;;  11-08-09 Renamed keyword arguments (:key -> :marker, etc.) in
;;;           MAKE-SCHEDULED-FUNCTION, SCHEDULE-FUNCTION,
;;;           SCHEDULE-FUNCTION-RELATIVE, and UNSCHEDULE-FUNCTION.  (Corkill)
;;;  11-10-09 Add PAUSE-SCHEDULED-FUNCTION-SCHEDULER, 
;;;           RESUME-SCHEDULED-FUNCTION-SCHEDULER,  
;;;           SCHEDULED-FUNCTION-SCHEDULER-PAUSED-P, and
;;;           SCHEDULED-FUNCTION-SCHEDULER-RUNNING-P.  (Corkill)
;;;  12-18-09 Moved scheduled & periodic functions to separate 
;;;           periodic-scheduled-functions.lisp file.  (Corkill)
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
;;; Add a feature to identify new lock structure for Lispworks 5.1:

#+(and lispworks (not lispworks6))
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
   #+(and lispworks lispworks6)
   '(system:atomic-decf
     system:atomic-incf 
     system:atomic-pop
     system:atomic-push
     mp::initialize-multiprocessing)
   #+(and lispworks (not lispworks6))
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

;;; ---------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(*non-threaded-polling-function-hook* ; not documented
            all-threads
            as-atomic-operation
            atomic-decf
            atomic-decf&
            atomic-delete
            atomic-flush
            atomic-incf
            atomic-incf&
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
            hibernate-thread
            #+lispworks
            initialize-multiprocessing
            kill-thread
            make-condition-variable
            make-lock
            make-recursive-lock
            nearly-forever-seconds
            portable-threads-implementation-version ; not documented
            run-in-thread
            sleep-nearly-forever
            spawn-form
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

#+(or (and clisp (not mt))
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
;;;  Portable Threads Interface ~a
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
  #+(and clisp mt)
  (mt:current-thread)
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
  #+(and clisp mt)
  '(mt:current-thread)
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
  #+(and clisp mt)
  (delete nil (mt:list-threads) :key #'mt:thread-active-p) ; Delete is OK?
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
  #+(and clisp mt)
  '(delete nil (mt:list-threads) :key #'mt:thread-active-p) ; Delete is OK?
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
  #+(and clisp mt)
  (mt:threadp obj)
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
  #+(and clisp mt)
  `(mt:threadp ,obj)
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
  #+(and clisp mt)
  (mt:thread-active-p obj)
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
  #+(and clisp mt)
  `(mt:thread-active-p ,obj)
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
  #+(and clisp mt)
  (mt:thread-name thread)
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
  #+(and clisp mt)
  `(mt:thread-name ,thread)
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

#-(or (and sbcl sb-thread)
      (and clisp mt))
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
  ;; We fake a basic whostate for CLISP/threads:
  #+(and clisp mt)
  (if (mt:thread-active-p thread) "Alive" "Dead")
  #+clozure
  (ccl:process-whostate thread)     
  #+(and cmu mp)
  (mp:process-whostate thread)
  #+digitool-mcl
  (ccl:process-whostate thread)
  ;; We fake a basic whostate for ECL/threads:
  #+(and ecl threads)
  (if (mp:process-active-p thread) "Alive" "Dead")
  #+lispworks
  (mp:process-whostate thread)  
  ;; We fake a basic whostate for SBCL/sb-threads:
  #+(and sbcl sb-thread)
  (if (sb-thread:thread-alive-p thread) "Alive" "Dead")
  #+scl
  (nth-value 1 (mp:process-whostate thread))
  #+threads-not-available
  (not-a-thread thread))

#-(or threads-not-available
      (and clisp mt)
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
  `(nth-value 1 (mp:process-whostate ,thread)))

(defun (setf thread-whostate) (whostate thread)
  ;;; Only Allegro, Clozure CL, and Digitool MCL support user-settable 
  ;;; whostates; this function is a NOOP on other CLs.
  #+allegro
  (setf (mp:process-whostate thread) whostate)
  #+(and clisp mt)
  (declare (ignore thread))
  #+(and clisp mt)
  whostate                              ; no-op
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
;;;
;;;  Note: CMUCL's native WITH-TIMEOUT doesn't nest correctly; however we
;;;        still expose the native version (in the hope that it will be fixed
;;;        someday) rather than rolling our own.  Nested users beware!!!!

#-(or allegro (and cmu mp))
(defmacro with-timeout ((seconds &body timeout-body) &body timed-body)
  #+(and clisp mt)
  `(mt:with-timeout (,seconds ,@timeout-body) ,@timed-body)
  #+clozure
  (let ((tag-sym (gensym))
        (semaphore-sym (gensym)))
    ;; No timers in Clozure, so we use TIMED-WAIT-ON-SEMAPHORE in a separate
    ;; "timer" process (a technique suggested by Jon S. Anthony):
    `(let ((,semaphore-sym (ccl:make-semaphore)))
       (catch ',tag-sym
         (ccl:process-run-function 
             "WITH-TIMEOUT timer"
           #'(lambda (process semaphore seconds)
               (unless (ccl:timed-wait-on-semaphore semaphore seconds)
                 (ccl:process-interrupt
                  process
                  #'(lambda ()
                      (ignore-errors
                       (throw ',tag-sym
                         (progn ,@timeout-body)))))))
           ccl:*current-process*
           ,semaphore-sym
           ,seconds)
         (unwind-protect (progn ,@timed-body)
           (ccl:signal-semaphore ,semaphore-sym)))))
  #+digitool-mcl
  (let ((tag-sym (gensym))
        (timer-process-sym (gensym)))
    ;; No timers in Digitool MCL, so we use SLEEP in a separate "timer"
    ;; process:
    `(catch ',tag-sym
       (let ((,timer-process-sym
              (ccl:process-run-function 
                  "WITH-TIMEOUT timer"
                #'(lambda (process seconds)
                    (sleep seconds)
                    (ccl:process-interrupt
                     process
                     #'(lambda ()
                         (ignore-errors
                          (throw ',tag-sym
                            (progn ,@timeout-body))))))
                ccl:*current-process* 
                ,seconds)))
         (ccl:process-allow-schedule)
         (unwind-protect (progn ,@timed-body)
           (ccl:process-kill ,timer-process-sym)
           (ccl:process-allow-schedule)))))
  #+(and ecl threads)
  (let ((tag-sym (gensym))
        (timer-process-sym (gensym)))
    ;; No timers in ECL, so we use SLEEP in a separate "timer" process:
    `(catch ',tag-sym
       (let ((,timer-process-sym
              (mp:process-run-function 
                  "WITH-TIMEOUT timer"
                #'(lambda (process seconds)
                    (sleep seconds)
                    (mp:interrupt-process
                     process
                     #'(lambda ()
                         (ignore-errors
                          (throw ',tag-sym
                            (progn ,@timeout-body))))))
                mp:*current-process* 
                ,seconds)))
         (sleep 0)
         (unwind-protect (progn ,@timed-body)
           (when (mp:process-active-p ,timer-process-sym)
             (mp:process-kill ,timer-process-sym)
             (sleep 0))))))
  #+lispworks
  (let ((tag-sym (gensym))
        (timer-sym (gensym)))
    ;; Note that Lispworks runs the timer function in the process that is
    ;; running when the timeout occurs, so we have to use some cruft to get
    ;; back to the WITH-TIMEOUT process:
    `(catch ',tag-sym
       (let ((,timer-sym 
              (mp:make-timer 
               #'(lambda (process)
                   (mp:process-interrupt 
                    process
                    #'(lambda ()
                        (throw ',tag-sym
                          (progn ,@timeout-body)))))
               mp:*current-process*)))
         (mp:schedule-timer-relative ,timer-sym ,seconds)
         (unwind-protect (progn ,@timed-body)
           (mp:unschedule-timer ,timer-sym)))))
  ;; SBCL's native WITH-TIMEOUT doesn't nest, so we have to roll our own:
  #+sbcl-does-not-nest
  `(handler-case (sb-ext:with-timeout ,seconds ,@timed-body)
     (sb-ext:timeout ()
       ,@timeout-body))
  #+sbcl
    (let ((tag-sym (gensym))
          (timer-sym (gensym)))
    `(block ,tag-sym
       (let ((,timer-sym 
              (sb-ext:make-timer
               #'(lambda () 
                   (return-from ,tag-sym (progn ,@timeout-body))))))
         (sb-ext:schedule-timer ,timer-sym ,seconds)
         (unwind-protect (progn ,@timed-body)
           (sb-ext:unschedule-timer ,timer-sym)))))
  #+scl
  (let ((tag-sym (gensym))
        (timer-process-sym (gensym)))
    ;; Simple version for SCL, we sleep in a separate "timer" process:
    `(catch ',tag-sym
       (let ((,timer-process-sym
              (mp:make-process 
               #'(lambda ()
                   (funcall 
                    #'(lambda (process seconds)
                        (sleep seconds)
                        (mp:process-interrupt
                         process
                         #'(lambda ()
                             (ignore-errors
                              (throw ',tag-sym
                                (progn ,@timeout-body))))))
                    (mp:current-process)
                    ,seconds))
               :name "WITH-TIMEOUT timer")))
         (mp:process-yield)
         (unwind-protect (progn ,@timed-body)
           (mp:destroy-process ,timer-process-sym)
           (mp:process-yield)))))
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
  #+(and clisp mt)
  (mt:thread-yield)
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
  #+(and clisp mt)
  '(mt:thread-yield)
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

#+(and lispworks new-locks (not lispworks6))
(defstruct (nonrecursive-lock
            (:include mp:lock)
            (:copier nil)
            (:constructor %make-nonrecursive-lock)))

#+(and lispworks (not lispworks6))
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

#-(or (and lispworks (not lispworks6))  ; simply imported
      threads-not-available
      cormanlisp)                       ; CLL 3.0 can't handle this one
(defun make-lock (&key (name
                        #+(and clisp mt) "Anonymous mutex"))
  #+allegro
  (mp:make-process-lock :name name)
  #+(and clisp mt)
  (mt:make-mutex :name name)
  #+(and cmu mp)
  (mp:make-lock name :kind ':error-check)
  #+(and ecl threads)
  (mp:make-lock :name name :recursive nil)
  #+(or clozure
        digitool-mcl)
  (%make-lock :ccl-lock (ccl:make-lock name))
  #+(and lispworks lispworks6)
  (mp:make-lock :name name :recursivep nil)
  #+(and sbcl sb-thread)
  (sb-thread:make-mutex :name name)
  #+scl
  (mp:make-lock name :type ':error-check))

;;; ---------------------------------------------------------------------------
;;;   Make-recursive-lock

#-(or allegro 
      (and lispworks (not new-locks) (not lispworks6))
      (and sbcl sb-thread)
      threads-not-available)
(defun make-recursive-lock (&key (name
                                  #+(and clisp mt) "Anonymous mutex"))
  #+(and clisp mt)
  (mt:make-mutex :name name :recursive-p t)
  #+(or clozure
        digitool-mcl)
  (%make-recursive-lock :ccl-lock (ccl:make-lock name))
  #+(and cmu mp)
  (mp:make-lock name)
  #+(and ecl threads)
  (mp:make-lock :name name :recursive t)
  #+(and lispworks lispworks6)
  (mp:make-lock :name name :recursivep t)
  #+(and lispworks new-locks (not lispworks6))
  (%make-recursive-lock :i-name name)
  #+scl
  (mp:make-lock name :type ':recursive))
  
;;; ---------------------------------------------------------------------------
;;;   With-Lock-held

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro with-lock-held ((lock &key (whostate "With Lock Held"))
                            &body body)
    #+(or (and clisp mt)
          (and ecl threads)
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
         #+(and clisp mt)
         (mt:with-mutex-lock (,lock-sym) ,@body)
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
         #+(and lispworks lispworks6)
           (mp:with-lock (,lock-sym ,whostate) 
             ,@body)
         #+(and lispworks (not lispworks6))
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
    #+(and clisp mt)
    (eq (mt:mutex-owner lock) (mt:current-thread))
    #+clozure
    (eq (ccl::%%lock-owner (lock-ccl-lock lock)) ccl:*current-process*)
    #+(and cmu mp)
    (eq (mp::lock-process lock) mp:*current-process*)
    #+digitool-mcl
    (eq (ccl::lock.value (lock-ccl-lock lock)) ccl:*current-process*)
    #+(and ecl threads)
    (eq (mp:lock-holder lock) mp:*current-process*)
    #+(and lispworks lispworks6)
    (mp:lock-owned-by-current-process-p lock)
    #+(and lispworks (not lispworks6))
    (eq (mp:lock-owner lock) mp:*current-process*)
    #+(and sbcl sb-thread)
    (eq (sb-thread:mutex-value lock) sb-thread:*current-thread*)
    ;; Checking the lock holder is not supported on SCL:
    #+scl
    nil
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
         #+(and clisp mt)
         (eq (mt:mutex-owner ,lock-sym) (mt:current-thread))
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
         #+(and lispworks lispworks6)
         (mp:lock-owned-by-current-process-p ,lock-sym)
         #+(and lispworks (not lispworks6))
         (eq (mp:lock-owner ,lock-sym) mp:*current-process*)
         #+(and sbcl sb-thread)
         (eq (sb-thread:mutex-value ,lock-sym) sb-thread:*current-thread*)
         ;; Checking the lock holder is not supported on SCL:
         #+scl
         nil
         #+threads-not-available
         (plusp (the fixnum (lock-count ,lock-sym)))))))

;;; ===========================================================================
;;;   As-atomic-operation 
;;;
;;;  (used to implement atomic operations; for very brief operations only)
;;;
;;; We use native without-scheduling on pre-SMP Allegro, CMUCL/mp, and SCL, and we use
;;; native without-interrupts on Digitool MCL, ECL/threads, and Lispworks.  
;;;
;;; Clozure's without-interrupts doesn't control thread scheduling, so we have
;;; to use a lock.

#-(or (and allegro (not smp-macros))
      (and cmu mp)
      digitool-mcl
      (and ecl threads) 
      lispworks
      scl)
(defvar *atomic-operation-lock* (make-lock :name "Atomic operation"))

#-(or (and allegro (not smp-macros))
      (and cmu mp)
      digitool-mcl
      (and lispworks (not lispworks6))
      scl)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro as-atomic-operation (&body body)
    `(with-lock-held (*atomic-operation-lock*)
       ,@body)))

#+(or (and allegro (not smp-macros))
      (and cmu mp)
      digitool-mcl 
      (and ecl threads) 
      (and lispworks (not lispworks6))
      scl)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro as-atomic-operation (&body body)
    `(#+allegro mp:without-scheduling
      #+(and cmu mp) mp:without-scheduling
      #+digitool-mcl ccl:without-interrupts
      #+(and ecl threads) mp:without-interrupts
      #+(and lispworks (not lispworks6)) mp:without-preemption
      #+scl mp:without-scheduling
      ,@body)))

;;; ===========================================================================
;;;   Atomic Operations (defined here unless imported from the CL
;;;   implementation)

#-(or (and cmu mp) 
      (and lispworks lispworks6)
      scl)
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

#-(or (and cmu mp)
      (and lispworks lispworks6)
      scl)
(defmacro atomic-pop (place)
  `(as-atomic-operation (pop ,place)))

#-(or (and cmu mp) 
      (and lispworks lispworks6)
      scl)
(defmacro atomic-incf (place &optional (delta 1))
  `(as-atomic-operation (incf ,place ,delta)))

#+(and lispworks lispworks6)
(defmacro atomic-incf& (place &optional (delta 1))
  `(system:atomic-fixnum-incf ,place ,delta))

#-lispworks6
(defmacro atomic-incf& (place &optional (delta 1))
  `(as-atomic-operation (the fixnum (incf (the fixnum ,place)
                                          (the fixnum ,delta)))))

#-(or (and cmu mp) 
      (and lispworks lispworks6)
      scl)
(defmacro atomic-decf (place &optional (delta 1))
  `(as-atomic-operation (decf ,place ,delta)))

#+(and lispworks lispworks6)
(defmacro atomic-decf& (place &optional (delta 1))
  `(system:atomic-fixnum-decf ,place ,delta))

#-lispworks6
(defmacro atomic-decf& (place &optional (delta 1))
  `(as-atomic-operation (the fixnum (decf (the fixnum ,place)
                                          (the fixnum ,delta)))))

(defmacro atomic-delete (item place &rest args &environment env)
  (if (symbolp place)
      `(as-atomic-operation
         (setf ,place (delete ,item ,place ,@args)))
      (multiple-value-bind (vars vals store-vars writer-form reader-form)
          (get-setf-expansion place env)
        (let ((item-var (gensym)))
          `(as-atomic-operation
             (let* ((,item-var ,item)
                    ,.(mapcar #'list vars vals)
                    (,(first store-vars)
                     (delete ,item-var ,reader-form ,@args)))
               ,writer-form))))))

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

#+(and cmu mp)
(defun %%lock-release (lock)
  ;;; Internal release-lock function for CMUCL
  (declare (type mp:lock lock))
  #-i486
  (setf (mp:lock-process lock) nil)
  #+i486
  (null (kernel:%instance-set-conditional
         lock 2 mp:*current-process* nil)))

;;; ---------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro without-lock-held ((lock &key (whostate "Without Lock Held"))
                               &body body)
    #-(or allegro
          clozure
          digitool-mcl
          scl)
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
           (#+smp-macros excl:with-delayed-interrupts
            #-smp-macros excl:without-interrupts
             (let ((.holding-thread. (mp:process-lock-locker ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (setf ,saved-whostate (thread-whostate .current-thread.))
               (setf (thread-whostate .current-thread.) ,whostate)
               (mp:process-unlock ,lock-sym)))
           (unwind-protect
               (progn ,@body)
             (mp:process-lock ,lock-sym .current-thread. ,saved-whostate)))
         #+(and clisp mt)
         (progn
           (mt:mutex-unlock ,lock-sym)  ; MUTEX-UNLOCK checks the mutex owner
           (unwind-protect
               (progn ,@body)
             (mt:mutex-lock ,lock-sym)))
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
           (unwind-protect
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
           (unwind-protect
               (progn ,@body)
             (mp::lock-wait ,lock-sym "Reacquiring lock")))
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
           (unwind-protect
               (progn ,@body)
             (ccl:without-interrupts
               (ccl:grab-lock .ccl-lock.)
               (setf (thread-whostate .current-thread.) ,saved-whostate))))
         #+(and ecl threads)
         (progn
           (mp:giveup-lock ,lock-sym)   ; performs valid-holder check
           (unwind-protect
               (progn ,@body)
             (mp:get-lock ,lock-sym)))
         #+(and lispworks lispworks6)
         (progn
           (mp:process-unlock ,lock-sym 't) ; performs valid-holder check
           (unwind-protect
               (progn ,@body)
             (mp:process-lock ,lock-sym)))
         #+(and lispworks (not lispworks6))
         (progn
           (mp:without-preemption
             (let ((.current-thread. mp:*current-process*)
                   (.holding-thread. (mp:lock-owner ,lock-sym)))
               (unless (eq .current-thread. .holding-thread.)
                 (non-holder-lock-release-error
                  ,lock-sym .current-thread. .holding-thread.))
               (mp::in-process-unlock ,lock-sym)))
           (unwind-protect
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
           (unwind-protect
               (progn ,@body)
             (sb-thread:grab-mutex ,lock-sym)))
         #+scl
         (progn
           ;; Hoping that RELEASE-LOCK checks the owner...
           (thread::release-lock ,lock-sym)
           (unwind-protect
               (progn ,@body)
             (thread::acquire-lock ,lock-sym ,whostate)))
         #+threads-not-available
         (progn ,@body)))))

;;; ===========================================================================
;;;   Spawn-Thread

(defun spawn-thread (name function &rest args)
  #-(or (and cmu mp) cormanlisp (and sbcl sb-thread))
  (declare (dynamic-extent args))
  #+allegro
  (apply #'mp:process-run-function name function args)
  #+(and clisp mt)
  (mt:make-thread #'(lambda () (apply function args)) 
                  :name name)
  #+clozure
  (apply #'ccl:process-run-function name function args)
  #+(and cmu mp)
  (mp:make-process #'(lambda () (apply function args)) 
                   :name name)
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
  (mp:make-process #'(lambda () (apply function args))
                   :name name)
  #+threads-not-available
  (declare (ignore name function args))
  #+threads-not-available
  (threads-not-available 'spawn-thread))

;;; ---------------------------------------------------------------------------
;;;   Spawn-Form

(defmacro spawn-form (&body body)
  (let* ((*print-length* 2)
         (*print-level* 2)
         (name (format nil "Form ~s" (first body))))
    `(spawn-thread ,name (lambda (*package*) ,@body) 
                   ;; Run in caller's package:
                   *package*)))

;;; ---------------------------------------------------------------------------
;;;   Kill-Thread

(defun kill-thread (thread)
  #+allegro
  (mp:process-kill thread)
  #+(and clisp mt)
  (mt:thread-interrupt thread :function t)
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
  #+(and clisp mt)
  `(mt:thread-interrupt ,thread :function t)
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
  #+(and clisp mt)
  (mt:thread-interrupt thread :function function :arguments args)
  #+clozure
  (apply #'ccl:process-interrupt thread function args)
  #+(and cmu mp)
  (mp:process-interrupt thread #'(lambda () (apply function args)))
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
  (mp:process-interrupt thread #'(lambda () (apply function args)))
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
  #+(and clisp mt)
  (multiple-value-bind (value boundp)
      (mt:symbol-value-thread symbol thread)
    (if boundp
        (values value (eq boundp 't))
        (if (boundp symbol)
            (values (symbol-value symbol) 't)
            (values nil nil))))
  #+clozure
  (handler-case
      (let ((value (ccl:symbol-value-in-process symbol thread)))
        (if (eq value (ccl::%unbound-marker))
            (values nil nil)
            (values value 't)))
    ;; If SYMBOL-VALUE-IN-PROCESS generates an error, assume it is due to an
    ;; unbound symbol (someday, check the condition class or error-message
    ;; string to be sure):
    (error (condition)
      (declare (ignore condition))
      (values nil nil)))
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
    (values-list result))
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
     #'(lambda () 
         (setf result (if (boundp symbol)
                          `(,(symbol-value symbol) t)
                          '(nil nil)))))
    ;; Wait for result:
    (loop until result do (sleep 0))
    (values-list result))
  #+lispworks
  (mp:read-special-in-process thread symbol)
  ;; Can't get SB-THREAD:SYMBOL-VALUE-IN-THREAD to work correctly, so:
  #+(and sbcl sb-thread)  
  (let ((result nil))
    (sb-thread:interrupt-thread 
     thread
     #'(lambda () 
         (setf result
               (if (boundp symbol)
                   `(,(symbol-value symbol) t)
                   '(nil nil)))))
    ;; Wait for result:
    (loop until result do (sleep 0.05))
    (values-list result))
  #+scl
  (multiple-value-bind (value boundp)
      (kernel:thread-symbol-dynamic-value thread symbol)
    (ecase boundp
      ((t) (values value t))
      (:unbound (values nil nil))
      ((nil)
       (handler-case
	   (values (kernel:symbol-global-value symbol) t)
	 (unbound-variable (condition)
	   (declare (ignore condition))
	   (values nil nil))))))
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
;;;  
;;;  Clozure is the exception to this, as occasionally it fails to run
;;;  thread-interrupt forms.  Instead, a global association list of sleeper
;;;  tag/thread semaphores are used to implement THROWABLE-SLEEP-FOREVER and
;;;  AWAKEN-THROWABLE-SLEEPER.

(defconstant nearly-forever-seconds
    #.(min most-positive-fixnum
           ;; Keep well within a 32-bit word on 64-bit CLs:
           (1- (expt 2 29))
           ;; Clozure CL on Windows needs a smaller value:
           #+(and clozure windows-target)
           (1- (expt 2 22))))

;;; ---------------------------------------------------------------------------

(defun sleep-nearly-forever (&optional seconds)
  (sleep (if seconds
             (min seconds nearly-forever-seconds)
             nearly-forever-seconds)))
             
;;; ---------------------------------------------------------------------------
;;;  Sleeper semaphores (needed in Clozure)

#+clozure
(defvar *sleeper-semaphores* nil)
#+clozure
(defvar *sleeper-semaphores-lock* (ccl:make-lock "sleeper semaphores"))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun throwable-sleep-forever (&optional (tag 'throwable-sleep-forever))
  ;; In most CLs, sleep allows run-in-thread, symbol-value-in-thread,
  ;; and throws to be processed while sleeping, and sleep is often
  ;; well optimized.  So, we use it whenever possible.
  #-(or clozure
        (and lispworks lispworks6))
  (catch tag (sleep-nearly-forever))
  #+clozure
  (let ((semaphore (ccl:make-semaphore)))
    (ccl:with-lock-grabbed (*sleeper-semaphores-lock* "adding")
      (push (cons (cons tag ccl:*current-process*) semaphore)
            *sleeper-semaphores*))
    (ccl:wait-on-semaphore semaphore))
  #+(and lispworks lispworks6)
  (mp:current-process-pause nearly-forever-seconds))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun awaken-throwable-sleeper (thread 
                                 &optional (tag 'throwable-sleep-forever))
  #-(or clozure
        (and lispworks lispworks6))
  (progn (run-in-thread 
          thread 
          #'(lambda () (ignore-errors (throw tag nil))))
         (thread-yield))
  #+clozure
  (let ((acons (assoc (cons tag thread) *sleeper-semaphores*
                      :test #'equal)))
    (when acons 
      (ccl:with-lock-grabbed (*sleeper-semaphores-lock* "removing")
        (setf *sleeper-semaphores*
              (delete acons *sleeper-semaphores* :test #'eq)))
      (ccl:signal-semaphore (cdr acons))))
  #+(and lispworks lispworks6)
  (mp:process-poke thread))

;;; ---------------------------------------------------------------------------

(defun hibernate-thread ()
  #-threads-not-available
  (throwable-sleep-forever 'hibernate-thread)
  #+threads-not-available
  (threads-not-available 'hibernate-thread))

;;; ---------------------------------------------------------------------------

(defun awaken-thread (thread)
  #-threads-not-available
  (awaken-throwable-sleeper thread 'hibernate-thread)
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

#+(and clisp mt)
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (mt:make-mutex :name "Exemption Lock")
         :reader condition-variable-lock)
   (cv :initform (mt:make-exemption :name "Anonymous Exemption")
       :reader condition-variable-cv)))

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
   #+lispworks6
   (cv :initform (mp:make-condition-variable)
       :reader condition-variable-cv)
   #-lispworks6
   (queue :initform nil
          :accessor condition-variable-queue)))

#+(and sbcl sb-thread)
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (sb-thread:make-mutex :name "CV Lock")
         :reader condition-variable-lock)
   (cv :initform (sb-thread:make-waitqueue)
       :reader condition-variable-cv)))

#+scl
(defclass condition-variable ()
  ((lock :initarg :lock
         :initform (mp:make-lock "CV Lock" :type ':error-check)
         :reader condition-variable-lock)
   (cv :initform (thread:make-cond-var "Anonymous CV")
       :accessor condition-variable-cv)))

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
    ;; Lock-owner checking is done by CLISP, ECL, SBCL, and SCL:
    #-(or (and clisp mt)
          (and ecl threads)
          (and sbcl sb-thread)
          scl)
    (unless (thread-holds-lock-p lock)
      (condition-variable-lock-needed-error
       condition-variable 'condition-variable-wait))
    #+allegro
    (progn
      (push system:*current-process* 
            (condition-variable-queue condition-variable))
      (mp::process-unlock lock)
      (throwable-sleep-forever 'condition-variable)
      (mp::process-lock lock))
    #+(and clisp mt)
    (mt:exemption-wait (condition-variable-cv condition-variable) lock)
    #+clozure
    (let ((ccl-lock (lock-ccl-lock lock)))
      (unwind-protect
          (progn
            (push ccl:*current-process* 
                  (condition-variable-queue condition-variable))
            (ccl:release-lock ccl-lock)
            (ccl:wait-on-semaphore 
             (condition-variable-semaphore condition-variable)))
        (ccl:grab-lock ccl-lock)
        (setf (condition-variable-queue condition-variable)
              (remove ccl:*current-process*
                      (condition-variable-queue condition-variable)))))
    #+(and cmu mp)
    (progn
      (push mp:*current-process*
            (condition-variable-queue condition-variable))
      (setf (mp::lock-process lock) nil)
      (throwable-sleep-forever 'condition-variable)
      (mp::lock-wait lock nil))
    #+digitool-mcl
    (let ((ccl-lock (lock-ccl-lock lock)))
      (push ccl:*current-process*
            (condition-variable-queue condition-variable))
      (ccl:process-unlock ccl-lock)
      (throwable-sleep-forever 'condition-variable)
      (ccl:process-lock ccl-lock ccl:*current-process*))
    #+(and ecl threads)
    (mp:condition-variable-wait (condition-variable-cv condition-variable) lock)
    #+(and lispworks lispworks6)
    (mp:condition-variable-wait (condition-variable-cv condition-variable) lock)
    #+(and lispworks (not lispworks6))
    (progn
      (push mp:*current-process*
            (condition-variable-queue condition-variable))
      (mp:process-unlock lock)
      (throwable-sleep-forever 'condition-variable)
      (mp:process-allow-scheduling)
      (mp:process-lock lock))
    #+(and sbcl sb-thread)
    (sb-thread:condition-wait (condition-variable-cv condition-variable) lock)
    #+scl
    (thread:cond-var-wait (condition-variable-cv condition-variable) lock))
  #+threads-not-available
  (declare (ignore condition-variable))
  #+threads-not-available
  (thread-condition-variables-not-available 'condition-variable-wait))

;;; ---------------------------------------------------------------------------

(defun condition-variable-wait-with-timeout (condition-variable seconds)
  #-threads-not-available
  (let ((lock (condition-variable-lock condition-variable)))
    ;; Lock-owner checking is done by CLISP, ECL, SBCL, and SCL:
    #-(or (and clisp mt)
          (and ecl threads)
          (and sbcl sb-thread)
          scl)
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
            (throwable-sleep-forever 'condition-variable)
            't)
        (mp::process-lock lock)))
    #+(and clisp mt)
    (mt:exemption-wait (condition-variable-cv condition-variable) lock
                       :timeout seconds)
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
            (throwable-sleep-forever 'condition-variable)
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
            (throwable-sleep-forever 'condition-variable)
            't)
        (ccl:process-lock ccl-lock ccl:*current-process*)))
    #+(and ecl threads)
    (mp:condition-variable-timedwait
     (condition-variable-cv condition-variable) lock seconds)
    #+(and lispworks lispworks6)
    (mp:condition-variable-wait (condition-variable-cv condition-variable) lock 
                                :timeout seconds)
    #+(and lispworks (not lispworks6))
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
            (throwable-sleep-forever 'condition-variable)
            't)
        (mp:process-lock lock)))
    #+(and sbcl sb-thread)
    (with-timeout (seconds)
      (sb-thread:condition-wait
       (condition-variable-cv condition-variable) 
       lock)
      't)
    #+sbcl-ignore
    (sb-ext:with-timeout seconds
      (handler-case (progn
                      (sb-thread:condition-wait
                       (condition-variable-cv condition-variable) 
                       lock)
                      't)
        (sb-ext:timeout () nil)))
    #+scl
    (thread:cond-var-timedwait (condition-variable-cv condition-variable) lock
			       seconds))
  #+threads-not-available
  (declare (ignore condition-variable seconds))
  #+threads-not-available
  (thread-condition-variables-not-available
   'condition-variable-wait-with-timeout))

;;; ---------------------------------------------------------------------------

(defun condition-variable-signal (condition-variable)
  ;; No lock-owner checking is available under SCL:
  #-scl
  (unless (thread-holds-lock-p (condition-variable-lock condition-variable))
    (condition-variable-lock-needed-error
     condition-variable 'condition-variable-signal))
  #+(or allegro
        (and cmu mp)
        digitool-mcl
        (and lispworks (not lispworks6)))
  (let ((thread (pop (condition-variable-queue condition-variable))))
    (when (and thread (thread-alive-p thread))
      (awaken-throwable-sleeper thread 'condition-variable)))
  #+(and clisp mt)
  (mt:exemption-signal (condition-variable-cv condition-variable))
  #+clozure
  (when (condition-variable-queue condition-variable)
    (ccl:signal-semaphore (condition-variable-semaphore condition-variable)))
  #+(and ecl threads)
  (mp:condition-variable-signal (condition-variable-cv condition-variable))
  #+(and lispworks lispworks6)
  (mp:condition-variable-signal (condition-variable-cv condition-variable))
  #+(and sbcl sb-thread)
  (sb-thread:condition-notify (condition-variable-cv condition-variable))
  #+scl
  (thread:cond-var-signal (condition-variable-cv condition-variable)))
  
;;; ---------------------------------------------------------------------------

(defun condition-variable-broadcast (condition-variable)
  ;; No lock-owner checking is available under SCL:
  #-scl
  (unless (thread-holds-lock-p (condition-variable-lock condition-variable))
    (condition-variable-lock-needed-error
     condition-variable 'condition-variable-broadcast))
  #+(or allegro
        (and cmu mp)
        digitool-mcl
        (and lispworks (not lispworks6)))
  (let ((queue (condition-variable-queue condition-variable)))
    (setf (condition-variable-queue condition-variable) nil)
    (dolist (thread queue)
      (when (thread-alive-p thread)
        (awaken-throwable-sleeper thread 'condition-variable))))
  #+(and clisp mt)
  (mt:exemption-broadcast (condition-variable-cv condition-variable))
  #+clozure
  (let ((queue-length (length (condition-variable-queue condition-variable)))
        (semaphore (condition-variable-semaphore condition-variable)))
    (dotimes (i queue-length)
      (declare (fixnum i))
      (ccl:signal-semaphore semaphore)))
  #+(and ecl threads)
  (mp:condition-variable-broadcast (condition-variable-cv condition-variable))
  #+(and lispworks lispworks6)
  (mp:condition-variable-broadcast (condition-variable-cv condition-variable))
  #+(and sbcl sb-thread)
  (sb-thread:condition-broadcast (condition-variable-cv condition-variable))
  #+scl
  (thread:cond-var-broadcast (condition-variable-cv condition-variable)))

;;; ===========================================================================
;;;  Portable threads interface is fully loaded:

(pushnew ':portable-threads *features*)
(pushnew *portable-threads-version-keyword* *features*)

;;; ===========================================================================
;;;                               End of File
;;; ===========================================================================
