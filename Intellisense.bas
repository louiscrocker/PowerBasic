'One of the more useful features of a modern day editor is the ability to give
'the users suggestions/options for the text they are about to type - syntax
'information, function arguments, and member information.  This is called
'Intellisense by Microsoft.

'An additional feature would be simply 'word completion', where the editor provides
'suggested spelling/text for completing a started word - essentially an automatic
'letter-by-letter spell-check with suggestions for completing the word being typed.

'This snippet deals with Intellisense, where the suggestions are for what follows
'a word that has just been typed.

'Primary Code:
'For length reasons, the primary code is given only once in the compilable example
'below. But a general description of the process is provided here.

'As each letter is typed the letters to the left are scanned for the presence of up
'to 3 words, corresponding to the maximum number of words in a multipleword
'PowerBASIC statement.

'However, the scanning only takes place when the character to the left of the cursor
'is one of several marker characters - a space, open parenthesis, period, or close
'parenthesis. These four characters mark the possible start/end of a PowerBASIC
'word or phrase that Intellisense will recognize. The presence of any other character
'closes any visible Intellisense display of information.

'When a marker charater is found and the (up to) 3 words to the left are scanned,
'a prioritized list of 5 searches is made to determine if the words are found in
'the Intellisense libraries.

'There are two types of words/phrases - those that will simply be followed by a
'list of arguments (the 'syntax') or those which will be followed by optional members.
'The 5 libraries are:
'   - single word Keywords             - single word Keywords with Members
'   - dual word Keyword phrases        - dual word Keyword phrases with Members
'   - triple word Keyword phrases

'These correspond to the PowerBASIC statements, which consist of 1-3 keywords that
'preceed an argument list or 1-2 keywords which preceed member options.

'If a word/phrase is found that supports trailing arguments (syntax), the argument list
'is presented in a small label just below the cursor.

'If a word/phrase is found that supports trailing members, the member list is presented
'in a listbox just below the cursor.

'When a word/phrase with members is found, the members are displayed in a popup
'listobx.  If the word/phrase has syntax, the syntax is shown in a popup label.

'With an Intellisense listbox or label shown, the user may use the following keys to
'take action.
'    ESC    -  hide the label/listbox
'    TAB    -  insert the argument list or selected member at the cursor
'    ENTER  - insert the argument list or selected member and move cursor to a new line

'In addition to the code in the callback and subclassed window procedures, there are
'several different subroutines which combine to provide the Intellisense features. The
'list of procedures is shown below.

'The Intellisense implementation in the compilable example below has the
'following limitations, which may be different than some implementations of
'Intellisense available in other editors.

'1. Dim x as MyType
'This snippet cannot automatically (at run time) determine MyType members
'unless they have been manually placed in the reference files.  Variables
'dimensioned as structure types are not recognized, i.e., popup member lists
'are not presented.

'2. ListBox
'Once the listbox is displayed, a selection must be mode by pressing
'TAB or Enter,  or else the ESC can be used to removed the listbox from view.
'Pressing letter keys will select an item from the list but the typed letters
'will not appear in the edit control.

'3. Argument Highlighting
'As arguments to a keyword/phrase are typed, Microsoft Intellisense changes
'the content of the popup syntax label - bolding the argument currently being
'typed.  The snippet below do not provide the bolding feature.

'Here are the primary procedures of the syntax highlighting code
'Credit: Borje Hagsten
'1. RichEdit control           - allows character size/font/color formatting
'2  Sub synInitilaize RWords   - uses DATA statements to create upper/lower/mixed keyword arrays
'3. Subclassed RichEdit        - to capture %WM_KeyUp
'4. Sub synApplySyntax         - calls TurnOffColor, ScanLine, handles mouse pointer
'5. Sub TurnOffColor           - sets entire control to black & white (a fast of erase syntax highlighting)
'6. Sub ScanLine               - primary parsers that identifies keywords, strings, comments
'7. Function setRichTextColor  - sets color of selection (keywords, strings, comments)
'8. Sub SetFont                - picks an easy to read font (Comic Sans MS)

'Here are the primary procedures of the Intellisense code
'1. Intellisense             -coordinates all of the other routines
'2. CharToLeftOfCursor       -returns the single character to the left of the cursor
'3. TestLeftChar             -takes action depending on what CharToLeftOfCursor Returns
'4. WordsToLeft              -returns the (up to) 3 words preceeding the cursor
'5. CloseIntellisense        -hide label/listbox, reset all flags
'6. InsertText               -place the label/listbox text into the RichEdit control
'7. LoadRef                  -loads the reference files
'8. BinaryRefSearch          -common routine to search all 5 reference files
'9. Modify Syntax            -modifies how syntax is displayed, depending on context of user input
'10. DisplaySyntaxLabel      -shows argument list (syntax) for the preceeding 1-3 words/phrase
'11. DisplaySyntaxListBox    -shows available Members for the preceeding 1-2 words/phrase
'12. NewListBoxProc          -detexts pressing RETURN, ESC, and TAB keys in ListBox
'13. NewRichEditProc         -detects pressing RETURN key in RichEdit control

'In addition to the source code below, the following text data files are required.
'Just put these files into the same folder as the EXE. These are now included as
'part of the gbSnippets distribution.

'  http://www.garybeene.com/files/word3_short.txt
'  http://www.garybeene.com/files/word2_short.txt
'  http://www.garybeene.com/files/word1_short.txt
'  http://www.garybeene.com/files/members1.txt
'  http://www.garybeene.com/files/members2.txt
'  http://www.garybeene.com/files/powerbasic.syn

'Compilable Example:
#COMPILE EXE
#DIM ALL
#INCLUDE "Win32api.inc"
#INCLUDE "commctrl.inc"
#INCLUDE "richedit.inc"
GLOBAL LWords() AS STRING, UWords() AS STRING, MWords() AS STRING

GLOBAL hRichEdit AS DWORD, hDlg AS DWORD, OrigRichEditProc&, CodeCase&
GLOBAL Ref_MemTerm1() AS STRING,  Ref_MemMember1() AS STRING
GLOBAL Ref_MemTerm2() AS STRING,  Ref_MemMember2() AS STRING
GLOBAL Ref_Term1() AS STRING, Ref_Desc1() AS STRING, Ref_Syntax1() AS STRING
GLOBAL Ref_Term2() AS STRING, Ref_Desc2() AS STRING, Ref_Syntax2() AS STRING
GLOBAL Ref_Term3() AS STRING, Ref_Desc3() AS STRING, Ref_Syntax3() AS STRING
GLOBAL hDlg AS DWORD, hRichEdit AS DWORD, LabelVisible&, ListBoxVisible&, hListBox AS DWORD
GLOBAL OldListBoxProc&, PI AS CharRange, OldRichEditProc&, CancelIntellisense&, cp AS LONG
%ID_RichEdit = 501 : %ID_Label = 502 : %ID_ListBox = 503 : %ID_Button = 504 : %ID_Button2 = 505


FUNCTION PBMAIN() AS LONG
    'create some sample content for the RichEdit control
    DIM CONTENT$
    CONTENT$ = "Function Example" + $CRLF + "Select Case MyVar" + $CRLF + "Case 12 '1st case" + $CRLF + "End Select" + $CRLF + "End Function"
    CONTENT$ = CONTENT$ + $CRLF + "For i = 1 to 10" + $CRLF + "Incr i" + $CRLF + "Next i"
    CONTENT$ = CONTENT$ + $CRLF + "If x = 2 Then" + $CRLF + "'do nothing" + $CRLF + "End If"
    DIALOG NEW PIXELS, 0, "Syntax Test",300,300,300,400, %WS_OVERLAPPEDWINDOW TO hDlg
    DIM Ref_Term1(0), Ref_Desc1(0), Ref_Syntax1(0)
    DIM Ref_Term2(0), Ref_Desc2(0), Ref_Syntax2(0)
    DIM Ref_Term3(0), Ref_Desc3(0), Ref_Syntax3(0)
    DIM Ref_MemTerm1(0), Ref_MemMember1(0)
    DIM Ref_MemTerm2(0), Ref_MemMember2(0)
    LoadRef "word1_short.txt", Ref_Term1(), Ref_Syntax1()
    LoadRef "word2_short.txt", Ref_Term2(), Ref_Syntax2()
    LoadRef "word3_short.txt", Ref_Term3(), Ref_Syntax3()
    LoadRef "members1.txt", Ref_memTerm1(), Ref_memMember1()
    LoadRef "members2.txt", Ref_memTerm2(), Ref_memMember2()
    cp = 1

    'create RichEdit and subclass (to intercept %WM_KeyUp actions)
    LoadLibrary("riched32.dll")
    InitCommonControls
    CONTROL ADD OPTION, hDlg, 201, "Upper", 10, 10, 50, 20
    CONTROL ADD OPTION, hDlg, 202, "Lower", 90, 10, 50, 20
    CONTROL ADD OPTION, hDlg, 203, "Mixed", 170, 10, 50, 20
    CONTROL ADD "RichEdit", hDlg, %ID_RichEdit, CONTENT$, 10, 40, 150, 100, _
             %WS_CHILD OR %WS_VISIBLE OR %ES_MULTILINE OR %WS_VSCROLL OR %ES_AUTOHSCROLL _
             OR %WS_HSCROLL OR %ES_AUTOVSCROLL OR %ES_WANTRETURN OR %ES_NOHIDESEL, _
             %WS_EX_CLIENTEDGE
    CONTROL HANDLE hDlg, %ID_RichEdit TO hRichEdit
    SetFont
    OrigRichEditProc& = SetWindowLong(GetDlgItem(hDlg, %ID_RichEdit), %GWL_WndProc, CODEPTR(NewRichEditProc))
    SendMessage hRichEdit, %EM_SETEVENTMASK, 0, %ENM_SELCHANGE OR %ENM_CHANGE OR %ENM_Link OR %ENM_KeyEvents

   CONTROL ADD LABEL, hDlg, %ID_Label, "tooltip",60,60,100,15, %WS_BORDER
   CONTROL SET COLOR hDlg, %ID_Label, %BLACK, %RGB_LIGHTYELLOW
   CONTROL ADD LISTBOX, hDlg, %ID_ListBox, ,60,60,100,100, %WS_BORDER
   CONTROL HANDLE hDlg, %ID_ListBox TO hListBox

    DIALOG SHOW MODAL hDlg CALL DlgProc
END FUNCTION

CALLBACK FUNCTION DlgProc() AS LONG
   LOCAL P AS CharRange
   SELECT CASE CB.MSG
        CASE %WM_INITDIALOG
            CodeCase& = 1        'upper lower mixed
            CONTROL SET OPTION hDlg, 201, 201, 203
            synInitializeRWords
            synApplySyntax
            OldListBoxProc& = SetWindowLong(GetDlgItem(hDlg, %ID_ListBox), %GWL_WndProc, CODEPTR(NewListBoxProc))
            CloseIntellisense
        CASE %WM_SIZE
            DIM w AS LONG, h AS LONG
            DIALOG GET CLIENT CB.HNDL TO w,h
            CONTROL SET SIZE CB.HNDL, %ID_RichEdit, w-20, h-20
        CASE %WM_NEXTDLGCTL
            SELECT CASE GetFocus
               CASE hRichEdit        'captures TAB in RichEdit
                   IF LabelVisible& OR ListBoxVisible& THEN
                      InsertText : FUNCTION = 1 : EXIT FUNCTION
                   END IF
            END SELECT
        CASE %WM_NOTIFY
            SELECT CASE CB.NMID
                CASE %ID_RichEdit
                    SELECT CASE CB.NMCODE
                       CASE %EN_SelChange
                           TestLeftChar
                    END SELECT
             END SELECT
        CASE %WM_COMMAND
            SELECT CASE CB.CTL
                CASE 201 : CodeCase& = 1 : synApplySyntax
                CASE 202 : CodeCase& = 2 : synApplySyntax
                CASE 203 : CodeCase& = 3 : synApplySyntax
                CASE %ID_RichEdit
                    SELECT CASE CB.CTLMSG
                       CASE %EN_SETFOCUS
                           P.cpmin = 0 : P.cpmax = 0 : SendMessage hRichedit, %EM_EXSETSEL, 0, VARPTR(P)   'highlight none
                    END SELECT
               CASE 100
                  IF CB.CTLMSG = %BN_CLICKED THEN
                     LOCAL iResult1&, iResult2&
                     TurnOffCol
                     ScanLine(0, SendMessage(hRichEdit, %EM_GETLINECOUNT, 0, 0) - 1)
                  END IF
               CASE %IDCANCEL    'pressing Escape
                     SELECT CASE GetFocus    'gets the control which has the focus
                        CASE hRichEdit : IF LabelVisible& OR ListBoxVisible& THEN CloseIntellisense  'ESC pressed in RichEdit
                     END SELECT
            END SELECT
    END SELECT
END FUNCTION

FUNCTION NewRichEditProc(BYVAL hWnd AS LONG, BYVAL wMsg AS LONG, BYVAL wParam AS LONG, BYVAL lParam AS LONG) AS LONG
  SELECT CASE wMsg
     CASE %WM_KEYUP         'trap key up, for syntax color check while editing
        LOCAL CurLine AS LONG
        CurLine = SendMessage(hRichEdit, %EM_EXLINEFROMCHAR, 0, -1)
        ScanLine(CurLine, CurLine)               'check current line only
        DIALOG REDRAW hDlg
        FUNCTION = 0 : EXIT FUNCTION                  'return zero
      CASE %WM_KEYDOWN
           SELECT CASE wParam
              CASE %VK_Return
                 IF LabelVisible& OR ListBoxVisible& THEN InsertText   'allow to continue processing
           END SELECT
  END SELECT
  NewRichEditProc = CallWindowProc(OrigRichEditProc&, hWnd, wMsg, wParam, lParam)
END FUNCTION

SUB synApplySyntax()
  MOUSEPTR 11                   'Scan all lines
  TurnOffCol
  ScanLine(0, SendMessage(hRichEdit, %EM_GETLINECOUNT, 0, 0) - 1)
  MOUSEPTR 0
  SetFocus hRichEdit
END SUB

SUB synInitializeRWords
   LOCAL temp$, i AS LONG
   REDIM UWords(1000), LWords(1000), MWords(1000)
   'read the language file
   OPEN EXE.PATH$ + "powerbasic.syn" FOR INPUT AS #1
   WHILE ISFALSE EOF(1)
      LINE INPUT #1, temp$
      IF LEN(TRIM$(temp$)) THEN
         MWords(i) = temp$
         UWords(i) = UCASE$(MWords(i))
         LWords(i) = LCASE$(MWords(i))
         INCR i
         END IF
    WEND
    CLOSE #1
    REDIM PRESERVE UWords(i-1), LWords(i-1), MWords(i-1)
END SUB

FUNCTION setRichTextColor( BYVAL NewColor AS LONG) AS LONG
' setRichTextColor sets the textcolor for selected text in a Richedit control.
' &HFF - read, &HFF0000 - blue, &H008000 - dark green, &H0 is black, etc.
   LOCAL cf AS CHARFORMAT
   cf.cbSize      = LEN(cf)       'Length of structure
   cf.dwMask      = %CFM_COLOR    'Set mask to colors only
   cf.crTextColor = NewColor      'Set the new color value
   SendMessage(hRichEdit, %EM_SETCHARFORMAT, %SCF_SELECTION, VARPTR(cf))
END FUNCTION

SUB TurnOffCol
' Set all text to black - faster this way
  LOCAL cf AS CHARFORMAT, xEvent AS LONG
  xEvent = SendMessage(hRichEdit, %EM_GETEVENTMASK, 0, 0)         'Get eventmask
  SendMessage(hRichEdit, %EM_SETEVENTMASK, 0, 0)            'Disable eventmask
  MOUSEPTR 11                                                'Hourglass
  cf.cbSize      = LEN(cf)                                   'Length of structure
  cf.dwMask      = %CFM_COLOR                                'Set mask to colors only
  cf.crTextColor = &H0                                       'Set black color value
  SendMessage(hRichEdit, %EM_SETCHARFORMAT, -1, VARPTR(cf)) '%SCF_ALL = -1
  IF xEvent THEN
     SendMessage(hRichEdit, %EM_SETEVENTMASK, 0, xEvent)     'Enable eventmask
  END IF                                                     'Arrow
  MOUSEPTR 0
  SendMessage(hRichEdit, %EM_SETMODIFY, %FALSE, 0)          'reset modify flag
END SUB

SUB ScanLine(BYVAL Line1 AS LONG, BYVAL Line2 AS LONG)
' Syntax color parser for received line numbers
  LOCAL pd AS CHARRANGE, Oldpd AS CHARRANGE, tBuff AS TEXTRANGE
  LOCAL xWord AS STRING, Buf AS STRING
  LOCAL Aspect AS LONG, xEvents AS LONG, I AS LONG , J AS LONG, stopPos AS LONG
  LOCAL lnLen AS LONG, Result AS LONG, wFlag AS BYTE, Letter AS BYTE PTR

  SendMessage(hRichEdit, %EM_EXGETSEL, 0, VARPTR(Oldpd)) 'Original position
                                                          '(so we can reset it later)
  'Disable the event mask, for better speed
  xEvents = SendMessage(hRichEdit, %EM_GETEVENTMASK, 0, 0)
  SendMessage(hRichEdit, %EM_SETEVENTMASK, 0, 0)

  'Turn off redraw for faster and smoother action
  SendMessage(hRichEdit, %WM_SETREDRAW, 0, 0)

  IF Line1 <> Line2 THEN                                  'if multiple lines
     MOUSEPTR 11
  ELSE                                                                     'editing a line
     pd.cpMin = SendMessage(hRichEdit, %EM_LINEINDEX, Line1, 0)                'line start
     pd.cpMax = pd.cpMin + SendMessage(hRichEdit, %EM_LINELENGTH, pd.cpMin, 0) 'line end
     SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(pd))                  'select line
     setRichTextColor &H0                                             'set black
  END IF

  FOR J = Line1 TO Line2
     Aspect = SendMessage(hRichEdit, %EM_LINEINDEX, J, 0)       'line start
     lnLen  = SendMessage(hRichEdit, %EM_LINELENGTH, Aspect, 0) 'line length

     IF lnLen THEN
        Buf = SPACE$(lnLen + 1)
        tBuff.chrg.cpMin = Aspect
        tBuff.chrg.cpMax = Aspect + lnLen
        tBuff.lpstrText = STRPTR(Buf)
        lnLen = SendMessage(hRichEdit, %EM_GETTEXTRANGE, 0, BYVAL VARPTR(tBuff)) 'Get line

        CharUpperBuff(BYVAL STRPTR(Buf), lnLen)        'Make UCASE
        'I always use this one, since it handles characters > ASC(127) as well.. ;-)

        '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ' Loop through the line, using a pointer for better speed
        '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Letter = STRPTR(Buf) : wFlag = 0
        FOR I = 1 TO LEN(Buf)
           SELECT CASE @Letter 'The characters we need to inlude in a word
              CASE 97 TO 122, 65 TO 90, 192 TO 214, 216 TO 246, 248 TO 255, _
                                                 35 TO 38, 48 TO 57, 63, 95
                 IF wFlag = 0 THEN
                    wFlag = 1 : stopPos = I
                 END IF

              CASE 34 ' string quotes -> "
                stopPos = INSTR(I + 1, Buf, CHR$(34)) 'Find match
                IF stopPos THEN
                   pd.cpMin = Aspect + I
                   pd.cpMax = Aspect + stopPos - 1
                   SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(pd))
                   setRichTextColor &HFF
                   StopPos = (StopPos - I + 1)
                   I = I + StopPos
                   Letter = Letter + StopPos
                   wFlag = 0
                END IF

              CASE 39 ' uncomment character -> '
                 pd.cpMin = Aspect + I - 1
                 pd.cpMax = Aspect + lnLen
                 SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(pd))
                 setRichTextColor &H00008000&
                 wFlag = 0
                 EXIT FOR

              CASE ELSE  'word is ready
                 IF wFlag = 1 THEN
                    xWord = MID$(Buf, stopPos, I - stopPos)  'Get word

                    IF xWord = "REM" THEN  'extra for the uncomment word, REM
                       pd.cpMin = Aspect + I - LEN(xWord) - 1
                       pd.cpMax = Aspect + lnLen
                       SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(pd))
                       setRichTextColor &H00008000&
                       wFlag = 0
                       EXIT FOR
                    END IF
                    ARRAY SCAN UWords(0), = xWord, TO Result  'Is it in the array?
                    IF Result THEN
                       pd.cpMin = Aspect + stopPos - 1
                       pd.cpMax = Aspect + I - 1
'---------------------------------upper/lower/mixed handled here-----------
                    SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(pd))
                    IF CodeCase& THEN
                       xWord = CHOOSE$(CodeCase&, UWords(Result-1), LWords(Result-1), MWords(Result-1))
                       CONTROL SEND hDlg, %ID_RichEdit, %EM_ReplaceSel, %True, STRPTR(xWord)
                    END IF
'----------------------------------------------------------------------
                       SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(pd))
                       setRichTextColor(&HFF0000)       'set blue color
                    END IF
                    wFlag = 0
                 END IF
           END SELECT

           INCR Letter
        NEXT I
     END IF
  NEXT J

  'Reset original caret position
  SendMessage(hRichEdit, %EM_EXSETSEL, 0, VARPTR(Oldpd))

  'Turn on Redraw again and refresh - this one causes some flicker in Richedit..
  SendMessage hRichEdit, %WM_SETREDRAW, 1, 0
  InvalidateRect hRichEdit, BYVAL %NULL, 0 : UpdateWindow hRichEdit

  'Reset the event mask
  IF xEvents THEN SendMessage(hRichEdit, %EM_SETEVENTMASK, 0, xEvents)
END SUB

SUB SetFont
   DIM hFont AS DWORD
   FONT NEW "Comic Sans MS", 10, 1 TO hFont
   CONTROL SET FONT hDlg, %ID_RichEdit, hFont
END SUB

SUB TestLeftChar
    LOCAL temp$
    temp$ = CharToLeftOfCursor
    IF temp$ = $SPC THEN
       Intellisense $SPC
    ELSEIF temp$ = "(" THEN
       Intellisense "("
    ELSEIF temp$ = ")" THEN
       IF LabelVisible& OR ListBoxVisible& THEN CloseIntellisense
    ELSEIF temp$ = "." THEN
       Intellisense "."
    ELSE
       CloseIntellisense
    END IF
END SUB

FUNCTION CharToLeftOfCursor() AS STRING
   LOCAL P AS CharRange, buf$, T AS TextRange
   SendMessage(hRichEdit, %EM_EXGetSel, 0, VARPTR(P))                     'caret position
   T.Chrg.cpmin = P.cpmin-1 : T.Chrg.cpmax = P.cpmax : buf$ = " "
   T.lpstrText = STRPTR(Buf$)
   SendMessage hRichEdit, %EM_GetTextRange, BYVAL 0, VARPTR(T)  'get text, specified char range or from selection
   FUNCTION = buf$
END FUNCTION

FUNCTION WordsToLeft(w3$, w2$, w1$) AS LONG
   LOCAL iLine AS LONG, buf$, iStartPos&, iLineLength&, P AS CharRange, iLeft&, iCount&
   SendMessage(hRichEdit, %EM_EXGetSel, 0, VARPTR(P))                     'caret position
   DECR p.cpmin
   iLine = SendMessage(hRichEdit, %EM_ExLineFromChar, 0, -1)              'current line#
   iStartPos& = SendMessage(hRichEdit, %EM_LineIndex, iLine, 0)            'position of 1st char in current line
   iLineLength& = SendMessage(hRichEdit, %EM_LineLength, iStartPos&, 0)   'length of specified line
   buf$ = SPACE$(iLineLength&)
   SendMessage(hRichEdit, %EM_GetLine, iLine, STRPTR(buf$))    'text of current line
   w3$ = MID$(buf$,1,P.cpmin-iStartPos&)                          'text to left of caret
   w3$ = RETAIN$(w3$, ANY CHR$(65 TO 90, 97 TO 122, 48 TO 57, $SPC, "$&#%?!"))
   iCount& = PARSECOUNT(w3$, " ")
   w1$ = PARSE$(w3$," ",iCount&)
   w2$ = PARSE$(w3$," ",iCount&-1)
   w3$ = PARSE$(w3$," ",iCount&-2)
END FUNCTION

SUB Intellisense(sChar$)
   IF CancelIntellisense& THEN EXIT SUB

   LOCAL sWord$, sSyntax$, iReturn&, w3$, w2$, w1$
   SendMessage(hRichEdit, %EM_EXGetSel, 0, VARPTR(PI))                     'caret position at start of intellisense
   WordsToLeft(w3$, w2$, w1$)

   IF LEN(w3$) AND BinaryReferenceSearch(BUILD$(w3$,$SPC,w2$,$SPC,w1$), iReturn&, Ref_Term3(), Ref_Syntax3()) THEN
       '3 word sequence was found
       sWord$ = BUILD$(w3$,$SPC,w2$,$SPC,w1$)
       sSyntax$ = Ref_Syntax3(iReturn&)
       DisplaySyntaxLabel (sSyntax$)
   ELSEIF LEN(w2$) AND BinaryReferenceSearch(BUILD$(w2$,$SPC,w1$), iReturn&, Ref_memTerm2(), Ref_memMember2()) THEN
        '2 word sequence was found
       sWord$ = BUILD$(w2$,$SPC,w1$)
       sSyntax$ = Ref_memMember2(iReturn&)
       DisplaySyntaxListbox (sSyntax$)
   ELSEIF LEN(w2$) AND BinaryReferenceSearch(BUILD$(w2$,$SPC,w1$), iReturn&, Ref_Term2(), Ref_Syntax2()) THEN
        '2 word sequence was found
       sWord$ = BUILD$(w2$,$SPC,w1$)
       sSyntax$ = Ref_Syntax2(iReturn&)
       DisplaySyntaxLabel (sSyntax$)
   ELSEIF LEN(w1$) AND BinaryReferenceSearch(w1$, iReturn&, Ref_memTerm1(), Ref_memMember1()) THEN
        '1 word sequence was found
       sWord$ = w1$
       sSyntax$ = Ref_memMember1(iReturn&)
       DisplaySyntaxListBox (sSyntax$)
   ELSEIF LEN(w1$) AND BinaryReferenceSearch(w1$, iReturn&, Ref_Term1(), Ref_Syntax1()) THEN
        '1 word sequence was found
       sWord$ = w1$
       sSyntax$ = ModifySyntax(sChar$, Ref_Syntax1(iReturn&))
       DisplaySyntaxLabel (sSyntax$)
    ELSE
        'no matches were found
        IF LabelVisible& OR ListBoxVisible& THEN CloseIntellisense
    END IF
END SUB

FUNCTION ModifySyntax (sChar$, BYVAL sSyntax$) AS STRING
'    If sChar$ = " " AND Left$(sSyntax$,1) = "(" Then             'optional way to skip leading (
'        sSyntax$ = Mid$(sSyntax$, 2, Len(sSyntax$)-2)
    IF sChar$ = "(" AND LEFT$(sSyntax$,1) = "(" THEN
       sSyntax$ = MID$(sSyntax$, 2)         'do not allow ((
    ELSEIF sChar$ = "(" AND LEFT$(sSyntax$,1) <> "(" THEN
       sSyntax$ = ""                        'if sChar is (, then sSyntax must also start with (, otherwise, don't show sSyntax
    END IF
    FUNCTION = sSyntax$
END FUNCTION

SUB CloseIntellisense
        CONTROL SHOW STATE hDlg, %ID_Label, %SW_HIDE : LabelVisible& = 0
        CONTROL SHOW STATE hDlg, %ID_ListBox, %SW_HIDE : ListBoxVisible& = 0
END SUB

SUB DisplaySyntaxLabel(sSyntax$)
      LOCAL P AS POINT
      CONTROL SET TEXT hDlg, %ID_Label, sSyntax$                      'put sSyntax in Label
      CONTROL SEND hDlg, %ID_RichEdit, %EM_PosFromChar, VARPTR(P), PI.cpmin   'get xy coordinates of caret
      CONTROL SET LOC hDlg, %ID_Label, P.x+25, P.y+60                'assign position of label
      CONTROL SET SIZE hDlg, %ID_Label, LEN(sSyntax$)*7,15
      CONTROL SHOW STATE hDlg, %ID_Listbox, %SW_HIDE : ListBoxVisible& = 0   'hide listbox
      CONTROL SHOW STATE hDlg, %ID_Label, %SW_SHOW : LabelVisible& = 1                'show label
END SUB

SUB DisplaySyntaxListBox(sMembers$)
      LOCAL P AS POINT, i AS LONG
      LISTBOX RESET hDlg, %ID_ListBox
      DIM mList(PARSECOUNT(sMembers$,".")-1) AS STRING
      PARSE sMembers$,mList(),"."
      FOR i = 0 TO UBOUND(mList) : LISTBOX INSERT hDlg, %ID_ListBox, 1, mList(i) : NEXT i
      CONTROL SEND hDlg, %ID_RichEdit, %EM_PosFromChar, VARPTR(P), PI.cpmin  'get xy coordinates of caret
      CONTROL SET LOC hDlg, %ID_ListBox, P.x+25, P.y+60                'assign position of label
      CONTROL SHOW STATE hDlg, %ID_Label, %SW_HIDE : LabelVisible& = 0       'hide label
      CONTROL SHOW STATE hDlg, %ID_ListBox, %SW_SHOW :ListBoxVisible& = 1       'show listbox
      CONTROL SET FOCUS hDlg, %ID_ListBox
      LISTBOX SELECT hDlg, %ID_ListBox, 1
END SUB

FUNCTION BinaryReferenceSearch(BYVAL sWord AS STRING, iArrayPos&, ArrayTerm() AS STRING, ArraySyntax() AS STRING) AS LONG
    LOCAL Upper AS LONG, Lower AS LONG
    Lower = LBOUND(ArrayTerm) : Upper = UBOUND(ArrayTerm) : sWord = LCASE$(sWord)
    'test boundary values
    IF sWord = ArrayTerm(Lower) THEN iArrayPos& = Lower : FUNCTION = 1 : EXIT FUNCTION
    IF sWord = ArrayTerm(Upper) THEN iArrayPos& = Upper : FUNCTION = 1 : EXIT FUNCTION
    IF sWord < ArrayTerm(Lower) THEN iArrayPos& = Lower - 1 : FUNCTION = 0 : EXIT FUNCTION
    IF sWord > ArrayTerm(Upper) THEN iArrayPos& = Upper + 1 : FUNCTION = 0 : EXIT FUNCTION
    'loop through remaining entries until searchterm found, or it's determined that term is not in the array
    DO UNTIL (Upper <= (Lower+1))
        iArrayPos& = (Lower + Upper) / 2
        IF sWord > ArrayTerm(iArrayPos&) THEN
           Lower = iArrayPos&
        ELSEIF sWord < ArrayTerm(iArrayPos&) THEN
           Upper = iArrayPos&
        ELSE
           FUNCTION = 1 : EXIT FUNCTION
        END IF
    LOOP
END FUNCTION

SUB LoadRef (sFile$, ArrayTerm() AS STRING, ArraySyntax() AS STRING)
    'load any of the 5 reference files - all use the same content format   sWord:::::sSyntax
    LOCAL temp$, i AS LONG
    OPEN sFile$ FOR BINARY AS #1 : GET$ #1, LOF(1), temp$ : CLOSE
    temp$ = RTRIM$(temp$,$CRLF)
    REDIM ArrayTerm(PARSECOUNT(temp$,$CRLF)-1) AS STRING, ArraySyntax(UBOUND(ArrayTerm)) AS STRING
    PARSE temp$,ArrayTerm(),$CRLF
    FOR i = 0 TO UBOUND(ArrayTerm)
        ArraySyntax(i) = PARSE$(ArrayTerm(i),":::::", 2)
        ArrayTerm(i) = PARSE$(ArrayTerm(i),":::::", 1)
    NEXT i
END SUB

SUB InsertText
   LOCAL temp$
   IF LabelVisible& THEN
      CONTROL GET TEXT hDlg, %ID_Label TO temp$                                 'get text
      temp$ = temp$ + " "
      CONTROL SHOW STATE hDlg, %ID_Label, %SW_HIDE : LabelVisible& = 0      'hide label
      SendMessage hRichEdit, %EM_ReplaceSel, 0, STRPTR(temp$)                'put text in RichEdit
   ELSEIF ListBoxVisible& THEN
      CancelIntellisense& = %True
      LISTBOX GET TEXT hDlg, %ID_ListBox TO temp$                                'get text (selected item)
      temp$ = temp$ + " "
      CONTROL SHOW STATE hDlg, %ID_ListBox, %SW_HIDE : ListBoxVisible& = 0   'hide ListBox
      SetFocus hRichEdit
      SendMessage hRichEdit, %EM_EXSetSel, 0, VARPTR(PI)                       'set cursor to new position
      SendMessage hRichEdit, %EM_ReplaceSel, 0, STRPTR(temp$)                  'put text in RichEdit
      CancelIntellisense& = %False
   END IF
END SUB

FUNCTION NewListBoxProc(BYVAL hWnd AS LONG, BYVAL Msg AS LONG, BYVAL wParam AS LONG, BYVAL lParam AS LONG) AS LONG
   SELECT CASE Msg
      CASE %WM_GETDLGCODE                 'establish control by the RichEdit
           FUNCTION = %DLGC_WANTALLKEYS
           EXIT FUNCTION
      CASE %WM_KEYDOWN      'WM_Char
           SELECT CASE wParam
              CASE %VK_Return
                 InsertText                            'richedit will now have focus
                 keybd_event %VK_Return, 0, 0, 0   'send return key to hRichEdit
              CASE %VK_Escape
                 CancelIntellisense& = %True      'avoids firing Intellisense a second time before this loop is over
                 CloseIntellisense
                 SetFocus hRichEdit
                 SendMessage (hRichEdit, %EM_EXSetSel, 0, VARPTR(PI))
                 CancelIntellisense& = %False
              CASE %VK_Tab
                 InsertText
                 TestLeftChar               'the inserted text may actually be a keyword itself
           END SELECT
   END SELECT
   FUNCTION = CallWindowProc(OldListBoxProc&, hWnd, Msg, wParam, lParam)
END FUNCTION
