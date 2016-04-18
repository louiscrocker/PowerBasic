' ------------------------------------------------------------
' Library Name:      Microsoft ActiveX Data Objects 2.5 Library
' Library File:      C:\Program Files\Common Files\system\ado\msado25.tlb
' ------------------------------------------------------------
' Version Info:
' -------------
' Company Name:      Microsoft Corporation
' File Description:  Microsoft Data Access - ActiveX Data Objects 2.5 Type Library
' File Version:      2.81.3012.0 (xpsp_sp3_gdr.101108-1643)
' Internal Name:     msado25.rc
' Legal Copyright:   © Microsoft Corporation. All rights reserved.
' Original Filename: msado25.rc
' Product Name:      Microsoft Data Access Components
' Product Version:   2.81.3012.0
' ------------------------------------------------------------
' ProgID:            ADODB.Command.2.8
' Interface Name:    ADODBCommand
'
' ProgID:            ADODB.Connection.2.8
' Interface Name:    ADODBConnection
'
' ProgID:            ADODB.Parameter.2.8
' Interface Name:    ADODBParameter
'
' ProgID:            ADODB.Record.2.8
' Interface Name:    ADODBRecord
'
' ProgID:            ADODB.Recordset.2.8
' Interface Name:    ADODBRecordset
'
' ProgID:            ADODB.Stream.2.8
' Interface Name:    ADODBStream
'
' Interface Prefix:  ADODB
' ------------------------------------------------------------

$PROGID_ADODBCommand28 = "ADODB.Command.2.8"
$PROGID_ADODBConnection28 = "ADODB.Connection.2.8"
$PROGID_ADODBParameter28 = "ADODB.Parameter.2.8"
$PROGID_ADODBRecord28 = "ADODB.Record.2.8"
$PROGID_ADODBRecordset28 = "ADODB.Recordset.2.8"
$PROGID_ADODBStream28 = "ADODB.Stream.2.8"


'Enumeration ADCPROP_ASYNCTHREADPRIORITY_ENUM
Macro enumADODBADCPROP_ASYNCTHREADPRIORITY_ENUM = LONG
%adPriorityLowest                                       = &H00000001
%adPriorityBelowNormal                                  = &H00000002
%adPriorityNormal                                       = &H00000003
%adPriorityAboveNormal                                  = &H00000004
%adPriorityHighest                                      = &H00000005

'Enumeration ADCPROP_AUTORECALC_ENUM
Macro enumADODBADCPROP_AUTORECALC_ENUM = LONG
%adRecalcUpFront                                        = &H00000000
%adRecalcAlways                                         = &H00000001

'Enumeration ADCPROP_UPDATECRITERIA_ENUM
Macro enumADODBADCPROP_UPDATECRITERIA_ENUM = LONG
%adCriteriaKey                                          = &H00000000
%adCriteriaAllCols                                      = &H00000001
%adCriteriaUpdCols                                      = &H00000002
%adCriteriaTimeStamp                                    = &H00000003

'Enumeration ADCPROP_UPDATERESYNC_ENUM
Macro enumADODBADCPROP_UPDATERESYNC_ENUM = LONG
%adResyncNone                                           = &H00000000
%adResyncAutoIncrement                                  = &H00000001
%adResyncConflicts                                      = &H00000002
%adResyncUpdates                                        = &H00000004
%adResyncInserts                                        = &H00000008
%adResyncAll                                            = &H0000000F

'Enumeration AffectEnum
Macro enumADODBAffectEnum = LONG
%adAffectCurrent                                        = &H00000001
%adAffectGroup                                          = &H00000002
%adAffectAll                                            = &H00000003
%adAffectAllChapters                                    = &H00000004

'Enumeration BookmarkEnum
Macro enumADODBBookmarkEnum = LONG
%adBookmarkCurrent                                      = &H00000000
%adBookmarkFirst                                        = &H00000001
%adBookmarkLast                                         = &H00000002

'Enumeration CommandTypeEnum
Macro enumADODBCommandTypeEnum = LONG
%adCmdUnspecified                                       = &HFFFFFFFF
%adCmdUnknown                                           = &H00000008
%adCmdText                                              = &H00000001
%adCmdTable                                             = &H00000002
%adCmdStoredProc                                        = &H00000004
%adCmdFile                                              = &H00000100
%adCmdTableDirect                                       = &H00000200

'Enumeration CompareEnum
Macro enumADODBCompareEnum = LONG
%adCompareLessThan                                      = &H00000000
%adCompareEqual                                         = &H00000001
%adCompareGreaterThan                                   = &H00000002
%adCompareNotEqual                                      = &H00000003
%adCompareNotComparable                                 = &H00000004

'Enumeration ConnectModeEnum
Macro enumADODBConnectModeEnum = LONG
%adModeUnknown                                          = &H00000000
%adModeRead                                             = &H00000001
%adModeWrite                                            = &H00000002
%adModeReadWrite                                        = &H00000003
%adModeShareDenyRead                                    = &H00000004
%adModeShareDenyWrite                                   = &H00000008
%adModeShareExclusive                                   = &H0000000C
%adModeShareDenyNone                                    = &H00000010
%adModeRecursive                                        = &H00400000

'Enumeration ConnectOptionEnum
Macro enumADODBConnectOptionEnum = LONG
%adConnectUnspecified                                   = &HFFFFFFFF
%adAsyncConnect                                         = &H00000010

'Enumeration ConnectPromptEnum
Macro enumADODBConnectPromptEnum = LONG
%adPromptAlways                                         = &H00000001
%adPromptComplete                                       = &H00000002
%adPromptCompleteRequired                               = &H00000003
%adPromptNever                                          = &H00000004

'Enumeration CopyRecordOptionsEnum
Macro enumADODBCopyRecordOptionsEnum = LONG
%adCopyUnspecified                                      = &HFFFFFFFF
%adCopyOverWrite                                        = &H00000001
%adCopyAllowEmulation                                   = &H00000004
%adCopyNonRecursive                                     = &H00000002

'Enumeration CursorLocationEnum
Macro enumADODBCursorLocationEnum = LONG
%adUseNone                                              = &H00000001
%adUseServer                                            = &H00000002
%adUseClient                                            = &H00000003
%adUseClientBatch                                       = &H00000003

'Enumeration CursorOptionEnum
Macro enumADODBCursorOptionEnum = LONG
%adHoldRecords                                          = &H00000100
%adMovePrevious                                         = &H00000200
%adAddNew                                               = &H01000400
%adDelete                                               = &H01000800
%adUpdate                                               = &H01008000
%adBookmark                                             = &H00002000
%adApproxPosition                                       = &H00004000
%adUpdateBatch                                          = &H00010000
%adResync                                               = &H00020000
%adNotify                                               = &H00040000
%adFind                                                 = &H00080000
%adSeek                                                 = &H00400000
%adIndex                                                = &H00800000

'Enumeration CursorTypeEnum
Macro enumADODBCursorTypeEnum = LONG
%adOpenUnspecified                                      = &HFFFFFFFF
%adOpenForwardOnly                                      = &H00000000
%adOpenKeyset                                           = &H00000001
%adOpenDynamic                                          = &H00000002
%adOpenStatic                                           = &H00000003

'Enumeration DataTypeEnum
Macro enumADODBDataTypeEnum = LONG
%adEmpty                                                = &H00000000
%adTinyInt                                              = &H00000010
%adSmallInt                                             = &H00000002
%adInteger                                              = &H00000003
%adBigInt                                               = &H00000014
%adUnsignedTinyInt                                      = &H00000011
%adUnsignedSmallInt                                     = &H00000012
%adUnsignedInt                                          = &H00000013
%adUnsignedBigInt                                       = &H00000015
%adSingle                                               = &H00000004
%adDouble                                               = &H00000005
%adCurrency                                             = &H00000006
%adDecimal                                              = &H0000000E
%adNumeric                                              = &H00000083
%adBoolean                                              = &H0000000B
%adError                                                = &H0000000A
%adUserDefined                                          = &H00000084
%adVariant                                              = &H0000000C
%adIDispatch                                            = &H00000009
%adIUnknown                                             = &H0000000D
%adGUID                                                 = &H00000048
%adDate                                                 = &H00000007
%adDBDate                                               = &H00000085
%adDBTime                                               = &H00000086
%adDBTimeStamp                                          = &H00000087
%adBSTR                                                 = &H00000008
%adChar                                                 = &H00000081
%adVarChar                                              = &H000000C8
%adLongVarChar                                          = &H000000C9
%adWChar                                                = &H00000082
%adVarWChar                                             = &H000000CA
%adLongVarWChar                                         = &H000000CB
%adBinary                                               = &H00000080
%adVarBinary                                            = &H000000CC
%adLongVarBinary                                        = &H000000CD
%adChapter                                              = &H00000088
%adFileTime                                             = &H00000040
%adPropVariant                                          = &H0000008A
%adVarNumeric                                           = &H0000008B
%adArray                                                = &H00002000

'Enumeration EditModeEnum
Macro enumADODBEditModeEnum = LONG
%adEditNone                                             = &H00000000
%adEditInProgress                                       = &H00000001
%adEditAdd                                              = &H00000002
%adEditDelete                                           = &H00000004

'Enumeration ErrorValueEnum
Macro enumADODBErrorValueEnum = LONG
%adErrProviderFailed                                    = &H00000BB8
%adErrInvalidArgument                                   = &H00000BB9
%adErrOpeningFile                                       = &H00000BBA
%adErrReadFile                                          = &H00000BBB
%adErrWriteFile                                         = &H00000BBC
%adErrNoCurrentRecord                                   = &H00000BCD
%adErrIllegalOperation                                  = &H00000C93
%adErrCantChangeProvider                                = &H00000C94
%adErrInTransaction                                     = &H00000CAE
%adErrFeatureNotAvailable                               = &H00000CB3
%adErrItemNotFound                                      = &H00000CC1
%adErrObjectInCollection                                = &H00000D27
%adErrObjectNotSet                                      = &H00000D5C
%adErrDataConversion                                    = &H00000D5D
%adErrObjectClosed                                      = &H00000E78
%adErrObjectOpen                                        = &H00000E79
%adErrProviderNotFound                                  = &H00000E7A
%adErrBoundToCommand                                    = &H00000E7B
%adErrInvalidParamInfo                                  = &H00000E7C
%adErrInvalidConnection                                 = &H00000E7D
%adErrNotReentrant                                      = &H00000E7E
%adErrStillExecuting                                    = &H00000E7F
%adErrOperationCancelled                                = &H00000E80
%adErrStillConnecting                                   = &H00000E81
%adErrInvalidTransaction                                = &H00000E82
%adErrNotExecuting                                      = &H00000E83
%adErrUnsafeOperation                                   = &H00000E84
%adwrnSecurityDialog                                    = &H00000E85
%adwrnSecurityDialogHeader                              = &H00000E86
%adErrIntegrityViolation                                = &H00000E87
%adErrPermissionDenied                                  = &H00000E88
%adErrDataOverflow                                      = &H00000E89
%adErrSchemaViolation                                   = &H00000E8A
%adErrSignMismatch                                      = &H00000E8B
%adErrCantConvertvalue                                  = &H00000E8C
%adErrCantCreate                                        = &H00000E8D
%adErrColumnNotOnThisRow                                = &H00000E8E
%adErrURLDoesNotExist                                   = &H00000E8F
%adErrTreePermissionDenied                              = &H00000E90
%adErrInvalidURL                                        = &H00000E91
%adErrResourceLocked                                    = &H00000E92
%adErrResourceExists                                    = &H00000E93
%adErrCannotComplete                                    = &H00000E94
%adErrVolumeNotFound                                    = &H00000E95
%adErrOutOfSpace                                        = &H00000E96
%adErrResourceOutOfScope                                = &H00000E97
%adErrUnavailable                                       = &H00000E98
%adErrURLNamedRowDoesNotExist                           = &H00000E99
%adErrDelResOutOfScope                                  = &H00000E9A
%adErrPropInvalidColumn                                 = &H00000E9B
%adErrPropInvalidOption                                 = &H00000E9C
%adErrPropInvalidValue                                  = &H00000E9D
%adErrPropConflicting                                   = &H00000E9E
%adErrPropNotAllSettable                                = &H00000E9F
%adErrPropNotSet                                        = &H00000EA0
%adErrPropNotSettable                                   = &H00000EA1
%adErrPropNotSupported                                  = &H00000EA2
%adErrCatalogNotSet                                     = &H00000EA3
%adErrCantChangeConnection                              = &H00000EA4
%adErrFieldsUpdateFailed                                = &H00000EA5
%adErrDenyNotSupported                                  = &H00000EA6
%adErrDenyTypeNotSupported                              = &H00000EA7

'Enumeration EventReasonEnum
Macro enumADODBEventReasonEnum = LONG
%adRsnAddNew                                            = &H00000001
%adRsnDelete                                            = &H00000002
%adRsnUpdate                                            = &H00000003
%adRsnUndoUpdate                                        = &H00000004
%adRsnUndoAddNew                                        = &H00000005
%adRsnUndoDelete                                        = &H00000006
%adRsnRequery                                           = &H00000007
%adRsnResynch                                           = &H00000008
%adRsnClose                                             = &H00000009
%adRsnMove                                              = &H0000000A
%adRsnFirstChange                                       = &H0000000B
%adRsnMoveFirst                                         = &H0000000C
%adRsnMoveNext                                          = &H0000000D
%adRsnMovePrevious                                      = &H0000000E
%adRsnMoveLast                                          = &H0000000F

'Enumeration EventStatusEnum
Macro enumADODBEventStatusEnum = LONG
%adStatusOK                                             = &H00000001
%adStatusErrorsOccurred                                 = &H00000002
%adStatusCantDeny                                       = &H00000003
%adStatusCancel                                         = &H00000004
%adStatusUnwantedEvent                                  = &H00000005

'Enumeration ExecuteOptionEnum
Macro enumADODBExecuteOptionEnum = LONG
%adOptionUnspecified                                    = &HFFFFFFFF
%adAsyncExecute                                         = &H00000010
%adAsyncFetch                                           = &H00000020
%adAsyncFetchNonBlocking                                = &H00000040
%adExecuteNoRecords                                     = &H00000080

'Enumeration FieldAttributeEnum
Macro enumADODBFieldAttributeEnum = LONG
%adFldUnspecified                                       = &HFFFFFFFF
%adFldMayDefer                                          = &H00000002
%adFldUpdatable                                         = &H00000004
%adFldUnknownUpdatable                                  = &H00000008
%adFldFixed                                             = &H00000010
%adFldIsNullable                                        = &H00000020
%adFldMayBeNull                                         = &H00000040
%adFldLong                                              = &H00000080
%adFldRowID                                             = &H00000100
%adFldRowVersion                                        = &H00000200
%adFldCacheDeferred                                     = &H00001000
%adFldIsChapter                                         = &H00002000
%adFldNegativeScale                                     = &H00004000
%adFldKeyColumn                                         = &H00008000
%adFldIsRowURL                                          = &H00010000
%adFldIsDefaultStream                                   = &H00020000
%adFldIsCollection                                      = &H00040000

'Enumeration FieldEnum
Macro enumADODBFieldEnum = LONG
%adDefaultStream                                        = &HFFFFFFFF
%adRecordURL                                            = &HFFFFFFFE

'Enumeration FieldStatusEnum
Macro enumADODBFieldStatusEnum = LONG
%adFieldOK                                              = &H00000000
%adFieldCantConvertValue                                = &H00000002
%adFieldIsNull                                          = &H00000003
%adFieldTruncated                                       = &H00000004
%adFieldSignMismatch                                    = &H00000005
%adFieldDataOverflow                                    = &H00000006
%adFieldCantCreate                                      = &H00000007
%adFieldUnavailable                                     = &H00000008
%adFieldPermissionDenied                                = &H00000009
%adFieldIntegrityViolation                              = &H0000000A
%adFieldSchemaViolation                                 = &H0000000B
%adFieldBadStatus                                       = &H0000000C
%adFieldDefault                                         = &H0000000D
%adFieldIgnore                                          = &H0000000F
%adFieldDoesNotExist                                    = &H00000010
%adFieldInvalidURL                                      = &H00000011
%adFieldResourceLocked                                  = &H00000012
%adFieldResourceExists                                  = &H00000013
%adFieldCannotComplete                                  = &H00000014
%adFieldVolumeNotFound                                  = &H00000015
%adFieldOutOfSpace                                      = &H00000016
%adFieldCannotDeleteSource                              = &H00000017
%adFieldReadOnly                                        = &H00000018
%adFieldResourceOutOfScope                              = &H00000019
%adFieldAlreadyExists                                   = &H0000001A
%adFieldPendingInsert                                   = &H00010000
%adFieldPendingDelete                                   = &H00020000
%adFieldPendingChange                                   = &H00040000
%adFieldPendingUnknown                                  = &H00080000
%adFieldPendingUnknownDelete                            = &H00100000

'Enumeration FilterGroupEnum
Macro enumADODBFilterGroupEnum = LONG
%adFilterNone                                           = &H00000000
%adFilterPendingRecords                                 = &H00000001
%adFilterAffectedRecords                                = &H00000002
%adFilterFetchedRecords                                 = &H00000003
%adFilterPredicate                                      = &H00000004
%adFilterConflictingRecords                             = &H00000005

'Enumeration GetRowsOptionEnum
Macro enumADODBGetRowsOptionEnum = LONG
%adGetRowsRest                                          = &HFFFFFFFF

'Enumeration IsolationLevelEnum
Macro enumADODBIsolationLevelEnum = LONG
%adXactUnspecified                                      = &HFFFFFFFF
%adXactChaos                                            = &H00000010
%adXactReadUncommitted                                  = &H00000100
%adXactBrowse                                           = &H00000100
%adXactCursorStability                                  = &H00001000
%adXactReadCommitted                                    = &H00001000
%adXactRepeatableRead                                   = &H00010000
%adXactSerializable                                     = &H00100000
%adXactIsolated                                         = &H00100000

'Enumeration LineSeparatorEnum
Macro enumADODBLineSeparatorEnum = LONG
%adLF                                                   = &H0000000A
%adCR                                                   = &H0000000D
%adCRLF                                                 = &HFFFFFFFF

'Enumeration LockTypeEnum
Macro enumADODBLockTypeEnum = LONG
%adLockUnspecified                                      = &HFFFFFFFF
%adLockReadOnly                                         = &H00000001
%adLockPessimistic                                      = &H00000002
%adLockOptimistic                                       = &H00000003
%adLockBatchOptimistic                                  = &H00000004

'Enumeration MarshalOptionsEnum
Macro enumADODBMarshalOptionsEnum = LONG
%adMarshalAll                                           = &H00000000
%adMarshalModifiedOnly                                  = &H00000001

'Enumeration MoveRecordOptionsEnum
Macro enumADODBMoveRecordOptionsEnum = LONG
%adMoveUnspecified                                      = &HFFFFFFFF
%adMoveOverWrite                                        = &H00000001
%adMoveDontUpdateLinks                                  = &H00000002
%adMoveAllowEmulation                                   = &H00000004

'Enumeration ObjectStateEnum
Macro enumADODBObjectStateEnum = LONG
%adStateClosed                                          = &H00000000
%adStateOpen                                            = &H00000001
%adStateConnecting                                      = &H00000002
%adStateExecuting                                       = &H00000004
%adStateFetching                                        = &H00000008

'Enumeration ParameterAttributesEnum
Macro enumADODBParameterAttributesEnum = LONG
%adParamSigned                                          = &H00000010
%adParamNullable                                        = &H00000040
%adParamLong                                            = &H00000080

'Enumeration ParameterDirectionEnum
Macro enumADODBParameterDirectionEnum = LONG
%adParamUnknown                                         = &H00000000
%adParamInput                                           = &H00000001
%adParamOutput                                          = &H00000002
%adParamInputOutput                                     = &H00000003
%adParamReturnValue                                     = &H00000004

'Enumeration PersistFormatEnum
Macro enumADODBPersistFormatEnum = LONG
%adPersistADTG                                          = &H00000000
%adPersistXML                                           = &H00000001

'Enumeration PositionEnum
Macro enumADODBPositionEnum = LONG
%adPosUnknown                                           = &HFFFFFFFF
%adPosBOF                                               = &HFFFFFFFE
%adPosEOF                                               = &HFFFFFFFD

'Enumeration PropertyAttributesEnum
Macro enumADODBPropertyAttributesEnum = LONG
%adPropNotSupported                                     = &H00000000
%adPropRequired                                         = &H00000001
%adPropOptional                                         = &H00000002
%adPropRead                                             = &H00000200
%adPropWrite                                            = &H00000400

'Enumeration RecordCreateOptionsEnum
Macro enumADODBRecordCreateOptionsEnum = LONG
%adCreateCollection                                     = &H00002000
%adCreateStructDoc                                      = &H80000000
%adCreateNonCollection                                  = &H00000000
%adOpenIfExists                                         = &H02000000
%adCreateOverwrite                                      = &H04000000
%adFailIfNotExists                                      = &HFFFFFFFF

'Enumeration RecordOpenOptionsEnum
Macro enumADODBRecordOpenOptionsEnum = LONG
%adOpenRecordUnspecified                                = &HFFFFFFFF
%adOpenSource                                           = &H00800000
%adOpenAsync                                            = &H00001000
%adDelayFetchStream                                     = &H00004000
%adDelayFetchFields                                     = &H00008000

'Enumeration RecordStatusEnum
Macro enumADODBRecordStatusEnum = LONG
%adRecOK                                                = &H00000000
%adRecNew                                               = &H00000001
%adRecModified                                          = &H00000002
%adRecDeleted                                           = &H00000004
%adRecUnmodified                                        = &H00000008
%adRecInvalid                                           = &H00000010
%adRecMultipleChanges                                   = &H00000040
%adRecPendingChanges                                    = &H00000080
%adRecCanceled                                          = &H00000100
%adRecCantRelease                                       = &H00000400
%adRecConcurrencyViolation                              = &H00000800
%adRecIntegrityViolation                                = &H00001000
%adRecMaxChangesExceeded                                = &H00002000
%adRecObjectOpen                                        = &H00004000
%adRecOutOfMemory                                       = &H00008000
%adRecPermissionDenied                                  = &H00010000
%adRecSchemaViolation                                   = &H00020000
%adRecDBDeleted                                         = &H00040000

'Enumeration RecordTypeEnum
Macro enumADODBRecordTypeEnum = LONG
%adSimpleRecord                                         = &H00000000
%adCollectionRecord                                     = &H00000001
%adStructDoc                                            = &H00000002

'Enumeration ResyncEnum
Macro enumADODBResyncEnum = LONG
%adResyncUnderlyingValues                               = &H00000001
%adResyncAllValues                                      = &H00000002

'Enumeration SaveOptionsEnum
Macro enumADODBSaveOptionsEnum = LONG
%adSaveCreateNotExist                                   = &H00000001
%adSaveCreateOverWrite                                  = &H00000002

'Enumeration SchemaEnum
Macro enumADODBSchemaEnum = LONG
%adSchemaProviderSpecific                               = &HFFFFFFFF
%adSchemaAsserts                                        = &H00000000
%adSchemaCatalogs                                       = &H00000001
%adSchemaCharacterSets                                  = &H00000002
%adSchemaCollations                                     = &H00000003
%adSchemaColumns                                        = &H00000004
%adSchemaCheckConstraints                               = &H00000005
%adSchemaConstraintColumnUsage                          = &H00000006
%adSchemaConstraintTableUsage                           = &H00000007
%adSchemaKeyColumnUsage                                 = &H00000008
%adSchemaReferentialContraints                          = &H00000009
%adSchemaReferentialConstraints                         = &H00000009
%adSchemaTableConstraints                               = &H0000000A
%adSchemaColumnsDomainUsage                             = &H0000000B
%adSchemaIndexes                                        = &H0000000C
%adSchemaColumnPrivileges                               = &H0000000D
%adSchemaTablePrivileges                                = &H0000000E
%adSchemaUsagePrivileges                                = &H0000000F
%adSchemaProcedures                                     = &H00000010
%adSchemaSchemata                                       = &H00000011
%adSchemaSQLLanguages                                   = &H00000012
%adSchemaStatistics                                     = &H00000013
%adSchemaTables                                         = &H00000014
%adSchemaTranslations                                   = &H00000015
%adSchemaProviderTypes                                  = &H00000016
%adSchemaViews                                          = &H00000017
%adSchemaViewColumnUsage                                = &H00000018
%adSchemaViewTableUsage                                 = &H00000019
%adSchemaProcedureParameters                            = &H0000001A
%adSchemaForeignKeys                                    = &H0000001B
%adSchemaPrimaryKeys                                    = &H0000001C
%adSchemaProcedureColumns                               = &H0000001D
%adSchemaDBInfoKeywords                                 = &H0000001E
%adSchemaDBInfoLiterals                                 = &H0000001F
%adSchemaCubes                                          = &H00000020
%adSchemaDimensions                                     = &H00000021
%adSchemaHierarchies                                    = &H00000022
%adSchemaLevels                                         = &H00000023
%adSchemaMeasures                                       = &H00000024
%adSchemaProperties                                     = &H00000025
%adSchemaMembers                                        = &H00000026
%adSchemaTrustees                                       = &H00000027

'Enumeration SearchDirectionEnum
Macro enumADODBSearchDirectionEnum = LONG
%adSearchForward                                        = &H00000001
%adSearchBackward                                       = &HFFFFFFFF

'Enumeration SeekEnum
Macro enumADODBSeekEnum = LONG
%adSeekFirstEQ                                          = &H00000001
%adSeekLastEQ                                           = &H00000002
%adSeekAfterEQ                                          = &H00000004
%adSeekAfter                                            = &H00000008
%adSeekBeforeEQ                                         = &H00000010
%adSeekBefore                                           = &H00000020

'Enumeration StreamOpenOptionsEnum
Macro enumADODBStreamOpenOptionsEnum = LONG
%adOpenStreamUnspecified                                = &HFFFFFFFF
%adOpenStreamAsync                                      = &H00000001
%adOpenStreamFromRecord                                 = &H00000004

'Enumeration StreamReadEnum
Macro enumADODBStreamReadEnum = LONG
%adReadAll                                              = &HFFFFFFFF
%adReadLine                                             = &HFFFFFFFE

'Enumeration StreamTypeEnum
Macro enumADODBStreamTypeEnum = LONG
%adTypeBinary                                           = &H00000001
%adTypeText                                             = &H00000002

'Enumeration StreamWriteEnum
Macro enumADODBStreamWriteEnum = LONG
%adWriteChar                                            = &H00000000
%adWriteLine                                            = &H00000001
%stWriteChar                                            = &H00000000
%stWriteLine                                            = &H00000001

'Enumeration StringFormatEnum
Macro enumADODBStringFormatEnum = LONG
%adClipString                                           = &H00000002

'Enumeration XactAttributeEnum
Macro enumADODBXactAttributeEnum = LONG
%adXactCommitRetaining                                  = &H00020000
%adXactAbortRetaining                                   = &H00040000
%adXactAsyncPhaseOne                                    = &H00080000
%adXactSyncPhaseOne                                     = &H00100000


Interface Dispatch ADODBCommand
    Member Get Properties<&H000001F4>() As ADODBProperties
    Member Get ActiveConnection<&H00000001>() As ADODBConnection
    Member Set ActiveConnection<&H00000001>()   'Parameter Type As ADODBConnection
    Member Let ActiveConnection<&H00000001>()   'Parameter Type As Variant
    Member Get CommandText<&H00000002>() As String
    Member Let CommandText<&H00000002>()   'Parameter Type As String
    Member Get CommandTimeout<&H00000003>() As Long
    Member Let CommandTimeout<&H00000003>()   'Parameter Type As Long
    Member Get Prepared<&H00000004>() As Long
    Member Let Prepared<&H00000004>()   'Parameter Type As Long
    Member Call Execute<&H00000005>(optional out RecordsAffected As Variant<&H00000000>, optional in Parameters As Variant<&H00000001>, optional in Options As Long<&H00000002>) As ADODBRecordset
    Member Call CreateParameter<&H00000006>(optional in Name As String<&H00000000>, optional in Type As enumADODBDataTypeEnum<&H00000001>, optional in Direction As enumADODBParameterDirectionEnum<&H00000002>, _
        optional in Size As Long<&H00000003>, optional in Value As Variant<&H00000004>) As ADODBParameter
    Member Get Parameters<&H00000000>() As ADODBParameters
    Member Let CommandType<&H00000007>()   'Parameter Type As enumADODBCommandTypeEnum
    Member Get CommandType<&H00000007>() As enumADODBCommandTypeEnum
    Member Get Name<&H00000008>() As String
    Member Let Name<&H00000008>()   'Parameter Type As String
    Member Get State<&H00000009>() As Long
    Member Call Cancel<&H0000000A>()
End Interface

Interface Dispatch ADODBConnection
    Member Get Properties<&H000001F4>() As ADODBProperties
    Member Get ConnectionString<&H00000000>() As String
    Member Let ConnectionString<&H00000000>()   'Parameter Type As String
    Member Get CommandTimeout<&H00000002>() As Long
    Member Let CommandTimeout<&H00000002>()   'Parameter Type As Long
    Member Get ConnectionTimeout<&H00000003>() As Long
    Member Let ConnectionTimeout<&H00000003>()   'Parameter Type As Long
    Member Get Version<&H00000004>() As String
    Member Call Close<&H00000005>()
    Member Call Execute<&H00000006>(in CommandText As String<&H00000000>, optional out RecordsAffected As Variant<&H00000001>, optional in Options As Long<&H00000002>) As ADODBRecordset
    Member Call BeginTrans<&H00000007>() As Long
    Member Call CommitTrans<&H00000008>()
    Member Call RollbackTrans<&H00000009>()
    Member Call Open<&H0000000A>(optional in ConnectionString As String<&H00000000>, optional in UserID As String<&H00000001>, optional in Password As String<&H00000002>, optional in Options As Long<&H00000003>)
    Member Get Errors<&H0000000B>() As ADODBErrors
    Member Get DefaultDatabase<&H0000000C>() As String
    Member Let DefaultDatabase<&H0000000C>()   'Parameter Type As String
    Member Get IsolationLevel<&H0000000D>() As enumADODBIsolationLevelEnum
    Member Let IsolationLevel<&H0000000D>()   'Parameter Type As enumADODBIsolationLevelEnum
    Member Get Attributes<&H0000000E>() As Long
    Member Let Attributes<&H0000000E>()   'Parameter Type As Long
    Member Get CursorLocation<&H0000000F>() As enumADODBCursorLocationEnum
    Member Let CursorLocation<&H0000000F>()   'Parameter Type As enumADODBCursorLocationEnum
    Member Get Mode<&H00000010>() As enumADODBConnectModeEnum
    Member Let Mode<&H00000010>()   'Parameter Type As enumADODBConnectModeEnum
    Member Get Provider<&H00000011>() As String
    Member Let Provider<&H00000011>()   'Parameter Type As String
    Member Get State<&H00000012>() As Long
    Member Call OpenSchema<&H00000013>(in Schema As enumADODBSchemaEnum<&H00000000>, optional in Restrictions As Variant<&H00000001>, optional in SchemaID As Variant<&H00000002>) As ADODBRecordset
    Member Call Cancel<&H00000015>()
End Interface

Interface Dispatch ADODBParameter
    Member Get Properties<&H000001F4>() As ADODBProperties
    Member Get Name<&H00000001>() As String
    Member Let Name<&H00000001>()   'Parameter Type As String
    Member Get Value<&H00000000>() As Variant
    Member Let Value<&H00000000>()   'Parameter Type As Variant
    Member Get Type<&H00000002>() As enumADODBDataTypeEnum
    Member Let Type<&H00000002>()   'Parameter Type As enumADODBDataTypeEnum
    Member Let Direction<&H00000003>()   'Parameter Type As enumADODBParameterDirectionEnum
    Member Get Direction<&H00000003>() As enumADODBParameterDirectionEnum
    Member Let Precision<&H00000004>()   'Parameter Type As Byte
    Member Get Precision<&H00000004>() As Byte
    Member Let NumericScale<&H00000005>()   'Parameter Type As Byte
    Member Get NumericScale<&H00000005>() As Byte
    Member Let Size<&H00000006>()   'Parameter Type As Long
    Member Get Size<&H00000006>() As Long
    Member Call AppendChunk<&H00000007>(in Val As Variant<&H00000000>)
    Member Get Attributes<&H00000008>() As Long
    Member Let Attributes<&H00000008>()   'Parameter Type As Long
End Interface

Interface Dispatch ADODBRecord
    Member Get Properties<&H000001F4>() As ADODBProperties
    Member Get ActiveConnection<&H00000001>() As Variant
    Member Let ActiveConnection<&H00000001>()   'Parameter Type As String
    Member Set ActiveConnection<&H00000001>()   'Parameter Type As ADODBConnection
    Member Get State<&H00000002>() As enumADODBObjectStateEnum
    Member Get Source<&H00000003>() As Variant
    Member Let Source<&H00000003>()   'Parameter Type As String
    Member Set Source<&H00000003>()   'Parameter Type As Variant
    Member Get Mode<&H00000004>() As enumADODBConnectModeEnum
    Member Let Mode<&H00000004>()   'Parameter Type As enumADODBConnectModeEnum
    Member Get ParentURL<&H00000005>() As String
    Member Call MoveRecord<&H00000006>(optional in Source As String<&H00000000>, optional in Destination As String<&H00000001>, optional in UserName As String<&H00000002>, optional in Password As String<&H00000003>, _
        optional in Options As enumADODBMoveRecordOptionsEnum<&H00000004>, optional in Async As Long<&H00000005>) As String
    Member Call CopyRecord<&H00000007>(optional in Source As String<&H00000000>, optional in Destination As String<&H00000001>, optional in UserName As String<&H00000002>, optional in Password As String<&H00000003>, _
        optional in Options As enumADODBCopyRecordOptionsEnum<&H00000004>, optional in Async As Long<&H00000005>) As String
    Member Call DeleteRecord<&H00000008>(optional in Source As String<&H00000000>, optional in Async As Long<&H00000001>)
    Member Call Open<&H00000009>(optional in Source As Variant<&H00000000>, optional in ActiveConnection As Variant<&H00000001>, optional in Mode As enumADODBConnectModeEnum<&H00000002>, _
        optional in CreateOptions As enumADODBRecordCreateOptionsEnum<&H00000003>, optional in Options As enumADODBRecordOpenOptionsEnum<&H00000004>, optional in UserName As String<&H00000005>, optional in Password As String<&H00000006>)
    Member Call Close<&H0000000A>()
    Member Get Fields<&H00000000>() As ADODBFields
    Member Get RecordType<&H0000000B>() As enumADODBRecordTypeEnum
    Member Call GetChildren<&H0000000C>() As ADODBRecordset
    Member Call Cancel<&H0000000D>()
End Interface

Interface Dispatch ADODBRecordset
    Member Get Properties<&H000001F4>() As ADODBProperties
    Member Get AbsolutePosition<&H000003E8>() As enumADODBPositionEnum
    Member Let AbsolutePosition<&H000003E8>()   'Parameter Type As enumADODBPositionEnum
    Member Set ActiveConnection<&H000003E9>()   'Parameter Type As Variant
    Member Let ActiveConnection<&H000003E9>()   'Parameter Type As Variant
    Member Get ActiveConnection<&H000003E9>() As Variant
    Member Get BOF<&H000003EA>() As Long
    Member Get Bookmark<&H000003EB>() As Variant
    Member Let Bookmark<&H000003EB>()   'Parameter Type As Variant
    Member Get CacheSize<&H000003EC>() As Long
    Member Let CacheSize<&H000003EC>()   'Parameter Type As Long
    Member Get CursorType<&H000003ED>() As enumADODBCursorTypeEnum
    Member Let CursorType<&H000003ED>()   'Parameter Type As enumADODBCursorTypeEnum
    Member Get EOF<&H000003EE>() As Long
    Member Get Fields<&H00000000>() As ADODBFields
    Member Get LockType<&H000003F0>() As enumADODBLockTypeEnum
    Member Let LockType<&H000003F0>()   'Parameter Type As enumADODBLockTypeEnum
    Member Get MaxRecords<&H000003F1>() As Long
    Member Let MaxRecords<&H000003F1>()   'Parameter Type As Long
    Member Get RecordCount<&H000003F2>() As Long
    Member Set Source<&H000003F3>()   'Parameter Type As Variant
    Member Let Source<&H000003F3>()   'Parameter Type As String
    Member Get Source<&H000003F3>() As Variant
    Member Call AddNew<&H000003F4>(optional in FieldList As Variant<&H00000000>, optional in Values As Variant<&H00000001>)
    Member Call CancelUpdate<&H000003F5>()
    Member Call Close<&H000003F6>()
    Member Call Delete<&H000003F7>(optional in AffectRecords As enumADODBAffectEnum<&H00000000>)
    Member Call GetRows<&H000003F8>(optional in Rows As Long<&H00000000>, optional in Start As Variant<&H00000001>, optional in Fields As Variant<&H00000002>) As Variant
    Member Call Move<&H000003F9>(in NumRecords As Long<&H00000000>, optional in Start As Variant<&H00000001>)
    Member Call MoveNext<&H000003FA>()
    Member Call MovePrevious<&H000003FB>()
    Member Call MoveFirst<&H000003FC>()
    Member Call MoveLast<&H000003FD>()
    Member Call Open<&H000003FE>(optional in Source As Variant<&H00000000>, optional in ActiveConnection As Variant<&H00000001>, optional in CursorType As enumADODBCursorTypeEnum<&H00000002>, _
        optional in LockType As enumADODBLockTypeEnum<&H00000003>, optional in Options As Long<&H00000004>)
    Member Call Requery<&H000003FF>(optional in Options As Long<&H00000000>)
    Member Call Update<&H00000401>(optional in Fields As Variant<&H00000000>, optional in Values As Variant<&H00000001>)
    Member Get AbsolutePage<&H00000417>() As enumADODBPositionEnum
    Member Let AbsolutePage<&H00000417>()   'Parameter Type As enumADODBPositionEnum
    Member Get EditMode<&H00000402>() As enumADODBEditModeEnum
    Member Get Filter<&H00000406>() As Variant
    Member Let Filter<&H00000406>()   'Parameter Type As Variant
    Member Get PageCount<&H0000041A>() As Long
    Member Get PageSize<&H00000418>() As Long
    Member Let PageSize<&H00000418>()   'Parameter Type As Long
    Member Get Sort<&H00000407>() As String
    Member Let Sort<&H00000407>()   'Parameter Type As String
    Member Get Status<&H00000405>() As Long
    Member Get State<&H0000041E>() As Long
    Member Call UpdateBatch<&H0000040B>(optional in AffectRecords As enumADODBAffectEnum<&H00000000>)
    Member Call CancelBatch<&H00000419>(optional in AffectRecords As enumADODBAffectEnum<&H00000000>)
    Member Get CursorLocation<&H0000041B>() As enumADODBCursorLocationEnum
    Member Let CursorLocation<&H0000041B>()   'Parameter Type As enumADODBCursorLocationEnum
    Member Call NextRecordset<&H0000041C>(optional out RecordsAffected As Variant<&H00000000>) As ADODBRecordset
    Member Call Supports<&H0000040C>(in CursorOptions As enumADODBCursorOptionEnum<&H00000000>) As Long
    Member Get Collect<&HFFFFFFF8>(in Index As Variant<&H00000000>) As Variant
    Member Let Collect<&HFFFFFFF8>(in Index As Variant<&H00000000>)
    Member Get MarshalOptions<&H0000041D>() As enumADODBMarshalOptionsEnum
    Member Let MarshalOptions<&H0000041D>()   'Parameter Type As enumADODBMarshalOptionsEnum
    Member Call Find<&H00000422>(in Criteria As String<&H00000000>, optional in SkipRecords As Long<&H00000001>, optional in SearchDirection As enumADODBSearchDirectionEnum<&H00000002>, optional in Start As Variant<&H00000003>)
    Member Call Cancel<&H0000041F>()
    Member Get DataSource<&H00000420>() As Variant
    Member Set DataSource<&H00000420>()   'Parameter Type As Variant
    Member Get ActiveCommand<&H00000425>() As Variant
    Member Let StayInSync<&H00000427>()   'Parameter Type As Long
    Member Get StayInSync<&H00000427>() As Long
    Member Call GetString<&H00000426>(optional in StringFormat As enumADODBStringFormatEnum<&H00000000>, optional in NumRows As Long<&H00000001>, optional in ColumnDelimeter As String<&H00000002>, optional in RowDelimeter As String<&H00000003>, _
        optional in NullExpr As String<&H00000004>) As String
    Member Get DataMember<&H00000428>() As String
    Member Let DataMember<&H00000428>()   'Parameter Type As String
    Member Call CompareBookmarks<&H00000429>(in Bookmark1 As Variant<&H00000000>, in Bookmark2 As Variant<&H00000001>) As enumADODBCompareEnum
    Member Call Clone<&H0000040A>(optional in LockType As enumADODBLockTypeEnum<&H00000000>) As ADODBRecordset
    Member Call Resync<&H00000400>(optional in AffectRecords As enumADODBAffectEnum<&H00000000>, optional in ResyncValues As enumADODBResyncEnum<&H00000001>)
    Member Call Seek<&H0000042A>(in KeyValues As Variant<&H00000000>, optional in SeekOption As enumADODBSeekEnum<&H00000001>)
    Member Let Index<&H0000042B>()   'Parameter Type As String
    Member Get Index<&H0000042B>() As String
    Member Call Save<&H00000421>(optional in Destination As Variant<&H00000000>, optional in PersistFormat As enumADODBPersistFormatEnum<&H00000001>)
End Interface

Interface Dispatch ADODBStream
    Member Get Size<&H00000001>() As Long
    Member Get EOS<&H00000002>() As Long
    Member Get Position<&H00000003>() As Long
    Member Let Position<&H00000003>()   'Parameter Type As Long
    Member Get Type<&H00000004>() As enumADODBStreamTypeEnum
    Member Let Type<&H00000004>()   'Parameter Type As enumADODBStreamTypeEnum
    Member Get LineSeparator<&H00000005>() As enumADODBLineSeparatorEnum
    Member Let LineSeparator<&H00000005>()   'Parameter Type As enumADODBLineSeparatorEnum
    Member Get State<&H00000006>() As enumADODBObjectStateEnum
    Member Get Mode<&H00000007>() As enumADODBConnectModeEnum
    Member Let Mode<&H00000007>()   'Parameter Type As enumADODBConnectModeEnum
    Member Get Charset<&H00000008>() As String
    Member Let Charset<&H00000008>()   'Parameter Type As String
    Member Call Read<&H00000009>(optional in NumBytes As Long<&H00000000>) As Variant
    Member Call Open<&H0000000A>(optional in Source As Variant<&H00000000>, optional in Mode As enumADODBConnectModeEnum<&H00000001>, optional in Options As enumADODBStreamOpenOptionsEnum<&H00000002>, optional in UserName As String<&H00000003>, _
        optional in Password As String<&H00000004>)
    Member Call Close<&H0000000B>()
    Member Call SkipLine<&H0000000C>()
    Member Call Write<&H0000000D>(in Buffer As Variant<&H00000000>)
    Member Call SetEOS<&H0000000E>()
    Member Call CopyTo<&H0000000F>(in DestStream As ADODBStream<&H00000000>, optional in CharNumber As Long<&H00000001>)
    Member Call Flush<&H00000010>()
    Member Call SaveToFile<&H00000011>(in FileName As String<&H00000000>, optional in Options As enumADODBSaveOptionsEnum<&H00000001>)
    Member Call LoadFromFile<&H00000012>(in FileName As String<&H00000000>)
    Member Call ReadText<&H00000013>(optional in NumChars As Long<&H00000000>) As String
    Member Call WriteText<&H00000014>(in Data As String<&H00000000>, optional in Options As enumADODBStreamWriteEnum<&H00000001>)
    Member Call Cancel<&H00000015>()
End Interface

Interface Dispatch ADODBConnectionEvents
    Member Call InfoMessage<&H00000000>(in pError As ADODBError<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pConnection As ADODBConnection<&H00000002>) As Long
    Member Call BeginTransComplete<&H00000001>(in TransactionLevel As Long<&H00000000>, in pError As ADODBError<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, in pConnection As ADODBConnection<&H00000003>) As Long
    Member Call CommitTransComplete<&H00000003>(in pError As ADODBError<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pConnection As ADODBConnection<&H00000002>) As Long
    Member Call RollbackTransComplete<&H00000002>(in pError As ADODBError<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pConnection As ADODBConnection<&H00000002>) As Long
    Member Call WillExecute<&H00000004>(inout Source As String<&H00000000>, inout CursorType As enumADODBCursorTypeEnum<&H00000001>, inout LockType As enumADODBLockTypeEnum<&H00000002>, inout Options As Long<&H00000003>, _
        inout adStatus As enumADODBEventStatusEnum<&H00000004>, in pCommand As ADODBCommand<&H00000005>, in pRecordset As ADODBRecordset<&H00000006>, in pConnection As ADODBConnection<&H00000007>) As Long
    Member Call ExecuteComplete<&H00000005>(in RecordsAffected As Long<&H00000000>, in pError As ADODBError<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, in pCommand As ADODBCommand<&H00000003>, _
        in pRecordset As ADODBRecordset<&H00000004>, in pConnection As ADODBConnection<&H00000005>) As Long
    Member Call WillConnect<&H00000006>(inout ConnectionString As String<&H00000000>, inout UserID As String<&H00000001>, inout Password As String<&H00000002>, inout Options As Long<&H00000003>, _
        inout adStatus As enumADODBEventStatusEnum<&H00000004>, in pConnection As ADODBConnection<&H00000005>) As Long
    Member Call ConnectComplete<&H00000007>(in pError As ADODBError<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pConnection As ADODBConnection<&H00000002>) As Long
    Member Call Disconnect<&H00000008>(inout adStatus As enumADODBEventStatusEnum<&H00000000>, in pConnection As ADODBConnection<&H00000001>) As Long
End Interface

Interface Dispatch ADODBError
    Member Get Number<&H00000001>() As Long
    Member Get Source<&H00000002>() As String
    Member Get Description<&H00000000>() As String
    Member Get HelpFile<&H00000003>() As String
    Member Get HelpContext<&H00000004>() As Long
    Member Get SQLState<&H00000005>() As String
    Member Get NativeError<&H00000006>() As Long
End Interface

Interface Dispatch ADODBErrors
    Member Get Count<&H00000001>() As Long
    Member Call Refresh<&H00000002>()
    Member Get Item<&H00000000>(in Index As Variant<&H00000000>) As ADODBError
    Member Call Clear<&H60030001>()
End Interface

Interface Dispatch ADODBField
    Member Get Properties<&H000001F4>() As ADODBProperties
    Member Get ActualSize<&H00000455>() As Long
    Member Get Attributes<&H0000045A>() As Long
    Member Get DefinedSize<&H0000044F>() As Long
    Member Get Name<&H0000044C>() As String
    Member Get Type<&H0000044E>() As enumADODBDataTypeEnum
    Member Get Value<&H00000000>() As Variant
    Member Let Value<&H00000000>()   'Parameter Type As Variant
    Member Get Precision<&H00000458>() As Byte
    Member Get NumericScale<&H00000459>() As Byte
    Member Call AppendChunk<&H00000453>(in Data As Variant<&H00000000>)
    Member Call GetChunk<&H00000454>(in Length As Long<&H00000000>) As Variant
    Member Get OriginalValue<&H00000450>() As Variant
    Member Get UnderlyingValue<&H00000451>() As Variant
    Member Get DataFormat<&H0000045B>() As Variant
    Member Set DataFormat<&H0000045B>()   'Parameter Type As Variant
    Member Let Precision<&H00000458>()   'Parameter Type As Byte
    Member Let NumericScale<&H00000459>()   'Parameter Type As Byte
    Member Let Type<&H0000044E>()   'Parameter Type As enumADODBDataTypeEnum
    Member Let DefinedSize<&H0000044F>()   'Parameter Type As Long
    Member Let Attributes<&H0000045A>()   'Parameter Type As Long
    Member Get Status<&H0000045C>() As Long
End Interface

Interface Dispatch ADODBFields
    Member Get Count<&H00000001>() As Long
    Member Call Refresh<&H00000002>()
    Member Get Item<&H00000000>(in Index As Variant<&H00000000>) As ADODBField
    Member Call Delete<&H00000004>(in Index As Variant<&H00000000>)
    Member Call Append<&H00000003>(in Name As String<&H00000000>, in Type As enumADODBDataTypeEnum<&H00000001>, optional in DefinedSize As Long<&H00000002>, optional in Attrib As enumADODBFieldAttributeEnum<&H00000003>, _
        optional in FieldValue As Variant<&H00000004>)
    Member Call Update<&H00000005>()
    Member Call Resync<&H00000006>(optional in ResyncValues As enumADODBResyncEnum<&H00000000>)
    Member Call CancelUpdate<&H00000007>()
End Interface

Interface Dispatch ADODBParameters
    Member Get Count<&H00000001>() As Long
    Member Call Refresh<&H00000002>()
    Member Call Append<&H60030000>(in Object As Variant<&H00000000>)
    Member Call Delete<&H60030001>(in Index As Variant<&H00000000>)
    Member Get Item<&H00000000>(in Index As Variant<&H00000000>) As ADODBParameter
End Interface

Interface Dispatch ADODBProperties
    Member Get Count<&H00000001>() As Long
    Member Call Refresh<&H00000002>()
    Member Get Item<&H00000000>(in Index As Variant<&H00000000>) As ADODBProperty
End Interface

Interface Dispatch ADODBProperty
    Member Get Value<&H00000000>() As Variant
    Member Let Value<&H00000000>()   'Parameter Type As Variant
    Member Get Name<&H60020002>() As String
    Member Get Type<&H60020003>() As enumADODBDataTypeEnum
    Member Get Attributes<&H60020004>() As Long
    Member Let Attributes<&H60020004>()   'Parameter Type As Long
End Interface

Interface Dispatch ADODBRecordsetEvents
    Member Call WillChangeField<&H00000009>(in cFields As Long<&H00000000>, in Fields As Variant<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, in pRecordset As ADODBRecordset<&H00000003>) As Long
    Member Call FieldChangeComplete<&H0000000A>(in cFields As Long<&H00000000>, in Fields As Variant<&H00000001>, in pError As ADODBError<&H00000002>, inout adStatus As enumADODBEventStatusEnum<&H00000003>, _
        in pRecordset As ADODBRecordset<&H00000004>) As Long
    Member Call WillChangeRecord<&H0000000B>(in adReason As enumADODBEventReasonEnum<&H00000000>, in cRecords As Long<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, in pRecordset As ADODBRecordset<&H00000003>) As Long
    Member Call RecordChangeComplete<&H0000000C>(in adReason As enumADODBEventReasonEnum<&H00000000>, in cRecords As Long<&H00000001>, in pError As ADODBError<&H00000002>, inout adStatus As enumADODBEventStatusEnum<&H00000003>, _
        in pRecordset As ADODBRecordset<&H00000004>) As Long
    Member Call WillChangeRecordset<&H0000000D>(in adReason As enumADODBEventReasonEnum<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pRecordset As ADODBRecordset<&H00000002>) As Long
    Member Call RecordsetChangeComplete<&H0000000E>(in adReason As enumADODBEventReasonEnum<&H00000000>, in pError As ADODBError<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, _
        in pRecordset As ADODBRecordset<&H00000003>) As Long
    Member Call WillMove<&H0000000F>(in adReason As enumADODBEventReasonEnum<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pRecordset As ADODBRecordset<&H00000002>) As Long
    Member Call MoveComplete<&H00000010>(in adReason As enumADODBEventReasonEnum<&H00000000>, in pError As ADODBError<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, in pRecordset As ADODBRecordset<&H00000003>) As Long
    Member Call EndOfRecordset<&H00000011>(inout fMoreData As Long<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pRecordset As ADODBRecordset<&H00000002>) As Long
    Member Call FetchProgress<&H00000012>(in Progress As Long<&H00000000>, in MaxProgress As Long<&H00000001>, inout adStatus As enumADODBEventStatusEnum<&H00000002>, in pRecordset As ADODBRecordset<&H00000003>) As Long
    Member Call FetchComplete<&H00000013>(in pError As ADODBError<&H00000000>, inout adStatus As enumADODBEventStatusEnum<&H00000001>, in pRecordset As ADODBRecordset<&H00000002>) As Long
End Interface
