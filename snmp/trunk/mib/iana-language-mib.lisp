;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;IANA-LANGUAGE-MIB.TXT

(in-package :asn.1)
(eval-when (:load-toplevel :execute)
  (pushnew 'iana-language-mib *mib-modules*))
(setf *current-module* 'iana-language-mib)
(defpackage :asn.1/iana-language-mib
  (:use :cl :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                |mib-2|))
(in-package :asn.1/iana-language-mib)
(defoid |ianaLanguages| (|mib-2| 73)
  (:type 'module-identity)
  (:description
   "The MIB module registers object identifier values for
         well-known programming and scripting languages. Every
         language registration MUST describe the format used
         when transferring scripts written in this language.

         Any additions or changes to the contents of this MIB
         module require Designated Expert Review as defined in
         the Guidelines for Writing IANA Considerations Section
         document. The Designated Expert will be selected by
         the IESG Area Director of the OPS Area.

         Note, this module does not have to register all possible
         languages since languages are identified by object
         identifier values. It is therefore possible to registered 
         languages in private OID trees. The references given below are not
         normative with regard to the language version. Other
         references might be better suited to describe some newer 
         versions of this language. The references are only
         provided as `a pointer into the right direction'."))
(defoid |ianaLangJavaByteCode| (|ianaLanguages| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "Java byte code to be processed by a Java virtual machine.
         A script written in Java byte code is transferred by using
         the Java archive file format (JAR)."))
(defoid |ianaLangTcl| (|ianaLanguages| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The Tool Command Language (Tcl). A script written in the
         Tcl language is transferred in Tcl source code format."))
(defoid |ianaLangPerl| (|ianaLanguages| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The Perl language. A script written in the Perl language
         is transferred in Perl source code format."))
(defoid |ianaLangScheme| (|ianaLanguages| 4)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The Scheme language. A script written in the Scheme
         language is transferred in Scheme source code format."))
(defoid |ianaLangSRSL| (|ianaLanguages| 5)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The SNMP Script Language defined by SNMP Research. A
         script written in the SNMP Script Language is transferred
         in the SNMP Script Language source code format."))
(defoid |ianaLangPSL| (|ianaLanguages| 6)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The Patrol Script Language defined by BMC Software. A script
         written in the Patrol Script Language is transferred in the
         Patrol Script Language source code format."))
(defoid |ianaLangSMSL| (|ianaLanguages| 7)
  (:type 'object-identity)
  (:status '|current|)
  (:description
   "The Systems Management Scripting Language. A script written
         in the SMSL language is transferred in the SMSL source code
         format."))
