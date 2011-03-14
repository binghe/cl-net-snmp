;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asn.1)

#+snmp-system::parsergen
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "parsergen"))

#+snmp-system::parsergen
(macrolet ((define-parser (name syntax)
             `(parsergen:defparser ,name ,@syntax)))
  (define-parser asn.1-parser #.*asn.1-syntax*))

#+snmp-system::cl-yacc
(macrolet ((define-parser (name reserved-words start-symbol syntax)
             `(snmp.yacc:define-parser ,name
                (:terminals ,reserved-words)
                (:start-symbol ,start-symbol)
                ,@syntax)))
  (define-parser *asn.1-parser*
                 #.(list* :id :number :string *reserved-words*)
                 %module-definition
                 #.(defparser-to-yacc *asn.1-syntax*)))

(defun asn.1-lexer (stream)
  (let ((*readtable* *asn.1-readtable*)
        (*package* (find-package :asn.1)))
    (let ((token (read stream nil nil nil)))
      (when token
        (values (detect-token token) token)))))

(defgeneric detect-token (token))

(defmethod detect-token ((token number))
  :number)

(defmethod detect-token ((token symbol))
  (gethash token *reserved-words-table* :id))

(defmethod detect-token ((token string))
  :string)

(defgeneric parse (source))

(defmethod parse ((source string))
  (with-input-from-string (s source)
    (parse s)))

(defmethod parse ((source pathname))
  (with-open-file (s source :direction :input)
    (parse s)))

(defmethod parse ((source stream))
  #+snmp-system::parsergen
  (asn.1-parser #'(lambda () (asn.1-lexer source)))
  #+snmp-system::cl-yacc
  (snmp.yacc:parse-with-lexer #'(lambda () (asn.1-lexer source))
                              *asn.1-parser*)
  (error "No parser defined in features.lisp-expr"))

(defmethod parse ((source t))
  (error "Unknown source"))
