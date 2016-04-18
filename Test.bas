#PBFORMS CREATED V1.52
'------------------------------------------------------------------------------
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
'------------------------------------------------------------------------------

#COMPILE EXE
#DIM ALL

'------------------------------------------------------------------------------
'   ** Includes **
'------------------------------------------------------------------------------
#PBFORMS BEGIN INCLUDES
#RESOURCE "Test.pbr"
%USEMACROS = 1
#IF NOT %DEF(%WINAPI)
    #INCLUDE "WIN32API.INC"
#ENDIF
#IF NOT %DEF(%COMMCTRL_INC)
    #INCLUDE "COMMCTRL.INC"
#ENDIF
#INCLUDE "PBForms.INC"
#PBFORMS END INCLUDES
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Constants **
'------------------------------------------------------------------------------
#PBFORMS BEGIN CONSTANTS
%IDD_DIALOG1              =  101
%IDC_LISTBOX1             = 1001
%IDC_GRAPHIC1             = 1002    '*
%IDC_MSCTLS_PROGRESS32_1  = 1003
%IDC_MSCTLS_STATUSBAR32_1 = 1004
%IDC_SYSDATETIMEPICK32_1  = 1005
%IDC_BUTTON1              = 1006
%IDC_BUTTON2              = 1007
%IDD_DIALOG2              =  102
%IDC_IMGBUTTON1           = 1008
%IDC_SYSLISTVIEW32_1      = 1009
%IDC_BUTTON3              = 1010
%IDC_CUSTOMCONTROL_1      = 1011    '*
%IDC_MSCTLS_PROGRESS32_2  = 1012    '*
%IDC_SYSTABCONTROL32_1    = 1013
#PBFORMS END CONSTANTS
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Declarations **
'------------------------------------------------------------------------------
DECLARE CALLBACK FUNCTION ShowDIALOG1Proc()
DECLARE FUNCTION SampleListBox(BYVAL hDlg AS DWORD, BYVAL lID AS LONG, BYVAL lCount AS LONG) AS LONG
DECLARE FUNCTION SampleProgress(BYVAL hDlg AS DWORD, BYVAL lID AS LONG) AS LONG
DECLARE FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
DECLARE CALLBACK FUNCTION ShowDIALOG2Proc()
DECLARE FUNCTION ShowDIALOG2(BYVAL hDlg AS DWORD) AS LONG
#PBFORMS DECLARATIONS
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Main Application Entry Point **
'------------------------------------------------------------------------------
FUNCTION PBMAIN()
    PBFormsInitComCtls (%ICC_WIN95_CLASSES OR %ICC_DATE_CLASSES OR _
        %ICC_INTERNET_CLASSES)

    ShowDIALOG1 %HWND_DESKTOP
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** CallBacks **
'------------------------------------------------------------------------------
CALLBACK FUNCTION ShowDIALOG1Proc()

    SELECT CASE AS LONG CBMSG
        CASE %WM_INITDIALOG
            ' Initialization handler

        CASE %WM_SIZE
            ' Dialog has been resized
            CONTROL SEND CBHNDL, %IDC_MSCTLS_STATUSBAR32_1, CBMSG, CBWPARAM, _
                CBLPARAM

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
                ' /* Inserted by PB/Forms 07-18-2011 22:58:53
                CASE %IDC_SYSTABCONTROL32_1
                ' */

                ' /* Inserted by PB/Forms 07-18-2011 13:43:24
                CASE %IDC_BUTTON2
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        'MSGBOX "%IDC_BUTTON2=" + FORMAT$(%IDC_BUTTON2), %MB_TASKMODAL
                        ShowDIALOG2 %HWND_DESKTOP
                    END IF
                ' */

                CASE %IDC_LISTBOX1

                CASE %IDC_MSCTLS_PROGRESS32_1

                CASE %IDC_MSCTLS_STATUSBAR32_1

                CASE %IDC_SYSDATETIMEPICK32_1

                CASE %IDC_BUTTON1
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        'MSGBOX "%IDC_BUTTON1=" + FORMAT$(%IDC_BUTTON1), %MB_TASKMODAL
                        DIALOG END CBHNDL
                    END IF

            END SELECT
    END SELECT
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Sample Code **
'------------------------------------------------------------------------------
FUNCTION SampleListBox(BYVAL hDlg AS DWORD, BYVAL lID AS LONG, BYVAL lCount _
    AS LONG) AS LONG
    LOCAL i AS LONG

    FOR i = 1 TO lCount
        LISTBOX ADD hDlg, lID, USING$("Test Item #", i)
    NEXT i
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
FUNCTION SampleProgress(BYVAL hDlg AS DWORD, BYVAL lID AS LONG) AS LONG
    CONTROL SEND hDlg, lID, %PBM_SETRANGE, 0, MAKDWD(0,100)
    CONTROL SEND hDlg, lID, %PBM_SETPOS,  90, 0
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Dialogs **
'------------------------------------------------------------------------------
FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
    LOCAL lRslt AS LONG

#PBFORMS BEGIN DIALOG %IDD_DIALOG1->->
    LOCAL hDlg  AS DWORD

    DIALOG NEW hParent, "Dialog1", 231, 112, 652, 270, %WS_POPUP OR %WS_BORDER OR %WS_DLGFRAME OR %WS_THICKFRAME OR %WS_SYSMENU OR %WS_MINIMIZEBOX OR %WS_CLIPSIBLINGS OR _
        %WS_VISIBLE OR %DS_MODALFRAME OR %DS_CENTER OR %DS_3DLOOK OR %DS_NOFAILCREATE OR %DS_SETFONT, %WS_EX_CONTROLPARENT OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR _
        %WS_EX_RIGHTSCROLLBAR, TO hDlg
    CONTROL ADD LISTBOX, hDlg, %IDC_LISTBOX1, , 10, 5, 355, 190
    CONTROL ADD "msctls_progress32", hDlg, %IDC_MSCTLS_PROGRESS32_1, "msctls_progress32_1", 10, 205, 350, 15, %WS_CHILD OR %WS_VISIBLE
    CONTROL ADD "msctls_statusbar32", hDlg, %IDC_MSCTLS_STATUSBAR32_1, "msctls_statusbar32_1", 0, 258, 652, 12, %WS_CHILD OR %WS_VISIBLE, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
        %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD "SysDateTimePick32", hDlg, %IDC_SYSDATETIMEPICK32_1, "SysDateTimePick32_1", 515, 5, 135, 15, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %DTS_LONGDATEFORMAT, _
        %WS_EX_CLIENTEDGE OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD BUTTON,  hDlg, %IDC_BUTTON1, "Button1", 535, 225, 110, 25
    CONTROL ADD BUTTON,  hDlg, %IDC_BUTTON2, "Button2", 10, 225, 110, 25
    CONTROL ADD "SysTabControl32", hDlg, %IDC_SYSTABCONTROL32_1, "SysTabControl32_1", 445, 25, 205, 110, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %TCS_SINGLELINE OR _
        %TCS_RIGHTJUSTIFY, %WS_EX_LEFT OR %WS_EX_LTRREADING
#PBFORMS END DIALOG

    SampleListBox  hDlg, %IDC_LISTBOX1, 30
    SampleProgress hDlg, %IDC_MSCTLS_PROGRESS32_1

    DIALOG SHOW MODAL hDlg, CALL ShowDIALOG1Proc TO lRslt

#PBFORMS BEGIN CLEANUP %IDD_DIALOG1
#PBFORMS END CLEANUP

    FUNCTION = lRslt
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
CALLBACK FUNCTION ShowDIALOG2Proc()

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
                CASE %IDC_IMGBUTTON1
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        MSGBOX "%IDC_IMGBUTTON1=" + FORMAT$(%IDC_IMGBUTTON1), _
                            %MB_TASKMODAL
                    END IF

                CASE %IDC_SYSLISTVIEW32_1

                CASE %IDC_BUTTON3
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        'MSGBOX "%IDC_BUTTON3=" + FORMAT$(%IDC_BUTTON3), %MB_TASKMODAL
                        DIALOG END CBHNDL
                    END IF

            END SELECT
    END SELECT
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
FUNCTION ShowDIALOG2(BYVAL hParent AS DWORD) AS LONG
    LOCAL lRslt AS LONG

#PBFORMS BEGIN DIALOG %IDD_DIALOG2->->
    LOCAL hDlg  AS DWORD

    DIALOG NEW hParent, "Dialog2", 241, 112, 465, 141, %WS_POPUP OR %WS_BORDER OR %WS_DLGFRAME OR %WS_SYSMENU OR %WS_MINIMIZEBOX OR %WS_CLIPSIBLINGS OR %WS_VISIBLE OR _
        %DS_MODALFRAME OR %DS_CENTER OR %DS_3DLOOK OR %DS_NOFAILCREATE OR %DS_SETFONT, %WS_EX_CONTROLPARENT OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR, TO _
        hDlg
    CONTROL ADD IMGBUTTON, hDlg, %IDC_IMGBUTTON1, "", 380, 10, 75, 20
    CONTROL ADD "SysListView32", hDlg, %IDC_SYSLISTVIEW32_1, "SysListView32_1", 0, 10, 375, 125, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %LVS_REPORT OR %LVS_SHOWSELALWAYS, _
        %WS_EX_LEFT OR %WS_EX_CLIENTEDGE OR %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD BUTTON,    hDlg, %IDC_BUTTON3, "Button3", 380, 115, 75, 20
#PBFORMS END DIALOG

    'SampleListView hDlg, %IDC_SYSLISTVIEW32_1, 3, 30

    DIALOG SHOW MODAL hDlg, CALL ShowDIALOG2Proc TO lRslt

#PBFORMS BEGIN CLEANUP %IDD_DIALOG2
#PBFORMS END CLEANUP

    FUNCTION = lRslt
END FUNCTION
'------------------------------------------------------------------------------
