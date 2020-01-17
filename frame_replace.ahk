offset1 := 5198
i := 1
loop, Files, C:\Users\PONDX\Desktop\aaa3\*.* ,F
{
	SplitPath, A_loopfilepath, name, dir, ext, name_no_ext, drive
	
	offset1 += i
	name2 := "C:\Users\PONDX\Desktop\aaa4\image00" offset1 ".png"

	;msgbox,% name2
	FileCopy, %A_loopfilepath%, %name2%
}