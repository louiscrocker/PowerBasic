#COMPILE EXE
#DIM ALL

TYPE Student
    FirstName AS STRING * 25
    LastName AS STRING * 25
END TYPE

FUNCTION PBMAIN () AS LONG

    DIM std1 AS Student
    DIM std2 AS Student

    std1.FirstName = "Fred"
    std2.FirstName = "Barney"

    PRINT std1.FirstName
    PRINT std2.FirstName

    WAITKEY$

END FUNCTION
