in_path := "D:\DATA\Downloads\Video"
out_path := "D:\DATA\Downloads\Video"
config_ext1 := ".mp4"
config_ext2 := ".jpg"

pass := "n4a"
rename_word1 := "_"
rename_word2 := "_RAW"


Gui, Add, Text, x12 y9 w80 h20 , Input Folder :
Gui, Add, Edit, x102 y9 w180 h20 vin_path ggui_update, %in_path%
Gui, Add, Text, x12 y39 w80 h20 , Output Folder :
Gui, Add, Edit, x102 y39 w180 h20 vout_path ggui_update, %out_path%
Gui, Add, Text, x12 y69 w80 h20 , Password :
Gui, Add, Edit, x102 y69 w180 h20 vpass ggui_update, %pass%

Gui, Add, CheckBox, x12 y159 w90 h20 vrename1 Checked ggui_update, Rename

Gui, Add, Edit, x12 y319 w310 h80 -VScroll vl_com,

Gui, Add, Text, x340 y9 w80 h20 , Find Word :
Gui, Add, Edit, x+10 w180 h20 vrename_word1 ggui_update, %rename_word1%
Gui, Add, Edit, x+10 w180 h20 vrename_word2 ggui_update, %rename_word2%

Gui, Add, Text, x340 y+30 w80 h20 vstatus,


Gui, Add, Text, x42 y229 w60 h20 vtconfig_gpu1, Ext 1 :
Gui, Add, DropDownList, x102 y229 w50 h20 vconfig_ext1 r8 ggui_update, .mp4|.mkv|.wma|.flv|.mov
Gui, Add, Text, x42 y249 w60 h20 vtconfig_gpu2, Ext 2 :
Gui, Add, DropDownList, x102 y249 w50 h20 vconfig_ext2 r8 ggui_update, .jpg|.png|.bmp

Gui, Add, Button, x282 y9 w30 h20 gin_folder, ...
Gui, Add, Button, x282 y39 w30 h20 gout_folder, ...
Gui, Add, button, x12 y439 w150 h20 vb_start grun_start, Start
Gui, Add, button, x12 y469 w150 h20 vb_stop grun_clear, Clear
Gui, Add, button, x+20 y469 w150 h20 vb_rename grun_rename, Rename

GuiControl, ChooseString, config_ext1, %config_ext1%
GuiControl, ChooseString, config_ext2, %config_ext2%

Gui, Add, Text, x652 y519 w240 h20, by pond_pop @ www.facebook.com/Net4Anime
Gui, Submit, NoHide
Gui, Show, x345 y137 h539 w895, Auto RAR

gui_update:
{
	Gui, Submit, NoHide
}
return

in_folder:
{
	Thread, NoTimers
	FileSelectFolder, in_path,, 3
	Thread, NoTimers, false
	GuiControl,,in_path,%in_path%
}
Return

out_folder:
{
	Thread, NoTimers
	FileSelectFolder, out_path,, 3
	Thread, NoTimers, false
	GuiControl,,out_path,%out_path%
}
Return

run_start:
{
	loopc := in_path "\*" config_ext1
	
	if(rename1 = 1)
	{
		word_len1 := StrLen(rename_word1)
		word_len2 := StrLen(rename_word2)
		
		Loop, Files, %loopc%, F
		{

			StringReplace, ren, A_LoopFileName, %A_Space%, _, All
			
			IfInString, ren, %rename_word1%
			{
				StringReplace, ren, ren, %rename_word1%, , All
			}
			
			IfInString, ren, %rename_word2%
			{
				StringReplace, ren, ren, %rename_word2%, , All
			}
			
			ren := out_path "\" ren
			FileMove, %A_LoopFilePath%, %ren%
			
		}
	}
	
	Loop, Files, %loopc%, F
	{
		StringTrimRight, out_filename, A_LoopFileName, 4
		
		
		
		
		IfExist, %out_path%\%out_filename%.rar
		{
			continue
		}
		
		command := """C:\Program Files\WinRAR\WinRAR.exe"" a -ep -hp" pass " """ out_path "\" out_filename ".rar"" """ A_LoopFilePath """"
		GuiControl,,l_com,%command%
		RunWait,  %command%, , min
	}
}
Return

run_rename:
{
	StartTime := A_TickCount
	count_loop_file := 0
	Loop, Files, %in_path%\*.* , F
	{
		count_loop_file++
	}
	
	Loop, Files, %in_path%\*.* , F
	{
		;StringReplace, ren, A_LoopFileName, .jpg, .png, All
		StringReplace, ren, A_LoopFileName, ge, image, All
		ren := out_path "\" ren
		FileMove, %A_LoopFilePath%, %ren%
		ElapsedTime := A_TickCount - StartTime
		If(ElapsedTime > 500)
		{
			GuiControl,,status,%A_LoopFileName% - %count_loop_file%/%A_Index%
			StartTime := A_TickCount
		}
	}
	
}
Return

run_clear:
{
	loopc := in_path "\*" config_ext1
	Loop, Files, %loopc%, F
	{
		FileDelete, %A_LoopFilePath%
	}
	
	loopc := in_path "\*" config_ext2
	Loop, Files, %loopc%, F
	{
		FileDelete, %A_LoopFilePath%
	}
	
}
Return

guiclose:
exit:
{
	exitapp
}
return
