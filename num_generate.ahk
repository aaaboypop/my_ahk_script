command := "ffmpeg "
file_list := ""
Loop, Files, F:\000\*.* , F
{
	file_list .= A_LoopFilePath ","
	;FileMove, C:\*.txt, C:\My Folder
	Num := A_Index
	Pack := "000000"
	new_name := "image" (SubStr(Pack, 1, StrLen(Pack) - StrLen(Num)) . Num) ".jpg"
	
	tooltip,% new_name
	sleep,10
}
	StringTrimRight,file_list,file_list,1
	Loop, Parse, file_list , "`,"
	{
		tooltip,% A_LoopField
		sleep,10
	}
	sleep,5000
	tooltip,