;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:VMWARE;VMWARE-RESOURCES-MIB.MIB by ASN.1 5.0

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (setf *current-module* 'vmware-resources-mib))

(defpackage :asn.1/vmware-resources-mib
  (:nicknames :vmware-resources-mib)
  (:use :common-lisp :asn.1)
  (:import-from :|ASN.1/SNMPv2-SMI| module-identity object-identity
                object-type |Gauge32| |Integer32|)
  (:import-from :|ASN.1/SNMPv2-TC| |DisplayString|)
  (:import-from :|ASN.1/SNMPv2-CONF| module-compliance object-group)
  (:import-from :asn.1/vmware-tc-mib |VmwSubsystemStatus|)
  (:import-from :asn.1/vmware-root-mib |vmwResources|))

(in-package :vmware-resources-mib)

(defoid |vmwResourcesMIB| (|vmwResources| 10)
  (:type 'module-identity)
  (:description
   "This MIB module provides instrumentation of ESX Hypervisor resources such 
      as cpu, memory, and disk."))

(defoid |vmwCPU| (|vmwResources| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description "Information about physical CPU(s)"))

(defoid |vmwNumCPUs| (|vmwCPU| 1)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of physical CPUs on the system."))

(defoid |vmwMemory| (|vmwResources| 2) (:type 'object-identity))

(defoid |vmwMemSize| (|vmwMemory| 1)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Amount of physical memory present on machine as provided by Hypervisor.
         It is computed from the sum of vmwMemCOS plus unreserved property as
         reported VIM subsystem. Unreserved is computed from hypervisor's total
         number of memory pages.

         VIM Parent Container: https://esx.example.com/mob/?moid=memorySystem
         VIM property: unreserved
         MOB: https://esx.example.com/mob/?moid=memoryManagerSystem&doPath=consoleReservationInfo

         For reference here two other related VIM properties:
         VIM property: memorySize
         MOB: https://esx.example.com/mob/?moid=ha%2dhost&doPath=summary%2ehardware
         
         VIM property: totalMemory
         MOB: https://esx.example.com/mob/?moid=ha%2dcompute%2dres&doPath=summary
         "))

(defoid |vmwMemCOS| (|vmwMemory| 2)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This managed object reports memory allocated for COS, theConsole OS
         (aka Service Console) which is a memory region carved out of physical
         memory to boot a RedHat Linux distribution/provides device management
         interface.

         Note that in the VMware ESXi product there is no COS so this will report 0.
         
         This managed object reports the amount of physical memory allocated to the COS.
         VIM Parent Container: https://esx.example.com/mob/?moid=memorySystem
         VIM property: serviceConsoleReserved
         MOB: https://esx.example.com/mob/?moid=memoryManagerSystem&doPath=consoleReservationInfo
        "))

(defoid |vmwMemAvail| (|vmwMemory| 3)
  (:type 'object-type)
  (:syntax '|Gauge32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Amount of memory available to run Virutal Machines and to allocate for
         hypervisor needs. It is computed by subtracting vmwMemCOS from
         vmwMemSize. The result is the amount of memory available to VMs and to
         the hypervisor.

         To get a more accurate view of memory available to VMs the following property
         represents the amount of resources available for the root resource pool for running 
         virtual machines.

         VIM property: effectiveMemory
         MOB: https://esx.example.com/mob/?moid=ha%2dcompute%2dres&doPath=summary
        "))

(defoid |vmwStorage| (|vmwResources| 5) (:type 'object-identity))

(defoid |vmwHostBusAdapterNumber| (|vmwStorage| 1)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Number of entries in vmwHostBusAdapterTable."))

(defoid |vmwHostBusAdapterTable| (|vmwStorage| 2)
  (:type 'object-type)
  (:syntax '(vector |VmwHostBusAdapterEntry|))
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "Inventory of Host Bus Adatpers found in this system. 
         CLI: esxcfg-scsidevs -a
         VIM Parent Container: https://esx.example.com/mob/?moid=storageSystem
         VIM property: hostBusAdapter
         MOB: https://esx.example.com/mob/?moid=storageSystem&doPath=storageDeviceInfo"))

(defoid |vmwHostBusAdapterEntry| (|vmwHostBusAdapterTable| 1)
  (:type 'object-type)
  (:syntax '|VmwHostBusAdapterEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "Details for this adapter."))

(defclass |VmwHostBusAdapterEntry|
          (sequence-type)
          ((|vmwHostBusAdapterIndex| :type |Integer32|)
           (|vmwHbaDeviceName| :type |DisplayString|)
           (|vmwHbaBusNumber| :type |Integer32|)
           (|vmwHbaStatus| :type |VmwSubsystemStatus|)
           (|vmwHbaModelName| :type |DisplayString|)
           (|vmwHbaDriverName| :type |DisplayString|)
           (|vmwHbaPci| :type |DisplayString|)))

(defoid |vmwHostBusAdapterIndex| (|vmwHostBusAdapterEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An arbitrary index assigned to this adapter."))

(defoid |vmwHbaDeviceName| (|vmwHostBusAdapterEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The system device name for this host bus adapter."))

(defoid |vmwHbaBusNumber| (|vmwHostBusAdapterEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The host bus number. For unsuported HBA's reports -1."))

(defoid |vmwHbaStatus| (|vmwHostBusAdapterEntry| 4)
  (:type 'object-type)
  (:syntax '|VmwSubsystemStatus|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The operational status of the adapter."))

(defoid |vmwHbaModelName| (|vmwHostBusAdapterEntry| 5)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The model name of the host bus adapter."))

(defoid |vmwHbaDriverName| (|vmwHostBusAdapterEntry| 6)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the driver."))

(defoid |vmwHbaPci| (|vmwHostBusAdapterEntry| 7)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The Peripheral Connect Interface (PCI) ID of the device."))

(defoid |vmwResourceMIBConformance| (|vmwResourcesMIB| 2)
  (:type 'object-identity))

(defoid |vmwResourceMIBCompliances| (|vmwResourceMIBConformance| 1)
  (:type 'object-identity))

(defoid |vmwResMIBGroups| (|vmwResourceMIBConformance| 2)
  (:type 'object-identity))

(defoid |vmwResourceMIBCompliance| (|vmwResourceMIBCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for entities which implement the 
    VMWARE-RESOURCE-MIB."))

(defoid |vmwResourceGroup| (|vmwResMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description "These objects provide resource details."))

(in-package :asn.1)

(eval-when (:load-toplevel :execute)
  (pushnew 'vmware-resources-mib *mib-modules*)
  (setf *current-module* nil))

