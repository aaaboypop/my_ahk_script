findprocess:
{
	Process, Close, parsec.exe
	Process, Close, parsecd.exe
	if Process, Exist , parsec.exe
	{
		Process, Close, parsec.exe
		Sleep, 100
		Goto, findprocess
	}
	if Process, Exist , parsecd.exe
	{
		Process, Close, parsecd.exe
		Sleep, 100
		Goto, findprocess
	}
}
Return
