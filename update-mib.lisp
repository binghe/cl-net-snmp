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
  '(#p"mib:net-snmp;snmp-community-mib.txt"
    #p"mib:net-snmp;snmp-framework-mib.txt"
    #p"mib:net-snmp;snmp-mpd-mib.txt"
    #p"mib:net-snmp;snmp-notification-mib.txt"
    #p"mib:net-snmp;snmp-proxy-mib.txt"
    #p"mib:net-snmp;snmp-target-mib.txt"
    #p"mib:net-snmp;snmp-user-based-sm-mib.txt"
    #p"mib:net-snmp;snmp-usm-aes-mib.txt"
    #p"mib:net-snmp;snmp-usm-dh-objects-mib.txt"
    #p"mib:net-snmp;snmp-view-based-acm-mib.txt"
    #p"mib:net-snmp;snmpv2-conf.txt"
    #p"mib:net-snmp;snmpv2-mib.txt"
    #p"mib:net-snmp;snmpv2-smi.txt"
    #p"mib:net-snmp;snmpv2-tc.txt"
    #p"mib:net-snmp;snmpv2-tm.txt"
    #p"mib:net-snmp;agentx-mib.txt"
    #p"mib:net-snmp;bgp4-mib.txt"
    #p"mib:net-snmp;disman-event-mib.txt"
    #p"mib:net-snmp;disman-schedule-mib.txt"
    #p"mib:net-snmp;disman-script-mib.txt"
    #p"mib:net-snmp;disman-ping-mib.txt"
    #p"mib:net-snmp;disman-expression-mib.txt"
    #p"mib:net-snmp;disman-traceroute-mib.txt"
    #p"mib:net-snmp;disman-nslookup-mib.txt"
    #p"mib:net-snmp;etherlike-mib.txt"
    #p"mib:net-snmp;gnome-smi.txt"
    #p"mib:net-snmp;hcnum-tc.txt"
    #p"mib:net-snmp;host-resources-mib.txt"
    #p"mib:net-snmp;host-resources-types.txt"
    #p"mib:net-snmp;iana-address-family-numbers-mib.txt"
    #p"mib:net-snmp;iana-language-mib.txt"
    #p"mib:net-snmp;iana-rtproto-mib.txt"
    #p"mib:net-snmp;ianaiftype-mib.txt"
    #p"mib:net-snmp;if-inverted-stack-mib.txt"
    #p"mib:net-snmp;if-mib.txt"
    #p"mib:net-snmp;inet-address-mib.txt"
    #p"mib:net-snmp;ip-forward-mib.txt"
    #p"mib:net-snmp;ip-mib.txt"
    #p"mib:net-snmp;ipv6-flow-label-mib.txt"
    #p"mib:net-snmp;ipv6-icmp-mib.txt"
    #p"mib:net-snmp;ipv6-mib.txt"
    #p"mib:net-snmp;ipv6-tc.txt"
    #p"mib:net-snmp;ipv6-tcp-mib.txt"
    #p"mib:net-snmp;ipv6-udp-mib.txt"
    #p"mib:net-snmp;lm-sensors-mib.txt"
    #p"mib:net-snmp;mta-mib.txt"
    #p"mib:net-snmp;net-snmp-agent-mib.txt"
    #p"mib:net-snmp;net-snmp-examples-mib.txt"
    #p"mib:net-snmp;net-snmp-extend-mib.txt"
    #p"mib:net-snmp;net-snmp-mib.txt"
    #p"mib:net-snmp;net-snmp-tc.txt"
    #p"mib:net-snmp;net-snmp-vacm-mib.txt"
    #p"mib:net-snmp;net-snmp-system-mib.txt"
    #p"mib:net-snmp;net-snmp-monitor-mib.txt"
    #p"mib:net-snmp;network-services-mib.txt"
    #p"mib:net-snmp;notification-log-mib.txt"
    #p"mib:net-snmp;ospf-mib.txt"
    #p"mib:net-snmp;ospf-trap-mib.txt"
    #p"mib:net-snmp;ripv2-mib.txt"
    #p"mib:net-snmp;rmon-mib.txt"
    #p"mib:net-snmp;tcp-mib.txt"
    #p"mib:net-snmp;transport-address-mib.txt"
    #p"mib:net-snmp;tunnel-mib.txt"
    #p"mib:net-snmp;ucd-demo-mib.txt"
    #p"mib:net-snmp;ucd-diskio-mib.txt"
    #p"mib:net-snmp;ucd-dlmod-mib.txt"
    #p"mib:net-snmp;ucd-ipfwacc-mib.txt"
    #p"mib:net-snmp;ucd-snmp-mib.txt"
    #p"mib:net-snmp;ucd-ipfilter-mib.txt"
    #p"mib:net-snmp;udp-mib.txt"
    #p"mib:lisp;lisp-mib.txt"
    #p"mib:lisp;lisp-lispworks-mib.txt"
    #p"mib:lisp;lisp-allegro-mib.txt"
    #p"mib:lisp;lisp-cmucl-mib.txt"
    #p"mib:lisp;lisp-sbcl-mib.txt"
    #p"mib:lisp;lisp-clozure-mib.txt"
    #p"mib:lisp;lisp-scl-mib.txt"
    #p"mib:lisp;lisp-cl-http-mib.txt"))

(defvar *mib-list-file* #p"snmp:mib.lisp-expr")
(defvar *mib-dependency-file* #p"snmp:mib-depend.lisp")

(defparameter *pathname-base* (translate-logical-pathname #p"snmp:"))

(defun lisp-file (path)
  (merge-pathnames (make-pathname :name (pathname-name path)
                                  :type "lisp"
                                  :directory (append (pathname-directory *pathname-base*)
                                                     '("mib")))
                   *pathname-base*))

(defun expr-file (path)
  (merge-pathnames (make-pathname :name (pathname-name path)
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
                                                asn.1::*mib-module-dependency*) (cdr asn.1::x)))
                             ',mib-depend.lisp))))
        (pprint i s))
      (terpri s))
    (load #p"snmp:snmp-mib.asd")
    (pprint mib.lisp-expr)))
