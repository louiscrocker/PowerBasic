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
%USEMACROS = 1
#IF NOT %DEF(%WINAPI)
    #INCLUDE "WIN32API.INC"
#ENDIF
#IF NOT %DEF(%COMMCTRL_INC)
    #INCLUDE "COMMCTRL.INC"
#ENDIF
#INCLUDE "PBForms.INC"
#PBFORMS END INCLUDES
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Constants **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PBFORMS BEGIN CONSTANTS 
%IDD_DIALOG1           =  101
%IDC_SYSLISTVIEW32_1   = 1001
%IDC_SYSTABCONTROL32_1 = 1002   '*
%IDC_FRAME1            = 1003
%IDC_BUTTON1           = 1004
#PBFORMS END CONSTANTS
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Declarations **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE CALLBACK FUNCTION ShowDIALOG1Proc()
DECLARE FUNCTION SampleListView(BYVAL hDlg AS DWORD, BYVAL lID AS LONG, BYVAL lColCnt AS LONG, BYVAL lRowCnt AS LONG) AS LONG
DECLARE FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
#PBFORMS DECLARATIONS
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Main Application Entry Point **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PBMAIN()
    PBFormsInitComCtls (%ICC_WIN95_CLASSES OR %ICC_DATE_CLASSES OR %ICC_INTERNET_CLASSES)

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
                CASE %IDC_SYSLISTVIEW32_1

                CASE %IDC_FRAME1

                CASE %IDC_BUTTON1
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        MSGBOX "%IDC_BUTTON1=" + FORMAT$(%IDC_BUTTON1), %MB_TASKMODAL
                    END IF

            END SELECT
    END SELECT
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Sample Code **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION SampleListView(BYVAL hDlg AS DWORD, BYVAL lID AS LONG, BYVAL lColCnt AS LONG, BYVAL lRowCnt AS LONG) AS LONG
    LOCAL lCol   AS LONG
    LOCAL lRow   AS LONG
    LOCAL hCtl   AS DWORD
    LOCAL tLVC   AS LV_COLUMN
    LOCAL tLVI   AS LV_ITEM
    LOCAL szBuf  AS ASCIIZ * 32
    LOCAL lStyle AS LONG

    CONTROL HANDLE hDlg, lID TO hCtl

    lStyle = ListView_GetExtendedListViewStyle(hCtl)
    ListView_SetExtendedListViewStyle(hCtl, lStyle OR %LVS_EX_FULLROWSELECT OR %LVS_EX_GRIDLINES)

    ' Load column headers.
    tLVC.mask    = %LVCF_FMT OR %LVCF_TEXT OR %LVCF_SUBITEM
    tLVC.fmt     = %LVCFMT_LEFT
    tLVC.pszText = VARPTR(szBuf)
    FOR lCol = 0 TO lColCnt - 1
        szBuf       = USING$("Column #", lCol)
        tLVC.iOrder = lCol
        ListView_InsertColumn(hCtl, lCol, tLVC)
    NEXT lCol

    ' Load sample data.
    FOR lRow = 0 TO lRowCnt - 1
        tLVI.stateMask = %LVIS_FOCUSED
        tLVI.pszText   = VARPTR(szBuf)
        tLVI.iItem     = lRow
        FOR lCol = 0 TO lColCnt - 1
            szBuf         = USING$("Column # Row #", lCol, lRow)
            tLVI.iSubItem = lCol
            tLVI.lParam   = lRow
            IF lCol = 0 THEN
                tLVI.mask = %LVIF_TEXT OR %LVIF_PARAM OR %LVIF_STATE
                ListView_InsertItem(hCtl, tLVI)
            ELSE
                tLVI.mask = %LVIF_TEXT
                ListView_SetItem(hCtl, tLVI)
            END IF
        NEXT lCol
    NEXT lRow

    ' Auto size columns.
    FOR lCol = 0 TO lColCnt - 2
        ListView_SetColumnWidth(hCtl, lCol, %LVSCW_AUTOSIZE)
    NEXT lCol
    ListView_SetColumnWidth(hCtl, lColCnt - 1, %LVSCW_AUTOSIZE_USEHEADER)
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Dialogs **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
    LOCAL lRslt AS LONG

#PBFORMS BEGIN DIALOG %IDD_DIALOG1->->
    LOCAL hDlg  AS DWORD

    DIALOG NEW hParent, "Dialog1", 237, 114, 584, 205, %WS_POPUP OR %WS_BORDER OR %WS_DLGFRAME OR %WS_SYSMENU OR %WS_MINIMIZEBOX OR %WS_CLIPSIBLINGS OR %WS_VISIBLE OR _
        %DS_MODALFRAME OR %DS_3DLOOK OR %DS_NOFAILCREATE OR %DS_SETFONT, %WS_EX_CONTROLPARENT OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR, TO hDlg
    CONTROL ADD "SysListView32", hDlg, %IDC_SYSLISTVIEW32_1, "SysListView32_1", 5, 5, 380, 170, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %LVS_REPORT OR %LVS_SHOWSELALWAYS, _
        %WS_EX_LEFT OR %WS_EX_CLIENTEDGE OR %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD FRAME,  hDlg, %IDC_FRAME1, "Frame1", 390, 5, 190, 170
    CONTROL ADD BUTTON, hDlg, %IDC_BUTTON1, "Button1", 485, 180, 95, 20
#PBFORMS END DIALOG

    SampleListView hDlg, %IDC_SYSLISTVIEW32_1, 3, 30

    DIALOG SHOW MODAL hDlg, CALL ShowDIALOG1Proc TO lRslt

#PBFORMS BEGIN CLEANUP %IDD_DIALOG1
#PBFORMS END CLEANUP

    FUNCTION = lRslt
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

