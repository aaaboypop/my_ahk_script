command := "ffmpeg"
aloop := 0
Loop, Files, C:\Users\PONDX\Desktop\00*.asf, FR
{
	command .= " -i " A_loopfilepath 
	aloop++
}
command .= " -filter_complex """
i:=0
while(i<aloop)
{
	command .= "[" i ":v] [" i ":a] " 
	i++
}

command .= "concat=n=" aloop ":v=1:a=1 [v] [a]"" -map ""[v]"" -map ""[a]"" "
command .= "-crf 0 -preset veryfast  F:\10.mkv"
clipboard = % command