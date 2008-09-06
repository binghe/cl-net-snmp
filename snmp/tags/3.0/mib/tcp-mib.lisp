;;;; Auto-generated from ASN-SNMP:TCP-MIB

(IN-PACKAGE :ASN.1)
(SETF *CURRENT-MODULE* 'TCP-MIB)
(DEFOID |tcpMIB| (|mib-2| 49))
(DEFOID |tcp| (|mib-2| 6))
(DEFOID |tcpRtoAlgorithm| (|tcp| 1))
(DEFOID |tcpRtoMin| (|tcp| 2))
(DEFOID |tcpRtoMax| (|tcp| 3))
(DEFOID |tcpMaxConn| (|tcp| 4))
(DEFOID |tcpActiveOpens| (|tcp| 5))
(DEFOID |tcpPassiveOpens| (|tcp| 6))
(DEFOID |tcpAttemptFails| (|tcp| 7))
(DEFOID |tcpEstabResets| (|tcp| 8))
(DEFOID |tcpCurrEstab| (|tcp| 9))
(DEFOID |tcpInSegs| (|tcp| 10))
(DEFOID |tcpOutSegs| (|tcp| 11))
(DEFOID |tcpRetransSegs| (|tcp| 12))
(DEFOID |tcpInErrs| (|tcp| 14))
(DEFOID |tcpOutRsts| (|tcp| 15))
(DEFOID |tcpHCInSegs| (|tcp| 17))
(DEFOID |tcpHCOutSegs| (|tcp| 18))
(DEFOID |tcpConnectionTable| (|tcp| 19))
(DEFOID |tcpConnectionEntry| (|tcpConnectionTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |tcpConnectionLocalAddressType| (|tcpConnectionEntry| 1))
(DEFOID |tcpConnectionLocalAddress| (|tcpConnectionEntry| 2))
(DEFOID |tcpConnectionLocalPort| (|tcpConnectionEntry| 3))
(DEFOID |tcpConnectionRemAddressType| (|tcpConnectionEntry| 4))
(DEFOID |tcpConnectionRemAddress| (|tcpConnectionEntry| 5))
(DEFOID |tcpConnectionRemPort| (|tcpConnectionEntry| 6))
(DEFOID |tcpConnectionState| (|tcpConnectionEntry| 7))
(DEFOID |tcpConnectionProcess| (|tcpConnectionEntry| 8))
(DEFOID |tcpListenerTable| (|tcp| 20))
(DEFOID |tcpListenerEntry| (|tcpListenerTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |tcpListenerLocalAddressType| (|tcpListenerEntry| 1))
(DEFOID |tcpListenerLocalAddress| (|tcpListenerEntry| 2))
(DEFOID |tcpListenerLocalPort| (|tcpListenerEntry| 3))
(DEFOID |tcpListenerProcess| (|tcpListenerEntry| 4))
(DEFOID |tcpConnTable| (|tcp| 13))
(DEFOID |tcpConnEntry| (|tcpConnTable| 1))
(DEFUNKNOWN :TYPE-ASSIGNMENT)
(DEFOID |tcpConnState| (|tcpConnEntry| 1))
(DEFOID |tcpConnLocalAddress| (|tcpConnEntry| 2))
(DEFOID |tcpConnLocalPort| (|tcpConnEntry| 3))
(DEFOID |tcpConnRemAddress| (|tcpConnEntry| 4))
(DEFOID |tcpConnRemPort| (|tcpConnEntry| 5))
(DEFOID |tcpMIBConformance| (|tcpMIB| 2))
(DEFOID |tcpMIBCompliances| (|tcpMIBConformance| 1))
(DEFOID |tcpMIBGroups| (|tcpMIBConformance| 2))
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFUNKNOWN 'MODULE-COMPLIANCE)
(DEFOID |tcpGroup| (|tcpMIBGroups| 1))
(DEFOID |tcpBaseGroup| (|tcpMIBGroups| 2))
(DEFOID |tcpConnectionGroup| (|tcpMIBGroups| 3))
(DEFOID |tcpListenerGroup| (|tcpMIBGroups| 4))
(DEFOID |tcpHCGroup| (|tcpMIBGroups| 5))