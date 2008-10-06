;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;NET-SNMP-EXTEND-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'net-snmp-extend-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'net-snmp-extend-mib *mib-modules*))
(defoid |netSnmpExtendMIB| (|nsExtensions| 1)
  (:type 'module-identity)
  (:description
   "Defines a framework for scripted extensions for the Net-SNMP agent."))
(defoid |nsExtendObjects| (|nsExtensions| 2) (:type 'object-identity))
(defoid |nsExtendGroups| (|nsExtensions| 3) (:type 'object-identity))
(defoid |nsExtendNumEntries| (|nsExtendObjects| 1)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The number of rows in the nsExtendConfigTable"))
(defoid |nsExtendConfigTable| (|nsExtendObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of scripted extensions - configuration and (basic) output."))
(defoid |nsExtendConfigEntry| (|nsExtendConfigTable| 1)
  (:type 'object-type)
  (:syntax '|NsExtendConfigEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row within the extension table."))
(deftype |NsExtendConfigEntry| () 't)
(defoid |nsExtendToken| (|nsExtendConfigEntry| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An arbitrary token to identify this extension entry"))
(defoid |nsExtendCommand| (|nsExtendConfigEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The full path of the command binary (or script) to run"))
(defoid |nsExtendArgs| (|nsExtendConfigEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "Any command-line arguments for the command"))
(defoid |nsExtendInput| (|nsExtendConfigEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The standard input for the command"))
(defoid |nsExtendCacheTime| (|nsExtendConfigEntry| 5)
  (:type 'object-type)
  (:syntax ':integer)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The length of time for which the output of
       this command will be cached.  During this time,
       retrieving the output-related values will not
       reinvoke the command.
       A value of -1 indicates that the output results
       should not be cached at all, and retrieving each
       individual output-related value will invoke the
       command afresh."))
(defoid |nsExtendExecType| (|nsExtendConfigEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The mechanism used to invoke the command."))
(defoid |nsExtendRunType| (|nsExtendConfigEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Used to implement 'push-button' command invocation.
       The command for a 'run-on-read' entry will be invoked
       whenever one of the corresponding output-related
       instances is requested (and assuming the cached value
       is not still current).
       The command for a 'run-on-set' entry will only be invoked
       on receipt of a SET assignment for this object with the
       value 'run-command'.
       Reading an instance of this object will always return either
       'run-on-read' or 'run-on-set'.
      "))
(defoid |nsExtendStorage| (|nsExtendConfigEntry| 20)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "The storage type for this conceptual row."))
(defoid |nsExtendStatus| (|nsExtendConfigEntry| 21)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Used to create new rows in the table, in the standard manner.
       Note that is valid for an instance to be left with the value
       notInService(2) indefinitely - i.e. the meaning of 'abnormally
       long' (see RFC 2579, RowStatus) for this table is infinite."))
(defoid |nsExtendOutput1Table| (|nsExtendObjects| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of scripted extensions - configuration and (basic) output."))
(defoid |nsExtendOutput1Entry| (|nsExtendOutput1Table| 1)
  (:type 'object-type)
  (:syntax '|NsExtendOutput1Entry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row within the extension table."))
(deftype |NsExtendOutput1Entry| () 't)
(defoid |nsExtendOutput1Line| (|nsExtendOutput1Entry| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The first line of output from the command"))
(defoid |nsExtendOutputFull| (|nsExtendOutput1Entry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The full output from the command, as a single string"))
(defoid |nsExtendOutNumLines| (|nsExtendOutput1Entry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of lines of output (and hence
       the number of rows in nsExtendOutputTable
       relating to this particular entry)."))
(defoid |nsExtendResult| (|nsExtendOutput1Entry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The return value of the command."))
(defoid |nsExtendOutput2Table| (|nsExtendObjects| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of (line-based) output from scripted extensions."))
(defoid |nsExtendOutput2Entry| (|nsExtendOutput2Table| 1)
  (:type 'object-type)
  (:syntax '|NsExtendOutput2Entry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A conceptual row within the line-based output table."))
(deftype |NsExtendOutput2Entry| () 't)
(defoid |nsExtendLineIndex| (|nsExtendOutput2Entry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The index of this line of output.
       For a given nsExtendToken, this will run from
       1 to the corresponding value of nsExtendNumLines."))
(defoid |nsExtendOutLine| (|nsExtendOutput2Entry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "A single line of output from the extension command."))
(defoid |nsExtendConfigGroup| (|nsExtendGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Objects relating to the configuration of extension commands."))
(defoid |nsExtendOutputGroup| (|nsExtendGroups| 2)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "Objects relating to the output of extension commands."))
