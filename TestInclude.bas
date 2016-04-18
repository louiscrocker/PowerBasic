#COMPILE EXE "TestInclude.exe"
#DIM ALL
#INCLUDE "Users.inc"

FUNCTION PBMAIN () AS LONG

    DIM strReturn AS STRING
    'strReturn = GetName()
    CALL GetUserName(strReturn)

    PRINT "hello from the test include"
    PRINT strReturn

    WAITKEY$

END FUNCTION
