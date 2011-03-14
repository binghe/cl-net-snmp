;;;; -*- Mode: Lisp -*-
;;;; $Id: syntax.lisp 813 2010-09-23 07:04:43Z binghe $
;;;; ASN.1 Syntax (BNF -> Lisp)

(in-package :asn.1)

(defparameter *reserved-words*
  '(ABSENT ENCODED INTEGER RELATIVE-OID
    ABSTRACT-SYNTAX END INTERSECTION SEQUENCE 
    ALL ENUMERATED |ISO646String| SET
    APPLICATION EXCEPT MAX SIZE
    AUTOMATIC EXPLICIT MIN STRING
    BEGIN EXPORTS MINUS-INFINITY SYNTAX 
    BIT EXTENSIBILITY NULL |T61String|
    |BMPString| EXTERNAL |NumericString| TAGS
    BOOLEAN FALSE OBJECT |TeletexString|
    BY FROM |ObjectDescriptor| TRUE
    CHARACTER |GeneralizedTime| OCTET TYPE-IDENTIFIER
    CHOICE |GeneralString| OF UNION
    CLASS |GraphicString| OPTIONAL UNIQUE
    COMPONENT |IA5String| PATTERN UNIVERSAL
    COMPONENTS IDENTIFIER PDV |UniversalString|
    CONSTRAINED IMPLICIT PLUS-INFINITY |UTCTime|
    CONTAINING IMPLIED PRESENT |UTF8String|
    DEFAULT IMPORTS |PrintableString| |VideotexString|
    DEFINITIONS INCLUDES PRIVATE |VisibleString|
    EMBEDDED INSTANCE REAL WITH
    ;; Additional keywords
    |::=| [ ] { } |,| |(| |)| |;| |..| |\|| < >
    MACRO TYPE VALUE NOTATION
    MODULE-IDENTITY OBJECT-TYPE NOTIFICATION-TYPE TRAP-TYPE
    TEXTUAL-CONVENTION MODULE-COMPLIANCE OBJECT-GROUP
    NOTIFICATION-GROUP OBJECT-IDENTITY
    MODULE AGENT-CAPABILITIES
    WRITE-SYNTAX))

(defvar *reserved-words-table* (make-hash-table))

(defun fill-reserved-words ()
  (clrhash *reserved-words-table*)
  (dolist (i *reserved-words*)
    (setf (gethash i *reserved-words-table*) i)))

(eval-when (:load-toplevel :execute)
  (fill-reserved-words))

(defparameter *asn.1-syntax* '(
  ((%root %module-definition) $1)
  ((%module-definition :id
                       DEFINITIONS
                       %tag-default
                       %extension-default
                       |::=|
                       BEGIN
                       %module-body
                       END)
   `(:module ,$1 ,$7))
  ((%tag-default))
  ((%extension-default))
  ((%module-body %exports %imports %assignment-list)
   `((,$1 ,$2) ,$3))
  ((%module-body))
  ((%exports EXPORTS ALL |;|) `(:export :all))
  ((%exports EXPORTS %symbol* |;|) `(:export ,@$2))
  ((%exports))
  ((%imports IMPORTS %symbols-from-modules |;|) `(:import ,@$2))
  ((%imports))
  ((%symbols-from-modules %symbols-from-module) `(,$1))
  ((%symbols-from-modules %symbols-from-modules %symbols-from-module)
   `(,@$1 ,$2))
  ((%symbols-from-module %symbol+ FROM :id) `(,$1 :from ,$3))
  ((%assignment-list %assignment-list %assignment) `(,@$1 ,$2))
  ((%assignment-list %assignment) `(,$1))
  ((%assignment-list))
  ((%assignment %macro-definition) $1)
  ((%assignment %type-assignment) $1)
  ((%assignment %value-assignment) $1)
  ;; ASN.1 Macro
  ((%macro-definition %macro-name
                     MACRO |::=|
                     BEGIN
                     %general-list
                     END) `(:macro ,$1))
  ((%value-assignment :id %type |::=| %value) `(:value-assignment ,$2 (,$1 ,$4)))
  ((%value-assignment :id %macro-name %macro-arguments+
                      |::=| %object-identifier-value)
   `(:define ,$2 (,$1 ,$3) ,$5))
  ((%value-assignment :id %macro-name %macro-arguments+
                      |::=| :number)
   `(:define ,$2 (,$1 ,$3) ,$5))
  ((%macro-arguments+ %macro-arguments) `(,$1))
  ((%macro-arguments+ %macro-arguments+ %macro-arguments) `(,@$1 ,$2))
  ((%macro-arguments :id :id) `(,$1 ,$2))
  ((%macro-arguments :id :string) `(,$1 ,$2))
  ((%macro-arguments SYNTAX %type) `(,$1 ,$2))
  ((%macro-arguments WRITE-SYNTAX %type) `(,$1 ,$2))
  ((%macro-arguments OBJECT :id) `(,$1 ,$2))
  ((%macro-arguments MODULE :id %macro-arguments+) `(:module ,$2 ,$3))
  ((%macro-arguments MODULE %macro-arguments+) `(:module nil ,$2))
  ((%macro-arguments INCLUDES { %symbol+ }) `(:includes ,$3))
  ((%macro-arguments :id { { %symbol* } }) `(,$1 ,$4))
  ((%macro-arguments :id { :string }) `(,$1 ,$3))
  ((%macro-arguments :id { :number }) `(,$1 ,$3))
  ((%macro-arguments :id { %implied-symbol+ }) `(,$1 ,$3))
  ((%type-assignment :id |::=| %type) `(:type-assignment ,$1 ,$3))
  ((%type %builtin-type) $1)
  ((%type %tagged-type) $1)
  ((%type :id) $1)
  ;; general string type
  ((%type :id |(| SIZE |(| %numbers+ |)| |)|) `(:general-string ,$1 ,$5))
  ;; general integer type
  ((%type :id |(| %numbers+ |)|) `(:general-integer ,$1 ,$3))
  ((%type :id { %named-number+ }) `(:general-integer ,$1 ,$3))
  ((%type %named-type) `(:named-type ,$1))
  ((%named-type :id %type) `(,$1 ,$2))
  ((%builtin-type %object-identifier-type) $1)
  ((%builtin-type %choice-type) $1)
  ((%builtin-type %string-type) $1)
  ((%builtin-type %integer-type) $1)
  ((%builtin-type %sequence-of-type) $1)
  ((%builtin-type %sequence-type) $1)
  ((%builtin-type %textual-convention-type) $1)
  ((%builtin-type NULL) `(:null))
  ((%object-identifier-type OBJECT IDENTIFIER) :object-identifier)
  ((%choice-type CHOICE { %alternative-type-lists }) `(:choice ,$3))
  ((%alternative-type-lists %root-alternative-type-list) $1)
  ;;((%alternative-type-lists %root-alternative-type-list |,|
  ;;                         %extension-and-exception
  ;;                         %extension-addition-alternatives
  ;;                         %option-extension-marker)
  ;; `(,$1 ,$3 ,$4 ,$5))
  ((%root-alternative-type-list %alternative-type-list) $1)
  ((%alternative-type-list %named-type) `(,$1))
  ((%alternative-type-list %alternative-type-list |,| %named-type) `(,@$1 ,$3))
  ;;((%extension-and-exception))
  ;;((%extension-addition-alternatives |,| extension-addition-alternatives-list)
  ;; $2)
  ;;((%extension-addition-alternatives))
  ;;((%extension-addition-alternatives-list extension-addition-alternative)
  ;; `(,$1))
  ;;((%extension-addition-alternatives-list extension-addition-alternatives-list
  ;;  |,| extension-addition-alternative)
  ;; `(,@$1 $3))
  ;;((%extension-addition-alternative :id) $1)
  ;;((%extension-addition-alternative extension-addition-alternatives-group) $1)
  ;;((%extension-addition-alternatives-group |[[|
  ;;  :number alternative-type-list |]]|)
  ;; `(,$2 ,$3))
  ;;((%option-extension-marker))
  ((%string-type OCTET STRING %string-options) `(:octet-string ,$3))
  ((%string-options |(| SIZE |(| %numbers+ |)| |)|) `(:size ,$4))
  ((%string-options |(| %numbers+ |)|) `(:size ,$2))
  ((%string-options))
  ((%numbers+ %numbers+ |\|| %splited-numbers) `(,@$1 ,$3))
  ((%numbers+ %splited-numbers) `(,$1))
  ((%integer-type %integer-type-name |(| %numbers+ |)|) `(,$1 ,$3))
  ((%integer-type %integer-type-name { %named-number+ }) `(,$1 ,$3))
  ((%integer-type %integer-type-name) $1)
  ((%integer-type-name INTEGER) :integer)
  ((%splited-numbers :number) $1)
  ((%splited-numbers :number |..| :number) `(,$1 ,$3))
  ((%named-number+ %named-number) `(,$1))
  ((%named-number+ %named-number+ |,| %named-number) `(,@$1 ,$3))
  ((%named-number :id |(| :number |)|) `(,$1 ,$3))
  ((%tagged-type %tag IMPLICIT %builtin-type) `(:implicit ,$1 ,$3))
  ((%tagged-type %tag EXPLICIT %builtin-type) `(:explicit ,$1 ,$3))
  ((%tagged-type %tag %builtin-type) `(:tag ,$1 ,$2))
  ((%tag [ %class :number ]) `(,$2 ,$3))
  ((%class UNIVERSAL) :universal)
  ((%class APPLICATION) :application)
  ((%class PRIVATE) :private)
  ((%class))
  ((%value %object-identifier-value) $1)
  ((%value :string) $1)
  ((%value :number) $1)
  ((%object-identifier-value { %obj-id-component+ }) `(,@$2))
  ((%obj-id-component+ %obj-id-component+ %obj-id-component) `(,@$1 ,$2))
  ((%obj-id-component+ %obj-id-component) `(,$1))
  ((%obj-id-component %name-and-number-form) $1)
  ((%obj-id-component :id) $1)
  ((%obj-id-component :number) $1)
  ((%name-and-number-form :id |(| :number |)|) `(,$1 ,$3))
  ((%sequence-of-type SEQUENCE OF %type) `(:sequence-of ,$3))
  ((%sequence-type SEQUENCE { }) `(:sequence))
  ((%sequence-type SEQUENCE { %component-type-lists }) `(:sequence ,@$3))
  ((%component-type-lists %root-component-type-list) $1)
  ((%root-component-type-list %component-type-list) $1)
  ((%component-type-list %component-type) `(,$1))
  ((%component-type-list %component-type-list |,| %component-type) `(,@$1 ,$3))
  ((%component-type %named-type OPTIONAL) `(,$1 :optional))
  ((%component-type %named-type DEFAULT %value) `(,$1 :default ,$3))
  ((%component-type %named-type) $1)
  ((%component-type COMPONENTS OF %type) `(:components-of ,$3))
  ((%textual-convention-type TEXTUAL-CONVENTION
                             %tc-args
                             SYNTAX %type)
   `(:textual-convention ,$2 (:syntax ,$4))) ; ,$2 may be ,@$2
  ((%tc-args %tc-arg) `(,$1))
  ((%tc-args %tc-args %tc-arg) `(,@$1 ,$2))
  ((%tc-arg :id :id) `(,$1 ,$2))
  ((%tc-arg :id :string) `(,$1 ,$2))
  ;; Symbol+ and Symbol*
  ((%symbol+ %symbol) `(,$1))
  ((%symbol+ %symbol+ |,| %symbol) `(,@$1 ,$3))
  ((%implied-symbol+ %implied-symbol) `(,$1))
  ((%implied-symbol+ %implied-symbol+ |,| %implied-symbol) `(,@$1 ,$3))
  ((%symbol* %symbol) `(,$1))
  ((%symbol* %symbol* |,| %symbol) `(,@$1 ,$3))
  ((%symbol*))
  ((%symbol %macro-name) $1)
  ((%symbol :id) $1)
  ((%implied-symbol :id) $1)
  ((%implied-symbol IMPLIED :id) `(:implied ,$2))
  ((%macro-name MODULE-IDENTITY) $1)
  ((%macro-name OBJECT-TYPE) $1)
  ((%macro-name NOTIFICATION-TYPE) $1)
  ((%macro-name TEXTUAL-CONVENTION) $1)
  ((%macro-name MODULE-COMPLIANCE) $1)
  ((%macro-name OBJECT-GROUP) $1)
  ((%macro-name NOTIFICATION-GROUP) $1)
  ((%macro-name OBJECT-IDENTITY) $1)
  ((%macro-name AGENT-CAPABILITIES) $1)
  ((%macro-name TRAP-TYPE) $1)
  ;;; Last Rules
  ((%general-list %general) `(,$1))
  ((%general-list %general-list |,| %general) `(,@$1 ,$2))
  ((%general-list %general-list %general) `(,@$1 ,$2))
  ((%general :number) $1)
  ((%general :id) $1)
  ((%general :string) $1)
  ((%general |::=|) $1)
  ((%general |(|) $1)
  ((%general |)|) $1)
  ((%general |\||) $1)
  ((%general {) $1)
  ((%general }) $1)
  ((%general <) $1)
  ((%general >) $1)
  ((%general TYPE) $1)
  ((%general VALUE) $1)
  ((%general NOTATION) $1)
  ((%general SEQUENCE) $1)
  ((%general OBJECT) $1)
  ((%general IDENTIFIER) $1)
  ((%general INTEGER) $1)
  ((%general |IA5String|) $1)
)) ; defparameter *asn.1-syntax*

;;; binghe: flatten is from alexandria project
(defun flatten (tree)
  "Traverses the tree in order, collecting non-null leaves into a list."
  (let (list)
    (labels ((traverse (subtree)
               (when subtree
                 (if (consp subtree)
                     (progn
                       (traverse (car subtree))
                       (traverse (cdr subtree)))
                     (push subtree list)))))
      (traverse tree))
    (nreverse list)))

;;; binghe: following funtions is contributed by John Fremlin from MSI <jf@msi.co.jp>

#+asn.1-features:cl-yacc
(defun defparser-production-to-yacc (grammar-symbols forms)
  (cond ((not (and forms (or (not (listp forms)) (some 'identity forms))))
	 nil)
	(t
	 (labels ((make-var (i)
		    (intern (format nil "$~D" i)))
		  (vars ()
		    (loop for i from 1
                          for x in grammar-symbols collect (make-var i)))
		  (used-vars ()
                    (remove-duplicates  
                     (loop for sym in (flatten forms)
                           when (and (symbolp sym) (eql #\$ (elt (symbol-name sym) 0))
                                     (ignore-errors (parse-integer (symbol-name sym) :start 1)))
                           collect (make-var (parse-integer (symbol-name sym) :start 1)))
                     :test 'eql)))
	   (let ((unused-vars (set-difference (vars) (used-vars))))
	     (list `#'(lambda(,@(vars)) 
                        ,@(when unused-vars  (list `(declare (ignore ,@unused-vars))))
                        ,forms)))))))

#+asn.1-features:cl-yacc
(defun defparser-to-yacc (rules)
  (let (grouped-rules)
    (loop for rule in rules do
	  (destructuring-bind ((non-terminal &rest grammar-symbols) &optional forms)
	      rule
	    (assert non-terminal)
            #+ignore
            (push (append grammar-symbols (defparser-production-to-yacc grammar-symbols forms)) 
		  (sys:cdr-assoc non-terminal grouped-rules))
            ;;; binghe: I don't know if this rewrite is correct ...
            (let* ((%assoc (assoc non-terminal grouped-rules))
                   (%cdr-assoc (cdr %assoc))
                   (item (append grammar-symbols
                                 (defparser-production-to-yacc grammar-symbols forms))))
              (if (null %assoc)
                  (setf grouped-rules (acons non-terminal (list item) grouped-rules))
                (setf (cdr %assoc) (push item %cdr-assoc))))))
    (loop for (name . alternatives) in (nreverse grouped-rules)
	  collect `(,name ,@(reverse alternatives)))))
