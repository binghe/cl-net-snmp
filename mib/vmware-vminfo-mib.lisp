;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-VMINFO-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-vminfo-mib))

(defpackage :asn.1/vmware-vminfo-mib
  (:nicknames :vmware-vminfo-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity |Integer32|
                object-type notification-type)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString| |PhysAddress|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group
                notification-group)
  (:import-from :asn.1/vmware-tc-mib |VmwConnectedState|)
  (:import-from :asn.1/vmware-env-mib |vmwESXNotifications|)
  (:import-from :asn.1/vmware-root-mib |vmwVirtMachines| |vmwTraps|))

(in-package :vmware-vminfo-mib)

(defoid |vmwVmInfoMIB| (|vmwVirtMachines| 10)
  (:type 'module-identity)
  (:description
   "This MIB module provides for monitoring of inventory and state via polling
      and notifications of state changes for virtual machines residing on
      this host system.  This MIB module also provides a mapping beween SMI
      managed objects defined here and their corresponding VMware Virtual
      Infrastructure Management (VIM) API properties."))

(defoid |vmwVmTable| (|vmwVirtMachines| 1)
  (:type 'object-type)
  (:syntax '(vector |VmwVmEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information on virtual machines that have been 
                configured on the system."))

(defoid |vmwVmEntry| (|vmwVmTable| 1)
  (:type 'object-type)
  (:syntax '|VmwVmEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Identifies a registered VM on this ESX system."))

(defclass |VmwVmEntry|
          (sequence-type)
          ((|vmwVmIdx| :type |Integer32|)
           (|vmwVmDisplayName| :type |DisplayString|)
           (|vmwVmConfigFile| :type |DisplayString|)
           (|vmwVmGuestOS| :type |DisplayString|)
           (|vmwVmMemSize| :type |Integer32|)
           (|vmwVmState| :type |DisplayString|)
           (|vmwVmVMID| :type |Integer32|)
           (|vmwVmGuestState| :type |DisplayString|)
           (|vmwVmCpus| :type |Integer32|)))

(defoid |vmwVmIdx| (|vmwVmEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An operational identifier given the VM when registered on this ESX system.
                 The value is not unique across ESX systems and may change upon reboot.
                 VIM property: ha-vm-folder
                 MOB: https://esx.example.com/mob/?moid=ha%2dfolder%2dvm
                 A given Virtual Machine Instance can be queried using this URL:
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx"))

(defoid |vmwVmDisplayName| (|vmwVmEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Name by which this vm is displayed. It is not guaranteed to be unique.
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=summary%2eguest"))

(defoid |vmwVmConfigFile| (|vmwVmEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Path to the configuration file for this vm expressed as a fully
                 qualified path name in POSIX or DOS extended format
                 VM Config file File name:
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2efiles
                 VM Datastore containing the filename:
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2edatastoreUrl"))

(defoid |vmwVmGuestOS| (|vmwVmEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Operating system running on this vm. This value corresponds to the
                 value specified when creating the VM and unless set correctly may differ
                 from the actual OS running. Will return one of the values if set in order:
                   Vim.Vm.GuestInfo.guestFullName
                   Vim.Vm.GuestInfo.guestId
                   Vim.Vm.GuestInfo.guestFamily
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=guest 
                      where moid = vmwVmIdx.
                 If VMware Tools is not running, value will be of form 'E: error message'"))

(defoid |vmwVmMemSize| (|vmwVmEntry| 5)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Memory configured for this virtual machine. 
                 Memory > MAX Integer32 is reported as max integer32.
                VIM Property: memoryMB
                MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware"))

(defoid |vmwVmState| (|vmwVmEntry| 6)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Power state of the virtual machine.
                VIM Property: powerState
                MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=summary%2eruntime"))

(defoid |vmwVmVMID| (|vmwVmEntry| 7)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Same value as vmwVmIdx, note that indexes in SMIv2 are not accessible.
                https://esx.example.com/mob/?moid=vmwVmIdx"))

(defoid |vmwVmGuestState| (|vmwVmEntry| 8)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Operation mode of guest operating system. Values include:
                  running  - Guest is running normally.
                  shuttingdown - Guest has a pending shutdown command.
                  resetting - Guest has a pending reset command.
                  standby - Guest has a pending standby command.
                  notrunning - Guest is not running.
                  unknown - Guest information is not available.
                VIM Property: guestState
                MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=guest"))

(defoid |vmwVmCpus| (|vmwVmEntry| 9)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Number of virtual CPUs assigned to this virtual machine.
                VIM Property: numCPU 
                MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware"))

(defoid |vmwVmHbaTable| (|vmwVirtMachines| 2)
  (:type 'object-type)
  (:syntax '(vector |VmwVmHbaEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Table of host bus adapters (hba) for all vms in vmwVmTable."))

(defoid |vmwVmHbaEntry| (|vmwVmHbaTable| 1)
  (:type 'object-type)
  (:syntax '|VmwVmHbaEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Uniquely identifies a given virtual machine host bus adapter."))

(defclass |VmwVmHbaEntry|
          (sequence-type)
          ((|vmwHbaVmIdx| :type |Integer32|)
           (|vmwVmHbaIdx| :type |Integer32|)
           (|vmwHbaNum| :type |DisplayString|)
           (|vmwHbaVirtDev| :type |DisplayString|)))

(defoid |vmwHbaVmIdx| (|vmwVmHbaEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This number corresponds to the vmwVmIdx in vmwVmTable."))

(defoid |vmwVmHbaIdx| (|vmwVmHbaEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Uniquely identifies a given Host Bus adapter in this VM. May 
                 change across system reboots."))

(defoid |vmwHbaNum| (|vmwVmHbaEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The name of the hba as it appears in the VM Settings.
                 VIM Property: Virtual Device index of 200-299.
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware"))

(defoid |vmwHbaVirtDev| (|vmwVmHbaEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The oem host bus adapter hardware being emulated to the Guest OS.
                 MOB: Not visible."))

(defoid |vmwHbaTgtTable| (|vmwVirtMachines| 3)
  (:type 'object-type)
  (:syntax '(vector |VmwHbaTgtEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Table of all virtual disks configured for vms in vmwVmTable."))

(defoid |vmwHbaTgtEntry| (|vmwHbaTgtTable| 1)
  (:type 'object-type)
  (:syntax '|VmwHbaTgtEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Identifies a specific storage disk. Index may change across reboots."))

(defclass |VmwHbaTgtEntry|
          (sequence-type)
          ((|vmwHbaTgtVmIdx| :type |Integer32|)
           (|vmwHbaTgtIdx| :type |Integer32|)
           (|vmwHbaTgtNum| :type |DisplayString|)))

(defoid |vmwHbaTgtVmIdx| (|vmwHbaTgtEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This number corresponds to vmwVmIdx in vmwVmTable."))

(defoid |vmwHbaTgtIdx| (|vmwHbaTgtEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This value identifies a particular disk."))

(defoid |vmwHbaTgtNum| (|vmwHbaTgtEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Identifies the disk as seen from the host bus controller
                 VIM Property: Virtual Device's with index of 2000-2999,3000-3999.
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware"))

(defoid |vmwVmNetTable| (|vmwVirtMachines| 4)
  (:type 'object-type)
  (:syntax '(vector |VmwVmNetEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Table of network adapters (nic) for all vms in vmwVmTable."))

(defoid |vmwVmNetEntry| (|vmwVmNetTable| 1)
  (:type 'object-type)
  (:syntax '|VmwVmNetEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Identifies a particular nic for the specified vmwVmIdx"))

(defclass |VmwVmNetEntry|
          (sequence-type)
          ((|vmwVmNetVmIdx| :type |Integer32|)
           (|vmwVmNetIdx| :type |Integer32|)
           (|vmwVmNetNum| :type |DisplayString|)
           (|vmwVmNetName| :type |DisplayString|)
           (|vmwVmNetConnType| :type |DisplayString|)
           (|vmwVmNetConnected| :type |VmwConnectedState|)
           (|vmwVmMAC| :type |PhysAddress|)))

(defoid |vmwVmNetVmIdx| (|vmwVmNetEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This number corresponds to vmwVmIdx in vmwVmTable."))

(defoid |vmwVmNetIdx| (|vmwVmNetEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Identifies a unique network adapter in this table.
                 Not guaranteed to be the same across system reboots."))

(defoid |vmwVmNetNum| (|vmwVmNetEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The name of the device as it appears in the VM Settings.
                 VIM Property: Virtual Device's with index of 4000-4999. 
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware"))

(defoid |vmwVmNetName| (|vmwVmNetEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "What this virutal nic is connected to such as a virtual switch portgroup identifier.
                 VIM Property: Virtual Device's with index of 4000-4999. 
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware
                 then select property 'backing' to how this nic connects.
                 If no backing was defined by operator, string will start with W:
                 If unavailable, string will start with E:"))

(defoid |vmwVmNetConnType| (|vmwVmNetEntry| 5)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|obsolete|)
  (:description
   "Do not use this value, and should an agent return it discard it."))

(defoid |vmwVmNetConnected| (|vmwVmNetEntry| 6)
  (:type 'object-type)
  (:syntax '|VmwConnectedState|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reports 'true' if the ethernet virtual device is connected to the virtual machine."))

(defoid |vmwVmMAC| (|vmwVmNetEntry| 7)
  (:type 'object-type)
  (:syntax '|PhysAddress|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reports the configured virtual hardware MAC address.  If VMware
                 Tools is not running, or VM has not yet been powered on for the
                 first time and mac is to be generated by VM then the value is
                 zero'd out/empty.  VIM Property: Virtual Device's with index of
                 4000-4999.  MOB:
                 https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware"))

(defoid |vmwFloppyTable| (|vmwVirtMachines| 5)
  (:type 'object-type)
  (:syntax '(vector |VmwFloppyEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Table of floppy drives for all vms in vmwVmTable."))

(defoid |vmwFloppyEntry| (|vmwFloppyTable| 1)
  (:type 'object-type)
  (:syntax '|VmwFloppyEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Identifies one specific floppy device. May change across system reboots."))

(defclass |VmwFloppyEntry|
          (sequence-type)
          ((|vmwFdVmIdx| :type |Integer32|)
           (|vmwFdIdx| :type |Integer32|)
           (|vmwFdName| :type |DisplayString|)
           (|vmwFdConnected| :type |VmwConnectedState|)))

(defoid |vmwFdVmIdx| (|vmwFloppyEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This number corresponds to vmwVmIdx in vmwVmTable."))

(defoid |vmwFdIdx| (|vmwFloppyEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Identifies one specific virtual floppy device."))

(defoid |vmwFdName| (|vmwFloppyEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "File or Device that this device is connected to, example /dev/fd0.
                 VIM Property: Virtual Device's with index of 8000-8999. 
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware
                 If no backing was defined by operator, string will start with W:
                 If unavailable, string will start with E:"))

(defoid |vmwFdConnected| (|vmwFloppyEntry| 4)
  (:type 'object-type)
  (:syntax '|VmwConnectedState|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reports 'true' if the floppy drive virtual device is connected to the virtual machine."))

(defoid |vmwCdromTable| (|vmwVirtMachines| 6)
  (:type 'object-type)
  (:syntax '(vector |VmwCdromEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Table of DVD or CDROM drives for all vms in vmwVmTable."))

(defoid |vmwCdromEntry| (|vmwCdromTable| 1)
  (:type 'object-type)
  (:syntax '|VmwCdromEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Identifies a specific DVD or CDROM drive. Value may change across system reboots."))

(defclass |VmwCdromEntry|
          (sequence-type)
          ((|vmwCdVmIdx| :type |Integer32|)
           (|vmwCdromIdx| :type |Integer32|)
           (|vmwCdromName| :type |DisplayString|)
           (|vmwCdromConnected| :type |VmwConnectedState|)))

(defoid |vmwCdVmIdx| (|vmwCdromEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This number corresponds to the vmwVmIdx the vmwVmTable."))

(defoid |vmwCdromIdx| (|vmwCdromEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Identifies the specific DVD or CDROM drive."))

(defoid |vmwCdromName| (|vmwCdromEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reports the iso or device this virtual drive has been configured to use
                 VIM Property: Virtual Device's with index of 3000-3999 (same as disks)
                 MOB: https://esx.example.com/mob/?moid=vmwVmIdx&doPath=config%2ehardware
                 then select property 'backing' to how this cdrom connects.
                 If no backing was defined by operator, string will start with W:
                 If unavailable, string will start with E:"))

(defoid |vmwCdromConnected| (|vmwCdromEntry| 4)
  (:type 'object-type)
  (:syntax '|VmwConnectedState|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Reports true if the dvd/cdrom is connected to the virtual machine."))

(defoid |vmwVmID| (|vmwTraps| 101)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "This holds the same value as vmwVmVMID of the affected vm generating the trap.
         to allow polling of the affected vm in vmwVmTable."))

(defoid |vmwVmConfigFilePath| (|vmwTraps| 102)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|accessible-for-notify|)
  (:status '|current|)
  (:description
   "This is the path to the config file of the affected vm generating the trap 
         and is same as vmwVmTable vmwVmConfigFile. It is expressed as POSIX pathname."))

(defoid |vmwVmPoweredOn| (|vmwESXNotifications| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This trap is sent when a virtual machine is powered on from a suspended 
     or a powered off state. The origin of this event can be several:
     for instance may be operator initiated, existing vmx process reconnects to control subsystem. 
     NOTE: vms powered up due to VMotion are not reported. Upon receiving this notification client applications should
     poll the vmwVmTable to obtain current status."))

(defoid |vmwVmPoweredOff| (|vmwESXNotifications| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This trap is sent when a virtual machine is powered off. The origin of this event can be several:
     for instance may be operator initiated, vmx process terminating abnormally. NOTE: vms powered down due
     to VMotion are not reported. Upon receiving this notification client applications should
     poll the vmwVmTable to obtain current status."))

(defoid |vmwVmHBLost| (|vmwESXNotifications| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This trap is sent when a virtual machine detects a loss in guest heartbeat. The Guest heartbeat
     is only sent if VMware Tools are installed in the Guest OS. Control process will send this event whenever it 
     determines the number of guest heartbeats for a given period of time have not been received. 
     Upon receiving this notification client applications should
     poll the vmwVmTable to obtain current status."))

(defoid |vmwVmHBDetected| (|vmwESXNotifications| 4)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This trap is sent when a virtual machine detects or regains the required number of guest heartbeats
     for a given period of time. This is only sent if VMware tools are installed in the Guest OS.
     Upon receiving this notification client applications should
     poll the vmwVmTable to obtain current status."))

(defoid |vmwVmSuspended| (|vmwESXNotifications| 5)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This trap is sent when a virtual machine is suspended. The origin of this event may be several: operator
     initiated, by software api clients, and by other means.
     Upon receiving this notification client applications should
     poll the vmwVmTable to obtain current status."))

(defoid |vmwVmInfoMIBConformance| (|vmwVmInfoMIB| 2)
  (:type 'object-identity))

(defoid |vmwVmInfoMIBCompliances| (|vmwVmInfoMIBConformance| 1)
  (:type 'object-identity))

(defoid |vmwVmInfoMIBGroups| (|vmwVmInfoMIBConformance| 2)
  (:type 'object-identity))

(defoid |vmwResMIBBasicCompliance| (|vmwVmInfoMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement the 
    VMWARE-RESOURCE-MIB."))

(defoid |vmwVmInfoGroup| (|vmwVmInfoMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects provide virtual machine details."))

(defoid |vmwVmInfoNotificationGroup| (|vmwVmInfoMIBGroups| 2)
  (:type 'notification-group)
  (:status '|current|)
  (:description "Group of objects describing notifications (traps)."))

(defoid |vmwVmObsoleteGroup| (|vmwVmInfoMIBGroups| 3)
  (:type 'object-group)
  (:status '|obsolete|)
  (:description "Managed objects that should not be used."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-vminfo-mib *mib-modules*)
  (setf *current-module* nil))

