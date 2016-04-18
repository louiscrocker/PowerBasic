'====================================================================================================================
'
'
'   ADO connection and data retrieval example
'
'
'====================================================================================================================

#COMPILE EXE
#DIM ALL
#INCLUDE "ADO.inc"

FUNCTION PBMAIN () AS LONG

    DIM adoCN AS ADODBConnection
    DIM adoRS AS ADODBRecordset
    DIM adoFields AS ADODBFields
    DIM sProgID_ADO AS STRING
    DIM strConn AS VARIANT
    DIM vnt AS VARIANT
    DIM lng AS LONG

    '================================================================================================================
    ' open the connection
    strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\InStore\OMInStore.mdb;Persist Security Info=False"

    sProgID_ADO = PROGID$(CLSID$("ADODB.Connection"))
    IF LEN(sProgID_ADO) = 0 THEN sProgID_ADO = "ADODB.Connection"

    adoCN = ADODBConnection IN sProgID_ADO
    IF ISFALSE ISOBJECT(adoCN) THEN adoCN = NEW ADODBConnection IN sProgID_ADO

    IF ISFALSE ISOBJECT(adoCN) THEN
        PRINT "Unable to create ADO Connection"
        EXIT FUNCTION
    END IF

    OBJECT LET adoCN.ConnectionString = strConn
    OBJECT CALL adoCN.Open()

    OBJECT GET adoCN.State() TO vnt
    PRINT "Connection State " & FORMAT$(VARIANT#(vnt))

    '================================================================================================================
    ' open the recordset
    sProgID_ADO = PROGID$(CLSID$("ADODB.Recordset"))
    IF LEN(sProgID_ADO) = 0 THEN sProgID_ADO = "ADODB.Recordset"

    adoRS = ADODBRecordset IN sProgID_ADO
    IF ISFALSE ISOBJECT(adoRS) THEN adoRS = NEW ADODBRecordset IN sProgID_ADO

    IF ISFALSE ISOBJECT(adoRS) THEN
        PRINT "Unable to create ADO Recordset"
        EXIT FUNCTION
    END IF

    DIM vntConn AS VARIANT
    DIM vntRS AS VARIANT
    LET vntConn = adoCN
    LET vntRS = "SELECT * FROM Ingredient ORDER BY Description"

    OBJECT CALL adoRS.Open(vntRS, vntConn)
    OBJECT GET adoRS.State() TO vnt
    PRINT "Recordset State " & FORMAT$(VARIANT#(vnt))
    '================================================================================================================

    WAITKEY$

    DIM vntFields AS VARIANT

    DIM vntPriceSheetId AS VARIANT
    DIM vntDescription AS VARIANT

    DIM vntPriceSheetIdField AS VARIANT
    DIM vntDescriptionField AS VARIANT

    DIM vEOF AS VARIANT

    vntPriceSheetIdField = "PriceSheetId"
    vntDescriptionField = "Description"

    OBJECT GET adoRS.Fields() TO vntFields
    LET adoFields = vntFields

    DO
        OBJECT GET adoRS.EOF TO vEOF

        IF ISTRUE VARIANT#(vEof) THEN
            ' Exit the fetch loop
            EXIT DO
        END IF

        OBJECT GET adoFields.Item(vntPriceSheetIdField).Value TO vntPriceSheetId
        OBJECT GET adoFields.Item(vntDescriptionField).Value TO vntDescription

        PRINT "PriceSheetId: " & VARIANT$(vntPriceSheetId) & " :: Description: " & VARIANT$(vntDescription)

        OBJECT CALL adoRS.MoveNext()
    LOOP

    WAITKEY$

    OBJECT CALL adoRs.Close()
    OBJECT CALL adoCn.Close()

    SET adoRS = NOTHING
    SET adoCN = NOTHING

END FUNCTION

'====================================================================================================================
'   end of file
'====================================================================================================================
