;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:MISC;LINUX-HA-MIB.MIB

(in-package :asn.1)
(setf *current-module* 'linux-ha-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'linux-ha-mib *mib-modules*))
(defoid |LinuxHA| (|enterprises| 4682)
  (:type 'module-identity)
  (:description
   "This MIB can be used to manage a Linux-HA cluster. The
	initial plan is to make the heartbeat, resource managment,
	and memberships accessible through SNMP. Hopefully more
	things can be added as Linux-HA matures."))
(deftype |LHAUUIDString| () 't)
(defoid |LHAClusterInfo| (|LinuxHA| 1) (:type 'object-identity))
(defoid |LHATotalNodeCount| (|LHAClusterInfo| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of nodes that are currently configured for this
	cluster."))
(defoid |LHALiveNodeCount| (|LHAClusterInfo| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of nodes that are currently active in this
	cluster."))
(defoid |LHACurrentNodeID| (|LHAClusterInfo| 3)
  (:type 'object-type)
  (:syntax '|Integer32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The nodes id of the host that this agent currently
	represents.  This value is the same as the LHANodeIndex value
	of this node."))
(defoid |LHAResourceGroupCount| (|LHAClusterInfo| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of Resource Groups that have been
	configured for this cluster."))
(defoid |LHANodeTable| (|LinuxHA| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table contains information about all the nodes in the
	cluster."))
(defoid |LHANodeEntry| (|LHANodeTable| 1)
  (:type 'object-type)
  (:syntax '|lhaNodeEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a node and its statistics."))
(deftype |lhaNodeEntry| () 't)
(defoid |LHANodeIndex| (|LHANodeEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An integer that identifies a node in a cluster for a given
	snmp session."))
(defoid |LHANodeName| (|LHANodeEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "A human readable name that represents that node."))
(defoid |LHANodeType| (|LHANodeEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "There could be many types of nodes in the cluster.  For
	example, a node could be a normal node, or a ping node
	depending on the configuration.  This object shows the
	type of this node as an integer.  
	
	So far only the normal node and ping node are defined.  All
	the rest will fall into the 'unknown' catagory. "))
(defoid |LHANodeStatus| (|LHANodeEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The status of the node as an integer. For heartbeat, this
	would normally be init, up, active, or dead.

	So far, only these four states are defined.  All the rest
	falls in 'unknown' catagory."))
(defoid |LHANodeUUID| (|LHANodeEntry| 5)
  (:type 'object-type)
  (:syntax '|LHAUUIDString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The UUID of the current node in string representatio.  This
	UUID will be persisted over the heartbeat session.  So it can
	be used as a unique identifier for a node."))
(defoid |LHANodeIFCount| (|LHANodeEntry| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The number of interfaces that is used by heartbeat
	for this node."))
(defoid |LHAIFStatusTable| (|LinuxHA| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table describes all the interfaces that are used by the
	heartbeat cluster."))
(defoid |LHAIFStatusEntry| (|LHAIFStatusTable| 1)
  (:type 'object-type)
  (:syntax '|lhaIFStatusEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry containing information about that interface.
	The LHANodeIndex is listed in the LHANodeTable."))
(deftype |lhaIFStatusEntry| () 't)
(defoid |LHAIFIndex| (|LHAIFStatusEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An unique integer identifies this interface."))
(defoid |LHAIFName| (|LHAIFStatusEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "A name for this interface."))
(defoid |LHAIFStatus| (|LHAIFStatusEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The status for this interface as an integer. 
	
	Currently only up and down are defined as the interface
	status.  All the others will fall into the unknown catagory."))
(defoid |LHAResourceGroupTable| (|LinuxHA| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information of all the resource groups."))
(defoid |LHAResourceGroupEntry| (|LHAResourceGroupTable| 1)
  (:type 'object-type)
  (:syntax '|lhaResourceGroupEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry that describes the resource group and its
	information."))
(deftype |lhaResourceGroupEntry| () 't)
(defoid |LHAResourceGroupIndex| (|LHAResourceGroupEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A unique integer that identifies this resource group."))
(defoid |LHAResourceGroupMaster| (|LHAResourceGroupEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The master node id of this resource group.  This is 
	the LHANodeIndex for the master node of this resource
	group. "))
(defoid |LHAResourceGroupResources| (|LHAResourceGroupEntry| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The resources contained in this resource group."))
(defoid |LHAResourceGroupStatus| (|LHAResourceGroupEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The status of this resource group.

	 0       program is running 
	 1       program is dead and /var/run pid file exists
	 2       program is dead and /var/lock lock file exists
	 3       program is stopped
	 4-100   reserved for future LSB use
	 100-149 reserved for distribution use
	 150-199 reserved for application use
	 200-254 reserved
	 "))
(defoid |LHAMembershipTable| (|LinuxHA| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing membership information for the cluster.
	A successful membership has to have qurom.  
	
				NOTE WELL

	If this table does not contain any entries, that means the 
	node is not part of the cluster membership."))
(defoid |LHAMembershipEntry| (|LHAMembershipTable| 1)
  (:type 'object-type)
  (:syntax '|lhaMembershipEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry containing a member and its status."))
(deftype |lhaMembershipEntry| () 't)
(defoid |LHAMemberIndex| (|LHAMembershipEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A unique integer that identifies this member."))
(defoid |LHAMemberName| (|LHAMembershipEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of the cluster member."))
(defoid |LHAMemberAddress| (|LHAMembershipEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The address of the cluster member."))
(defoid |LHAMemberClusterName| (|LHAMembershipEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of this cluster."))
(defoid |LHAMemberIsMember| (|LHAMembershipEntry| 5)
  (:type 'object-type)
  (:syntax '|TruthValue|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "If this node is part of the membership or not."))
(defoid |LHAMemberLastChange| (|LHAMembershipEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "If this node is part of the membership or not."))
(defoid |LHAMemberBootTime| (|LHAMembershipEntry| 7)
  (:type 'object-type)
  (:syntax '|TimeStamp|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The time when this cluster member last started."))
(defoid |LHAHeartbeatConfigInfo| (|LinuxHA| 7) (:type 'object-identity))
(defoid |LHAHBVersion| (|LHAHeartbeatConfigInfo| 1)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The heartbeat version."))
(defoid |LHAKeepAlive| (|LHAHeartbeatConfigInfo| 3)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The heartbeat interval."))
(defoid |LHADeadTime| (|LHAHeartbeatConfigInfo| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time it waits before declaring a node to be dead."))
(defoid |LHADeadPing| (|LHAHeartbeatConfigInfo| 5)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time it waits before declaring a ping node to be dead."))
(defoid |LHAWarnTime| (|LHAHeartbeatConfigInfo| 6)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The time it waits before issuing a 'late heartbeat' warning."))
(defoid |LHAInitDead| (|LHAHeartbeatConfigInfo| 7)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Very first dead time.  Should be twice the normal dead time."))
(defoid |LHABaudRate| (|LHAHeartbeatConfigInfo| 9)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "Baud rate for serial ports."))
(defoid |LHAAutoFailBack| (|LHAHeartbeatConfigInfo| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "Determins whether a resource will automatically fail back to
	its primary node, or remain on whatever the node is serving.
	
	Possible values are: on, off, legacy."))
(defoid |LHAStonith| (|LHAHeartbeatConfigInfo| 13)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The STONITH device configured for this cluster."))
(defoid |LHAStonithHost| (|LHAHeartbeatConfigInfo| 14)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The STONITH host configured for this cluster."))
(defoid |LHARespawn| (|LHAHeartbeatConfigInfo| 15)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The other services that got respawned by heartbeat daemon."))
(defoid |LHAResourceTable| (|LinuxHA| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A table containing information of all the resource for V2."))
(defoid |LHAResourceEntry| (|LHAResourceTable| 1)
  (:type 'object-type)
  (:syntax '|lhaResourceEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry that describes the resource and its status for V2."))
(deftype |lhaResourceEntry| () 't)
(defoid |LHAResourceIndex| (|LHAResourceEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "A unique integer that identifies this resource."))
(defoid |LHAResourceName| (|LHAResourceEntry| 2)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of this resource."))
(defoid |LHAResourceType| (|LHAResourceEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The type of this resource.
	 0       unknown type
	 1       primitive resource.
	 2       group resource.
	 3       clone resource.
	 4	     master/slave resource.
	 "))
(defoid |LHAResourceNode| (|LHAResourceEntry| 4)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The node name that this resource resides on."))
(defoid |LHAResourceStatus| (|LHAResourceEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The status of this resource.
	 0       unknown status
	 1       program is stopped.
	 2       program is started.
	 3       program is started in slave state.
	 4	 program is started in master state.
	 "))
(defoid |LHAResourceIsManaged| (|LHAResourceEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The status of this resource.
	 0       resource is not managed.
	 1       resource is managed.
	 "))
(defoid |LHAResourceFailCount| (|LHAResourceEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The value of this resource's fail-count."))
(defoid |LHAResourceParent| (|LHAResourceEntry| 8)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The name of this resource's parent resource."))
(defoid |LHATrapTable| (|LinuxHA| 900) (:type 'object-identity))
(defoid |LHANodeStatusUpdate| (|LHATrapTable| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description "A node status change event just happened."))
(defoid |LHAIFStatusUpdate| (|LHATrapTable| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description "A link status just changed."))
(defoid |LHAMembershipChange| (|LHATrapTable| 5)
  (:type 'notification-type)
  (:status '|current|)
  (:description "A node just changed it membership. "))
(defoid |LHAHBAgentOnline| (|LHATrapTable| 7)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "The heartbeat agent for this node is online and ready to accept queries. "))
(defoid |LHAHBAgentOffline| (|LHATrapTable| 9)
  (:type 'notification-type)
  (:status '|current|)
  (:description "The heartbeat agent for this node is offline. "))
(defoid |LHAResourceStatusUpdate| (|LHATrapTable| 11)
  (:type 'notification-type)
  (:status '|current|)
  (:description "A resource status change event just happened."))
