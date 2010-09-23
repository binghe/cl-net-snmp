;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-TC-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-tc-mib))

(defpackage :asn.1/vmware-tc-mib
  (:nicknames :vmware-tc-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity)
  (:import-from :|ASN.1/SNMPv2-TC| textual-convention)
  (:import-from :asn.1/vmware-root-mib |vmwSystem|))

(in-package :vmware-tc-mib)

(defoid |vmwTcMIB| (|vmwSystem| 11)
  (:type 'module-identity)
  (:description
   "This MIB module provides common datatypes for use in VMWARE
     enterprise mib modules"))

(define-textual-convention |VmwSubsystemTypes|
                           t
                           (:status '|current|)
                           (:description
                            "Define the various subsystems fond on hardware."))

(define-textual-convention |VmwSubsystemStatus|
                           t
                           (:status '|current|)
                           (:description
                            "Define the state oof a given subsystem if known."))

(define-textual-convention |VmwConnectedState|
                           octet-string
                           (:display-hint "7a")
                           (:status '|current|)
                           (:description
                            "Can hold one of the following values: 'true' or 'false' or 'unknown'."))

(define-textual-convention |VmwLongDisplayString|
                           octet-string
                           (:display-hint "1a")
                           (:status '|current|)
                           (:description
                            "Represents textual information taken from the NVT ASCII
            character set, as defined in pages 4, 10-11 of RFC 854.

            To summarize RFC 854, the NVT ASCII repertoire specifies:

              - the use of character codes 0-127 (decimal)

              - the graphics characters (32-126) are interpreted as
                US ASCII

              - NUL, LF, CR, BEL, BS, HT, VT and FF have the special
                meanings specified in RFC 854

              - the other 25 codes have no standard interpretation

              - the sequence 'CR LF' means newline

              - the sequence 'CR NUL' means carriage-return

              - an 'LF' not preceded by a 'CR' means moving to the
                same column on the next line.

              - the sequence 'CR x' for any x other than LF or NUL is
                illegal.  (Note that this also means that a string may
                end with either 'CR LF' or 'CR NUL', but not with CR.)

            An object defined using this syntax may be of indefinite
            length, as specified by the protocol, but displays may
            choose to display only the first 4096 characters."))

(define-textual-convention |VmwLongSnmpAdminString|
                           octet-string
                           (:display-hint "4096t")
                           (:status '|current|)
                           (:description
                            "This TC adapted from SnmpAdminString from SNMP-FRAMEWORK-MIB An
                 octet string containing administrative information, preferably
                 in human-readable form.

                 To facilitate internationalization, this
                 information is represented using the ISO/IEC
                 IS 10646-1 character set, encoded as an octet
                 string using the UTF-8 transformation format
                 described in [RFC2279].

                 Since additional code points are added by
                 amendments to the 10646 standard from time
                 to time, implementations must be prepared to
                 encounter any code point from 0x00000000 to
                 0x7fffffff.  Byte sequences that do not
                 correspond to the valid UTF-8 encoding of a
                 code point or are outside this range are
                 prohibited.

                 The use of control codes should be avoided.

                 When it is necessary to represent a newline,
                 the control code sequence CR LF should be used.

                 The use of leading or trailing white space should
                 be avoided.

                 For code points not directly supported by user
                 interface hardware or software, an alternative
                 means of entry and display, such as hexadecimal,
                 may be provided.

                 For information encoded in 7-bit US-ASCII,
                 the UTF-8 encoding is identical to the
                 US-ASCII encoding.

                 UTF-8 may require multiple bytes to represent a
                 single character / code point; thus the length
                 of this object in octets may be different from
                 the number of characters encoded.  Similarly,
                 size constraints refer to the number of encoded
                 octets, not the number of characters represented
                 by an encoding.

                 Note that when this TC is used for an object that
                 is used or envisioned to be used as an index, then
                 a SIZE restriction MUST be specified so that the
                 number of sub-identifiers for any object instance
                 does not exceed the limit of 128, as defined by
                 [RFC3416].

                 Note that the size of an SnmpAdminString object is
                 measured in octets, not characters."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-tc-mib *mib-modules*)
  (setf *current-module* nil))

