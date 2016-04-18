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
#RESOURCE MANIFEST, 1, "C:\ClasPB\Test\XPTheme.xml"

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
%IDD_DIALOG1              =  101
%IDC_BUTTON1              = 1001
%IDC_LISTBOX1             = 1002
%IDC_FRAME1               = 1003
%IDC_OPTION1              = 1004
%IDC_MSCTLS_STATUSBAR32_1 = 1005
%IDC_SYSANIMATE32_1       = 1006
%IDC_GRAPHIC1             = 1007
%IDC_SYSTABCONTROL32_1    = 1008
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
    PBFormsInitComCtls (%ICC_WIN95_CLASSES OR %ICC_DATE_CLASSES OR %ICC_INTERNET_CLASSES)

    ShowDIALOG1 %HWND_DESKTOP
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** CallBacks **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CALLBACK FUNCTION ShowDIALOG1Proc()

    SELECT CASE AS LONG CBMSG
        ' /* Inserted by PB/Forms 08-19-2011 03:11:03
        CASE %WM_SIZE
            ' Dialog has been resized
            CONTROL SEND CBHNDL, %IDC_MSCTLS_STATUSBAR32_1, CBMSG, CBWPARAM, CBLPARAM
        ' */

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
                ' /* Inserted by PB/Forms 08-19-2011 03:16:07
                CASE %IDC_GRAPHIC1

                CASE %IDC_SYSTABCONTROL32_1
                ' */

                ' /* Inserted by PB/Forms 08-19-2011 03:11:03
                CASE %IDC_LISTBOX1

                CASE %IDC_FRAME1

                CASE %IDC_OPTION1

                CASE %IDC_MSCTLS_STATUSBAR32_1

                CASE %IDC_SYSANIMATE32_1
                ' */

                CASE %IDC_BUTTON1
                    IF CBCTLMSG = %BN_CLICKED OR CBCTLMSG = 1 THEN
                        MSGBOX "%IDC_BUTTON1=" + FORMAT$(%IDC_BUTTON1), %MB_TASKMODAL
                    END IF
                    DIM h AS LONG
                    GRAPHIC WINDOW NEW "Preview", 400, 100, 800, 900 TO h&
                    XPRINT ATTACH DEFAULT
                    XPRINT PREVIEW h&, 0
                    CALL PrintIt         ' print to the preview window
                    XPRINT PREVIEW CLOSE

            END SELECT
    END SELECT
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SUB PrintIt()
    XPRINT "This is a test of preview..."
    XPRINT ELLIPSE (300,300) - (500,400), %RGB_RED
    XPRINT RENDER "xx.bmp", (300,500)-(500,700)
END SUB

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'   ** Dialogs **
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ShowDIALOG1(BYVAL hParent AS DWORD) AS LONG
    LOCAL lRslt AS LONG

#PBFORMS BEGIN DIALOG %IDD_DIALOG1->->
    LOCAL hDlg  AS DWORD

    DIALOG NEW hParent, "Dialog1", 353, 311, 461, 202, %WS_POPUP OR %WS_BORDER OR %WS_DLGFRAME OR %WS_SYSMENU OR %WS_MINIMIZEBOX OR %WS_CLIPSIBLINGS OR %WS_VISIBLE OR _
        %DS_MODALFRAME OR %DS_3DLOOK OR %DS_NOFAILCREATE OR %DS_SETFONT, %WS_EX_CONTROLPARENT OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR, TO hDlg
    CONTROL ADD BUTTON,  hDlg, %IDC_BUTTON1, "Button1", 360, 5, 85, 30
    CONTROL ADD LISTBOX, hDlg, %IDC_LISTBOX1, , 5, 5, 345, 175
    CONTROL ADD FRAME,   hDlg, %IDC_FRAME1, "Frame1", 360, 95, 85, 85
    CONTROL ADD OPTION,  hDlg, %IDC_OPTION1, "Option1", 370, 110, 65, 15
    CONTROL ADD "msctls_statusbar32", hDlg, %IDC_MSCTLS_STATUSBAR32_1, "msctls_statusbar32_1", 0, 190, 461, 12, %WS_CHILD OR %WS_VISIBLE, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
        %WS_EX_LTRREADING OR %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD GRAPHIC, hDlg, %IDC_GRAPHIC1, "", 360, 50, 85, 40, %WS_CHILD OR %WS_VISIBLE OR %WS_BORDER, %WS_EX_CLIENTEDGE OR %WS_EX_STATICEDGE OR %WS_EX_ACCEPTFILES
#PBFORMS END DIALOG

    DIALOG SHOW MODAL hDlg, CALL ShowDIALOG1Proc TO lRslt

#PBFORMS BEGIN CLEANUP %IDD_DIALOG1
#PBFORMS END CLEANUP

    FUNCTION = lRslt
END FUNCTION
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
