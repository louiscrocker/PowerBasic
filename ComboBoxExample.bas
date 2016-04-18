'===========================================================================================================
'
'
'
'
'
'===========================================================================================================

#COMPILE EXE
#DIM ALL

'===========================================================================================================
%USEMACROS = 1

'===========================================================================================================
#INCLUDE "WIN32API.INC"

'===========================================================================================================
%ID_COMBOBOX  = 1000
%ID_TEXTBOX   = 1001
%ID_COPYBTN1  = 1002
%ID_COPYBTN2  = 1003
%ID_CLOSEBTN  = 1004

'===========================================================================================================
DECLARE CALLBACK FUNCTION DialogProc()
DECLARE SUB AddDataToComboBox(hdlg AS DWORD)

'===========================================================================================================
FUNCTION PBMAIN () AS LONG

  LOCAL hDlg AS DWORD

  DIALOG NEW 0, "Combobox Tutorial",,, 220, 90, %WS_CAPTION OR %WS_SYSMENU, 0 TO hDlg

  CONTROL ADD COMBOBOX, hDlg, %ID_COMBOBOX, , 0, 0, 100, 80, %CBS_DROPDOWNLIST OR %WS_VSCROLL
  CONTROL ADD TEXTBOX, hDlg, %ID_TEXTBOX,  "", 120, 0, 100, 12
  CONTROL ADD BUTTON, hDlg, %ID_COPYBTN1, "Copy ->", 65, 20, 35, 15
  CONTROL ADD BUTTON, hDlg, %ID_COPYBTN2, "<- Copy", 120, 20, 35, 15
  CONTROL ADD BUTTON,hDlg, %ID_CLOSEBTN, "Close",   93,  60,  35, 15

  DIALOG SHOW MODAL hDlg CALL DialogProc

END FUNCTION

'===========================================================================================================
CALLBACK FUNCTION DialogProc()

  SELECT CASE AS LONG CBMSG

    CASE %WM_INITDIALOG
      AddDataToComboBox(CBHNDL)

    CASE %WM_COMMAND

      SELECT CASE AS LONG CBCTL

        LOCAL TXT AS STRING

        CASE %ID_COPYBTN1
          IF CBCTLMSG = %BN_CLICKED THEN
            COMBOBOX GET TEXT CBHNDL, %ID_COMBOBOX TO TXT
            CONTROL SET TEXT CBHNDL, %ID_TEXTBOX, TXT
          END IF

        CASE %ID_COPYBTN2
          IF CBCTLMSG = %BN_CLICKED THEN
            LOCAL InComboBox AS LONG
            CONTROL GET TEXT CBHNDL, %ID_TEXTBOX TO TXT
            CONTROL SEND CBHNDL, %ID_COMBOBOX, %CB_FINDSTRINGEXACT, -1, STRPTR(TXT) TO InComboBox

            IF InComboBox = %CB_ERR THEN
              COMBOBOX ADD CBHNDL, %ID_COMBOBOX, TXT
            ELSE
              ? "That item is already in the Combobox"
            END IF
          END IF

        CASE %ID_CLOSEBTN
          IF CBCTLMSG = %BN_CLICKED THEN DIALOG END CBHNDL

      END SELECT

  END SELECT

END FUNCTION

'===========================================================================================================
SUB AddDataToComboBox(hdlg AS DWORD)

  LOCAL i AS LONG

  FOR i = 1 TO 10
    COMBOBOX ADD hdlg, %ID_COMBOBOX, "Combobox data #" + STR$(i)
  NEXT i

  COMBOBOX SELECT hdlg, %ID_COMBOBOX, 1

END SUB

'===========================================================================================================
' end of file
'===========================================================================================================
