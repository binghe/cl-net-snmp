(in-package :mib)

(defparameter *mib-list*
  '("SNMPv2-SMI"
    "SNMPv2-MIB"
    "SNMPv2-TM"
    "SNMP-TARGET-MIB"
    "SNMP-FRAMEWORK-MIB"
    "SNMP-COMMUNITY-MIB"
    "SNMP-MPD-MIB"
    "SNMP-NOTIFICATION-MIB"
    "SNMP-PROXY-MIB"
    "SNMP-VIEW-BASED-ACM-MIB"
    "SNMP-USER-BASED-SM-MIB"
    "SNMP-USM-AES-MIB"
    "SNMP-USM-DH-OBJECTS-MIB"
    "IF-MIB"
    "INET-ADDRESS-MIB"
    "TRANSPORT-ADDRESS-MIB"
    "IP-MIB" ;; one char patch: string not close
    "TCP-MIB"
    "UDP-MIB"
    "IPV6-MIB"
    "IPV6-ICMP-MIB"
    "IPV6-TCP-MIB"
    "IPV6-UDP-MIB"
    "IP-FORWARD-MIB"
    "AGENTX-MIB"
    "BGP4-MIB"
    "DISMAN-EVENT-MIB"
    "DISMAN-SCHEDULE-MIB"
    "DISMAN-SCRIPT-MIB"
    "EtherLike-MIB"
    "HCNUM-TC"
    "HOST-RESOURCES-MIB"
    "HOST-RESOURCES-TYPES"
    "IANA-ADDRESS-FAMILY-NUMBERS-MIB"
    "IANAifType-MIB"
    "IANA-LANGUAGE-MIB"
    "IANA-RTPROTO-MIB"
    "IF-INVERTED-STACK-MIB"
    "NET-SNMP-MIB"
    "NET-SNMP-TC"
    "NET-SNMP-AGENT-MIB" ;; a patch to deal with comment: -- ... --
    "NET-SNMP-EXTEND-MIB"
    "NET-SNMP-EXAMPLES-MIB"
    "UCD-SNMP-MIB"
    "UCD-DISKIO-MIB"
    "UCD-IPFWACC-MIB"
    "UCD-DLMOD-MIB"
    "UCD-DEMO-MIB"
    "LM-SENSORS-MIB"
    "RMON-MIB"
    "NOTIFICATION-LOG-MIB"
    "SMUX-MIB"
    "LINUX-HA-MIB"     ;; heartbeat-2
    ))

(defparameter *mib-pathname-base*
  (merge-pathnames
   (make-pathname :directory '(:relative "mib" "mibs"))
   (asdf:component-pathname (asdf:find-system :net-snmp))))

(defun mib-pathname (name &optional (base *mib-pathname-base*))
  (merge-pathnames (make-pathname :name name :type "txt")
                   base))

(defun test-syntax-2 (name)
  (parse-mib (mib-pathname name)))

(defun parse-value-assignments (syntax-tree)
  "Parse all value assignments into a list"
  (let ((module (car syntax-tree)))
    (let ((assignment-list (Module-Body-assignment-list
			    (Module-Definition-body module))))
      (mapcar #'Assignment-value
              (delete-if-not #'(lambda (x) (eq (Assignment-type x) :value))
                             (kb-sequence->list assignment-list))))))

(defun parse-value-assignment (va)
  "Parse one value assignment"
  (declare (type Value-Assignment va))
  (let ((name (Value-Assignment-name va))
        (vlist (kb-sequence->list (Object-Identifier-Value-value
                                   (Value-Assignment-value va)))))
    (cons (mapcar #'(lambda (x) (cond ((numberp x) x)
                                      ((symbolp x) (symbol-name x))
                                      ((Obj-Id-Component-p x)
                                       (cons (symbol-name (Obj-Id-Component-name x))
                                             (Obj-Id-Component-value x)))))
                  vlist)
          (symbol-name name))))

(defun resolve-parent (olist)
  (if (numberp (car olist))
      (tree-node (reverse (cdr (reverse olist))))
    (if (and (= 2 (list-length olist)) (stringp (car olist)))
        (or (gethash (car olist) *mib-index*)
            nil)
      nil)))

(defun parse (pathname)
  (mapcar #'parse-value-assignment
          (parse-value-assignments (parse-mib pathname))))

(defun read-mib (pathname)
  (let ((l (parse pathname)))
    (dolist (i l (list-length l))
      (let ((oid (car i)) (name (cdr i)))
        (insert-node (resolve-parent oid) (car (last oid)) name)))))

(defun build-tree ()
  (dolist (i *mib-list* t)
    (format t "Parsing ~A" i)
    (read-mib (mib-pathname i))
    (format t ".~%")))

(eval-when (:load-toplevel :execute)
  (build-tree))
