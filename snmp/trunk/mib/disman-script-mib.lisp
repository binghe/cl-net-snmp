;;;; -*- Mode: Lisp -*-
;;;; Auto-generated from MIB:NET-SNMP;DISMAN-SCRIPT-MIB.TXT

(in-package :asn.1)
(setf *current-module* 'disman-script-mib)
(eval-when (:load-toplevel :execute)
  (pushnew 'disman-script-mib *mib-modules*))
(defoid |scriptMIB| (|mib-2| 64)
  (:type 'module-identity)
  (:description
   "This MIB module defines a set of objects that allow to
         delegate management scripts to distributed managers."))
(defoid |smObjects| (|scriptMIB| 1) (:type 'object-identity))
(defoid |smNotifications| (|scriptMIB| 2) (:type 'object-identity))
(defoid |smConformance| (|scriptMIB| 3) (:type 'object-identity))
(defoid |smLangTable| (|smObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This table lists supported script languages."))
(defoid |smLangEntry| (|smLangTable| 1)
  (:type 'object-type)
  (:syntax '|SmLangEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry describing a particular language."))
(deftype |SmLangEntry| () 't)
(defoid |smLangIndex| (|smLangEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this language entry.

         The value is expected to remain constant at least from one
         re-initialization of the entity's network management system
         to the next re-initialization.

         Note that the data type and the range of this object must
         be consistent with the definition of smScriptLanguage."))
(defoid |smLangLanguage| (|smLangEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The globally unique identification of the language."))
(defoid |smLangVersion| (|smLangEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The version number of the language. The zero-length string
         shall be used if the language does not have a version
         number.

         It is suggested that the version number consist of one or
         more decimal numbers separated by dots, where the first
         number is called the major version number."))
(defoid |smLangVendor| (|smLangEntry| 4)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An object identifier which identifies the vendor who
         provides the implementation of the language. This object
         identifier SHALL point to the object identifier directly
         below the enterprise object identifier {1 3 6 1 4 1}
         allocated for the vendor. The value must be the object
         identifier {0 0} if the vendor is not known."))
(defoid |smLangRevision| (|smLangEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The version number of the language implementation.
         The value of this object must be an empty string if
         version number of the implementation is unknown.

         It is suggested that the value consist of one or more
         decimal numbers separated by dots, where the first
         number is called the major version number."))
(defoid |smLangDescr| (|smLangEntry| 6)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "A textual description of the language."))
(defoid |smExtsnTable| (|smObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "This table lists supported language extensions."))
(defoid |smExtsnEntry| (|smExtsnTable| 1)
  (:type 'object-type)
  (:syntax '|SmExtsnEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry describing a particular language extension."))
(deftype |SmExtsnEntry| () 't)
(defoid |smExtsnIndex| (|smExtsnEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this language extension entry.

         The value is expected to remain constant at least from one
         re-initialization of the entity's network management system
         to the next re-initialization."))
(defoid |smExtsnExtension| (|smExtsnEntry| 2)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The globally unique identification of the language
         extension."))
(defoid |smExtsnVersion| (|smExtsnEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The version number of the language extension.
         It is suggested that the version number consist of one or
         more decimal numbers separated by dots, where the first
         number is called the major version number."))
(defoid |smExtsnVendor| (|smExtsnEntry| 4)
  (:type 'object-type)
  (:syntax 'object-id)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "An object identifier which identifies the vendor who
         provides the implementation of the extension. The
         object identifier value should point to the OID node
         directly below the enterprise OID {1 3 6 1 4 1}
         allocated for the vendor. The value must by the object
         identifier {0 0} if the vendor is not known."))
(defoid |smExtsnRevision| (|smExtsnEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The version number of the extension implementation.
         The value of this object must be an empty string if
         version number of the implementation is unknown.

         It is suggested that the value consist of one or more
         decimal numbers separated by dots, where the first
         number is called the major version number."))
(defoid |smExtsnDescr| (|smExtsnEntry| 6)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "A textual description of the language extension."))
(defoid |smScriptObjects| (|smObjects| 3) (:type 'object-identity))
(defoid |smScriptTable| (|smScriptObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table lists and describes locally known scripts."))
(defoid |smScriptEntry| (|smScriptTable| 1)
  (:type 'object-type)
  (:syntax '|SmScriptEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry describing a particular script. Every script that
         is stored in non-volatile memory is required to appear in
         this script table."))
(deftype |SmScriptEntry| () 't)
(defoid |smScriptOwner| (|smScriptEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The manager who owns this row in the smScriptTable."))
(defoid |smScriptName| (|smScriptEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally-unique, administratively assigned name for this
         script. This object allows an smScriptOwner to have multiple
         entries in the smScriptTable.

         This value of this object may be used to derive the name
         (e.g. a file name) which is used by the Script MIB
         implementation to access the script in non-volatile
         storage. The details of this mapping are implementation
         specific. However, the mapping needs to ensure that scripts
         created by different owners with the same script name do not
         map to the same name in non-volatile storage."))
(defoid |smScriptDescr| (|smScriptEntry| 3)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description "A description of the purpose of the script."))
(defoid |smScriptLanguage| (|smScriptEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object type identifies an entry in the
         smLangTable which is used to execute this script.
         The special value 0 may be used by hard-wired scripts
         that can not be modified and that are executed by
         internal functions.

         Set requests to change this object are invalid if the
         value of smScriptOperStatus is `enabled' or `compiling'
         and will result in an inconsistentValue error.

         Note that the data type and the range of this object must
         be consistent with the definition of smLangIndex."))
(defoid |smScriptSource| (|smScriptEntry| 5)
  (:type 'object-type)
  (:syntax '|DisplayString|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object either contains a reference to the script
         source or an empty string. A reference must be given
         in the form of a Uniform Resource Locator (URL) as
         defined in RFC 2396. The allowed character sets and the
         encoding rules defined in RFC 2396 section 2 apply.

         When the smScriptAdminStatus object is set to `enabled',
         the Script MIB implementation will `pull' the script
         source from the URL contained in this object if the URL
         is not empty.

         An empty URL indicates that the script source is loaded
         from local storage. The script is read from the smCodeTable
         if the value of smScriptStorageType is volatile. Otherwise,
         the script is read from non-volatile storage.

         Note: This document does not mandate implementation of any
         specific URL scheme. An attempt to load a script from a
         nonsupported URL scheme will cause the smScriptOperStatus
         to report an `unknownProtocol' error.

         Set requests to change this object are invalid if the
         value of smScriptOperStatus is `enabled', `editing',
         `retrieving' or `compiling' and will result in an
         inconsistentValue error."))
(defoid |smScriptAdminStatus| (|smScriptEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object indicates the desired status of
         the script. See the definition of smScriptOperStatus for
         a description of the values.

         When the smScriptAdminStatus object is set to `enabled' and
         the smScriptOperStatus is `disabled' or one of the error
         states, the Script MIB implementation will `pull' the script
         source from the URL contained in the smScriptSource object
         if the URL is not empty."))
(defoid |smScriptOperStatus| (|smScriptEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The actual status of the script in the runtime system. The
         value of this object is only meaningful when the value of
         the smScriptRowStatus object is `active'.

         The smScriptOperStatus object may have the following values:

         - `enabled' indicates that the script is available and can
            be started by a launch table entry.

         - `disabled' indicates that the script can not be used.

         - `editing' indicates that the script can be modified in the
           smCodeTable.

         - `retrieving' indicates that the script is currently being
           loaded from non-volatile storage or a remote system.

         - `compiling' indicates that the script is currently being
           compiled by the runtime system.

         - `noSuchScript' indicates that the script does not exist
           at the smScriptSource.

         - `accessDenied' indicates that the script can not be loaded
           from the smScriptSource due to a lack of permissions.

         - `wrongLanguage' indicates that the script can not be
            loaded from the smScriptSource because of a language
            mismatch.

         - `wrongVersion' indicates that the script can not be loaded
           from the smScriptSource because of a language version
           mismatch.

         - `compilationFailed' indicates that the compilation failed.

         - `noResourcesLeft' indicates that the runtime system does
           not have enough resources to load the script.

         - `unknownProtocol' indicates that the script could not be
           loaded from the smScriptSource because the requested
           protocol is not supported.

         - `protocolFailure' indicates that the script could not be
           loaded from the smScriptSource because of a protocol
           failure.

         - `genericError' indicates that the script could not be

           loaded due to an error condition not listed above.

         The `retrieving' and `compiling' states are transient states
         which will either lead to one of the error states or the
         `enabled' state. The `disabled' and `editing' states are
         administrative states which are only reached by explicit
         management operations.

         All launch table entries that refer to this script table
         entry shall have an smLaunchOperStatus value of `disabled'
         when the value of this object is not `enabled'."))
(defoid |smScriptStorageType| (|smScriptEntry| 8)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object defines whether this row and the script
         controlled by this row are kept in volatile storage and
         lost upon reboot or if this row is backed up by
         non-volatile or permanent storage.

         The storage type of this row always complies with the value
         of this entry if the value of the corresponding RowStatus
         object is `active'.

         However, the storage type of the script controlled by this
         row may be different, if the value of this entry is
         `non-volatile'. The script controlled by this row is written
         into local non-volatile storage if the following condition
         becomes true:

         (a) the URL contained in the smScriptSource object is empty
             and
         (b) the smScriptStorageType is `nonVolatile'
             and
         (c) the smScriptOperStatus is `enabled'

         Setting this object to `volatile' removes a script from
         non-volatile storage if the script controlled by this row
         has been in non-volatile storage before. Attempts to set
         this object to permanent will always fail with an
         inconsistentValue error.

         The value of smScriptStorageType is only meaningful if the
         value of the corresponding RowStatus object is `active'.

         If smScriptStorageType has the value permanent(4), then all
         objects whose MAX-ACCESS value is read-create must be
         writable, with the exception of the smScriptStorageType and
         smScriptRowStatus objects, which shall be read-only."))
(defoid |smScriptRowStatus| (|smScriptEntry| 9)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A control that allows entries to be added and removed from
         this table.

         Changing the smScriptRowStatus from `active' to
         `notInService' will remove the associated script from the
         runtime system.

         Deleting conceptual rows from this table may affect the
         deletion of other resources associated with this row. For
         example, a script stored in non-volatile storage may be
         removed from non-volatile storage.

         An entry may not exist in the `active' state unless all
         required objects in the entry have appropriate values. Rows
         that are not complete or not in service are not known by the
         script runtime system.

         Attempts to `destroy' a row or to set a row `notInService'
         while the smScriptOperStatus is `enabled' will result in an
         inconsistentValue error.

         Attempts to `destroy' a row or to set a row `notInService'
         where the value of the smScriptStorageType object is
         `permanent' or `readOnly' will result in an
         inconsistentValue error.

         The value of this object has no effect on whether other
         objects in this conceptual row can be modified."))
(defoid |smScriptError| (|smScriptEntry| 10)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object contains a descriptive error message if the

         transition into the operational status `enabled' failed.
         Implementations must reset the error message to a
         zero-length string when a new attempt to change the
         script status to `enabled' is started."))
(defoid |smScriptLastChange| (|smScriptEntry| 11)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when this script table entry was last
         modified. The value '0000000000000000'H is returned if
         the script table entry has not yet been modified.

         Note that the resetting of smScriptError is not considered
         a change of the script table entry."))
(defoid |smCodeTable| (|smScriptObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table contains the script code for scripts that are
         written via SNMP write operations."))
(defoid |smCodeEntry| (|smCodeTable| 1)
  (:type 'object-type)
  (:syntax '|SmCodeEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry describing a particular fragment of a script."))
(deftype |SmCodeEntry| () 't)
(defoid |smCodeIndex| (|smCodeEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "The index value identifying this code fragment."))
(defoid |smCodeText| (|smCodeEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The code that makes up a fragment of a script. The format
         of this code fragment depends on the script language which
         is identified by the associated smScriptLanguage object."))
(defoid |smCodeRowStatus| (|smCodeEntry| 3)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A control that allows entries to be added and removed from
         this table.

         The value of this object has no effect on whether other
         objects in this conceptual row can be modified."))
(defoid |smRunObjects| (|smObjects| 4) (:type 'object-identity))
(defoid |smLaunchTable| (|smRunObjects| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table lists and describes scripts that are ready
         to be executed together with their parameters."))
(defoid |smLaunchEntry| (|smLaunchTable| 1)
  (:type 'object-type)
  (:syntax '|SmLaunchEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description "An entry describing a particular executable script."))
(deftype |SmLaunchEntry| () 't)
(defoid |smLaunchOwner| (|smLaunchEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The manager who owns this row in the smLaunchTable. Every
         instance of a running script started from a particular entry
         in the smLaunchTable (i.e. entries in the smRunTable) will
         be owned by the same smLaunchOwner used to index the entry
         in the smLaunchTable. This owner is not necessarily the same
         as the owner of the script itself (smLaunchScriptOwner)."))
(defoid |smLaunchName| (|smLaunchEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally-unique, administratively assigned name for this
         launch table entry. This object allows an smLaunchOwner to
         have multiple entries in the smLaunchTable. The smLaunchName
         is an arbitrary name that must be different from any other
         smLaunchTable entries with the same smLaunchOwner but can be
         the same as other entries in the smLaunchTable with
         different smLaunchOwner values. Note that the value of
         smLaunchName is not related in any way to the name of the
         script being launched."))
(defoid |smLaunchScriptOwner| (|smLaunchEntry| 3)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object in combination with the value of
         smLaunchScriptName identifies the script that can be
         launched from this smLaunchTable entry. Attempts to write
         this object will fail with an inconsistentValue error if
         the value of smLaunchOperStatus is `enabled'."))
(defoid |smLaunchScriptName| (|smLaunchEntry| 4)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object in combination with the value of
         the smLaunchScriptOwner identifies the script that can be
         launched from this smLaunchTable entry. The zero-length
         string may be used to point to a non-existing script.

         Attempts to write this object will fail with an
         inconsistentValue error if the value of smLaunchOperStatus
         is `enabled'."))
(defoid |smLaunchArgument| (|smLaunchEntry| 5)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The argument supplied to the script. When a script is
         invoked, the value of this object is used to initialize
         the smRunArgument object."))
(defoid |smLaunchMaxRunning| (|smLaunchEntry| 6)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of concurrently running scripts that may
         be invoked from this entry in the smLaunchTable. Lowering
         the current value of this object does not affect any scripts
         that are already executing."))
(defoid |smLaunchMaxCompleted| (|smLaunchEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The maximum number of finished scripts invoked from this
         entry in the smLaunchTable allowed to be retained in the
         smRunTable. Whenever the value of this object is changed
         and whenever a script terminates, entries in the smRunTable
         are deleted if necessary until the number of completed
         scripts is smaller than the value of this object. Scripts
         whose smRunEndTime value indicates the oldest completion
         time are deleted first."))
(defoid |smLaunchLifeTime| (|smLaunchEntry| 8)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The default maximum amount of time a script launched
         from this entry may run. The value of this object is used
         to initialize the smRunLifeTime object when a script is
         launched. Changing the value of an smLaunchLifeTime
         instance does not affect scripts previously launched from

         this entry."))
(defoid |smLaunchExpireTime| (|smLaunchEntry| 9)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The default maximum amount of time information about a
         script launched from this entry is kept in the smRunTable
         after the script has completed execution.  The value of
         this object is used to initialize the smRunExpireTime
         object when a script is launched. Changing the value of an
         smLaunchExpireTime instance does not affect scripts
         previously launched from this entry."))
(defoid |smLaunchStart| (|smLaunchEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object is used to start the execution of scripts.
         When retrieved, the value will be the value of smRunIndex
         for the last script that started execution by manipulating
         this object. The value will be zero if no script started
         execution yet.

         A script is started by setting this object to an unused
         smRunIndex value. A new row in the smRunTable will be
         created which is indexed by the value supplied by the
         set-request in addition to the value of smLaunchOwner and
         smLaunchName. An unused value can be obtained by reading
         the smLaunchRunIndexNext object.

         Setting this object to the special value 0 will start
         the script with a self-generated smRunIndex value. The
         consequence is that the script invoker has no reliable
         way to determine the smRunIndex value for this script
         invocation and that the invoker has therefore no way
         to obtain the results from this script invocation. The
         special value 0 is however useful for scheduled script
         invocations.

         If this object is set, the following checks must be

         performed:

         1) The value of the smLaunchOperStatus object in this
            entry of the smLaunchTable must be `enabled'.
         2) The values of smLaunchScriptOwner and
            smLaunchScriptName of this row must identify an
            existing entry in the smScriptTable.
         3) The value of smScriptOperStatus of this entry must
            be `enabled'.
         4) The principal performing the set operation must have
            read access to the script. This must be checked by
            calling the isAccessAllowed abstract service interface
            defined in RFC 2271 on the row in the smScriptTable
            identified by smLaunchScriptOwner and smLaunchScriptName.
            The isAccessAllowed abstract service interface must be
            called on all columnar objects in the smScriptTable with
            a MAX-ACCESS value different than `not-accessible'. The
            test fails as soon as a call indicates that access is
            not allowed.
         5) If the value provided by the set operation is not 0,
            a check must be made that the value is currently not
            in use. Otherwise, if the value provided by the set
            operation is 0, a suitable unused value must be
            generated.
         6) The number of currently executing scripts invoked
            from this smLaunchTable entry must be less than
            smLaunchMaxRunning.

         Attempts to start a script will fail with an
         inconsistentValue error if one of the checks described
         above fails.

         Otherwise, if all checks have been passed, a new entry
         in the smRunTable will be created indexed by smLaunchOwner,
         smLaunchName and the new value for smRunIndex. The value
         of smLaunchArgument will be copied into smRunArgument,
         the value of smLaunchLifeTime will be copied to
         smRunLifeTime, and the value of smLaunchExpireTime
         will be copied to smRunExpireTime.

         The smRunStartTime will be set to the current time and
         the smRunState will be set to `initializing' before the
         script execution is initiated in the appropriate runtime
         system.

         Note that the data type and the range of this object must
         be consistent with the smRunIndex object. Since this
         object might be written from the scheduling MIB, the

         data type Integer32 rather than Unsigned32 is used."))
(defoid |smLaunchControl| (|smLaunchEntry| 11)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object is used to request a state change for all
         running scripts in the smRunTable that were started from
         this row in the smLaunchTable.

         Setting this object to abort(1), suspend(2) or resume(3)
         will set the smRunControl object of all applicable rows
         in the smRunTable to abort(1), suspend(2) or resume(3)
         respectively. The phrase `applicable rows' means the set of
         rows which were created from this entry in the smLaunchTable
         and whose value of smRunState allows the corresponding
         state change as described in the definition of the
         smRunControl object. Setting this object to nop(4) has no
         effect.

         Attempts to set this object lead to an inconsistentValue
         error only if all implicated sets on all the applicable
         rows lead to inconsistentValue errors. It is not allowed
         to return an inconsistentValue error if at least one state
         change on one of the applicable rows was successful."))
(defoid |smLaunchAdminStatus| (|smLaunchEntry| 12)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object indicates the desired status of
         this launch table entry. The values enabled(1) and
         autostart(3) both indicate that the launch table entry

         should transition into the operational enabled(1) state as
         soon as the associated script table entry is enabled(1).

         The value autostart(3) further indicates that the script
         is started automatically by conceptually writing the
         value 0 into the associated smLaunchStart object during
         the transition from the `disabled' into the `enabled'
         operational state. This is useful for scripts that are
         to be launched on system start-up."))
(defoid |smLaunchOperStatus| (|smLaunchEntry| 13)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object indicates the actual status of
         this launch table entry.  The smLaunchOperStatus object
         may have the following values:

         - `enabled' indicates that the launch table entry is
           available and can be used to start scripts.

         - `disabled' indicates that the launch table entry can
           not be used to start scripts.

         - `expired' indicates that the launch table entry can
           not be used to start scripts and will disappear as
           soon as all smRunTable entries associated with this
           launch table entry have disappeared.

         The value `enabled' requires that the smLaunchRowStatus
         object is active. The value `disabled' requires that there
         are no entries in the smRunTable associated with this
         smLaunchTable entry."))
(defoid |smLaunchRunIndexNext| (|smLaunchEntry| 14)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This variable is used for creating rows in the smRunTable.
         The value of this variable is a currently unused value
         for smRunIndex, which can be written into the smLaunchStart
         object associated with this row to launch a script.

         The value returned when reading this variable must be unique
         for the smLaunchOwner and smLaunchName associated with this
         row. Subsequent attempts to read this variable must return
         different values.

         This variable will return the special value 0 if no new rows
         can be created.

         Note that the data type and the range of this object must be
         consistent with the definition of smRunIndex."))
(defoid |smLaunchStorageType| (|smLaunchEntry| 15)
  (:type 'object-type)
  (:syntax '|StorageType|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "This object defines if this row is kept in volatile storage
         and lost upon reboot or if this row is backed up by stable
         storage.

         The value of smLaunchStorageType is only meaningful if the
         value of the corresponding RowStatus object is active.

         If smLaunchStorageType has the value permanent(4), then all
         objects whose MAX-ACCESS value is read-create must be
         writable, with the exception of the smLaunchStorageType and
         smLaunchRowStatus objects, which shall be read-only."))
(defoid |smLaunchRowStatus| (|smLaunchEntry| 16)
  (:type 'object-type)
  (:syntax '|RowStatus|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "A control that allows entries to be added and removed from
         this table.

         Attempts to `destroy' a row or to set a row `notInService'
         while the smLaunchOperStatus is `enabled' will result in
         an inconsistentValue error.

         Attempts to `destroy' a row or to set a row `notInService'
         where the value of the smLaunchStorageType object is
         `permanent' or `readOnly' will result in an
         inconsistentValue error.

         The value of this object has no effect on whether other
         objects in this conceptual row can be modified."))
(defoid |smLaunchError| (|smLaunchEntry| 17)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object contains a descriptive error message if an
         attempt to launch a script fails. Implementations must reset
         the error message to a zero-length string when a new attempt
         to launch a script is started."))
(defoid |smLaunchLastChange| (|smLaunchEntry| 18)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when this launch table entry was last
         modified. The value '0000000000000000'H is returned if
         the launch table entry has not yet been modified.

         Note that a change of smLaunchStart, smLaunchControl,
         smLaunchRunIndexNext, smLaunchRowExpireTime, or the
         resetting of smLaunchError is not considered a change
         of this launch table entry."))
(defoid |smLaunchRowExpireTime| (|smLaunchEntry| 19)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-create|)
  (:status '|current|)
  (:description
   "The value of this object specifies how long this row remains
         in the `enabled' or `disabled' operational state. The value
         reported by this object ticks backwards. When the value
         reaches 0, it stops ticking backward and the row is
         deleted if there are no smRunTable entries associated with

         this smLaunchTable entry. Otherwise, the smLaunchOperStatus
         changes to `expired' and the row deletion is deferred
         until there are no smRunTable entries associated with this
         smLaunchTable entry.

         The smLaunchRowExpireTime will not tick backwards if it is
         set to its maximum value (2147483647). In other words,
         setting this object to its maximum value turns the timer
         off.

         The value of this object may be set in order to increase
         or reduce the remaining time that the launch table entry
         may be used. Setting the value to 0 will cause an immediate
         row deletion or transition into the `expired' operational
         state.

         It is not possible to set this object while the operational
         status is `expired'. Attempts to modify this object while
         the operational status is `expired' leads to an
         inconsistentValue error.

         Note that the timer ticks backwards independent of the
         operational state of the launch table entry."))
(defoid |smRunTable| (|smRunObjects| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "This table lists and describes scripts that are currently
         running or have been running in the past."))
(defoid |smRunEntry| (|smRunTable| 1)
  (:type 'object-type)
  (:syntax '|SmRunEntry|)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "An entry describing a particular running or finished
         script."))
(deftype |SmRunEntry| () 't)
(defoid |smRunIndex| (|smRunEntry| 1)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|not-accessible|)
  (:status '|current|)
  (:description
   "The locally arbitrary, but unique identifier associated
         with this running or finished script. This value must be
         unique for all rows in the smRunTable with the same
         smLaunchOwner and smLaunchName.

         Note that the data type and the range of this object must
         be consistent with the definition of smLaunchRunIndexNext
         and smLaunchStart."))
(defoid |smRunArgument| (|smRunEntry| 2)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description "The argument supplied to the script when it started."))
(defoid |smRunStartTime| (|smRunEntry| 3)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when the execution started. The value
         '0000000000000000'H is returned if the script has not
         started yet."))
(defoid |smRunEndTime| (|smRunEntry| 4)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when the execution terminated. The value
         '0000000000000000'H is returned if the script has not
         terminated yet."))
(defoid |smRunLifeTime| (|smRunEntry| 5)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "This object specifies how long the script can execute.
         This object returns the remaining time that the script
         may run. The object is initialized with the value of the
         associated smLaunchLifeTime object and ticks backwards.
         The script is aborted immediately when the value reaches 0.

         The value of this object may be set in order to increase or
         reduce the remaining time that the script may run. Setting
         this value to 0 will abort script execution immediately,
         and, if the value of smRunExpireTime is also 0, will remove
         this entry from the smRunTable once it has terminated.

         If smRunLifeTime is set to its maximum value (2147483647),
         either by a set operation or by its initialization from the
         smLaunchLifeTime object, then it will not tick backwards.
         A running script with a maximum smRunLifeTime value will
         thus never be terminated with a `lifeTimeExceeded' exit
         code.

         The value of smRunLifeTime reflects the real-time execution
         time as seen by the outside world. The value of this object
         will always be 0 for a script that finished execution, that
         is smRunState has the value `terminated'.

         The value of smRunLifeTime does not change while a script
         is suspended, that is smRunState has the value `suspended'.
         Note that this does not affect set operations. It is legal
         to modify smRunLifeTime via set operations while a script
         is suspended."))
(defoid |smRunExpireTime| (|smRunEntry| 6)
  (:type 'object-type)
  (:syntax '|TimeInterval|)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The value of this object specifies how long this row can
         exist in the smRunTable after the script has terminated.
         This object returns the remaining time that the row may
         exist before it is aged out. The object is initialized with
         the value of the associated smLaunchExpireTime object and
         ticks backwards. The entry in the smRunTable is destroyed
         when the value reaches 0 and the smRunState has the value
         `terminated'.

         The value of this object may be set in order to increase or
         reduce the remaining time that the row may exist.  Setting
         the value to 0 will destroy this entry as soon as the
         smRunState has the value `terminated'."))
(defoid |smRunExitCode| (|smRunEntry| 7)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object indicates the reason why a
         script finished execution. The smRunExitCode code may have
         one of the following values:

         - `noError', which indicates that the script completed
            successfully without errors;

         - `halted', which indicates that the script was halted
            by a request from an authorized manager;

         - `lifeTimeExceeded', which indicates that the script
            exited because a time limit was exceeded;

         - `noResourcesLeft', which indicates that the script
            exited because it ran out of resources (e.g. memory);

         - `languageError', which indicates that the script exited
            because of a language error (e.g. a syntax error in an
            interpreted language);

         - `runtimeError', which indicates that the script exited
            due to a runtime error (e.g. a division by zero);

         - `invalidArgument', which indicates that the script could
            not be run because of invalid script arguments;

         - `securityViolation', which indicates that the script
            exited due to a security violation;

         - `genericError', which indicates that the script exited
            for an unspecified reason.

         If the script has not yet begun running, or is currently
         running, the value will be `noError'."))
(defoid |smRunResult| (|smRunEntry| 8)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The result value produced by the running script. Note that
         the result may change while the script is executing."))
(defoid |smRunControl| (|smRunEntry| 9)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-write|)
  (:status '|current|)
  (:description
   "The value of this object indicates the desired status of the
         script execution defined by this row.

         Setting this object to `abort' will abort execution if the

         value of smRunState is `initializing', `executing',
         `suspending', `suspended' or `resuming'. Setting this object
         to `abort' when the value of smRunState is `aborting' or
         `terminated', or if the implementation can determine that
         the attempt to abort the execution would fail, will result
         in an inconsistentValue error.

         Setting this object to `suspend' will suspend execution
         if the value of smRunState is `executing'. Setting this
         object to `suspend' will cause an inconsistentValue error
         if the value of smRunState is not `executing' or if the
         implementation can determine that the attempt to suspend
         the execution would fail.

         Setting this object to `resume' will resume execution
         if the value of smRunState is `suspending' or
         `suspended'. Setting this object to `resume' will cause an
         inconsistentValue error if the value of smRunState is
         not `suspended' or if the implementation can determine
         that the attempt to resume the execution would fail.

         Setting this object to nop(4) has no effect."))
(defoid |smRunState| (|smRunEntry| 10)
  (:type 'object-type)
  (:syntax 't)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The value of this object indicates the script's execution
         state. If the script has been invoked but has not yet
         begun execution, the value will be `initializing'. If the
         script is running, the value will be `executing'.

         A running script which received a request to suspend
         execution first transitions into a temporary `suspending'
         state.  The temporary `suspending' state changes to
         `suspended' when the script has actually been suspended. The
         temporary `suspending' state changes back to `executing' if

         the attempt to suspend the running script fails.

         A suspended script which received a request to resume
         execution first transitions into a temporary `resuming'
         state. The temporary `resuming' state changes to `running'
         when the script has actually been resumed. The temporary
         `resuming' state changes back to `suspended' if the attempt
         to resume the suspended script fails.

         A script which received a request to abort execution but
         which is still running first transitions into a temporary
         `aborting' state.

         A script which has finished its execution is `terminated'."))
(defoid |smRunError| (|smRunEntry| 11)
  (:type 'object-type)
  (:syntax '|SnmpAdminString|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "This object contains a descriptive error message if the
         script startup or execution raised an abnormal condition.
         An implementation must store a descriptive error message
         in this object if the script exits with the smRunExitCode
         `genericError'."))
(defoid |smRunResultTime| (|smRunEntry| 12)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when the smRunResult was last updated.
         The value '0000000000000000'H is returned if smRunResult
         has not yet been updated after the creation of this
         smRunTable entry."))
(defoid |smRunErrorTime| (|smRunEntry| 13)
  (:type 'object-type)
  (:syntax '|DateAndTime|)
  (:max-access '|read-only|)
  (:status '|current|)
  (:description
   "The date and time when the smRunError was last updated.
         The value '0000000000000000'H is returned if smRunError

         has not yet been updated after the creation of this
         smRunTable entry."))
(defoid |smTraps| (|smNotifications| 0) (:type 'object-identity))
(defoid |smScriptAbort| (|smTraps| 1)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification is generated whenever a running script
         terminates with an smRunExitCode unequal to `noError'."))
(defoid |smScriptResult| (|smTraps| 2)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification can be used by scripts to notify other
         management applications about results produced by the
         script.

         This notification is not automatically generated by the
         Script MIB implementation. It is the responsibility of
         the executing script to emit this notification where it
         is appropriate to do so."))
(defoid |smScriptException| (|smTraps| 3)
  (:type 'notification-type)
  (:status '|current|)
  (:description
   "This notification can be used by scripts to notify other
         management applications about script errors.

         This notification is not automatically generated by the
         Script MIB implementation. It is the responsibility of
         the executing script or the runtime system to emit this
         notification where it is appropriate to do so."))
(defoid |smCompliances| (|smConformance| 1) (:type 'object-identity))
(defoid |smGroups| (|smConformance| 2) (:type 'object-identity))
(defoid |smCompliance2| (|smCompliances| 2)
  (:type 'module-compliance)
  (:status '|current|)
  (:description
   "The compliance statement for SNMP entities which implement
         the Script MIB."))
(defoid |smLanguageGroup| (|smGroups| 1)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information about the
         capabilities of the scripting engine."))
(defoid |smScriptGroup2| (|smGroups| 7)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information about
         installed scripts."))
(defoid |smCodeGroup| (|smGroups| 3)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects used to download or modify scripts
         by using SNMP set requests."))
(defoid |smLaunchGroup2| (|smGroups| 8)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information about scripts
         that can be launched."))
(defoid |smRunGroup2| (|smGroups| 9)
  (:type 'object-group)
  (:status '|current|)
  (:description
   "A collection of objects providing information about running
         scripts."))
(defoid |smNotificationsGroup2| (|smGroups| 10)
  (:type 'notification-group)
  (:status '|current|)
  (:description "The notifications emitted by the Script MIB."))
(defoid |smCompliance| (|smCompliances| 1)
  (:type 'module-compliance)
  (:status '|deprecated|)
  (:description
   "The compliance statement for SNMP entities which implement
         the Script MIB."))
(defoid |smScriptGroup| (|smGroups| 2)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing information about
         installed scripts."))
(defoid |smLaunchGroup| (|smGroups| 4)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing information about scripts
         that can be launched."))
(defoid |smRunGroup| (|smGroups| 5)
  (:type 'object-group)
  (:status '|deprecated|)
  (:description
   "A collection of objects providing information about running
         scripts."))
(defoid |smNotificationsGroup| (|smGroups| 6)
  (:type 'notification-group)
  (:status '|deprecated|)
  (:description "The notifications emitted by the Script MIB."))
