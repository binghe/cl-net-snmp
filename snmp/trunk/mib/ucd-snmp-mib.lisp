;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:UCD-SNMP-MIB

(in-package :asn.1)
(setf *current-module* 'ucd-snmp-mib)
(defoid |ucdavis| (|enterprises| 2021)
  (:type 'module-identity)
  (:description
   "Clarify behaviour of objects in the memory & systemStats groups
         (including updated versions of malnamed mem*Text objects).
         Define suitable TCs to describe error reporting/fix behaviour."))
(defoid |ucdInternal| (|ucdavis| 12) (:type 'object-identity))
(defoid |ucdExperimental| (|ucdavis| 13) (:type 'object-identity))
(defoid |ucdSnmpAgent| (|ucdavis| 250) (:type 'object-identity))
(defoid |hpux9| (|ucdSnmpAgent| 1) (:type 'object-identity))
(defoid |sunos4| (|ucdSnmpAgent| 2) (:type 'object-identity))
(defoid |solaris| (|ucdSnmpAgent| 3) (:type 'object-identity))
(defoid |osf| (|ucdSnmpAgent| 4) (:type 'object-identity))
(defoid |ultrix| (|ucdSnmpAgent| 5) (:type 'object-identity))
(defoid |hpux10| (|ucdSnmpAgent| 6) (:type 'object-identity))
(defoid |netbsd1| (|ucdSnmpAgent| 7) (:type 'object-identity))
(defoid |freebsd| (|ucdSnmpAgent| 8) (:type 'object-identity))
(defoid |irix| (|ucdSnmpAgent| 9) (:type 'object-identity))
(defoid |linux| (|ucdSnmpAgent| 10) (:type 'object-identity))
(defoid |bsdi| (|ucdSnmpAgent| 11) (:type 'object-identity))
(defoid |openbsd| (|ucdSnmpAgent| 12) (:type 'object-identity))
(defoid |win32| (|ucdSnmpAgent| 13) (:type 'object-identity))
(defoid |hpux11| (|ucdSnmpAgent| 14) (:type 'object-identity))
(defoid |unknown| (|ucdSnmpAgent| 255) (:type 'object-identity))
(deftype |Float| () 't)
(deftype |UCDErrorFlag| () 't)
(deftype |UCDErrorFix| () 't)
(defoid |prTable| (|ucdavis| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information on running
	 programs/daemons configured for monitoring in the
	 snmpd.conf file of the agent.  Processes violating the
	 number of running processes required by the agent's
	 configuration file are flagged with numerical and
	 textual errors."))
(defoid |prEntry| (|prTable| 1)
  (:type 'object-type)
  (:syntax '|PrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a process and its statistics."))
(deftype |PrEntry| () 't)
(defoid |prIndex| (|prEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Reference Index for each observed process."))
(defoid |prNames| (|prEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The process name we're counting/checking on."))
(defoid |prMin| (|prEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum number of processes that should be
	 running.  An error flag is generated if the number of
	 running processes is < the minimum."))
(defoid |prMax| (|prEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of processes that should be
	 running.  An error flag is generated if the number of
	 running processes is > the maximum."))
(defoid |prCount| (|prEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of current processes running with the name
	 in question."))
(defoid |prErrorFlag| (|prEntry| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A Error flag to indicate trouble with a process.  It
	 goes to 1 if there is an error, 0 if no error."))
(defoid |prErrMessage| (|prEntry| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An error message describing the problem (if one exists)."))
(defoid |prErrFix| (|prEntry| 102)
  (:type 'object-type)
  (:syntax '|UCDErrorFix|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Setting this to one will try to fix the problem if
	 the agent has been configured with a script to call
	 to attempt to fix problems automatically using remote
	 snmp operations."))
(defoid |prErrFixCmd| (|prEntry| 103)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The command that gets run when the prErrFix column is 
	 set to 1."))
(defoid |extTable| (|ucdavis| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table of extensible commands returning output and
	 result codes.  These commands are configured via the
	 agent's snmpd.conf file."))
(defoid |extEntry| (|extTable| 1)
  (:type 'object-type)
  (:syntax '|ExtEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing an extensible script/program and its output."))
(deftype |ExtEntry| () 't)
(defoid |extIndex| (|extEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reference Index for extensible scripts.  Simply an
	 integer row number."))
(defoid |extNames| (|extEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A Short, one name description of the extensible command."))
(defoid |extCommand| (|extEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The command line to be executed."))
(defoid |extResult| (|extEntry| 100)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The result code (exit status) from the executed command."))
(defoid |extOutput| (|extEntry| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The first line of output of the executed command."))
(defoid |extErrFix| (|extEntry| 102)
  (:type 'object-type)
  (:syntax '|UCDErrorFix|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Setting this to one will try to fix the problem if
	 the agent has been configured with a script to call
	 to attempt to fix problems automatically using remote
	 snmp operations."))
(defoid |extErrFixCmd| (|extEntry| 103)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The command that gets run when the extErrFix column is 
	 set to 1."))
(defoid |memory| (|ucdavis| 4) (:type 'object-identity))
(defoid |memIndex| (|memory| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Bogus Index.  This should always return the integer 0."))
(defoid |memErrorName| (|memory| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Bogus Name. This should always return the string 'swap'."))
(defoid |memTotalSwap| (|memory| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of swap space configured for this host."))
(defoid |memAvailSwap| (|memory| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of swap space currently unused or available."))
(defoid |memTotalReal| (|memory| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of real/physical memory installed
         on this host."))
(defoid |memAvailReal| (|memory| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of real/physical memory currently unused
         or available."))
(defoid |memTotalSwapTXT| (|memory| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of swap space or virtual memory allocated
         for text pages on this host.

         This object will not be implemented on hosts where the
         underlying operating system does not distinguish text
         pages from other uses of swap space or virtual memory."))
(defoid |memAvailSwapTXT| (|memory| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The amount of swap space or virtual memory currently
         being used by text pages on this host.

         This object will not be implemented on hosts where the
         underlying operating system does not distinguish text
         pages from other uses of swap space or virtual memory.

         Note that (despite the name), this value reports the
         amount used, rather than the amount free or available
         for use.  For clarity, this object is being deprecated
         in favour of 'memUsedSwapTXT(16)."))
(defoid |memTotalRealTXT| (|memory| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of real/physical memory allocated
         for text pages on this host.

         This object will not be implemented on hosts where the
         underlying operating system does not distinguish text
         pages from other uses of physical memory."))
(defoid |memAvailRealTXT| (|memory| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The amount of real/physical memory currently being
         used by text pages on this host.

         This object will not be implemented on hosts where the
         underlying operating system does not distinguish text
         pages from other uses of physical memory.

         Note that (despite the name), this value reports the
         amount used, rather than the amount free or available
         for use.  For clarity, this object is being deprecated
         in favour of 'memUsedRealTXT(17)."))
(defoid |memTotalFree| (|memory| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of memory free or available for use on
         this host.  This value typically covers both real memory
         and swap space or virtual memory."))
(defoid |memMinimumSwap| (|memory| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The minimum amount of swap space expected to be kept
         free or available during normal operation of this host.

         If this value (as reported by 'memAvailSwap(4)') falls
         below the specified level, then 'memSwapError(100)' will
         be set to 1 and an error message made available via
         'memSwapErrorMsg(101)'."))
(defoid |memShared| (|memory| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of real or virtual memory currently
         allocated for use as shared memory.

         This object will not be implemented on hosts where the
         underlying operating system does not explicitly identify
         memory as specifically reserved for this purpose."))
(defoid |memBuffer| (|memory| 14)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of real or virtual memory currently
         allocated for use as memory buffers.

         This object will not be implemented on hosts where the
         underlying operating system does not explicitly identify
         memory as specifically reserved for this purpose."))
(defoid |memCached| (|memory| 15)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total amount of real or virtual memory currently
         allocated for use as cached memory.

         This object will not be implemented on hosts where the
         underlying operating system does not explicitly identify
         memory as specifically reserved for this purpose."))
(defoid |memUsedSwapTXT| (|memory| 16)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of swap space or virtual memory currently
         being used by text pages on this host.

         This object will not be implemented on hosts where the
         underlying operating system does not distinguish text
         pages from other uses of swap space or virtual memory."))
(defoid |memUsedRealTXT| (|memory| 17)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The amount of real/physical memory currently being
         used by text pages on this host.

         This object will not be implemented on hosts where the
         underlying operating system does not distinguish text
         pages from other uses of physical memory."))
(defoid |memSwapError| (|memory| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Indicates whether the amount of available swap space
         (as reported by 'memAvailSwap(4)'), is less than the
         desired minimum (specified by 'memMinimumSwap(12)')."))
(defoid |memSwapErrorMsg| (|memory| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Describes whether the amount of available swap space
         (as reported by 'memAvailSwap(4)'), is less than the
         desired minimum (specified by 'memMinimumSwap(12)')."))
(defoid |dskTable| (|ucdavis| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Disk watching information.  Partions to be watched
	 are configured by the snmpd.conf file of the agent."))
(defoid |dskEntry| (|dskTable| 1)
  (:type 'object-type)
  (:syntax '|DskEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a disk and its statistics."))
(deftype |DskEntry| () 't)
(defoid |dskIndex| (|dskEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Integer reference number (row number) for the disk mib."))
(defoid |dskPath| (|dskEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Path where the disk is mounted."))
(defoid |dskDevice| (|dskEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Path of the device for the partition"))
(defoid |dskMinimum| (|dskEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Minimum space required on the disk (in kBytes) before the
         errors are triggered.  Either this or dskMinPercent is
         configured via the agent's snmpd.conf file."))
(defoid |dskMinPercent| (|dskEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Percentage of minimum space required on the disk before the
         errors are triggered.  Either this or dskMinimum is
         configured via the agent's snmpd.conf file."))
(defoid |dskTotal| (|dskEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Total size of the disk/partion (kBytes)"))
(defoid |dskAvail| (|dskEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Available space on the disk"))
(defoid |dskUsed| (|dskEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Used space on the disk"))
(defoid |dskPercent| (|dskEntry| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Percentage of space used on disk"))
(defoid |dskPercentNode| (|dskEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Percentage of inodes used on disk"))
(defoid |dskErrorFlag| (|dskEntry| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Error flag signaling that the disk or partition is under
	 the minimum required space configured for it."))
(defoid |dskErrorMsg| (|dskEntry| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A text description providing a warning and the space left
	 on the disk."))
(defoid |laTable| (|ucdavis| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Load average information."))
(defoid |laEntry| (|laTable| 1)
  (:type 'object-type)
  (:syntax '|LaEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a load average and its values."))
(deftype |LaEntry| () 't)
(defoid |laIndex| (|laEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "reference index/row number for each observed loadave."))
(defoid |laNames| (|laEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The list of loadave names we're watching."))
(defoid |laLoad| (|laEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The 1,5 and 15 minute load averages (one per row)."))
(defoid |laConfig| (|laEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The watch point for load-averages to signal an
	 error.  If the load averages rises above this value,
	 the laErrorFlag below is set."))
(defoid |laLoadInt| (|laEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 1,5 and 15 minute load averages as an integer.
	 This is computed by taking the floating point
	 loadaverage value and multiplying by 100, then
	 converting the value to an integer."))
(defoid |laLoadFloat| (|laEntry| 6)
  (:type 'object-type)
  (:syntax '|Float|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The 1,5 and 15 minute load averages as an opaquely
	 wrapped floating point number."))
(defoid |laErrorFlag| (|laEntry| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A Error flag to indicate the load-average has crossed
	 its threshold value defined in the snmpd.conf file.
	 It is set to 1 if the threshold is crossed, 0 otherwise."))
(defoid |laErrMessage| (|laEntry| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An error message describing the load-average and its
	 surpased watch-point value."))
(defoid |version| (|ucdavis| 100) (:type 'object-identity))
(defoid |versionIndex| (|version| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Index to mib (always 0)"))
(defoid |versionTag| (|version| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "CVS tag keyword"))
(defoid |versionDate| (|version| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Date string from RCS keyword"))
(defoid |versionCDate| (|version| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Date string from ctime() "))
(defoid |versionIdent| (|version| 5)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Id string from RCS keyword"))
(defoid |versionConfigureOptions| (|version| 6)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Options passed to the configure script when this agent was built."))
(defoid |versionClearCache| (|version| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "Set to 1 to clear the exec cache, if enabled"))
(defoid |versionUpdateConfig| (|version| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "Set to 1 to read-read the config file(s)."))
(defoid |versionRestartAgent| (|version| 12)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description "Set to 1 to restart the agent."))
(defoid |versionSavePersistentData| (|version| 13)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Set to 1 to force the agent to save it's persistent data immediately."))
(defoid |versionDoDebugging| (|version| 20)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "Set to 1 to turn debugging statements on in the agent or 0
	 to turn it off."))
(defoid |snmperrs| (|ucdavis| 101) (:type 'object-identity))
(defoid |snmperrIndex| (|snmperrs| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Bogus Index for snmperrs (always 0)."))
(defoid |snmperrNames| (|snmperrs| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "snmp"))
(defoid |snmperrErrorFlag| (|snmperrs| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A Error flag to indicate trouble with the agent.  It
	 goes to 1 if there is an error, 0 if no error."))
(defoid |snmperrErrMessage| (|snmperrs| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An error message describing the problem (if one exists)."))
(defoid |mrTable| (|ucdavis| 102)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table displaying all the oid's registered by mib modules in
	 the agent.  Since the agent is modular in nature, this lists
	 each module's OID it is responsible for and the name of the module"))
(defoid |mrEntry| (|mrTable| 1)
  (:type 'object-type)
  (:syntax '|MrEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a registered mib oid."))
(deftype |MrEntry| () 't)
(defoid |mrIndex| (|mrEntry| 1)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The registry slot of a mibmodule."))
(defoid |mrModuleName| (|mrEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The module name that registered this OID."))
(defoid |systemStats| (|ucdavis| 11) (:type 'object-identity))
(defoid |ssIndex| (|systemStats| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Bogus Index.  This should always return the integer 1."))
(defoid |ssErrorName| (|systemStats| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Bogus Name. This should always return the string 'systemStats'."))
(defoid |ssSwapIn| (|systemStats| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The average amount of memory swapped in from disk,
         calculated over the last minute."))
(defoid |ssSwapOut| (|systemStats| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The average amount of memory swapped out to disk,
         calculated over the last minute."))
(defoid |ssIOSent| (|systemStats| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The average amount of data written to disk or other
         block device, calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssIORawSent(57)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssIOReceive| (|systemStats| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The average amount of data read from disk or other
         block device, calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssIORawReceived(58)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssSysInterrupts| (|systemStats| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The average rate of interrupts processed (including
         the clock) calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssRawInterrupts(59)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssSysContext| (|systemStats| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The average rate of context switches,
         calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssRawContext(60)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssCpuUser| (|systemStats| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The percentage of CPU time spent processing
         user-level code, calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssCpuRawUser(50)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssCpuSystem| (|systemStats| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The percentage of CPU time spent processing
         system-level code, calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssCpuRawSystem(52)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssCpuIdle| (|systemStats| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|deprecated|)
  (:description
   "The percentage of processor time spent idle,
         calculated over the last minute.
       
	 This object has been deprecated in favour of
         'ssCpuRawIdle(53)', which can be used to calculate
         the same metric, but over any desired time period."))
(defoid |ssCpuRawUser| (|systemStats| 50)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         processing user-level code.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssCpuRawNice| (|systemStats| 51)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         processing reduced-priority code.

         This object will not be implemented on hosts where
         the underlying operating system does not measure
         this particular CPU metric.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssCpuRawSystem| (|systemStats| 52)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         processing system-level code.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors).

         This object may sometimes be implemented as the
         combination of the 'ssCpuRawWait(54)' and
         'ssCpuRawKernel(55)' counters, so care must be
         taken when summing the overall raw counters."))
(defoid |ssCpuRawIdle| (|systemStats| 53)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         idle.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssCpuRawWait| (|systemStats| 54)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         waiting for IO.

         This object will not be implemented on hosts where
         the underlying operating system does not measure
         this particular CPU metric.  This time may also be
         included within the 'ssCpuRawSystem(52)' counter.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssCpuRawKernel| (|systemStats| 55)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         processing kernel-level code.

         This object will not be implemented on hosts where
         the underlying operating system does not measure
         this particular CPU metric.  This time may also be
         included within the 'ssCpuRawSystem(52)' counter.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssCpuRawInterrupt| (|systemStats| 56)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         processing hardware interrupts.

         This object will not be implemented on hosts where
         the underlying operating system does not measure
         this particular CPU metric.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssIORawSent| (|systemStats| 57)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of blocks sent to a block device"))
(defoid |ssIORawReceived| (|systemStats| 58)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of blocks received from a block device"))
(defoid |ssRawInterrupts| (|systemStats| 59)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of interrupts processed"))
(defoid |ssRawContexts| (|systemStats| 60)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of context switches"))
(defoid |ssCpuRawSoftIRQ| (|systemStats| 61)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of 'ticks' (typically 1/100s) spent
         processing software interrupts.

         This object will not be implemented on hosts where
         the underlying operating system does not measure
         this particular CPU metric.

         On a multi-processor system, the 'ssCpuRaw*'
         counters are cumulative over all CPUs, so their
         sum will typically be N*100 (for N processors)."))
(defoid |ssRawSwapIn| (|systemStats| 62)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of blocks swapped in"))
(defoid |ssRawSwapOut| (|systemStats| 63)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of blocks swapped out"))
(defoid |ucdTraps| (|ucdavis| 251) (:type 'object-identity))
(defoid |ucdStart| (|ucdTraps| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This trap could in principle be sent when the agent start"))
(defoid |ucdShutdown| (|ucdTraps| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description "This trap is sent when the agent terminates"))
(defoid |fileTable| (|ucdavis| 15)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Table of monitored files."))
(defoid |fileEntry| (|fileTable| 1)
  (:type 'object-type)
  (:syntax '|FileEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Entry of file"))
(deftype |FileEntry| () 't)
(defoid |fileIndex| (|fileEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Index of file"))
(defoid |fileName| (|fileEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Filename"))
(defoid |fileSize| (|fileEntry| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Size of file (kB)"))
(defoid |fileMax| (|fileEntry| 4)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Limit of filesize (kB)"))
(defoid |fileErrorFlag| (|fileEntry| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Limit exceeded flag"))
(defoid |fileErrorMsg| (|fileEntry| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Filesize error message"))
(defoid |logMatch| (|ucdavis| 16) (:type 'object-identity))
(defoid |logMatchMaxEntries| (|logMatch| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The maximum number of logmatch entries
		this snmpd daemon can support."))
(defoid |logMatchTable| (|logMatch| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Table of monitored files."))
(defoid |logMatchEntry| (|logMatchTable| 1)
  (:type 'object-type)
  (:syntax '|LogMatchEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Entry of file"))
(deftype |LogMatchEntry| () 't)
(defoid |logMatchIndex| (|logMatchEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Index of logmatch"))
(defoid |logMatchName| (|logMatchEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "logmatch instance name"))
(defoid |logMatchFilename| (|logMatchEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "filename to be logmatched"))
(defoid |logMatchRegEx| (|logMatchEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "regular expression"))
(defoid |logMatchGlobalCounter| (|logMatchEntry| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "global count of matches"))
(defoid |logMatchGlobalCount| (|logMatchEntry| 6)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Description."))
(defoid |logMatchCurrentCounter| (|logMatchEntry| 7)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Regex match counter. This counter will
		be reset with each logfile rotation."))
(defoid |logMatchCurrentCount| (|logMatchEntry| 8)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Description."))
(defoid |logMatchCounter| (|logMatchEntry| 9)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Regex match counter. This counter will
		be reset with each read"))
(defoid |logMatchCount| (|logMatchEntry| 10)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Description."))
(defoid |logMatchCycle| (|logMatchEntry| 11)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "time between updates (if not queried) in seconds"))
(defoid |logMatchErrorFlag| (|logMatchEntry| 100)
  (:type 'object-type)
  (:syntax '|UCDErrorFlag|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "errorflag: is this line configured correctly?"))
(defoid |logMatchRegExCompilation| (|logMatchEntry| 101)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "message of regex precompilation"))
