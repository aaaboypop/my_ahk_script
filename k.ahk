findprocess:
{
	Process, Close, parsec.exe
	Process, Close, parsecd.exe
	if Process, Exist , parsec.exe
	{
		Sleep, 100
		Goto, findprocess
	}
}
Return
