FileDelete, C:\Users\PONDX\Desktop\sample\*.*

Loop, Files, C:\Users\PONDX\Desktop\thumb\*.* ,F
{
	SplitPath, A_LoopFilePath, name, dir, ext, name_no_ext, drive
	
	ren := dir "\movie." ext
	FileMove, %A_LoopFilePath%, %ren%
}

run_command := "vspipe --y4m C:\Users\PONDX\Desktop\thumbnail.vpy - | ffmpeg -i pipe: -q:v 1 C:\Users\PONDX\Desktop\sample\image%06d.png"
RunWait, %comspec% /c %run_command% ,,


;ren1 := dir "\" name
;FileMove, %ren%, %ren1%


FileDelete, C:\Users\PONDX\Desktop\thumb\*.*