;;;; Auto-generated from ASN-SNMP:UCD-SNMP-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'UCD-SNMP-MIB)
(DEFOID |ucdavis| (|enterprises| 2021))
(DEFOID |ucdInternal| (|ucdavis| 12))
(DEFOID |ucdExperimental| (|ucdavis| 13))
(DEFOID |ucdSnmpAgent| (|ucdavis| 250))
(DEFOID |hpux9| (|ucdSnmpAgent| 1))
(DEFOID |sunos4| (|ucdSnmpAgent| 2))
(DEFOID |solaris| (|ucdSnmpAgent| 3))
(DEFOID |osf| (|ucdSnmpAgent| 4))
(DEFOID |ultrix| (|ucdSnmpAgent| 5))
(DEFOID |hpux10| (|ucdSnmpAgent| 6))
(DEFOID |netbsd1| (|ucdSnmpAgent| 7))
(DEFOID |freebsd| (|ucdSnmpAgent| 8))
(DEFOID |irix| (|ucdSnmpAgent| 9))
(DEFOID |linux| (|ucdSnmpAgent| 10))
(DEFOID |bsdi| (|ucdSnmpAgent| 11))
(DEFOID |openbsd| (|ucdSnmpAgent| 12))
(DEFOID |win32| (|ucdSnmpAgent| 13))
(DEFOID |hpux11| (|ucdSnmpAgent| 14))
(DEFOID |unknown| (|ucdSnmpAgent| 255))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |prTable| (|ucdavis| 2))
(DEFOID |prEntry| (|prTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |prIndex| (|prEntry| 1))
(DEFOID |prNames| (|prEntry| 2))
(DEFOID |prMin| (|prEntry| 3))
(DEFOID |prMax| (|prEntry| 4))
(DEFOID |prCount| (|prEntry| 5))
(DEFOID |prErrorFlag| (|prEntry| 100))
(DEFOID |prErrMessage| (|prEntry| 101))
(DEFOID |prErrFix| (|prEntry| 102))
(DEFOID |prErrFixCmd| (|prEntry| 103))
(DEFOID |extTable| (|ucdavis| 8))
(DEFOID |extEntry| (|extTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |extIndex| (|extEntry| 1))
(DEFOID |extNames| (|extEntry| 2))
(DEFOID |extCommand| (|extEntry| 3))
(DEFOID |extResult| (|extEntry| 100))
(DEFOID |extOutput| (|extEntry| 101))
(DEFOID |extErrFix| (|extEntry| 102))
(DEFOID |extErrFixCmd| (|extEntry| 103))
(DEFOID |memory| (|ucdavis| 4))
(DEFOID |memIndex| (|memory| 1))
(DEFOID |memErrorName| (|memory| 2))
(DEFOID |memTotalSwap| (|memory| 3))
(DEFOID |memAvailSwap| (|memory| 4))
(DEFOID |memTotalReal| (|memory| 5))
(DEFOID |memAvailReal| (|memory| 6))
(DEFOID |memTotalSwapTXT| (|memory| 7))
(DEFOID |memAvailSwapTXT| (|memory| 8))
(DEFOID |memTotalRealTXT| (|memory| 9))
(DEFOID |memAvailRealTXT| (|memory| 10))
(DEFOID |memTotalFree| (|memory| 11))
(DEFOID |memMinimumSwap| (|memory| 12))
(DEFOID |memShared| (|memory| 13))
(DEFOID |memBuffer| (|memory| 14))
(DEFOID |memCached| (|memory| 15))
(DEFOID |memUsedSwapTXT| (|memory| 16))
(DEFOID |memUsedRealTXT| (|memory| 17))
(DEFOID |memSwapError| (|memory| 100))
(DEFOID |memSwapErrorMsg| (|memory| 101))
(DEFOID |dskTable| (|ucdavis| 9))
(DEFOID |dskEntry| (|dskTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dskIndex| (|dskEntry| 1))
(DEFOID |dskPath| (|dskEntry| 2))
(DEFOID |dskDevice| (|dskEntry| 3))
(DEFOID |dskMinimum| (|dskEntry| 4))
(DEFOID |dskMinPercent| (|dskEntry| 5))
(DEFOID |dskTotal| (|dskEntry| 6))
(DEFOID |dskAvail| (|dskEntry| 7))
(DEFOID |dskUsed| (|dskEntry| 8))
(DEFOID |dskPercent| (|dskEntry| 9))
(DEFOID |dskPercentNode| (|dskEntry| 10))
(DEFOID |dskErrorFlag| (|dskEntry| 100))
(DEFOID |dskErrorMsg| (|dskEntry| 101))
(DEFOID |laTable| (|ucdavis| 10))
(DEFOID |laEntry| (|laTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |laIndex| (|laEntry| 1))
(DEFOID |laNames| (|laEntry| 2))
(DEFOID |laLoad| (|laEntry| 3))
(DEFOID |laConfig| (|laEntry| 4))
(DEFOID |laLoadInt| (|laEntry| 5))
(DEFOID |laLoadFloat| (|laEntry| 6))
(DEFOID |laErrorFlag| (|laEntry| 100))
(DEFOID |laErrMessage| (|laEntry| 101))
(DEFOID |version| (|ucdavis| 100))
(DEFOID |versionIndex| (|version| 1))
(DEFOID |versionTag| (|version| 2))
(DEFOID |versionDate| (|version| 3))
(DEFOID |versionCDate| (|version| 4))
(DEFOID |versionIdent| (|version| 5))
(DEFOID |versionConfigureOptions| (|version| 6))
(DEFOID |versionClearCache| (|version| 10))
(DEFOID |versionUpdateConfig| (|version| 11))
(DEFOID |versionRestartAgent| (|version| 12))
(DEFOID |versionSavePersistentData| (|version| 13))
(DEFOID |versionDoDebugging| (|version| 20))
(DEFOID |snmperrs| (|ucdavis| 101))
(DEFOID |snmperrIndex| (|snmperrs| 1))
(DEFOID |snmperrNames| (|snmperrs| 2))
(DEFOID |snmperrErrorFlag| (|snmperrs| 100))
(DEFOID |snmperrErrMessage| (|snmperrs| 101))
(DEFOID |mrTable| (|ucdavis| 102))
(DEFOID |mrEntry| (|mrTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |mrIndex| (|mrEntry| 1))
(DEFOID |mrModuleName| (|mrEntry| 2))
(DEFOID |systemStats| (|ucdavis| 11))
(DEFOID |ssIndex| (|systemStats| 1))
(DEFOID |ssErrorName| (|systemStats| 2))
(DEFOID |ssSwapIn| (|systemStats| 3))
(DEFOID |ssSwapOut| (|systemStats| 4))
(DEFOID |ssIOSent| (|systemStats| 5))
(DEFOID |ssIOReceive| (|systemStats| 6))
(DEFOID |ssSysInterrupts| (|systemStats| 7))
(DEFOID |ssSysContext| (|systemStats| 8))
(DEFOID |ssCpuUser| (|systemStats| 9))
(DEFOID |ssCpuSystem| (|systemStats| 10))
(DEFOID |ssCpuIdle| (|systemStats| 11))
(DEFOID |ssCpuRawUser| (|systemStats| 50))
(DEFOID |ssCpuRawNice| (|systemStats| 51))
(DEFOID |ssCpuRawSystem| (|systemStats| 52))
(DEFOID |ssCpuRawIdle| (|systemStats| 53))
(DEFOID |ssCpuRawWait| (|systemStats| 54))
(DEFOID |ssCpuRawKernel| (|systemStats| 55))
(DEFOID |ssCpuRawInterrupt| (|systemStats| 56))
(DEFOID |ssIORawSent| (|systemStats| 57))
(DEFOID |ssIORawReceived| (|systemStats| 58))
(DEFOID |ssRawInterrupts| (|systemStats| 59))
(DEFOID |ssRawContexts| (|systemStats| 60))
(DEFOID |ssCpuRawSoftIRQ| (|systemStats| 61))
(DEFOID |ssRawSwapIn| (|systemStats| 62))
(DEFOID |ssRawSwapOut| (|systemStats| 63))
(DEFOID |ucdTraps| (|ucdavis| 251))
(DEFOID |ucdStart| (|ucdTraps| 1))
(DEFOID |ucdShutdown| (|ucdTraps| 2))
(DEFOID |fileTable| (|ucdavis| 15))
(DEFOID |fileEntry| (|fileTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |fileIndex| (|fileEntry| 1))
(DEFOID |fileName| (|fileEntry| 2))
(DEFOID |fileSize| (|fileEntry| 3))
(DEFOID |fileMax| (|fileEntry| 4))
(DEFOID |fileErrorFlag| (|fileEntry| 100))
(DEFOID |fileErrorMsg| (|fileEntry| 101))
(DEFOID |logMatch| (|ucdavis| 16))
(DEFOID |logMatchMaxEntries| (|logMatch| 1))
(DEFOID |logMatchTable| (|logMatch| 2))
(DEFOID |logMatchEntry| (|logMatchTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |logMatchIndex| (|logMatchEntry| 1))
(DEFOID |logMatchName| (|logMatchEntry| 2))
(DEFOID |logMatchFilename| (|logMatchEntry| 3))
(DEFOID |logMatchRegEx| (|logMatchEntry| 4))
(DEFOID |logMatchGlobalCounter| (|logMatchEntry| 5))
(DEFOID |logMatchGlobalCount| (|logMatchEntry| 6))
(DEFOID |logMatchCurrentCounter| (|logMatchEntry| 7))
(DEFOID |logMatchCurrentCount| (|logMatchEntry| 8))
(DEFOID |logMatchCounter| (|logMatchEntry| 9))
(DEFOID |logMatchCount| (|logMatchEntry| 10))
(DEFOID |logMatchCycle| (|logMatchEntry| 11))
(DEFOID |logMatchErrorFlag| (|logMatchEntry| 100))
(DEFOID |logMatchRegExCompilation| (|logMatchEntry| 101))