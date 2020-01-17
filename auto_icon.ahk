in_path := "D:\DATA\DaTa2\EM-EG\Manga"
config_ext1 := ".mp4"

Gui, Add, Text, x22 y9 w70 h20 , Input Folder :
Gui, Add, Edit, x102 y9 w180 h20 vin_path ggui_update, %in_path%
Gui, Add, Button, x282 y9 w30 h20 , ...
Gui, Add, Edit, x622 y19 w730 h180 vc_log,

Gui, Add, Text, x22 y179 w60 h20 , Icon :
Gui, Add, Edit, x102 y179 w400 h20 vedit1,
Gui, Add, Button, x502 y179 w30 h20 , ...
Gui, Add, Button, x542 y179 w70 h20 ggui_update, Change
Gui, Add, Text, x22 y39 w70 h20 , Icon Select :
Gui, Add, Radio, x102 y39 w60 h20 vpick_first Group ggui_update, First File
Gui, Add, Radio, x172 y39 w60 h20 vpick_png ggui_update, icon.png
Gui, Add, Radio, x242 y39 w60 h20 vpick_ico ggui_update, icon.ico
Gui, Add, button, x182 y669 w150 h20 vb_start gstart, Start
Gui, Add, button, x22 y669 w150 h20 gauto_fill, Auto Fill


Gui, Add, ListView, x22 y212 w1330 h400 glist_view, Path|Folder Name|Icon|Type





Gui, Submit, NoHide
Gui, Show, x345 y137 h700 w1366, Auto Folder Icon

gui_update:
{
	Gui, Submit, NoHide
	
	Loop, Files,%in_path%\*, D R
	{
		fpath := A_LoopFileDir "\" A_LoopFileName "\*.ico"

		if FileExist(fpath)
		Loop, Files,%fpath%
		{
			icon_name := A_LoopFilePath
			file_type := A_LoopFileExt
			break
		}
		else
		{
			icon_name := ""
			file_type := ""
		}
		in_len := StrLen(test_path)
		StringTrimLeft, test_sub_dir, A_LoopFileDir, %in_len%
		LV_Add("", A_LoopFileDir, A_LoopFileName, icon_name, file_type)
	}
		
	LV_ModifyCol() 
	LV_ModifyCol(2,Auto) 
}
return

list_view:
{
	LastEventInfo := LV_GetNext(0, "F")
	LV_GetText(var1, LastEventInfo, 3)
	
	Guicontrol,,edit1,%var1%
}
return

auto_fill:
{
	loop,% LV_GetCount()
	{
		fill3 := ""
		LV_GetText(fill3, a_index, 3)
		
		if(fill3 = "")
		{
			LV_GetText(fill1, a_index, 1)
			LV_GetText(fill2, a_index, 2)
			fill3 := fill1 "\" fill2 "\"
			
			loop_index := a_index
			loop, Files, %fill3%*.*
			{
				if A_LoopFileExt in png,jpg,bmp
				{
					fill3 := fill1 "\" fill2 "\" A_LoopFileName
					LV_Modify(loop_index , ,fill1,fill2,fill3,A_LoopFileExt)
					break
				}
			}
		}
	}
	msgbox, end
}
return

start:
{
	loop,% LV_GetCount()
	{
		LV_GetText(file_type, a_index, 4)
		LV_GetText(ico_filepath, a_index, 3)
		LV_GetText(outpath1, a_index, 1)
		LV_GetText(outpath2, a_index, 2)
		outpath0 := outpath1 "\" outpath2
		
		if(file_type <> "ico")
		{
			outpath3 :=  outpath1 "\" outpath2 "\icon.ico"
			run_command := """" A_WorkingDir "\ImageMagick\convert.exe"" """ ico_filepath """ -gravity center -crop 1:1 -resize 256x256 " """" outpath3 """"
			Guicontrol,,c_log,% run_command
			runwait,%run_command%
			ico_filepath := outpath3
		}
		
		FileDelete, %outpath0%\desktop.ini
		runwait, %comspec% /c attrib +r %outpath0%,,
		IniWrite, Pictures, %outpath0%\desktop.ini, ViewState, FolderType
		IniWrite, %A_Space%, %outpath0%\desktop.ini, ViewState, Mode
		IniWrite, %A_Space%, %outpath0%\desktop.ini, ViewState, Vid
		SplitPath, ico_filepath, ico_name
		IniWrite, %ico_name%`,0, %outpath0%\desktop.ini, .ShellClassInfo, IconResource
		runwait, %comspec% /c attrib +s +h "%outpath0%\desktop.ini",,

	}
	runwait, %comspec% /c %outpath1% /a /b,,
}
Return


;convert 0001.jpg -gravity center -crop 1:1 -resize 256x256 cover.ico
;update data folder :: dir /a /b
;runcommand run, %comspec% /c del C:\Users\Test\Desktop\test.txt,,hide

guiclose:
exit:
{
	exitapp
}
return
