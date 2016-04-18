#COMPILE EXE
#DIM ALL

FUNCTION PBMAIN () AS LONG

   LOCAL Collect AS IPOWERCOLLECTION

LET Collect = CLASS "PowerCollection"

 Collect.add ("w" , 7)
   Collect.add ("x" , 9)
    Collect.add ("y" , "%7")

    ? STR$(Collect.COUNT)

END FUNCTION
