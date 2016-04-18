FUNCTION GetName() AS STRING

    GetName = "Fred Flinstone"

END FUNCTION

FUNCTION GetUserName(BYREF strUserName AS STRING) AS LONG

    strUserName = GetName()

END FUNCTION
