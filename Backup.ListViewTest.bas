'===============================================================================================================================================================================
'----------------------------------------------------------------------------(')
'===============================================================================================================================================================================

#COMPILE EXE "ListViewFillTestNoThread.exe"
#DIM ALL
#INCLUDE ONCE "WIN32API.INC"

'----------------------------------------------------------------------------(')

%dlgMain = 1001
%btnTest = 1002
%chkSpeedUpListview = 1003
%btnExit = 1004
%lvcListview = 1005
%stbStatusbar = 1006

'----------------------------------------------------------------------------(')

TYPE PassedInfoType
    hDlg AS DWORD
    STBID AS LONG
    lngCount AS LONG
END TYPE

'----------------------------------------------------------------------------(')

%ItemCount = 500

'----------------------------------------------------------------------------(')
'===============================================================================================================================================================================
THREAD FUNCTION FillLV( BYVAL pudtPassedInfo AS PassedInfoType PTR ) AS LONG

    DIM lngColumn AS LONG
    DIM lngRow AS LONG
    DIM lngFlag AS LONG
    DIM sngTime1 AS SINGLE
    DIM sngTime2 AS SINGLE

    LISTVIEW RESET @pudtPassedInfo.hDlg, %lvcListview

    CONTROL DISABLE @pudtPassedInfo.hDlg, %btnTest
    CONTROL DISABLE @pudtPassedInfo.hDlg, %chkSpeedUpListview
    CONTROL DISABLE @pudtPassedInfo.hDlg, %btnExit
    CONTROL DISABLE @pudtPassedInfo.hDlg, %lvcListview

    CONTROL GET CHECK @pudtPassedInfo.hDlg, %chkSpeedUpListview TO lngFlag

    'msgbox format$(lngFlag)

    SETTIMER @pudtPassedInfo.hDlg, 1, 333, BYVAL %NULL
    sngTime1 = TIMER

    FOR lngRow = 1 TO %ItemCount
        LISTVIEW INSERT ITEM @pudtPassedInfo.hDlg, %lvcListview, lngRow, 0, "Row" + FORMAT$( lngRow ) + " Col1"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 2, "Row" + FORMAT$( lngRow ) + " Col2"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 3, "Row" + FORMAT$( lngRow ) + " Col3"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 4, "Row" + FORMAT$( lngRow ) + " Col4"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 5, "Row" + FORMAT$( lngRow ) + " Col5"

        @pudtPassedInfo.lngCount = lngRow

        ' WOWOWOWOWOWOWOWOWOWOWOWOW
        IF lngFlag THEN LISTVIEW VISIBLE @pudtPassedInfo.hDlg, %lvcListview, lngRow
    NEXT lngRow

    sngTime2 = TIMER
    KILLTIMER @pudtPassedInfo.hDlg, 1

    CONTROL SET TEXT @pudtPassedInfo.hDlg, %stbStatusbar, FORMAT$( %ItemCount ) + " items added in " + FORMAT$( sngTime2 - sngTime1, "###.#" ) + " seconds"

    CONTROL ENABLE @pudtPassedInfo.hDlg, %btnTest
    CONTROL ENABLE @pudtPassedInfo.hDlg, %chkSpeedUpListview
    CONTROL ENABLE @pudtPassedInfo.hDlg, %btnExit
    CONTROL ENABLE @pudtPassedInfo.hDlg, %lvcListview

END FUNCTION

'----------------------------------------------------------------------------(')
'===============================================================================================================================================================================
FUNCTION FillListView( BYVAL pudtPassedInfo AS PassedInfoType PTR ) AS LONG

    DIM lngColumn AS LONG
    DIM lngRow AS LONG
    DIM lngFlag AS LONG
    DIM sngTime1 AS SINGLE
    DIM sngTime2 AS SINGLE

    '----------------------------------------------------------------------------(')
    LISTVIEW RESET @pudtPassedInfo.hDlg, %lvcListview
    LISTVIEW SET STYLEXX @pudtPassedInfo.hDlg, %lvcListview, %LVS_EX_FULLROWSELECT

    '----------------------------------------------------------------------------(')
    CONTROL DISABLE @pudtPassedInfo.hDlg, %btnTest
    CONTROL DISABLE @pudtPassedInfo.hDlg, %chkSpeedUpListview
    CONTROL DISABLE @pudtPassedInfo.hDlg, %btnExit
    CONTROL DISABLE @pudtPassedInfo.hDlg, %lvcListview

    '----------------------------------------------------------------------------(')
    CONTROL GET CHECK @pudtPassedInfo.hDlg, %chkSpeedUpListview TO lngFlag

    MSGBOX FORMAT$(lngFlag)

    '----------------------------------------------------------------------------(')
    SETTIMER @pudtPassedInfo.hDlg, 1, 333, BYVAL %NULL
    sngTime1 = TIMER

    '----------------------------------------------------------------------------(')
    FOR lngRow = 1 TO %ItemCount
        LISTVIEW INSERT ITEM @pudtPassedInfo.hDlg, %lvcListview, lngRow, 0, "Row" + FORMAT$( lngRow ) + " Col1"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 2, "Row" + FORMAT$( lngRow ) + " Col2"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 3, "Row" + FORMAT$( lngRow ) + " Col3"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 4, "Row" + FORMAT$( lngRow ) + " Col4"
        LISTVIEW SET TEXT @pudtPassedInfo.hDlg, %lvcListview, lngRow, 5, "Row" + FORMAT$( lngRow ) + " Col5"

        @pudtPassedInfo.lngCount = lngRow

        ' WOWOWOWOWOWOWOWOWOWOWOWOW
        IF lngFlag THEN LISTVIEW VISIBLE @pudtPassedInfo.hDlg, %lvcListview, lngRow
    NEXT lngRow

    '----------------------------------------------------------------------------(')
    sngTime2 = TIMER
    KILLTIMER @pudtPassedInfo.hDlg, 1

    '----------------------------------------------------------------------------(')
    CONTROL SET TEXT @pudtPassedInfo.hDlg, %stbStatusbar, FORMAT$( %ItemCount ) + " items added in " + FORMAT$( sngTime2 - sngTime1, "###.#" ) + " seconds"

    '----------------------------------------------------------------------------(')
    CONTROL ENABLE @pudtPassedInfo.hDlg, %btnTest
    CONTROL ENABLE @pudtPassedInfo.hDlg, %chkSpeedUpListview
    CONTROL ENABLE @pudtPassedInfo.hDlg, %btnExit
    CONTROL ENABLE @pudtPassedInfo.hDlg, %lvcListview

END FUNCTION

'----------------------------------------------------------------------------(')
'===============================================================================================================================================================================
CALLBACK FUNCTION ShowMainProc( )

    DIM lngResult AS LONG
    DIM udtPassedInfo AS STATIC PassedInfoType
    DIM hThread AS DWORD

    SELECT CASE AS LONG CB.MSG

        '----------------------------------------------------------------------------(')
        CASE %WM_INITDIALOG
            udtPassedInfo.hDlg = CB.HNDL
            'LISTVIEW INSERT COLUMN gudtData.hTabHeaders, %lvcMSGHeaders, 1, "Status:", 0, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 1", 100, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 2", 285, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 3", 50, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 4", 50, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 5", 50, 0

        '----------------------------------------------------------------------------(')
        CASE %WM_NCACTIVATE
            STATIC hWndSaveFocus AS DWORD
            IF ISFALSE CB.WPARAM THEN
                hWndSaveFocus = GETFOCUS( )
            ELSEIF hWndSaveFocus THEN
                SETFOCUS( hWndSaveFocus )
                hWndSaveFocus = 0
            END IF

        '----------------------------------------------------------------------------(')
        CASE %WM_TIMER
            CONTROL SET TEXT CB.HNDL, %stbStatusbar, FORMAT$( udtPassedInfo.lngCount ) + " items of " + FORMAT$( %ItemCount ) + " added so far."

        '----------------------------------------------------------------------------(')
        CASE %WM_COMMAND
            SELECT CASE AS LONG CB.CTL
                CASE %btnTest
                    IF CB.CTLMSG = %BN_CLICKED OR CB.CTLMSG = 1 THEN
                        'THREAD CREATE FillLV( VARPTR( udtPassedInfo )) TO hThread
                        'THREAD CLOSE hThread TO lngResult
                        FillListView( VARPTR( udtPassedInfo ))
                    END IF
                CASE %btnExit
                    IF CB.CTLMSG = %BN_CLICKED OR CB.CTLMSG = 1 THEN
                        DIALOG END CB.HNDL
                    END IF
            END SELECT

    END SELECT

END FUNCTION

'----------------------------------------------------------------------------(')
'===============================================================================================================================================================================
FUNCTION PBMAIN( )

    DIM hDlg AS DWORD
    DIM lngResult AS LONG

    '----------------------------------------------------------------------------(')
    DIALOG NEW %HWND_DESKTOP, "Listview Fill Test", 700, 287, 600, 205, TO hDlg

    '----------------------------------------------------------------------------(')
    CONTROL ADD BUTTON, hDlg, %btnTest, "&Test", 5, 160, 50, 25
    CONTROL ADD CHECKBOX, hDlg, %chkSpeedUpListview, "Speed up the listview fill", 65, 160, 100, 25
    CONTROL ADD BUTTON, hDlg, %btnExit, "E&xit", 245, 160, 50, 25
    CONTROL ADD LISTVIEW, hDlg, %lvcListview, "", 5, 5, 550, 145, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %LVS_REPORT OR %LVS_SHOWSELALWAYS, %WS_EX_CLIENTEDGE OR %WS_EX_LEFT
    CONTROL ADD STATUSBAR, hDlg, %stbStatusbar, "", 0, 0, 0, 0

    '----------------------------------------------------------------------------(')
    DIALOG SHOW MODAL hDlg, CALL ShowMainProc TO lngResult

    '----------------------------------------------------------------------------(')
    FUNCTION = lngResult

END FUNCTION

'==============================================================================================================================================================
' end of file
'==============================================================================================================================================================
