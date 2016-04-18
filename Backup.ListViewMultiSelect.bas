'-------------------------------------------------------------------------------
'   LV_MULTISELECT.BAS
'   copy of listview report viewer to test getting list of selected items in multi-select
'   listview in backwards order using ListView_GetNextItem
'   As written, needs a GLOBAL or STATIC array containing the text,
'   but that would not be too hard to change.
'   AUTHOR: Michael Mattias Racine WI
'   USE AND DISTRIBUTION
'    Placed in public domain by author 11/23/02
'   HISTORY
'   10/07/01 for PB.DLL 6.0
'   11/23/01 Migrate to PB/WIN 7.0 and clean up source code, add comments, etc.
'   01/04/03 Try to add "greenbar" background image...
'   12/04/04 changed to LV_MULTISELECT for testing
'-------------------------------------------------------------------------------
#COMPILE EXE
#DEBUG ERROR ON
#REGISTER NONE
'#RESOURCE GOES HERE IF USED
'===[Windows API Header Files]=========================================
'  If you don't need all of the functionality supported by these APIs
'  (and who does?), you can selectively turn off various modules by putting
'  the following constants in your program BEFORE you #include "win32api.inc":
'
'  %NOGDI = 1     ' no GDI (Graphics Device Interface) functions
'  %NOMMIDS = 1   ' no Multimedia ID definitions
'
%NOMMIDS  = 1
#INCLUDE "WIN32API.INC"
%SKEL_USE_COMMONCONTROL = 1
#IF %SKEL_USE_COMMONCONTROL
' THE '%NOxxx' EQUATES MUST BE COMMENTED OUT - NOT SET TO ZERO - TO ACTIVIATE THE PARTICULAR CONTROL
    %NOANIMATE       = 1
    %NOBUTTON        = 1
    %NOCOMBO         = 1
    %NODATETIMEPICK  = 1
    %NODRAGLIST      = 1
    %NOHEADER        = 1
    %NOHOTKEY        = 1
    %NOIMAGELIST     = 1
    %NOPIADDRESS     = 1
    %NOLIST          = 1
   ' %NOLISTVIEW      = 1
    %NOMONTHCAL      = 1
    %NONATIVEFONTCTL = 1
    %NOPAGESCROLLER  = 1
    %NOPROGRESS      = 1
    %NOREBAR         = 1
    %NOSTATUSBAR     = 1
    %NOTABCONTROL    = 1
    %NOTOOLBAR       = 1
    %NOTOOLTIPS      = 1
    %NOTRACKBAR      = 1
    %NOTREEVIEW      = 1
    %NOUPDOWN        = 1
   #INCLUDE "COMMCTRL.INC"
#ENDIF
'==============================================================
' UNION used for WM_NOTIFY handling from all Listview controls
'==============================================================
 UNION LvUnion
    NMHDR  AS NMHDR
    NMLV   AS NMLISTVIEW
    NMIA   AS NMITEMACTIVATE
    LVDI   AS LV_DISPINFO
    LVCD   AS NMLVCUSTOMDRAW
    NMLVK  AS NMLVKEYDOWN
 END UNION
' === END OF COMMON CONTROLS INCLUDE ==========
DECLARE FUNCTION ReportFont (BYVAL hwndLv AS LONG) AS LONG
FUNCTION WINMAIN (BYVAL hInstance     AS LONG, _
                  BYVAL hPrevInstance AS LONG, _
                  lpCmdLine           AS ASCIIZ PTR, _
                  BYVAL iCmdShow      AS LONG) AS LONG

  LOCAL  Msg         AS tagMsg
  LOCAL  wcex        AS WndClassEx
  LOCAL  szAppName   AS ASCIIZ * 80
  STATIC szMenuName  AS ASCIIZ * 80
  LOCAL  hWnd         AS LONG

  LOCAL iccex AS Init_Common_ControlsEx
        iccex.dwSize = SIZEOF(iccex)
        iccex.dwICC  = %ICC_LISTVIEW_CLASSES
        InitCommonControlsEx iccex
  szAppName          = "rptView"
  szMenuName         = ""
  wcex.cbSize        = SIZEOF(wcex)
  wcex.style         = %CS_HREDRAW OR %CS_VREDRAW
  wcex.lpfnWndProc   = CODEPTR( WndProc )
  wcex.cbClsExtra    = 0
  wcex.cbWndExtra    = 0
  wcex.hInstance     = hInstance
  wcex.hIcon         = LoadIcon( 0&,  BYVAL %IDI_ASTERISK )
  wcex.hCursor       = LoadCursor( %NULL, BYVAL %IDC_ARROW )
  wcex.hbrBackground = GetStockObject( %WHITE_BRUSH )
  wcex.lpszMenuName  = VARPTR (szMenuName)
  wcex.lpszClassName = VARPTR(szAppName )
  wcex.hIconSm       = LoadIcon( 0&, BYVAL %IDI_ASTERISK )
  RegisterClassEx wcex
  ' Create a window using the registered class
  hWnd = CreateWindowEx(0&, szAppName, _               ' window exStyle and class name
                      "ListView Report Viewer Demo Using Text Callbacks", _     ' window caption
                      %WS_OVERLAPPEDWINDOW, _    ' window style
                      %CW_USEDEFAULT, _          ' initial x position
                      %CW_USEDEFAULT, _          ' initial y position
                      %CW_USEDEFAULT, _          ' initial x size
                      %CW_USEDEFAULT, _          ' initial y size
                      %NULL, _                   ' parent window handle
                      %NULL, _                   ' window menu handle
                      hInstance, _               ' program instance handle
                      BYVAL %NULL)               ' creation parameters

  ' Display the window on the screen
  ShowWindow hWnd, iCmdShow
  UpdateWindow hWnd
  ' Main message loop:
  WHILE GetMessage(Msg, %NULL, 0, 0)
    TranslateMessage Msg
    DispatchMessage Msg
  WEND
  FUNCTION = msg.wParam
END FUNCTION  ' WinMain

FUNCTION WndProc (BYVAL hWnd AS LONG, BYVAL wMsg AS LONG, _
                  BYVAL wParam AS LONG, BYVAL lParam AS LONG) EXPORT AS LONG

  LOCAL hDC       AS LONG
  LOCAL LpPaint   AS PaintStruct
  LOCAL R         AS Rect
  LOCAL Stat AS LONG, I AS LONG, J AS LONG
  LOCAL szText   AS ASCIIZ * %MAX_PATH
  ' listview support
  LOCAL lvStyle AS DWORD, lvExStyle AS DWORD, hWndLv AS LONG
  LOCAL plvu AS LvUnion PTR
  LOCAL sText AS STRING
  LOCAL  lvc AS lvcolumn
  LOCAL  lvi AS LvItem, lvWidth AS LONG
  STATIC LVID AS LONG
         lvid = 101     '<<< ID FOR LISTVIEW CONTROL

  SELECT CASE AS LONG wMsg   ' MUST USE 'AS LONG' WITH WIN7 & LISTVIEWS!

    CASE %WM_CREATE
         ' create a listview control as a child of this window. Multiple select is default
           lvStyle   = %WS_CLIPSIBLINGS OR %WS_CHILDWINDOW OR %WS_VISIBLE OR %LVS_REPORT OR %LVS_NOSORTHEADER OR %DS_SETFONT
           lvExStyle = %WS_EX_CLIENTEDGE OR %LVS_EX_FULLROWSELECT
           ' Size and locate this window based on the current size of the parent window
     '      LOCAL cx AS LONG, cy AS LONG, fWidth AS LONG, fheight AS LONG
           GetClientRect hWnd, R
           hWndLv = CreateWindowEx( lvExStyle, _              ' any extended style bits
                      "syslistview32", _               ' window class name
                      "Listview", _                  ' window caption
                       lvStyle, _                     ' window style
                       0, _                     ' initial x position
                       0, _                     ' initial y position
                      R.nright - R.nleft + 1, _                        ' initial x size
                      r.nBottom - r.ntop + 1, _                        ' initial y size
                      hWnd, _                        ' parent window handle
                      Lvid, _         ' window menu handle or ID ; the first menu is the "main" menu
                      GetWindowLong(hWnd, %GWL_HINSTANCE), _               ' program instance handle
                      BYVAL %NULL)               ' creation parameters (which I might need? via subclass?)

          IF hWndLv = 0 THEN
             MSGBOX "CreateWindowExFailed"
          END IF
         ' Set LV extended style:
         SendMessage hWndLv,%LVM_SETEXTENDEDLISTVIEWSTYLE, lvExStyle, lvExStyle

         ' 1/3/04 try to add greenbar background image.. do from file for now, add to
         ' resource later...
         ' does not work, may need to init image list? Does not work with *.bmp?
         ' I do not get a failure on SETBKIMAGE
        ' LOCAL lretBI AS LONG, szBkFile AS ASCIIZ * %MAX_PATH
        ' LOCAL LVBI AS LVBKIMAGE

        ' ListView_SetTextBkColor(hWndLv, %CLR_NONE)

        ' szBkFile = "C:\Software_Development\pbwin70\work\greenbar.bmp"

        ' IF DIR$(szBkFile) = "" THEN
        '     MSGBOX "Can't find greenbar.bmp !!!"
        '8 END IF


         'LVBI.hBM = LoadImage (BYVAL %NULL, "greenbar.bmp", %IMAGE_BITMAP, %NULL, %NULL, %LR_LOADFROMFILE)
        ' LVBI.ulFlags    = %LVBKIF_STYLE_NORMAL OR %LVBKIF_SOURCE_URL
        ' LVBI.pszImage   = VARPTR(szBkFile)

        ' lretBi       = SendMessage hWndLV, %LVM_SETBKIMAGE, %NULL, BYVAL VARPTR(LVBI)
        ' IF isfalse lretBi THEN
        '         MSGBOX "LVM_SETBKIMAGE failed"
        '        'Listview_SetBkImage hwndLv, BYVAL VARPTR(LVBI)
        ' END IF


'LVBKIF_STYLE_NORMAL
'The background image is displayed normally.
'LVBKIF_STYLE_TILE


         lvWidth = 800   ' could figure out exactly with GetTextExtent AFTER setting the font...
         ' ===================================================
         ' add the columns and column headers to the listview
         ' ===================================================
         ' initialize the column structure and set the column headers
         lvc.mask        =  %LVCF_FMT OR %LVCF_TEXT OR %LVCF_WIDTH
         lvc.pszText     = VARPTR(szText)
         lvc.cchTextMax  = SIZEOF(szText) - 1
         lvc.iSubItem    = 0
         lvc.iImage      = 0
         lvc.iOrder      = 0
         szText          = "This is the header text of the report listview"
         lvc.fmt         = %LVCFMT_LEFT
         lvc.cx          = lvWidth
         J = SendMessage (hWndLv,%LVM_INSERTCOLUMN, 0, BYVAL VARPTR(lvc))
         IF J <> 0 THEN
            MSGBOX "Insert Column Header Failed "
         END IF
         ' Create the report lines for the demo
         LOCAL pRL AS ASCIIZ PTR * 136, nRL AS LONG
         nRL = 1000   ' << number of report lines for demo (actually, -1)
         stext = STRING$(133, "X") + "4"
         REDIM RL (nRL) AS STATIC ASCIIZ * 136
         REDIM NewLines(10) AS STATIC ASCIIZ * 136
         STATIC nNewLines AS LONG
         FOR I = 0 TO nRL
             MID$(sText, 50) = "This is actual report line #" & FORMAT$(I, " ##### ")
             RL(I) = sText
         NEXT I
        ' set the item count for the listview, as this is more efficient when adding stuff
         nRL = UBOUND(RL,1) - LBOUND(RL,1) + 1
         I = SendMessage(hWndLv, %LVM_SETITEMCOUNT, nRl, 0&)
        ' use callbacks for label text to keep the control's space usage to a minimum.
        ' this means we must process the WM_NOTIFY/LVN_GETDISPINFO message
        ' lparam will be ASCIIZ pointer to the text for this item
         lvi.mask    = %LVIF_TEXT  OR %LVIF_PARAM   '
         lvi.pszText = %LPSTR_TEXTCALLBACK       ' for all columns, we supply the text..
         pRL = VARPTR(Rl(0))                     ' we start with item zero
         FOR I = 0 TO nRL -1
            lvi.iItem  = I
            lvi.lparam = pRL
            J          = SendMessage (hWndLv,%LVM_INSERTITEM, 0, BYVAL VARPTR(lvi))
            IF J < 0 THEN
                MSGBOX "Insert Item Failed for #" & STR$(I)
            END IF
            INCR pRL
         NEXT I
         ' Change the font to fixed for any report
         STATIC hFont AS LONG    ' static so I can delete it
         hFont = ReportFont (HwndLv)
         IF ISTRUE hFont THEN
            SendMessage hWndLv, %WM_SETFONT, hFont, %TRUE
         ELSE
            MSGBOX "Create our own font failed"
         END IF

         FUNCTION = 0: EXIT FUNCTION

     CASE %WM_SIZE
          ' resize the listview to fit our client area unless isIconic
          IF ISFALSE isIconic(hWnd) THEN
              GetClientRect Hwnd, R
              MoveWindow GetDlgItem(hWnd, lvid), 0,0, R.nRight - R.nLeft + 1, r.nBottom -r.ntop + 1, %TRUE
              FUNCTION = 0: EXIT FUNCTION
          END IF

     CASE %WM_NOTIFY
            plvu = lparam
            SELECT CASE AS LONG @plvu.nmhdr.idfrom
                 CASE LvId                  ' notify message from the listview control
                     SELECT CASE AS LONG @pLVU.NMHDR.Code
                              ' CASE %LVN_COLUMNCLICK      ' pointer is to NM_LISTVIEW
                             '   MSGBOX "COLUMN CLICK on column " & STR$(@pLvu.NMLV.iSubITem)
                             '  CASE %LVN_ITEMACTIVATE     ' pointer is to NMITEMACTIVATE
                             '   CASE %NM_CLICK             ' pointer is to NMITEMACTIVATE
                               CASE %NM_RCLICK            ' pointer is to NMITEMACTIVATE
                                   ' get an array of all selected rows in backwards order and show indexes
                                   LOCAL nSel AS LONG, iSelIndex() AS LONG, iSel AS LONG
                                   LOCAL iLastRow AS LONG, hLV AS LONG, iStart AS LONG
                                   LOCAL iSub AS LONG, sDisplay AS STRING

                                   hLV  = @plvu.nmhdr.hWndFrom    ' save some typing
                                   nSel = ListView_getSelectedCount (hLV)
                                   IF nSel = 0 THEN
                                       MSGBOX "No Items Selected, kind of fruitless endeavor, huh?"
                                   ELSE
                                       REDIM iSelIndex (nSel-1)        ' make space for all selected rows
                                       iLastRow  = ListView_GetItemCount (hLV) - 1 ' subtract one  to make zero-based
                                       iStart    = iLastRow       ' fails with  + 1   ' is +1 allowed?
                                       'iStart    = -1&            ' will this work backwards? NOPE
                                       iSub      = UBOUND (iSelIndex)
                                       DO
                                           iSel  = Listview_GetNextItem (hLV, iStart, %LVNI_SELECTED OR %LVNI_ABOVE)
                                           IF iSel <> - 1 THEN
                                               iSelIndex (iSub) = Isel
                                               DECR iSub
                                               iStart   = iSel
                                           ELSE
                                               EXIT DO
                                           END IF

                                       LOOP
                                       ' build a display string
                                       FOR iSub = LBOUND (iSelIndex,1) TO UBOUND (iSelIndex,1)
                                           sDisplay = sDisplay & STR$ (iSelIndex(iSub))
                                       NEXT
                                       MSGBOX sDisplay,,"Selected rows of " & STR$(nSel) & " Selected Items"
                                   END IF






                             '  CASE %NM_DBLCLK            ' pointer is to NMITEMACTIVATE
                             '  CASE %NM_SETFOCUS          ' NMHDR
                         CASE  %LVN_GETDISPINFO    ' returns LVDI
                              IF ISTRUE (@plvu.LVDI.item.mask AND %LVIF_TEXT) THEN  ' it wants text
                                  @plvu.LVDI.item.pszText     = @plvu.LVDI.item.lparam  ' return pointer to text
                              END IF    ' if this is a trip wanting text
                              FUNCTION = 0: EXIT FUNCTION
                     END SELECT  ' of which message the listview control is sending
           END SELECT ' of control ID for WM_NOTIFY

    CASE %WM_DESTROY
      deleteobject hFont
      PostQuitMessage 0
      FUNCTION = 0
      EXIT FUNCTION

   END SELECT

  FUNCTION = DefWindowProc(hWnd, wMsg, wParam, lParam)

END FUNCTION

FUNCTION ReportFont (BYVAL hwndLv AS LONG) AS LONG
 ' returns: handle to a font
 ' if zero, function failed
 ' what I want is Courier New fixed pitch, 8 pt high but condensed
 LOCAL nHeight AS LONG, nWidth AS LONG, nEscapement AS LONG, nOrientation AS LONG, _
       fdwCharset AS LONG, _
       fnWeight AS LONG, fdwItalic AS LONG, fdwUNderLine AS LONG, fdwStrikeOut AS LONG, _
       fdwOutputPrecision AS LONG, _
       fdwClipPrecision   AS LONG, _
       fdwQuality         AS LONG, _
       fdwPitchAndFamily  AS LONG,_
       lpszFace           AS ASCIIZ * 48
 LOCAL PointSizeHeight AS LONG, HDc AS LONG, hFont AS LONG
       PointSizeHeight     = 10
       hDC                 =  GetDc(hwndLv)
       ' next formula only applies when mapping mode is MM_TEXT:
      ' LOCAL iMapMode AS LONG
      ' iMapMode  = GetMapMode (hDc)
      ' MSGBOX "iMapMode=" & STR$(iMapMode) & " &h" & HEX$(iMapMode,4)
      ' returns 1, = MM-TEXT

       nHeight             =  -MulDiv(PointSizeHeight, GetDeviceCaps(hDC, %LOGPIXELSY), 72)
       ' when nHeight < 0
       ' "The font mapper transforms this value into device units and matches its absolute value
       '  against the character height of the available fonts."
       nWidth        =  nHeight * .5    ' guess  ' kind hard to read at .5
       nWidth        =  nHeight * .6    ' too wide does not fit size 800 listview
       nWidth        =  nHeight * .55   ' still too wide
       nWidth        =  nHeight * .52   ' still too wide
       nWidth        =  nHeight * .50   ' haven't we been here before?  43 line when maximized, but way narrow.
       nWidth        =  nHeight * .51   ' same as any other > .5: too wide
       nEscapement   = 0
       nOrientation  = 0
       fnWeight      = %FW_NORMAL       ' NORMAL=400
       ' lets try this a little bolder at nWidth = .50
       fnweight           = %FW_MEDIUM       ' MEDIUM = 500 looks same as normal
      ' fnweight          = %FW_SEMIBOLD    ' SEMIBOLD=DEMIBOLD=600  WAY TOO THICK at nWdith = .50
       fdwItalic          = %FALSE
       fdwUnderline       = %FALSE
       fdwStrikeout       = %FALSE
       fdwCharset         = %ANSI_CHARSET
       fdwOutputPrecision = %OUT_DEFAULT_PRECIS
       fdwClipPrecision   = %CLIP_DEFAULT_PRECIS
       fdwQuality         = %DEFAULT_QUALITY
       lpszFace           = "Courier New"
      ' lpszFace           = "Terminal"
      ' lpszFace           = "MS Sans Serif"  ' no good at 10, .5 PROPORTIONAL FONT
      ' terminal is proportional
      ' courier new, point 8, w= height * .5 is pretty good
      ' Ditto point 10 is OK, too. Need to narrow and/or LIMIT the size of the column to 135??
      ' 7/9/04 never tried playing with these..

      fdwPitchandFamily   =  %FF_SWISS  ' var stroke width, with or without serifs


       hFont = CreateFont(nHeight,_
                          nWidth, _
                          nEscapement,_
                          nOrientation,_
                          fnWeight,_
                          fdwItalic,_
                          fdwUnderline,_
                          fdwStrikeOut,_
                          fdwCharSet,_
                          fdwOutputPrecision,_
                          fdwClipPrecision,_
                          fdwQuality,_
                          fdwPitchAndFamily,_
                          lpszFace)

  IF ISTRUE hDc THEN
     ReleaseDc hWndLv, hDc
  END IF
  FUNCTION = hFont
END FUNCTION

' ** END OF FILE **
