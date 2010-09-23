;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:BASE;AIRPORT-BASESTATION-3-MIB.TXT by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'airport-basestation-3-mib))

(defpackage :asn.1/airport-basestation-3-mib
  (:nicknames :airport-basestation-3-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| |enterprises| module-identity
                object-type |IpAddress|)
  (:import-from :asn.1/rfc1213-mib |PhysAddress|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|))

(in-package :airport-basestation-3-mib)

(defoid |apple| (|enterprises| 63) (:type 'object-identity))

(defoid |airport| (|apple| 501) (:type 'object-identity))

(defoid |baseStation3| (|airport| 3)
  (:type 'module-identity)
  (:description
   "Management information base in SMI v2 for the AirPort and AirPort Extreme Base Station (v3)."))

(defoid |abs3SysConf| (|baseStation3| 1) (:type 'object-identity))

(defoid |sysConfName| (|abs3SysConf| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Configured name of the AirPort Base Station."))

(defoid |sysConfContact| (|abs3SysConf| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Configured name of the contact for the AirPort Base Station."))

(defoid |sysConfLocation| (|abs3SysConf| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Configured name of where the AirPort Base Station is located."))

(defoid |sysConfUptime| (|abs3SysConf| 4)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Length of time, in seconds, the AirPort Base Station has been running."))

(defoid |sysConfFirmwareVersion| (|abs3SysConf| 5)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Current firmware revision running on the AirPort Base Station."))

(defoid |wireless| (|baseStation3| 2) (:type 'object-identity))

(defoid |wirelessNumber| (|wireless| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of wireless clients associated with this AP."))

(defoid |wirelessClientsTable| (|wireless| 2)
  (:type 'object-type)
  (:syntax '(vector |WirelessClient|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of wireless clients."))

(defoid |wirelessClient| (|wirelessClientsTable| 1)
  (:type 'object-type)
  (:syntax '|WirelessClient|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A wireless client entry containing information about the client."))

(defclass |WirelessClient|
          (sequence-type)
          ((|wirelessPhysAddress| :type |PhysAddress|)
           (|wirelessType| :type integer)
           (|wirelessDataRates| :type |DisplayString|)
           (|wirelessTimeAssociated| :type integer)
           (|wirelessLastRefreshTime| :type integer)
           (|wirelessStrength| :type integer)
           (|wirelessNoise| :type integer)
           (|wirelessRate| :type integer)
           (|wirelessNumRX| :type integer)
           (|wirelessNumTX| :type integer)
           (|wirelessNumRXErrors| :type integer)
           (|wirelessNumTXErrors| :type integer)))

(defoid |wirelessPhysAddress| (|wirelessClient| 1)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The MAC address of the wireless client."))

(defoid |wirelessType| (|wirelessClient| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The type of wireless client node."))

(defoid |wirelessDataRates| (|wirelessClient| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The data rates available for the wireless client."))

(defoid |wirelessTimeAssociated| (|wirelessClient| 4)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The time that this wireless client associated."))

(defoid |wirelessLastRefreshTime| (|wirelessClient| 5)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of seconds since the client reported its statistics to the AirPort Base Station (-1 if never refreshed or not supported)."))

(defoid |wirelessStrength| (|wirelessClient| 6)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The signal strength reported by the wireless client (-1 if not supported)."))

(defoid |wirelessNoise| (|wirelessClient| 7)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The noise reported by the wireless client (-1 if not supported)."))

(defoid |wirelessRate| (|wirelessClient| 8)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The rate reported by the wireless client (-1 if not supported)."))

(defoid |wirelessNumRX| (|wirelessClient| 9)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets received reported by the wireless client (-1 if not supported)."))

(defoid |wirelessNumTX| (|wirelessClient| 10)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of packets transmitted reported by this wireless client (-1 if not supported)."))

(defoid |wirelessNumRXErrors| (|wirelessClient| 11)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of errors encountered receiving packets reported by this wireless client (-1 if not supported)."))

(defoid |wirelessNumTXErrors| (|wirelessClient| 12)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of errors encountered transmitting packets reported by this wireless client (-1 if not supported)."))

(defoid |dhcpServer| (|baseStation3| 3) (:type 'object-identity))

(defoid |dhcpNumber| (|dhcpServer| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of DHCP clients served by the AirPort base station."))

(defoid |dhcpClientsTable| (|dhcpServer| 2)
  (:type 'object-type)
  (:syntax '(vector |DHCPClient|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A list of DHCP clients."))

(defoid |dhcpClient| (|dhcpClientsTable| 1)
  (:type 'object-type)
  (:syntax '|DHCPClient|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A DHCP client entry containing information about the client."))

(defclass |DHCPClient|
          (sequence-type)
          ((|dhcpPhysAddress| :type |PhysAddress|)
           (|dhcpIpAddress| :type |IpAddress|)
           (|dhcpClientID| :type octet-string)
           (|dhcpLeaseTime| :type integer)))

(defoid |dhcpPhysAddress| (|dhcpClient| 1)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The MAC address of the DHCP client."))

(defoid |dhcpIpAddress| (|dhcpClient| 2)
  (:type 'object-type)
  (:syntax '|IpAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The IP address of the DHCP client."))

(defoid |dhcpClientID| (|dhcpClient| 3)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The DHCP client ID of the DHCP client."))

(defoid |dhcpLeaseTime| (|dhcpClient| 4)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The lease time for the DHCP client."))

(defoid |physicalInterfaces| (|baseStation3| 4)
  (:type 'object-identity))

(defoid |physicalInterfaceCount| (|physicalInterfaces| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of physical interfaces on the AirPort Base Station.  This is different than the number of IP interfaces, as reported by the system MIBs, as the AirPort's bridge typically multiplexes two or more interfaces."))

(defoid |physicalInterfacesTable| (|physicalInterfaces| 2)
  (:type 'object-type)
  (:syntax '(vector |PhysicalInterface|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "List of physical interfaces on the AirPort Base Station."))

(defoid |physicalInterface| (|physicalInterfacesTable| 1)
  (:type 'object-type)
  (:syntax '|PhysicalInterface|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Entry containing data about the physical interface on the AirPort Base Station."))

(defclass |PhysicalInterface|
          (sequence-type)
          ((|physicalInterfaceIndex| :type integer)
           (|physicalInterfaceName| :type octet-string)
           (|physicalInterfaceUnit| :type integer)
           (|physicalInterfaceSpeed| :type integer)
           (|physicalInterfaceState| :type integer)
           (|physicalInterfaceDuplex| :type integer)
           (|physicalInterfaceNumTX| :type integer)
           (|physicalInterfaceNumRX| :type integer)
           (|physicalInterfaceNumTXError| :type integer)
           (|physicalInterfaceNumRXError| :type integer)))

(defoid |physicalInterfaceIndex| (|physicalInterface| 1)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A unique value for each physical interface.  Its value ranges between 1 and the value of physicalInterfaceCount."))

(defoid |physicalInterfaceName| (|physicalInterface| 2)
  (:type 'object-type)
  (:syntax 'octet-string)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the physical interface."))

(defoid |physicalInterfaceUnit| (|physicalInterface| 3)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The unit number of the physical interface."))

(defoid |physicalInterfaceSpeed| (|physicalInterface| 4)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The speed, in bits per second, of the interface."))

(defoid |physicalInterfaceState| (|physicalInterface| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The status of this interface."))

(defoid |physicalInterfaceDuplex| (|physicalInterface| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The duplex-state of this interface."))

(defoid |physicalInterfaceNumTX| (|physicalInterface| 7)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The number of packets transmitted on this interface."))

(defoid |physicalInterfaceNumRX| (|physicalInterface| 8)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The number of packets received on this interface."))

(defoid |physicalInterfaceNumTXError| (|physicalInterface| 9)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of errors during transmission on this interface."))

(defoid |physicalInterfaceNumRXError| (|physicalInterface| 10)
  (:type 'object-type)
  (:syntax 'integer)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of errors during reception on this interface."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'airport-basestation-3-mib *mib-modules*)
  (setf *current-module* nil))

