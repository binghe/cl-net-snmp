;;;; Patch 5.14: new version dependency policy

(in-package :snmp)

(makunbound '*version*)
(unintern '*version*)

(defvar *major-version* 5)
(defvar *minor-version* 14)

(eval-when (:load-toplevel :execute)
  (assert (or (> asn.1::*major-version* 4)
              (and (= asn.1::*major-version* 4)
                   (>= asn.1::*minor-version* 10)))))
