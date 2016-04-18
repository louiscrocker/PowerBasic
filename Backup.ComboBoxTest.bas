   #COMPILE EXE

   GLOBAL hDlg AS DWORD

   FUNCTION PBMAIN() AS LONG
      DIM MyArray(3) AS STRING
      ARRAY ASSIGN MyArray() = "zero", "one", "two", "three"

      DIALOG NEW PIXELS, 0, "ComboBox Test", 300, 300, 200, 200, %WS_SYSMENU, 0 TO hDlg

      'CONTROL ADD COMBOBOX, hDlg, 100, MyArray(), 50, 50, 75, 100
      CONTROL ADD COMBOBOX, hDlg, 100, , 50, 50, 75, 100, %CBS_DROPDOWN OR %WS_VSCROLL
      COMBOBOX ADD hDlg, 100, "Hello"
      COMBOBOX ADD hDlg, 100, "Hello 1"
      COMBOBOX ADD hDlg, 100, "Hello 2"
      COMBOBOX ADD hDlg, 100, "Hello 3"
      COMBOBOX ADD hDlg, 100, "Hello 4"
      COMBOBOX ADD hDlg, 100, "Hello 5"
      COMBOBOX ADD hDlg, 100, "Hello 6"
      COMBOBOX ADD hDlg, 100, "Hello 7"

      DIALOG SHOW MODAL hDlg CALL DlgProc
   END FUNCTION

   CALLBACK FUNCTION DlgProc() AS LONG
      IF CB.MSG = %WM_COMMAND AND CB.CTL = 100 AND CB.CTLMSG = %LBN_SELCHANGE THEN
         MSGBOX "Selected!"
      END IF
   END FUNCTION
