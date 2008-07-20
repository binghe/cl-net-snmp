;;;; Auto-generated from ASN-SNMP:NET-SNMP-VACM-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'NET-SNMP-VACM-MIB)
(DEFOID |netSnmpVacmMIB| (|netSnmpObjects| 9))
(DEFOID |nsVacmAccessTable| (|netSnmpVacmMIB| 1))
(DEFOID |nsVacmAccessEntry| (|nsVacmAccessTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |nsVacmAuthType| (|nsVacmAccessEntry| 1))
(DEFOID |nsVacmContextMatch| (|nsVacmAccessEntry| 2))
(DEFOID |nsVacmViewName| (|nsVacmAccessEntry| 3))
(DEFOID |nsVacmStorageType| (|nsVacmAccessEntry| 4))
(DEFOID |nsVacmStatus| (|nsVacmAccessEntry| 5))
