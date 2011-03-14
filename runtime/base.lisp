;;;; -*- Mode: Lisp -*-
;;;; $Id: base.lisp 800 2010-07-09 15:31:44Z binghe $

(in-package :asn.1)

(defvar *current-module*)

(defmacro defunknown (type)
  (declare (ignore type))
  nil)

(defclass asn.1-type ()
  ()
  (:documentation "Base ASN.1 Type"))

(defclass general-type (asn.1-type)
  ((value :accessor value-of
          :initarg :value))
  (:documentation "General Container Type, used by counter, gauge and opaque, etc."))

(defclass number-type (general-type)
  ()
  (:documentation "Number-based type"))

(defmethod print-object ((obj general-type) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (value-of obj))))

(defgeneric plain-value (object &key default)
  (:documentation "Plain value: map a ASN.1 object into plain lisp values"))

(defmethod plain-value ((object general-type) &key default)
  (if (slot-boundp object 'value)
      (value-of object)
    default))

(defmethod plain-value ((object number-type) &key (default 0))
  (or (call-next-method)
      default))
