#PBFORMS CREATED V1.52
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
' The first line in this file is a PB/Forms metastatement.
' It should ALWAYS be the first line of the file. Other   
' PB/Forms metastatements are placed at the beginning and 
' end of "Named Blocks" of code that should be edited     
' with PBForms only. Do not manually edit or delete these 
' metastatements or PB/Forms will not be able to reread   
' the file correctly.  See the PB/Forms documentation for 
' more information.                                       
' Named blocks begin like this:    #PBFORMS BEGIN ...     
' Named blocks end like this:      #PBFORMS END ...       
' Other PB/Forms metastatements such as:                  
'     #PBFORMS DECLARATIONS                               
' are used by PB/Forms to insert additional code.         
' Feel free to make changes anywhere else in the file.    
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#COMPILE EXE
#DIM ALL

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Includes **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PBFORMS BEGIN INCLUDES 
#IF NOT %DEF(%WINAPI)
    #INCLUDE "WIN32API.INC"
#ENDIF
#PBFORMS END INCLUDES
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Constants **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PBFORMS BEGIN CONSTANTS 
%dlgMain            = 1001  '*
%btnTest            = 1002
%chkSpeedUpListview = 1003
%btnExit            = 1004
%lvcListview        = 1005
%stbStatusbar       = 1006
%ItemCount          =  500  '*
%IDD_DIALOG1        =  101
#PBFORMS END CONSTANTS
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Declarations **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE CALLBACK FUNCTION ShowDIALOG1Proc()
DECLARE FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
#PBFORMS DECLARATIONS
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Main Application Entry Point **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PBMAIN()
    ShowDIALOG1 %HWND_DESKTOP
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** CallBacks **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CALLBACK FUNCTION ShowDIALOG1Proc()

    SELECT CASE AS LONG CBMSG
        CASE %WM_INITDIALOG
            ' Initialization handler

        CASE %WM_NCACTIVATE
            STATIC hWndSaveFocus AS DWORD
            IF ISFALSE CBWPARAM THEN
                ' Save control focus
                hWndSaveFocus = GetFocus()
            ELSEIF hWndSaveFocus THEN
                ' Restore control focus
                SetFocus(hWndSaveFocus)
                hWndSaveFocus = 0
            END IF

        CASE %WM_COMMAND
            ' Process control notifications
            SELECT CASE AS LONG CBCTL
                CASE %btnTest
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        MSGBOX "%btnTest=" + FORMAT$(%btnTest), %MB_TASKMODAL
                    END IF

                CASE %chkSpeedUpListview

                CASE %btnExit
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        MSGBOX "%btnExit=" + FORMAT$(%btnExit), %MB_TASKMODAL
                    END IF

                CASE %lvcListview

                CASE %stbStatusbar

            END SELECT
    END SELECT
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Dialogs **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
    LOCAL lRslt AS LONG

#PBFORMS BEGIN DIALOG %IDD_DIALOG1->->
    LOCAL hDlg  AS DWORD

    DIALOG NEW hParent, "Listview Fill Test", 246, 132, 609, 333, TO hDlg
    CONTROL ADD BUTTON,   hDlg, %btnTest, "&Test", 5, 305, 50, 25
    CONTROL ADD CHECKBOX, hDlg, %chkSpeedUpListview, "Speed up the listview fill", 65, 305, 100, 25
    CONTROL ADD BUTTON,   hDlg, %btnExit, "E&xit", 555, 305, 50, 25
    CONTROL ADD "", hDlg, %lvcListview, "", 5, 5, 600, 295, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP, %WS_EX_CLIENTEDGE OR %WS_EX_LEFT
    CONTROL ADD "", hDlg, %stbStatusbar, "", 0, 0, 0, 0, %WS_CHILD OR %WS_VISIBLE, %WS_EX_LEFT OR %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR
#PBFORMS END DIALOG

    DIALOG SHOW MODAL hDlg, CALL ShowDIALOG1Proc TO lRslt

#PBFORMS BEGIN CLEANUP %IDD_DIALOG1
#PBFORMS END CLEANUP

    FUNCTION = lRslt
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#PBFORMS COPY
'==================================================================================================================================================================================
'The following is a copy of your code before importing:
#IF 0
'----------------------------------------------------------------------------(')

#COMPILE EXE "ListviewFillTest.exe"
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

CALLBACK FUNCTION ShowMainProc( )

    DIM lngResult AS LONG
    DIM udtPassedInfo AS STATIC PassedInfoType
    DIM hThread AS DWORD

    SELECT CASE AS LONG CB.MSG

        CASE %WM_INITDIALOG
            udtPassedInfo.hDlg = CB.HNDL
            '            LISTVIEW INSERT COLUMN gudtData.hTabHeaders, %lvcMSGHeaders, 1, "Status:", 0, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 1", 50, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 2", 50, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 3", 50, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 4", 50, 0
            LISTVIEW INSERT COLUMN CB.HNDL, %lvcListview, 1, "Column 5", 50, 0

        CASE %WM_NCACTIVATE
            STATIC hWndSaveFocus AS DWORD
            IF ISFALSE CB.WPARAM THEN
                hWndSaveFocus = GETFOCUS( )
            ELSEIF hWndSaveFocus THEN
                SETFOCUS( hWndSaveFocus )
                hWndSaveFocus = 0
            END IF

        CASE %WM_TIMER
            CONTROL SET TEXT CB.HNDL, %stbStatusbar, FORMAT$( udtPassedInfo.lngCount ) + " items of " + FORMAT$( %ItemCount ) + " added so far."

        CASE %WM_COMMAND
            SELECT CASE AS LONG CB.CTL
                CASE %btnTest
                    IF CB.CTLMSG = %BN_CLICKED OR CB.CTLMSG = 1 THEN
                        THREAD CREATE FillLV( VARPTR( udtPassedInfo )) TO hThread
                        THREAD CLOSE hThread TO lngResult
                    END IF
                CASE %btnExit
                    IF CB.CTLMSG = %BN_CLICKED OR CB.CTLMSG = 1 THEN
                        DIALOG END CB.HNDL
                    END IF
            END SELECT

    END SELECT

END FUNCTION

'----------------------------------------------------------------------------(')

FUNCTION PBMAIN( )

    DIM hDlg AS DWORD
    DIM lngResult AS LONG

    DIALOG NEW %HWND_DESKTOP, "Listview Fill Test", 483, 287, 301, 205, TO hDlg

    CONTROL ADD BUTTON, hDlg, %btnTest, "&Test", 5, 160, 50, 25
    CONTROL ADD CHECKBOX, hDlg, %chkSpeedUpListview, "Speed up the listview fill", 65, 160, 100, 25
    CONTROL ADD BUTTON, hDlg, %btnExit, "E&xit", 245, 160, 50, 25
    CONTROL ADD LISTVIEW, hDlg, %lvcListview, "", 5, 5, 290, 145, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %LVS_REPORT OR %LVS_SHOWSELALWAYS, %WS_EX_CLIENTEDGE OR %WS_EX_LEFT
    CONTROL ADD STATUSBAR, hDlg, %stbStatusbar, "", 0, 0, 0, 0

    DIALOG SHOW MODAL hDlg, CALL ShowMainProc TO lngResult

    FUNCTION = lngResult

END FUNCTION

'==============================================================================================================================================================
' end of file
'==============================================================================================================================================================

#ENDIF
'==================================================================================================================================================================================

