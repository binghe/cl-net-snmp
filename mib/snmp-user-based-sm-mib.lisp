;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from ASN-SNMP:SNMP-USER-BASED-SM-MIB

(in-package :asn.1)
(setf *current-module* 'snmp-user-based-sm-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'snmp-user-based-sm-mib *mib-modules*))
(defoid |snmpUsmMIB| (|snmpModules| 15)
  (:type 'module-identity)
  (:description
   "The management information definitions for the
                  SNMP User-based Security Model.

                  Copyright (C) The Internet Society (2002). This
                  version of this MIB module is part of RFC 3414;
                  see the RFC itself for full legal notices.
                 "))
(defoid |usmMIBObjects| (|snmpUsmMIB| 1) (:type 'object-identity))
(defoid |usmMIBConformance| (|snmpUsmMIB| 2) (:type 'object-identity))
(defoid |usmNoAuthProtocol| (|snmpAuthProtocols| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description "No Authentication Protocol."))
(defoid |usmHMACMD5AuthProtocol| (|snmpAuthProtocols| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The HMAC-MD5-96 Digest Authentication Protocol."))
(defoid |usmHMACSHAAuthProtocol| (|snmpAuthProtocols| 3)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The HMAC-SHA-96 Digest Authentication Protocol."))
(defoid |usmNoPrivProtocol| (|snmpPrivProtocols| 1)
  (:type 'object-identity)
  (:status '|current|)
  (:description "No Privacy Protocol."))
(defoid |usmDESPrivProtocol| (|snmpPrivProtocols| 2)
  (:type 'object-identity)
  (:status '|current|)
  (:description "The CBC-DES Symmetric Encryption Protocol."))
(deftype |KeyChange| () 't)
(defoid |usmStats| (|usmMIBObjects| 1) (:type 'object-identity))
(defoid |usmStatsUnsupportedSecLevels| (|usmStats| 1)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they requested a
                 securityLevel that was unknown to the SNMP engine
                 or otherwise unavailable.
                "))
(defoid |usmStatsNotInTimeWindows| (|usmStats| 2)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they appeared
                 outside of the authoritative SNMP engine's window.
                "))
(defoid |usmStatsUnknownUserNames| (|usmStats| 3)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they referenced a
                 user that was not known to the SNMP engine.
                "))
(defoid |usmStatsUnknownEngineIDs| (|usmStats| 4)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they referenced an
                 snmpEngineID that was not known to the SNMP engine.
                "))
(defoid |usmStatsWrongDigests| (|usmStats| 5)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they didn't
                 contain the expected digest value.
                "))
(defoid |usmStatsDecryptionErrors| (|usmStats| 6)
  (:type 'object-type)
  (:syntax '|Counter32|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The total number of packets received by the SNMP
                 engine which were dropped because they could not be
                 decrypted.
                "))
(defoid |usmUser| (|usmMIBObjects| 2) (:type 'object-identity))
(defoid |usmUserSpinLock| (|usmUser| 1)
  (:type 'object-type)
  (:syntax '|TestAndIncr|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "An advisory lock used to allow several cooperating
                 Command Generator Applications to coordinate their
                 use of facilities to alter secrets in the
                 usmUserTable.
                "))
(defoid |usmUserTable| (|usmUser| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The table of users configured in the SNMP engine's
                 Local Configuration Datastore (LCD).

                 To create a new user (i.e., to instantiate a new
                 conceptual row in this table), it is recommended to
                 follow this procedure:

                   1)  GET(usmUserSpinLock.0) and save in sValue.

                   2)  SET(usmUserSpinLock.0=sValue,
                           usmUserCloneFrom=templateUser,
                           usmUserStatus=createAndWait)
                       You should use a template user to clone from
                       which has the proper auth/priv protocol defined.

                 If the new user is to use privacy:

                   3)  generate the keyChange value based on the secret
                       privKey of the clone-from user and the secret key
                       to be used for the new user. Let us call this
                       pkcValue.
                   4)  GET(usmUserSpinLock.0) and save in sValue.
                   5)  SET(usmUserSpinLock.0=sValue,
                           usmUserPrivKeyChange=pkcValue
                           usmUserPublic=randomValue1)
                   6)  GET(usmUserPulic) and check it has randomValue1.
                       If not, repeat steps 4-6.

                 If the new user will never use privacy:

                   7)  SET(usmUserPrivProtocol=usmNoPrivProtocol)

                 If the new user is to use authentication:

                   8)  generate the keyChange value based on the secret
                       authKey of the clone-from user and the secret key
                       to be used for the new user. Let us call this
                       akcValue.
                   9)  GET(usmUserSpinLock.0) and save in sValue.
                   10) SET(usmUserSpinLock.0=sValue,
                           usmUserAuthKeyChange=akcValue
                           usmUserPublic=randomValue2)
                   11) GET(usmUserPulic) and check it has randomValue2.
                       If not, repeat steps 9-11.

                 If the new user will never use authentication:

                   12) SET(usmUserAuthProtocol=usmNoAuthProtocol)

                 Finally, activate the new user:

                   13) SET(usmUserStatus=active)

                 The new user should now be available and ready to be
                 used for SNMPv3 communication. Note however that access
                 to MIB data must be provided via configuration of the
                 SNMP-VIEW-BASED-ACM-MIB.

                 The use of usmUserSpinlock is to avoid conflicts with
                 another SNMP command generator application which may
                 also be acting on the usmUserTable.
                "))
(defoid |usmUserEntry| (|usmUserTable| 1)
  (:type 'object-type)
  (:syntax '|UsmUserEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A user configured in the SNMP engine's Local
                 Configuration Datastore (LCD) for the User-based
                 Security Model.
                "))
(deftype |UsmUserEntry| () 't)
(defoid |usmUserEngineID| (|usmUserEntry| 1)
  (:type 'object-type)
  (:syntax '|SnmpEngineID|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An SNMP engine's administratively-unique identifier.

                 In a simple agent, this value is always that agent's
                 own snmpEngineID value.

                 The value can also take the value of the snmpEngineID
                 of a remote SNMP engine with which this user can
                 communicate.
                "))
(defoid |usmUserName| (|usmUserEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "A human readable string representing the name of
                 the user.

                 This is the (User-based Security) Model dependent
                 security ID.
                "))
(defoid |usmUserSecurityName| (|usmUserEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "A human readable string representing the user in
                 Security Model independent format.

                 The default transformation of the User-based Security
                 Model dependent security ID to the securityName and
                 vice versa is the identity function so that the
                 securityName is the same as the userName.
                "))
(defoid |usmUserCloneFrom| (|usmUserEntry| 4)
  (:type 'object-type)
  (:syntax '|RowPointer|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A pointer to another conceptual row in this
                 usmUserTable.  The user in this other conceptual
                 row is called the clone-from user.

                 When a new user is created (i.e., a new conceptual
                 row is instantiated in this table), the privacy and
                 authentication parameters of the new user must be
                 cloned from its clone-from user. These parameters are:
                   - authentication protocol (usmUserAuthProtocol)
                   - privacy protocol (usmUserPrivProtocol)
                 They will be copied regardless of what the current
                 value is.

                 Cloning also causes the initial values of the secret
                 authentication key (authKey) and the secret encryption

                 key (privKey) of the new user to be set to the same
                 values as the corresponding secrets of the clone-from
                 user to allow the KeyChange process to occur as
                 required during user creation.

                 The first time an instance of this object is set by
                 a management operation (either at or after its
                 instantiation), the cloning process is invoked.
                 Subsequent writes are successful but invoke no
                 action to be taken by the receiver.
                 The cloning process fails with an 'inconsistentName'
                 error if the conceptual row representing the
                 clone-from user does not exist or is not in an active
                 state when the cloning process is invoked.

                 When this object is read, the ZeroDotZero OID
                 is returned.
                "))
(defoid |usmUserAuthProtocol| (|usmUserEntry| 5)
  (:type 'object-type)
  (:syntax '|AutonomousType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An indication of whether messages sent on behalf of
                 this user to/from the SNMP engine identified by
                 usmUserEngineID, can be authenticated, and if so,
                 the type of authentication protocol which is used.

                 An instance of this object is created concurrently
                 with the creation of any other object instance for
                 the same user (i.e., as part of the processing of
                 the set operation which creates the first object
                 instance in the same conceptual row).

                 If an initial set operation (i.e. at row creation time)
                 tries to set a value for an unknown or unsupported
                 protocol, then a 'wrongValue' error must be returned.

                 The value will be overwritten/set when a set operation
                 is performed on the corresponding instance of
                 usmUserCloneFrom.

                 Once instantiated, the value of such an instance of
                 this object can only be changed via a set operation to
                 the value of the usmNoAuthProtocol.

                 If a set operation tries to change the value of an

                 existing instance of this object to any value other
                 than usmNoAuthProtocol, then an 'inconsistentValue'
                 error must be returned.

                 If a set operation tries to set the value to the
                 usmNoAuthProtocol while the usmUserPrivProtocol value
                 in the same row is not equal to usmNoPrivProtocol,
                 then an 'inconsistentValue' error must be returned.
                 That means that an SNMP command generator application
                 must first ensure that the usmUserPrivProtocol is set
                 to the usmNoPrivProtocol value before it can set
                 the usmUserAuthProtocol value to usmNoAuthProtocol.
                "))
(defoid |usmUserAuthKeyChange| (|usmUserEntry| 6)
  (:type 'object-type)
  (:syntax '|KeyChange|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An object, which when modified, causes the secret
                 authentication key used for messages sent on behalf
                 of this user to/from the SNMP engine identified by
                 usmUserEngineID, to be modified via a one-way
                 function.

                 The associated protocol is the usmUserAuthProtocol.
                 The associated secret key is the user's secret
                 authentication key (authKey). The associated hash
                 algorithm is the algorithm used by the user's
                 usmUserAuthProtocol.

                 When creating a new user, it is an 'inconsistentName'
                 error for a set operation to refer to this object
                 unless it is previously or concurrently initialized
                 through a set operation on the corresponding instance
                 of usmUserCloneFrom.

                 When the value of the corresponding usmUserAuthProtocol
                 is usmNoAuthProtocol, then a set is successful, but
                 effectively is a no-op.

                 When this object is read, the zero-length (empty)
                 string is returned.

                 The recommended way to do a key change is as follows:

                   1) GET(usmUserSpinLock.0) and save in sValue.
                   2) generate the keyChange value based on the old
                      (existing) secret key and the new secret key,
                      let us call this kcValue.

                 If you do the key change on behalf of another user:

                   3) SET(usmUserSpinLock.0=sValue,
                          usmUserAuthKeyChange=kcValue
                          usmUserPublic=randomValue)

                 If you do the key change for yourself:

                   4) SET(usmUserSpinLock.0=sValue,
                          usmUserOwnAuthKeyChange=kcValue
                          usmUserPublic=randomValue)

                 If you get a response with error-status of noError,
                 then the SET succeeded and the new key is active.
                 If you do not get a response, then you can issue a
                 GET(usmUserPublic) and check if the value is equal
                 to the randomValue you did send in the SET. If so, then
                 the key change succeeded and the new key is active
                 (probably the response got lost). If not, then the SET
                 request probably never reached the target and so you
                 can start over with the procedure above.
                "))
(defoid |usmUserOwnAuthKeyChange| (|usmUserEntry| 7)
  (:type 'object-type)
  (:syntax '|KeyChange|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Behaves exactly as usmUserAuthKeyChange, with one
                 notable difference: in order for the set operation
                 to succeed, the usmUserName of the operation
                 requester must match the usmUserName that
                 indexes the row which is targeted by this
                 operation.
                 In addition, the USM security model must be
                 used for this operation.

                 The idea here is that access to this column can be
                 public, since it will only allow a user to change
                 his own secret authentication key (authKey).
                 Note that this can only be done once the row is active.

                 When a set is received and the usmUserName of the
                 requester is not the same as the umsUserName that
                 indexes the row which is targeted by this operation,
                 then a 'noAccess' error must be returned.

                 When a set is received and the security model in use
                 is not USM, then a 'noAccess' error must be returned.
                "))
(defoid |usmUserPrivProtocol| (|usmUserEntry| 8)
  (:type 'object-type)
  (:syntax '|AutonomousType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An indication of whether messages sent on behalf of
                 this user to/from the SNMP engine identified by
                 usmUserEngineID, can be protected from disclosure,
                 and if so, the type of privacy protocol which is used.

                 An instance of this object is created concurrently
                 with the creation of any other object instance for
                 the same user (i.e., as part of the processing of
                 the set operation which creates the first object
                 instance in the same conceptual row).

                 If an initial set operation (i.e. at row creation time)
                 tries to set a value for an unknown or unsupported
                 protocol, then a 'wrongValue' error must be returned.

                 The value will be overwritten/set when a set operation
                 is performed on the corresponding instance of
                 usmUserCloneFrom.

                 Once instantiated, the value of such an instance of
                 this object can only be changed via a set operation to
                 the value of the usmNoPrivProtocol.

                 If a set operation tries to change the value of an
                 existing instance of this object to any value other
                 than usmNoPrivProtocol, then an 'inconsistentValue'
                 error must be returned.

                 Note that if any privacy protocol is used, then you
                 must also use an authentication protocol. In other
                 words, if usmUserPrivProtocol is set to anything else
                 than usmNoPrivProtocol, then the corresponding instance
                 of usmUserAuthProtocol cannot have a value of

                 usmNoAuthProtocol. If it does, then an
                 'inconsistentValue' error must be returned.
                "))
(defoid |usmUserPrivKeyChange| (|usmUserEntry| 9)
  (:type 'object-type)
  (:syntax '|KeyChange|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "An object, which when modified, causes the secret
                 encryption key used for messages sent on behalf
                 of this user to/from the SNMP engine identified by
                 usmUserEngineID, to be modified via a one-way
                 function.

                 The associated protocol is the usmUserPrivProtocol.
                 The associated secret key is the user's secret
                 privacy key (privKey). The associated hash
                 algorithm is the algorithm used by the user's
                 usmUserAuthProtocol.

                 When creating a new user, it is an 'inconsistentName'
                 error for a set operation to refer to this object
                 unless it is previously or concurrently initialized
                 through a set operation on the corresponding instance
                 of usmUserCloneFrom.

                 When the value of the corresponding usmUserPrivProtocol
                 is usmNoPrivProtocol, then a set is successful, but
                 effectively is a no-op.

                 When this object is read, the zero-length (empty)
                 string is returned.
                 See the description clause of usmUserAuthKeyChange for
                 a recommended procedure to do a key change.
                "))
(defoid |usmUserOwnPrivKeyChange| (|usmUserEntry| 10)
  (:type 'object-type)
  (:syntax '|KeyChange|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "Behaves exactly as usmUserPrivKeyChange, with one
                 notable difference: in order for the Set operation
                 to succeed, the usmUserName of the operation
                 requester must match the usmUserName that indexes

                 the row which is targeted by this operation.
                 In addition, the USM security model must be
                 used for this operation.

                 The idea here is that access to this column can be
                 public, since it will only allow a user to change
                 his own secret privacy key (privKey).
                 Note that this can only be done once the row is active.

                 When a set is received and the usmUserName of the
                 requester is not the same as the umsUserName that
                 indexes the row which is targeted by this operation,
                 then a 'noAccess' error must be returned.

                 When a set is received and the security model in use
                 is not USM, then a 'noAccess' error must be returned.
                "))
(defoid |usmUserPublic| (|usmUserEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A publicly-readable value which can be written as part
                 of the procedure for changing a user's secret
                 authentication and/or privacy key, and later read to
                 determine whether the change of the secret was
                 effected.
                "))
(defoid |usmUserStorageType| (|usmUserEntry| 12)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The storage type for this conceptual row.

                 Conceptual rows having the value 'permanent' must
                 allow write-access at a minimum to:

                 - usmUserAuthKeyChange, usmUserOwnAuthKeyChange
                   and usmUserPublic for a user who employs
                   authentication, and
                 - usmUserPrivKeyChange, usmUserOwnPrivKeyChange
                   and usmUserPublic for a user who employs
                   privacy.

                 Note that any user who employs authentication or
                 privacy must allow its secret(s) to be updated and
                 thus cannot be 'readOnly'.

                 If an initial set operation tries to set the value to
                 'readOnly' for a user who employs authentication or
                 privacy, then an 'inconsistentValue' error must be
                 returned.  Note that if the value has been previously
                 set (implicit or explicit) to any value, then the rules
                 as defined in the StorageType Textual Convention apply.

                 It is an implementation issue to decide if a SET for
                 a readOnly or permanent row is accepted at all. In some
                 contexts this may make sense, in others it may not. If
                 a SET for a readOnly or permanent row is not accepted
                 at all, then a 'wrongValue' error must be returned.
                "))
(defoid |usmUserStatus| (|usmUserEntry| 13)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The status of this conceptual row.

                 Until instances of all corresponding columns are
                 appropriately configured, the value of the
                 corresponding instance of the usmUserStatus column
                 is 'notReady'.

                 In particular, a newly created row for a user who
                 employs authentication, cannot be made active until the
                 corresponding usmUserCloneFrom and usmUserAuthKeyChange
                 have been set.

                 Further, a newly created row for a user who also
                 employs privacy, cannot be made active until the
                 usmUserPrivKeyChange has been set.

                 The RowStatus TC [RFC2579] requires that this
                 DESCRIPTION clause states under which circumstances
                 other objects in this row can be modified:

                 The value of this object has no effect on whether
                 other objects in this conceptual row can be modified,
                 except for usmUserOwnAuthKeyChange and
                 usmUserOwnPrivKeyChange. For these 2 objects, the

                 value of usmUserStatus MUST be active.
                "))
(defoid |usmMIBCompliances| (|usmMIBConformance| 1)
  (:type 'object-identity))
(defoid |usmMIBGroups| (|usmMIBConformance| 2) (:type 'object-identity))
(defoid |usmMIBCompliance| (|usmMIBCompliances| 1)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP engines which
                 implement the SNMP-USER-BASED-SM-MIB.
                "))
(defoid |usmMIBBasicGroup| (|usmMIBGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing for configuration
                 of an SNMP engine which implements the SNMP
                 User-based Security Model.
                "))
