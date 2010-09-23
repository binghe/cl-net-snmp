;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :snmp)

(defparameter *mib-list*
  '(;; Base MIBs from net-snmp project
    #p"MIB:BASE;AGENTX-MIB.txt"
    #p"MIB:BASE;AIRPORT-BASESTATION-3-MIB.txt"
    #p"MIB:BASE;DISMAN-EVENT-MIB.txt"
    #p"MIB:BASE;DISMAN-SCHEDULE-MIB.txt"
    #p"MIB:BASE;DISMAN-SCRIPT-MIB.txt"
    #p"MIB:BASE;EtherLike-MIB.txt"
    #p"MIB:BASE;HCNUM-TC.txt"
    #p"MIB:BASE;HOST-RESOURCES-MIB.txt"
    #p"MIB:BASE;HOST-RESOURCES-TYPES.txt"
    #p"MIB:BASE;IANA-ADDRESS-FAMILY-NUMBERS-MIB.txt"
    #p"MIB:BASE;IANA-LANGUAGE-MIB.txt"
    #p"MIB:BASE;IANA-RTPROTO-MIB.txt"
    #p"MIB:BASE;IANAifType-MIB.txt"
    #p"MIB:BASE;IF-INVERTED-STACK-MIB.txt"
    #p"MIB:BASE;IF-MIB.txt"
    #p"MIB:BASE;INET-ADDRESS-MIB.txt"
    #p"MIB:BASE;IP-FORWARD-MIB.txt"
    #p"MIB:BASE;IP-MIB.txt"
    #p"MIB:BASE;IPV6-ICMP-MIB.txt"
    #p"MIB:BASE;IPV6-MIB.txt"
    #p"MIB:BASE;IPV6-TC.txt"
    #p"MIB:BASE;IPV6-TCP-MIB.txt"
    #p"MIB:BASE;IPV6-UDP-MIB.txt"
    #p"MIB:BASE;LM-SENSORS-MIB.txt"
    #p"MIB:BASE;NET-SNMP-AGENT-MIB.txt"
    ; #p"MIB:BASE;NET-SNMP-EXAMPLES-MIB.txt"
    #p"MIB:BASE;NET-SNMP-EXTEND-MIB.txt"
    #p"MIB:BASE;NET-SNMP-MIB.txt"
    #p"MIB:BASE;NET-SNMP-TC.txt"
    #p"MIB:BASE;NET-SNMP-VACM-MIB.txt"
    #p"MIB:BASE;NOTIFICATION-LOG-MIB.txt"
    #p"MIB:BASE;RFC-1212.txt"    ; old MIB for SNMPv1
    #p"MIB:BASE;RFC-1215.txt"    ; old MIB for SNMPv1
    #p"MIB:BASE;RFC1155-SMI.txt" ; old MIB for SNMPv1
    #p"MIB:BASE;RFC1213-MIB.txt" ; old MIB for SNMPv1
    #p"MIB:BASE;RMON-MIB.txt"
    #p"MIB:BASE;SCTP-MIB.txt"
    ; #p"MIB:BASE;SMUX-MIB.txt"  ; unless
    #p"MIB:BASE;SNMP-COMMUNITY-MIB.txt"
    #p"MIB:BASE;SNMP-FRAMEWORK-MIB.txt"
    #p"MIB:BASE;SNMP-MPD-MIB.txt"
    #p"MIB:BASE;SNMP-NOTIFICATION-MIB.txt"
    #p"MIB:BASE;SNMP-PROXY-MIB.txt"
    #p"MIB:BASE;SNMP-TARGET-MIB.txt"
    #p"MIB:BASE;SNMP-USER-BASED-SM-MIB.txt"
    #p"MIB:BASE;SNMP-USM-AES-MIB.txt"
    #p"MIB:BASE;SNMP-USM-DH-OBJECTS-MIB.txt"
    #p"MIB:BASE;SNMP-VIEW-BASED-ACM-MIB.txt"
    #p"MIB:BASE;SNMPv2-CONF.txt"
    #p"MIB:BASE;SNMPv2-MIB.txt"
    #p"MIB:BASE;SNMPv2-SMI.txt"
    #p"MIB:BASE;SNMPv2-TC.txt"
    #p"MIB:BASE;SNMPv2-TM.txt"
    #p"MIB:BASE;TCP-MIB.txt"
    #p"MIB:BASE;TRANSPORT-ADDRESS-MIB.txt"
    ; #p"MIB:BASE;UCD-DEMO-MIB.txt"
    #p"MIB:BASE;UCD-DISKIO-MIB.txt"
    #p"MIB:BASE;UCD-DLMOD-MIB.txt"
    #p"MIB:BASE;UCD-IPFWACC-MIB.txt"
    #p"MIB:BASE;UCD-SNMP-MIB.txt"
    #p"MIB:BASE;UDP-MIB.txt"

    ;; VMware MIBs from vmware.com
    #p"MIB:VMware;VMware-AGENTCAP-MIB.mib"
    #p"MIB:VMware;VMware-ENV-MIB.mib"
    ; #p"MIB:VMware;VMware-OBSOLETE-MIB.mib"
    #p"MIB:VMware;VMware-PRODUCTS-MIB.mib"
    #p"MIB:VMware;VMware-RESOURCES-MIB.mib"
    #p"MIB:VMware;VMware-ROOT-MIB.mib"
    #p"MIB:VMware;VMware-SYSTEM-MIB.mib"
    #p"MIB:VMware;VMware-TC-MIB.mib"
    #p"MIB:VMware;VMware-VC-EVENT-MIB.mib"
    #p"MIB:VMware;VMware-VMINFO-MIB.mib"

    ;; Lisp MIBs defined by cl-net-snmp
    #p"MIB:lisp;lisp-mib.txt"
    #p"MIB:lisp;lisp-lispworks-mib.txt"
    #p"MIB:lisp;lisp-allegro-mib.txt"
    #p"MIB:lisp;lisp-cmucl-mib.txt"
    #p"MIB:lisp;lisp-sbcl-mib.txt"
    #p"MIB:lisp;lisp-clozure-mib.txt"
    #p"MIB:lisp;lisp-scl-mib.txt"
    #p"MIB:lisp;lisp-cl-http-mib.txt"))

(defvar *mib-list-file* #p"SNMP:mib.lisp-expr")
(defvar *mib-dependency-file* #p"SNMP:mib-depend.lisp")

(defparameter *pathname-base* (translate-logical-pathname #p"SNMP:"))

(defun lisp-file (path)
  (merge-pathnames (make-pathname :name (pathname-name (translate-logical-pathname path))
                                  :type "lisp"
                                  :directory (append (pathname-directory *pathname-base*)
                                                     '("mib")))
                   *pathname-base*))

(defun expr-file (path)
  (merge-pathnames (make-pathname :name (pathname-name (translate-logical-pathname path))
                                  :type "lisp-expr"
                                  :directory (append (pathname-directory *pathname-base*)
                                                     '("mib")))
                   *pathname-base*))

(defun update-mib (&optional (mib-list *mib-list*))
  "Update mib.lisp-expr"
  (let ((mib.lisp-expr '())
        (mib-depend.lisp '())
        (*package* (find-package :asn.1)))
    (dolist (i mib-list)
      (format t "; Compiling ~A~%" i)
      (compile-asn.1 i :to (lisp-file i))
      (let ((depends (with-open-file (s (expr-file i) :direction :input)
                       (read s)))
            (name (string-downcase (pathname-name (lisp-file i)))))
        (push (if (cdr depends)
                  `(:file ,name
                    :depends-on ,(mapcar #'(lambda (x) (string-downcase (symbol-name x)))
                                         (cdr depends)))
                `(:file ,name))
              mib.lisp-expr)
        (if (cdr depends)
            (push depends mib-depend.lisp))))
    ;;; Update MIB Dependency, it's for ASDF
    (with-open-file (s *mib-list-file*
                       :direction :output
                       :if-exists :supersede)
      (format s ";;;; -*- Mode: Lisp -*-~%;;;; Auto-generated by #p\"snmp:update-mib.lisp\"~%")
      (pprint (setf mib.lisp-expr (nreverse mib.lisp-expr)) s)
      (terpri s))
    ;;; Update MIB Dependency, it's for MIB Browser
    (with-open-file (s *mib-dependency-file*
                       :direction :output
                       :if-exists :supersede)
      (format s ";;;; -*- Mode: Lisp -*-~%;;;; Auto-generated by #p\"snmp:update-mib.lisp\"~%")
      (dolist (i `((in-package :asn.1)
                   (eval-when (:load-toplevel :execute)
                     (mapcar #'(lambda (asn.1::x)
                                 (setf (gethash (car asn.1::x)
                                                asn.1:*mib-module-dependency*)
                                       (cdr asn.1::x)))
                             ',mib-depend.lisp))))
        (pprint i s))
      (terpri s))
    (load #p"SNMP:snmp-mib.asd")
    (pprint mib.lisp-expr)))
