'Code:
'PBWIN 9.03 - WinApi 05/2008 - XP Pro SP3
'
'I've always struggled with Timers and never really understood the %Wm_Timer concept until just recently
'The thing I was hung up on was SetTimer and KillTimer. No good reason, I just never saw an example
'that struck the right chord in my head. (Trust me I looked at plenty examples, and had several pointed out.)
'Finally (working On the Network Ferret - http://www.powerbasic.com/support/pb...sprune=30&f=11)
'the concepts broke through.
'
'What I didn't quite get was SetTimer(CB.Hndl, %Timer_Id, 1000, ByVal %Null) told the program to trigger the %WM_Timer
'message every second (1000 milliseconds) for the %Timer_Id in this example. Could be any number of milliseconds.
'And the KillTimer actually stopped sending the message.
'Now I know that's probably obvious to most PB'ers but it wasn't to me. And Maybe a few others as well.
'
'So here's what I hope is a simple clear demo of just how Wm_Timer works for those few others. As much/most of
'programming, pretty simple really ... once you get it.
'
' Each control here is updated (incremented) every x seconds with a counter.
'
'I hope the use of relative numbers for the control id's isn't too confusing. It's technique I use a lot.
'Not to say it's a good one but one I use frequently. Has nothing to to with setting the timers at all.
'
' Gösta H. Lovgren
#COMPILE EXE
#DIM ALL
#OPTIMIZE SPEED  'Fly baby Fly!!!
#DEBUG DISPLAY ON '<<<<<<<<<<<<<<< Remember to turn off for production code

'******** Includes *********
#INCLUDE "WIN32API.INC"
'******** Equates **********
%Exit_Btn = 1000
'
%Timer_Equates_Start = 1101
%Timer_Equates_End = 1105
' Labels +20
' Buttons +40 start, +60 stop, +80 reset
'  to 1200 reserved for labels, buttons
' to 1300 for Timer ids
'
'********* Globals *********
GLOBAL g_Hdlg, g_Dlg_Wd, g_Dlg_ht AS LONG ' in case want to use in controls
GLOBAL g_Timer_Counter() AS LONG
'
'############################
CALLBACK FUNCTION Dialog_Processor
  LOCAL msecs, Timer_Id, idd AS LONG
  LOCAL s AS STRING
  s$ = SPACE$(60)
   SELECT CASE CB.MSG
     CASE %WM_INITDIALOG'<- Initialiaton when the program loads
     '
     CASE %WM_TIMER
       SELECT CASE CB.CTL
          CASE  %Timer_Equates_Start + 100 TO %Timer_Equates_End + 100 'Timer Id established by Start button
           CSET s$ = "WM Timer Demo " & TIME$
            DIALOG SET TEXT CB.HNDL, s$
            idd = CB.CTL - %Timer_Equates_Start - 100 + 1
            'g_Timer_Counter(idd) = g_Timer_Counter(idd) + CB.Ctl 'show timer being hit
            INCR g_Timer_Counter(idd)
            CONTROL SET TEXT CB.HNDL, CB.CTL - 80, USING$("#,", g_Timer_Counter(idd))
            'Incr Timer_Counter(idd)
       END SELECT
     '
     CASE %WM_COMMAND  'This processes command messages
       SELECT CASE CB.CTL
         CASE %Exit_Btn  'adios honey
            DIALOG END CB.HNDL
         '
         CASE %Timer_Equates_Start + 40 TO %Timer_Equates_End + 40 'start buttons
            CONTROL DISABLE CB.HNDL, CB.CTL
            CONTROL ENABLE CB.HNDL, CB.CTL + 20 'stop
            CONTROL ENABLE CB.HNDL, CB.CTL + 40 'reset
            msecs = CB.CTL - %Timer_Equates_Start - 40 + 1 'How many seconds to use for uodates
            msecs = msecs * 1000 'milliseconds for SetTimer
            Timer_Id = CB.CTL -40 + 100 'Timer id's
            SetTimer(CB.HNDL, Timer_Id, msecs, BYVAL %Null)   'Call Timer every msecs for Timer_Id control
         '
         CASE %Timer_Equates_Start + 60 TO %Timer_Equates_End + 60 'stop buttons
            CONTROL DISABLE CB.HNDL, CB.CTL
            Timer_Id = CB.CTL -60 + 100 'Timer id's
            KillTimer CB.HNDL, Timer_Id 'don't call wm_timer anymore for this control
'
            CONTROL ENABLE   CB.HNDL, CB.CTL - 20 'start
            CONTROL SET TEXT CB.HNDL, CB.CTL - 20, "Restart"
            CONTROL ENABLE   CB.HNDL, CB.CTL + 20 'reset
         '
         CASE %Timer_Equates_Start + 80 TO %Timer_Equates_End + 80 'reset buttons
            CONTROL DISABLE CB.HNDL, CB.CTL
            CONTROL ENABLE CB.HNDL, CB.CTL - 40 'start
            CONTROL DISABLE CB.HNDL, CB.CTL - 20 'stop
            CONTROL SET TEXT CB.HNDL, CB.CTL - 60, STR$(0)
            Timer_Id = CB.CTL -80 + 100 'Timer id's
            KillTimer CB.HNDL, Timer_Id 'don't call wm_timer anymore for this control
            idd = CB.CTL - %Timer_Equates_Start -80 + 1
            RESET g_Timer_Counter(idd)

       END SELECT
   END SELECT
END FUNCTION
'############################

'############################
FUNCTION PBMAIN
  LOCAL wd, ht, ctr, ctr1, ctr2, ROW, COL, stile AS LONG
  LOCAL s AS STRING
  LOCAL fnt AS DWORD
  '
  g_Dlg_Wd = 600
  g_Dlg_ht = 200
' easier to adjust/change styles this way
   Stile = Stile OR %WS_CAPTION
   Stile = Stile OR %WS_SYSMENU
   Stile = Stile OR %WS_MINIMIZEBOX
   Stile = Stile OR %WS_THICKFRAME
   Stile = Stile OR %WS_BORDER  'doesn't seem to do anything
'
  s$ = SPACE$(60)
  CSET s$ = "WM Timer Demo "
  DIALOG NEW PIXELS, 0, s$, , , g_Dlg_Wd, g_Dlg_ht, Stile TO g_hdlg 'centered
'
  FONT NEW "Comic Sans MS", 16 TO fnt
  ROW = 10
  FOR ctr = %Timer_Equates_Start TO %Timer_Equates_End
      GOSUB Draw_Controls
      ROW = ROW + ht + 5
      INCR ctr2 ' for dimming
  NEXT ctr
'
  REDIM g_Timer_Counter(ctr2)
'
  wd = 200
  ROW = g_dlg_ht - ht - 10
  COL = (g_dlg_wd - wd) \ 2
   s$ = "Abandon Time": CONTROL ADD BUTTON, g_Hdlg, %Exit_Btn, s$, COL, ROW, wd, ht, stile
   CONTROL SET FONT g_Hdlg, %Exit_Btn, fnt
'
  DIALOG SHOW MODAL g_hDlg   CALL Dialog_Processor
 EXIT FUNCTION
'
Draw_Controls:
  RESET ctr1
  COL = 20
   ht = 24
   wd = 100
   stile = %SS_CENTER
   s$ = USING$("In # Secs", ctr - 1100): CONTROL ADD LABEL, g_Hdlg, ctr, s$, COL, ROW, wd, ht, %SS_LEFT
   s$ = USING$("Timer #", ctr - 1100): INCR ctr1:  CONTROL ADD LABEL, g_Hdlg, ctr + 20, s$, COL + (wd * ctr1) + (10 * ctr1), ROW, wd + 20 , ht, stile
   s$ = "Start": INCR ctr1:  CONTROL ADD BUTTON, g_Hdlg, ctr + 40, s$, COL + (wd * ctr1) + (10 * ctr1), ROW, wd, ht, stile
   s$ = "Stop" : INCR ctr1:  CONTROL ADD BUTTON, g_Hdlg, ctr + 60, s$, COL + (wd * ctr1) + (10 * ctr1), ROW, wd, ht, stile
   s$ = "Reset": INCR ctr1:  CONTROL ADD BUTTON, g_Hdlg, ctr + 80, s$, COL + (wd * ctr1) + (10 * ctr1), ROW, wd, ht, stile
 'fonts
   CONTROL SET FONT g_Hdlg, ctr, fnt     ' label
   CONTROL SET FONT g_Hdlg, ctr + 20, fnt 'results
   CONTROL SET FONT g_Hdlg, ctr + 40, fnt 'start
   CONTROL SET FONT g_Hdlg, ctr + 60, fnt 'Stop
   CONTROL SET FONT g_Hdlg, ctr + 80, fnt 'Reset
  '
  CONTROL DISABLE g_Hdlg, ctr + 60 'not needed yet
  CONTROL DISABLE g_Hdlg, ctr + 80 '   ""
RETURN
END FUNCTION
'############################
