;;;; Auto-generated from ASN-SNMP:SNMP-VIEW-BASED-ACM-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'SNMP-VIEW-BASED-ACM-MIB)
(DEFOID |snmpVacmMIB| (|snmpModules| 16))
(DEFOID |vacmMIBObjects| (|snmpVacmMIB| 1))
(DEFOID |vacmMIBConformance| (|snmpVacmMIB| 2))
(DEFOID |vacmContextTable| (|vacmMIBObjects| 1))
(DEFOID |vacmContextEntry| (|vacmContextTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |vacmContextName| (|vacmContextEntry| 1))
(DEFOID |vacmSecurityToGroupTable| (|vacmMIBObjects| 2))
(DEFOID |vacmSecurityToGroupEntry| (|vacmSecurityToGroupTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |vacmSecurityModel| (|vacmSecurityToGroupEntry| 1))
(DEFOID |vacmSecurityName| (|vacmSecurityToGroupEntry| 2))
(DEFOID |vacmGroupName| (|vacmSecurityToGroupEntry| 3))
(DEFOID |vacmSecurityToGroupStorageType| (|vacmSecurityToGroupEntry| 4))
(DEFOID |vacmSecurityToGroupStatus| (|vacmSecurityToGroupEntry| 5))
(DEFOID |vacmAccessTable| (|vacmMIBObjects| 4))
(DEFOID |vacmAccessEntry| (|vacmAccessTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |vacmAccessContextPrefix| (|vacmAccessEntry| 1))
(DEFOID |vacmAccessSecurityModel| (|vacmAccessEntry| 2))
(DEFOID |vacmAccessSecurityLevel| (|vacmAccessEntry| 3))
(DEFOID |vacmAccessContextMatch| (|vacmAccessEntry| 4))
(DEFOID |vacmAccessReadViewName| (|vacmAccessEntry| 5))
(DEFOID |vacmAccessWriteViewName| (|vacmAccessEntry| 6))
(DEFOID |vacmAccessNotifyViewName| (|vacmAccessEntry| 7))
(DEFOID |vacmAccessStorageType| (|vacmAccessEntry| 8))
(DEFOID |vacmAccessStatus| (|vacmAccessEntry| 9))
(DEFOID |vacmMIBViews| (|vacmMIBObjects| 5))
(DEFOID |vacmViewSpinLock| (|vacmMIBViews| 1))
(DEFOID |vacmViewTreeFamilyTable| (|vacmMIBViews| 2))
(DEFOID |vacmViewTreeFamilyEntry| (|vacmViewTreeFamilyTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |vacmViewTreeFamilyViewName| (|vacmViewTreeFamilyEntry| 1))
(DEFOID |vacmViewTreeFamilySubtree| (|vacmViewTreeFamilyEntry| 2))
(DEFOID |vacmViewTreeFamilyMask| (|vacmViewTreeFamilyEntry| 3))
(DEFOID |vacmViewTreeFamilyType| (|vacmViewTreeFamilyEntry| 4))
(DEFOID |vacmViewTreeFamilyStorageType| (|vacmViewTreeFamilyEntry| 5))
(DEFOID |vacmViewTreeFamilyStatus| (|vacmViewTreeFamilyEntry| 6))
(DEFOID |vacmMIBCompliances| (|vacmMIBConformance| 1))
(DEFOID |vacmMIBGroups| (|vacmMIBConformance| 2))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |vacmBasicGroup| (|vacmMIBGroups| 1))
