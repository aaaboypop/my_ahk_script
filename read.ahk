WinGetActiveTitle, Title1
processName := "VoiceroidEditor.exe"
if (WinExist("ahk_exe " . processName)){
	WinGetTitle, title, ahk_exe %processName%
	StartTime := A_TickCount
	WinActivate, %title%
	WinWaitActive, %title%, , 1
	if ErrorLevel
	{
		exitapp
	}
	SendInput ^a
	SendInput ^v
	Send, {F5}
	WinActivate, %Title1%
	ElapsedTime := A_TickCount - StartTime
	;msgbox,% ElapsedTime
}