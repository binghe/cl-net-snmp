;;;; -*- Mode:Common-Lisp; Package:PORTABLE-THREADS; Syntax:common-lisp -*-
;;;; *-* File: /usr/local/gbbopen/source/tools/scheduled-periodic-functions.lisp *-*
;;;; *-* Edited-By: cork *-*
;;;; *-* Last-Edit: Thu Jul  8 06:24:44 2010 *-*
;;;; *-* Machine: cyclone.cs.umass.edu *-*

;;;; **************************************************************************
;;;; **************************************************************************
;;;; *
;;;; *                    Scheduled & Periodic Functions
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
;;; This file can be used in conjunction with the stand-alone
;;; portable-threads.lisp file (no additional libraries are requried).
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;;;
;;;  12-18-09 Separated from portable-threads.lisp.  (Corkill)
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

(in-package :portable-threads)

;;; ---------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(*periodic-function-verbose*
            *schedule-function-verbose*
            all-scheduled-functions
            #+exported-below
            encode-time-of-day          ; exported near the end of this file
            kill-periodic-function
            make-scheduled-function
            nearly-forever-seconds
            pause-scheduled-function-scheduler
            restart-scheduled-function-scheduler
            resume-scheduled-function-scheduler
            schedule-function
            schedule-function-relative
            scheduled-function          ; structure (not documented)
            scheduled-function-invocation-time
            scheduled-function-marker
            scheduled-function-marker-test
            scheduled-function-name
            scheduled-function-name-test
            scheduled-function-repeat-interval
            scheduled-function-scheduler-paused-p
            scheduled-function-scheduler-running-p
            spawn-periodic-function
            unschedule-function)))

;;; ===========================================================================
;;;  Scheduled Functions (built entirely on top of Portable Threads substrate)

(defstruct (scheduled-function
            (:constructor %make-scheduled-function
                          (function name name-test marker marker-test))
            (:copier nil))
  name
  name-test
  marker
  marker-test
  function
  invocation-time
  repeat-interval
  verbose)

(defmethod print-object ((obj scheduled-function) stream)
  (if *print-readably*
      (call-next-method)
      (print-unreadable-object (obj stream :type t)
        (format stream "~:[<unnamed>~;~:*~s~]~@[ (marker: ~s)~] ["
                (scheduled-function-name obj)
                (scheduled-function-marker obj))
        (pretty-invocation-time (scheduled-function-invocation-time obj)
                                stream)
        (format stream "]"))))

;;; ---------------------------------------------------------------------------

(defparameter *month-name-vector* 
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
(defvar *scheduled-functions-paused?* nil)
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
                                                    function))
                                         (name-test #'eql)
                                         marker
                                         (marker-test #'eql))
  #+threads-not-available
  (declare (ignore name name-test marker marker-test))
  #-threads-not-available
  (%make-scheduled-function function name name-test marker marker-test)
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
    (when *schedule-function-verbose*
      (format *trace-output* 
              "~&;; Starting the scheduled-function scheduler...~%"))
    (loop
      (with-lock-held (*scheduled-functions-cv*)
        (cond 
         ;; nothing to schedule or paused, wait until signaled:
         ((or *scheduled-functions-paused?*
              (null *scheduled-functions*))
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
                          "~&;; Scheduling ~s~@[ (marker: ~s)~] at ~
                                repeat-interval ~s...~%"
                          scheduled-function-to-run
                          (scheduled-function-marker scheduled-function-to-run)
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
              "~&;; Scheduling ~s~@[ (marker: ~s)~] as the next ~
                    scheduled-function...~%"
              scheduled-function
              (scheduled-function-marker scheduled-function))
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
                      "~&;; Adding ~s~@[ (marker: ~s)~] as a ~
                            scheduled-function...~%"
                      scheduled-function
                      (scheduled-function-marker scheduled-function))
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
(defun delete-scheduled-function (name-or-scheduled-function marker verbose)
  ;;; Do the work of deleting a scheduled function from the list of
  ;;; *scheduled-functions*.  The *scheduled-function-cv* lock must be held
  ;;; when calling this function.
  (let ((the-deleted-scheduled-function nil))
    (flet ((on-deletion (scheduled-function)
             (when verbose
               (format *trace-output* 
                       "~&;; Unscheduling ~s~@[ (marker: ~s)~]...~%"
                       scheduled-function
                       marker)
               (force-output *trace-output*))
             ;; Clear the invocation and repeat-interval values:
             (setf (scheduled-function-invocation-time scheduled-function)
                   nil)
             (setf (scheduled-function-repeat-interval scheduled-function) 
                   nil)
             ;; Record the deleted function (which also returns true):
             (setf the-deleted-scheduled-function scheduled-function)))
      (setf *scheduled-functions* 
            (flet ((scheduled-function-fn (scheduled-function)
                     (when (eq scheduled-function name-or-scheduled-function)
                       (on-deletion scheduled-function)))
                   (scheduled-function-structure-fn (scheduled-function)
                     (when (and 
                             (funcall
                              (scheduled-function-name-test scheduled-function)
                              (scheduled-function-name scheduled-function)
                              name-or-scheduled-function)
                             (funcall
                              (scheduled-function-marker-test scheduled-function)
                              marker 
                              (scheduled-function-marker scheduled-function)))
                       (on-deletion scheduled-function))))
              (declare (dynamic-extent #'scheduled-function-fn
                                       #'scheduled-function-structure-fn))
              (delete-if
               (if (scheduled-function-p name-or-scheduled-function)
                 #'scheduled-function-fn
                 #'scheduled-function-structure-fn)
               *scheduled-functions*
               :count 1))))
    ;; return the deleted scheduled-function (or nil, if unsuccessful):
    the-deleted-scheduled-function))

;;; ---------------------------------------------------------------------------

#-threads-not-available
(defun schedule-function-internal (name-or-scheduled-function marker
                                   invocation-time repeat-interval verbose)
  (or (with-lock-held (*scheduled-functions-cv*)
        (let* ((next-scheduled-function (first *scheduled-functions*))
               (unscheduled-scheduled-function 
                (delete-scheduled-function name-or-scheduled-function marker
                                           verbose))
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
              (awaken-scheduled-function-scheduler))
            ;; return success (outside of the lock):
            't)))
      ;; warn if unable to find the scheduled function (outside of the lock):
      (warn "Unable to find scheduled-function: ~s~@[ (marker: ~s)~]."
            name-or-scheduled-function
            marker)))

;;; ---------------------------------------------------------------------------

(defun schedule-function (name-or-scheduled-function invocation-time
                          &key marker
                               repeat-interval
                               (verbose *schedule-function-verbose*))
  #+threads-not-available
  (declare (ignore name-or-scheduled-function invocation-time marker 
                   repeat-interval verbose))
  #-threads-not-available
  (progn
    (check-type invocation-time integer)
    (check-type repeat-interval (or null integer))
    (schedule-function-internal name-or-scheduled-function
                                marker 
                                invocation-time 
                                repeat-interval
                                verbose)
    (values))
  #+threads-not-available
  (threads-not-available 'schedule-function))

;;; ---------------------------------------------------------------------------

(defun schedule-function-relative (name-or-scheduled-function interval
                                   &key marker
                                        repeat-interval 
                                        (verbose *schedule-function-verbose*))
  ;;; Syntactic sugar that simply adds `interval' to the current time before
  ;;; scheduling the scheduled-function.
  #+threads-not-available
  (declare (ignore name-or-scheduled-function interval marker
                   repeat-interval verbose))
  #-threads-not-available
  (progn
    (check-type interval integer)
    (check-type repeat-interval (or null integer))
    (schedule-function-internal name-or-scheduled-function 
                                marker
                                (+ (get-universal-time) interval)
                                repeat-interval
                                verbose)
    (values))
  #+threads-not-available
  (threads-not-available 'schedule-function-relative))

;;; ---------------------------------------------------------------------------

(defun unschedule-function (name-or-scheduled-function 
                            &key marker
                                 (warnp 't)
                                 (verbose *schedule-function-verbose*))
  #+threads-not-available
  (declare (ignore name-or-scheduled-function marker warnp verbose))
  #-threads-not-available
  (or (with-lock-held (*scheduled-functions-cv*)
        (let* ((next-scheduled-function (first *scheduled-functions*))
               (unscheduled-function
                (delete-scheduled-function name-or-scheduled-function marker
                                           verbose)))
          ;; when unscheduled successfully: 
          (when unscheduled-function
            ;; awaken the scheduler if the next-scheduled-function became the
            ;; first one due to the unscheduling:
            (unless (eq next-scheduled-function (first *scheduled-functions*))
              (awaken-scheduled-function-scheduler))
            ;; return the unscheduled function if we unscheduled:
            unscheduled-function)))
      ;; warn if unable to find the scheduled function (outside of the lock):
      (when warnp
        (warn "Scheduled-function ~s~@[ (marker: ~s)~] was not scheduled; ~
               no action taken."
              name-or-scheduled-function 
              marker)
        ;; ensure nil is returned:
        nil))
  #+threads-not-available
  (threads-not-available 'unschedule-function))

;;; ---------------------------------------------------------------------------

(defun pause-scheduled-function-scheduler ()
  #-threads-not-available
  (with-lock-held (*scheduled-functions-cv*)
    (when *schedule-function-verbose*
      (format *trace-output* 
              "~&;; Pausing the scheduled-function scheduler...~%"))
    (setf *scheduled-functions-paused?* 't)
    (values))
  #+threads-not-available
  (threads-not-available 'pause-scheduled-function-scheduler))

;;; ---------------------------------------------------------------------------

(defun resume-scheduled-function-scheduler ()
  #-threads-not-available
  (with-lock-held (*scheduled-functions-cv*)
    (when *schedule-function-verbose*
      (format *trace-output* 
              "~&;; Resuming the scheduled-function scheduler...~%"))
    (setf *scheduled-functions-paused?* nil)
    (condition-variable-signal *scheduled-functions-cv*)
    (values))
  #+threads-not-available
  (threads-not-available 'resume-scheduled-function-scheduler))

;;; ---------------------------------------------------------------------------

(defun scheduled-function-scheduler-paused-p ()
  #-threads-not-available
  *scheduled-functions-paused?*
  #+threads-not-available
  (threads-not-available 'scheduled-function-scheduler-paused-p))

;;; ---------------------------------------------------------------------------

(defun scheduled-function-scheduler-running-p ()
  #-threads-not-available
  (and (threadp *scheduled-function-scheduler-thread*)
       (thread-alive-p *scheduled-function-scheduler-thread*))
  #+threads-not-available
  (threads-not-available 'scheduled-function-scheduler-running-p))

;;; ---------------------------------------------------------------------------

(defun restart-scheduled-function-scheduler ()
  #-threads-not-available
  (if (scheduled-function-scheduler-running-p)
      (format t "~%;; The scheduled-function scheduler is already running.~%")
      (with-lock-held (*scheduled-functions-cv*)
        (when *schedule-function-verbose*
          (format *trace-output* 
                  "~&;; Restarting the scheduled-function scheduler...~%"))
        (awaken-scheduled-function-scheduler)))
  #+threads-not-available
  (threads-not-available 'restart-scheduled-function-scheduler))

;;; ===========================================================================
;;;  Periodic Functions (also built entirely on top of Portable Threads)

(defvar *periodic-function-verbose* nil)

;;; ---------------------------------------------------------------------------

(defun spawn-periodic-function (function interval 
                                &key (count nil)
                                     (name (and (symbolp function)
                                                function))
                                     (verbose *periodic-function-verbose*))
  #+threads-not-available
  (declare (ignore interval count name verbose))
  #-threads-not-available
  (when verbose
    (format *trace-output* 
            "~&;; Spawning periodic-function thread for~@[ ~s~]...~%"
            name)
    (force-output *trace-output*))
  #-threads-not-available
  (spawn-thread 
   (format nil "Periodic Function~@[ ~a~]" name)
   #'(lambda ()
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
;;;  Handy function to encode (second minute hour) time of day into a
;;;  universal time.  If that time has already passed, the next day is
;;;  assumed.
;;;
;;;  (ENCODE-TIME-OF-DAY is duplicated here (as %ENCODE-TIME-OF-DAY) from
;;;  GBBopen Tools, for stand-alone use.)

(defun %encode-time-of-day (second minute hour
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

;;; ---------------------------------------------------------------------------
;;;  Cruft to use GBBopen Tool's ENCODE-TIME-OF-DAY, if present; otherwise,
;;;  the above %ENCODE-TIME-OF-DAY definition is used:

(let* ((gbbopen-tools-package (find-package ':gbbopen-tools))
       (symbol (when gbbopen-tools-package
                 (find-symbol (symbol-name '#:encode-time-of-day) 
                              gbbopen-tools-package))))
  (cond
   ((and symbol (fboundp symbol))
    (import `(,symbol) gbbopen-tools-package)
    (export `(,symbol) gbbopen-tools-package))
   (t (setf (symbol-function (intern (symbol-name '#:encode-time-of-day)))
            (symbol-function '%encode-time-of-day))
      (export (list (intern (symbol-name '#:encode-time-of-day))))))
  (unintern '%encode-time-of-day))
  
;;; ===========================================================================
;;;  Scheduled/periodic-functions are fully loaded:

(pushnew ':scheduled/periodic-functions *features*)

;;; ===========================================================================
;;;                               End of File
;;; ===========================================================================
