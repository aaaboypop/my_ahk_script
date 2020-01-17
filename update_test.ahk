str_upper( string = "" )
{
	Loop, parse, string
	{
		ac := Asc(A_LoopField)
		newstring .= Chr(ac+(ac>96&&ac<123 ? -32 : 0))
	}
	return newstring
}
str_lower( string = "" )
{
	Loop, parse, string
	{
		ac := Asc(A_LoopField)
		newstring .= Chr(ac+(ac>64&&ac<91 ? 32 : 0))
	}
	return newstring
}


Loop, read, C:\Users\PONDX\Desktop\N4A-V2.html
{
    if InStr(A_LoopReadLine, "Commits on")
	{
	    DL := RegExReplace(A_LoopReadLine, ".*Commits on","")
		if InStr(DL, "Jan")
			month := 1
		if InStr(DL, "Feb")
			month := 2
		if InStr(DL, "Mar")
			month := 3
		if InStr(DL, "Apr")
			month := 4
		if InStr(DL, "May")
			month := 5
		if InStr(DL, "Jun")
			month := 6
		if InStr(DL, "Jul")
			month := 7
		if InStr(DL, "Aug")
			month := 8
		if InStr(DL, "Sep")
			month := 9
		if InStr(DL, "Oct")
			month := 10
		if InStr(DL, "Nov")
			month := 11
		if InStr(DL, "Dec")
			month := 12
		
        Msgbox,% str_lower(DL) "`n" month "`n" str_upper(DL)
		Break
	}
}