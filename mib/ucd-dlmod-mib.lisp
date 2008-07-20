;;;; Auto-generated from ASN-SNMP:UCD-DLMOD-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'UCD-DLMOD-MIB)
(DEFOID |ucdDlmodMIB| (|ucdExperimental| 14))
(DEFOID |dlmodNextIndex| (|ucdDlmodMIB| 1))
(DEFOID |dlmodTable| (|ucdDlmodMIB| 2))
(DEFOID |dlmodEntry| (|dlmodTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |dlmodIndex| (|dlmodEntry| 1))
(DEFOID |dlmodName| (|dlmodEntry| 2))
(DEFOID |dlmodPath| (|dlmodEntry| 3))
(DEFOID |dlmodError| (|dlmodEntry| 4))
(DEFOID |dlmodStatus| (|dlmodEntry| 5))
