;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

;;; Empty and old MIB module
(eval-when (:load-toplevel :execute)
  (setf *mib-name-map*
        '((RFC1155-SMI . |SNMPv2-SMI|)
          (RFC1212 . nil)
          (RFC-1212 . nil)
          (RFC1213-MIB . |SNMPv2-SMI|)
          (RFC-1215 . nil)))
  (make-mib-name-map))

(in-package :snmp)

(defparameter *mib-list*
  '(#p"MIB:NET-SNMP;SNMP-COMMUNITY-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-FRAMEWORK-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-MPD-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-NOTIFICATION-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-PROXY-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-TARGET-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-USER-BASED-SM-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-USM-AES-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-USM-DH-OBJECTS-MIB.TXT"
    #p"MIB:NET-SNMP;SNMP-VIEW-BASED-ACM-MIB.TXT"
    #p"MIB:NET-SNMP;SNMPv2-CONF.TXT"
    #p"MIB:NET-SNMP;SNMPv2-MIB.TXT"
    #p"MIB:NET-SNMP;SNMPv2-SMI.TXT"
    #p"MIB:NET-SNMP;SNMPv2-TC.TXT"
    #p"MIB:NET-SNMP;SNMPv2-TM.TXT"
    #p"MIB:NET-SNMP;AGENTX-MIB.TXT"
    #p"MIB:NET-SNMP;BGP4-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-EVENT-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-SCHEDULE-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-SCRIPT-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-PING-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-EXPRESSION-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-TRACEROUTE-MIB.TXT"
    #p"MIB:NET-SNMP;DISMAN-NSLOOKUP-MIB.TXT"
    #p"MIB:NET-SNMP;EtherLike-MIB.TXT"
    #p"MIB:NET-SNMP;GNOME-SMI.TXT"
    #p"MIB:NET-SNMP;HCNUM-TC.TXT"
    #p"MIB:NET-SNMP;HOST-RESOURCES-MIB.TXT"
    #p"MIB:NET-SNMP;HOST-RESOURCES-TYPES.TXT"
    #p"MIB:NET-SNMP;IANA-ADDRESS-FAMILY-NUMBERS-MIB.TXT"
    #p"MIB:NET-SNMP;IANA-LANGUAGE-MIB.TXT"
    #p"MIB:NET-SNMP;IANA-RTPROTO-MIB.TXT"
    #p"MIB:NET-SNMP;IANAifType-MIB.TXT"
    #p"MIB:NET-SNMP;IF-INVERTED-STACK-MIB.TXT"
    #p"MIB:NET-SNMP;IF-MIB.TXT"
    #p"MIB:NET-SNMP;INET-ADDRESS-MIB.TXT"
    #p"MIB:NET-SNMP;IP-FORWARD-MIB.TXT"
    #p"MIB:NET-SNMP;IP-MIB.TXT"
    #p"MIB:NET-SNMP;IPV6-FLOW-LABEL-MIB.TXT"
    #p"MIB:NET-SNMP;IPV6-ICMP-MIB.TXT"
    #p"MIB:NET-SNMP;IPV6-MIB.TXT"
    #p"MIB:NET-SNMP;IPV6-TC.TXT"
    #p"MIB:NET-SNMP;IPV6-TCP-MIB.TXT"
    #p"MIB:NET-SNMP;IPV6-UDP-MIB.TXT"
    #p"MIB:NET-SNMP;LM-SENSORS-MIB.TXT"
    #p"MIB:NET-SNMP;MTA-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-AGENT-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-EXAMPLES-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-EXTEND-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-TC.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-VACM-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-SYSTEM-MIB.TXT"
    #p"MIB:NET-SNMP;NET-SNMP-MONITOR-MIB.TXT"
    #p"MIB:NET-SNMP;NETWORK-SERVICES-MIB.TXT"
    #p"MIB:NET-SNMP;NOTIFICATION-LOG-MIB.TXT"
    #p"MIB:NET-SNMP;OSPF-MIB.TXT"
    #p"MIB:NET-SNMP;OSPF-TRAP-MIB.TXT"
    #p"MIB:NET-SNMP;RIPv2-MIB.TXT"
    #p"MIB:NET-SNMP;RMON-MIB.TXT"
    #p"MIB:NET-SNMP;SMUX-MIB.TXT"
    #p"MIB:NET-SNMP;TCP-MIB.TXT"
    #p"MIB:NET-SNMP;TRANSPORT-ADDRESS-MIB.TXT"
    #p"MIB:NET-SNMP;TUNNEL-MIB.TXT"
    #p"MIB:NET-SNMP;UCD-DEMO-MIB.TXT"
    #p"MIB:NET-SNMP;UCD-DISKIO-MIB.TXT"
    #p"MIB:NET-SNMP;UCD-DLMOD-MIB.TXT"
    #p"MIB:NET-SNMP;UCD-IPFWACC-MIB.TXT"
    #p"MIB:NET-SNMP;UCD-SNMP-MIB.TXT"
    #p"MIB:NET-SNMP;UCD-IPFILTER-MIB.TXT"
    #p"MIB:NET-SNMP;UDP-MIB.TXT"
    #p"MIB:LISP;LISP-MIB.TXT"
    #p"MIB:LISP;LISP-LISPWORKS-MIB.TXT"
    #p"MIB:LISP;LISP-ALLEGRO-MIB.TXT"
    #p"MIB:LISP;LISP-CMUCL-MIB.TXT"
    #p"MIB:LISP;LISP-SBCL-MIB.TXT"
    #p"MIB:LISP;LISP-CLOZURE-MIB.TXT"
    #p"MIB:LISP;LISP-SCL-MIB.TXT"
    #p"MIB:LISP;LISP-CL-HTTP-MIB.TXT"))

(defvar *mib-list-file* #p"SNMP:MIB.LISP-EXPR")
(defvar *mib-dependency-file* #p"SNMP:MIB-DEPEND.LISP")

(defun lisp-file (path)
  (merge-pathnames (make-pathname :name (pathname-name path)
                                  :type "LISP"
                                  :directory '(:relative "MIB"))
                   #p"SNMP:"))

(defun expr-file (path)
  (merge-pathnames (make-pathname :name (pathname-name path)
                                  :type "LISP-EXPR"
                                  :directory '(:relative "MIB"))
                   #p"SNMP:"))

(defun update-mib (&optional (mib-list *mib-list*))
  (let ((mib.lisp-expr '())
        (mib-depend.lisp '()))
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
      (format s ";;;; -*- Mode: Lisp -*-~%;;;; Auto-generated by SNMP:UPDATE-MIB.LISP~%")
      (pprint (setf mib.lisp-expr (nreverse mib.lisp-expr)) s)
      (terpri s))
    ;;; Update MIB Dependency, it's for MIB Browser
    (with-open-file (s *mib-dependency-file*
                       :direction :output
                       :if-exists :supersede)
      (format s ";;;; -*- Mode: Lisp -*-~%;;;; Auto-generated by SNMP:UPDATE-MIB.LISP~%")
      (dolist (i `((in-package :asn.1)
                   (eval-when (:load-toplevel :execute)
                     (mapcar #'(lambda (asn.1::x)
                                 (setf (gethash (car asn.1::x)
                                                asn.1::*mib-module-dependency*) (cdr asn.1::x)))
                             ',mib-depend.lisp))))
        (pprint i s))
      (terpri s))
    (load #p"SNMP:SNMP-MIB.ASD")
    (pprint mib.lisp-expr)))
