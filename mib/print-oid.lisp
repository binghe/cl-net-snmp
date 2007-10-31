(in-package :mib)

(defmethod print-object ((obj object-id) stream)
  (with-slots (rev-ids rev-names) obj
    (print-unreadable-object (obj stream :type t)
      (when *oid-print-id*
        (let ((part-1 (reverse rev-ids)))
          (format stream "~A~{.~A~}" (car part-1) (cdr part-1))))
      (when (and *oid-print-id* *oid-print-name*)
        (format stream " ("))
      (when *oid-print-name*
        (let ((part-2 (if rev-names
                        (reverse rev-names)
                        (resolve (reverse rev-ids)))))
          (when *oid-print-short*
            (setf part-2 (nthcdr (let ((d (- (oid-length obj) *oid-print-length*)))
                                   (if (plusp d) d 0)) part-2)))
          (format stream "~A~{.~A~}"
                  (car part-2)
                  (cdr part-2))))
      (when (and *oid-print-id* *oid-print-name*)
        (format stream ")")))))
