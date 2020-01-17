#SingleInstance, force

version := 190906 " ver"1.1

;In
Gui, Add, Text, x10 y12 w70 h20 +right, Input File :
Gui, Add, Edit, x82 y9 w180 h20 vPath_in, 
Gui, Add, Button, x262 y9 w30 h20 gIn_folder, ...
;Out
Gui, Add, Text, x10 y33 w70 h20 +right, Output Folder :
Gui, Add, Edit, x82 y29 w180 h20 vPath_out, 
Gui, Add, Button, x262 y29 w30 h20 gOut_folder, ...
;Replace1
Gui, Add, Text, x300 y12 w50 h20 +right, Match :
Gui, Add, ComboBox, x352 y9 w180 h20 r10 vr_fn1_m, |image|@num|
Gui, Add, Text, x300 y33 w50 h20 +right, Replace :
Gui, Add, ComboBox, x352 y29 w180 h20 r10 vr_fn1_r, |.jpg|.png|.bmp
;Button
Gui, Add, button, x542 y9 w60 h40 gr_Edit, Edit
Gui, Add, button, x602 y9 w60 h40 gr_Add, Add
Gui, Add, button, x662 y9 w60 h40 gr_Del, Delete
;ListView
Gui, Add, ListView, x300 y53 w360 r10 gr_ListView,Match|Replace
;Combo Ext
Gui, Add, Text, x10 y63 w70 h20 +right, Ext : 
Gui, Add, ComboBox, x82 y59 w180 h20 r10 vUI_Ext, jpg:png:bmp||txt|*.*|
;Generate Number
Gui, Add, GroupBox, x5 y88 w288 h80 +c123456, Generate Number
Gui, Add, Text, x10 y113 w70 h20 +right, Start :Num:
Gui, Add, Edit, x82 y109 w180 h20 +Number,
Gui, Add, UpDown, vr_Start_Num range0-999999, 1
Gui, Add, Text, x10 y133 w70 h20 +right, Digit :Num:
Gui, Add, DropDownList, x82 y129 w180 h20 r10 vr_Digit_Num, 0|00|000|0000|00000|000000||0000000|00000000|000000000|
/*
Gui, Add, Text, x10 y133 w70 h20 +right, End :Num:
Gui, Add, ComboBox, x82 y129 w180 h20 r10 vr_End_Num, 
;Rp1
Gui, Add, Text, x10 y63 w70 h20 +right, Match 1 :
Gui, Add, Edit, x82 y59 w180 h20 vr_fn1_m, 
Gui, Add, Text, x10 y83 w70 h20 +right, Replace 1 :
Gui, Add, Edit, x82 y79 w180 h20 vr_fn1_r, 
;Replace2
Gui, Add, Text, x10 y123 w70 h20 +right, Match 2 :
Gui, Add, Edit, x82 y119 w180 h20 vr_fn2_m, 
Gui, Add, Text, x10 y143 w70 h20 +right, Replace 2 :
Gui, Add, Edit, x82 y139 w180 h20 vr_fn2_r, 
;Replace3
Gui, Add, Text, x10 y183 w70 h20 +right, Match 3 :
Gui, Add, Edit, x82 y179 w180 h20 vr_fn3_m, 
Gui, Add, Text, x10 y203 w70 h20 +right, Replace 3 :
Gui, Add, Edit, x82 y199 w180 h20 vr_fn3_r, 
*/
;Start
Gui, Add, Button, x10 y200 w65 h20 gSave, Save
Gui, Add, Button, x83 y200 w65 h20 gLoad, Load
Gui, Add, Button, x156 y200 w65 h20 gHelp, Help!
;
Gui, Add, Button, x10 y225 w65 h20 gTest, Test
Gui, Add, Button, x83 y225 w65 h20 gStart, Start
Gui, Add, Button, x156 y225 w65 h20 gRestart, Restart
Gui, Add, CheckBox, x230 y225 w65 h20 vDebug, Debug

Gui, Show,,% "Rename Files Tool By HentaiRyuu & Pondpop - Build " version
Gosub,Load
Return

;---------------------------------------------------
;Help

Help:
MsgBox, 0x0, Help,
(Join
---- Replace Syntax ----`n`n
Match :`n
   @num = \d+ //Find Number `n`n
   
Replace :`n
   @num = 000001 //Replace "@num" by generated number like 0001`n`n


)
Return

;---------------------------------------------------
;Replace

r_ListView:
	LastEventInfo := LV_GetNext(0, "F")
	LV_GetText(I_Edit, LastEventInfo, 1)
	LV_GetText(I_Add, LastEventInfo, 2)
	Guicontrol,,r_fn1_m,%I_Edit%
	Guicontrol,,r_fn1_r,%I_Add%
Return

r_Edit:
Gosub, GetUpdate
	LastEventInfo := LV_GetNext(0, "F")
	LV_Modify(LastEventInfo,"",r_fn1_m,r_fn1_r)
	LV_ModifyCol()
Return

r_Add:
Gosub, GetUpdate
	LV_Add("", r_fn1_m, r_fn1_r)
	LV_ModifyCol()
Return

r_Del:
Gosub, GetUpdate
	LastEventInfo := LV_GetNext(0, "F")
	LV_Delete(LastEventInfo)
	LV_ModifyCol()
Return

;---------------------------------------------------

GetUpdate:
	Gui, Submit, NoHide
	LV_ModifyCol()
    Total_LV := LV_GetCount()
Return

;---------------------------------------------------

Test:
Test = 1
Gosub, Start
Return

;---------------------------------------------------

Start:
Gosub, GetUpdate

UI_Ext := RegExReplace(UI_Ext,":","|")
r_Ext := "(" UI_Ext ")"

if(Test)
{
Msgbox, In    : %Path_in%`rOut : %Path_out%`r`rMatch    1 : %r_fn1_m% `rReplace 1 : %r_fn1_r%`rMatch    2 : %r_fn2_m% `rReplace 2 : %r_fn2_r%`rMatch    3 : %r_fn3_m% `rReplace 3 : %r_fn3_r%
/*
if (Debug)
Msgbox, Debug On!
else
Msgbox, Debug Off!
*/
}

if(Path_out="")
{
	Msgbox,0x2003, Warning, Output Path is Empty`rDo you want to Set Output Path to Input Path `nPress No, If you Don't want output file

	IfMsgBox Yes
	{
		If (Debug)
		{
			Msgbox, %Path_in%
		}
		GuiControl,,Path_out,%Path_in%
	}
	else IfMsgBox No
	{
	}
	else
	Return
}
IfNotExist, %Path_out%
{
	FileCreateDir, %Path_out%
}
Gui, 2:Add, Progress, y9 x7 w640 r6 +c777777, 100
Gui, 2:Add, Text, y12 x10 w640 r6 vcurrent_fn +BackgroundTrans +ceeeeee, File Name : ...
Gui, 2:Add, Progress, y92 x7 w640 r1 border +c00dd00 vtest_progress, 0
Gui, 2:Add, Text, y92 x7 w640 +BackgroundTrans center r1 vtest_per,% 0.00 " %"
Gui, 2:Color, bbbbbb
Gui, 2:Show, w654,Renaming..
;Gui, 1:Show,Hide

found:=0
i:=1
file_list := ""
Loop, Files, %Path_in%\*.* , F
{
	if RegExMatch(A_LoopFileExt, r_Ext)
	{
		file_list .= A_LoopFileFullPath ","
		found++
	}
}
StringTrimRight,file_list,file_list,1
If(found = 0)
{
	Msgbox,
}

StartTime := A_TickCount
Loop, Parse, file_list , "`,"
{
	SplitPath, A_LoopField, name, dir, ext, name_no_ext, drive
	L_Fn := name_no_ext
	
	e_time := (A_TickCount-StartTime)
	If(e_time>50)
	{
		StartTime := A_TickCount
		GuiControl,, current_fn,% "File Name : " L_Fn
		progress_percent := (A_Index/f_count)*100
		progress_percent2 := Round(progress_percent,2)
		GuiControl,, test_progress, %progress_percent%
		GuiControl,, test_per, %progress_percent2% `%
	}
		
	;Start Replace
	i:=0
	while(i<total_lv)
	{
		i++
		LV_GetText(r_fn1_m, i , 1)
		LV_GetText(r_fn1_r, i , 2)
			
		if RegExMatch(r_fn1_m, "@num")
		{
			r_fn1_m := RegExReplace(r_fn1_m, "@num", "\d+")
		}
			
		;Msgbox, Match    : %r_fn1_m% `rReplace : %r_fn1_r%`rI : %i%
		L_Fn := RegExReplace(L_Fn, r_fn1_m, r_fn1_r)
			
	}
		
	;Replace By Number00001 Digit
	Num := r_Start_Num
	new_name := (SubStr(r_Digit_Num, 1, StrLen(r_Digit_Num) - StrLen(Num)) . Num)
	L_Fn := RegExReplace(L_Fn, "@num", new_name)
	r_Start_Num++
		
	;Recieve Result Filename
	r_out := "" L_Fn ""
		
	If (Debug)
	{
		Msgbox, In    : %Path_in%`rOut : %Path_out%`r`rMatch    1 : %r_fn1_m% `rReplace 1 : %r_fn1_r%
		Msgbox, In Dir : `r%Path_in%`rIn Filename : %name%`r`rOut Dir : %Path_out%`rOut Filename : %r_out%.%ext%
	}
		
	;Change Filename
	FileMove,  %A_LoopField%, %Path_out%\%r_out%.%ext%

	;%A_LoopFileExt%
	If (Test)
	{
		Test = 0
		Msgbox, In Dir : `r%Path_in%`rIn Filename : %name%`r`rOut Dir : %Path_out%`rOut Filename : %r_out%.%ext%
		break
	}
}
GuiControl,, test_progress, 100
GuiControl,, test_per, 100.00 `%

MsgBox,0x2000, Media Convert,Finished!
Gui, 2:Destroy
Gui, 1:Show
Return

;---------------------------------------------------

Save:
i:=0
L_LV1:=""
L_LV2:=""
L_LVm := ""
L_LVr := ""
Gosub, GetUpdate
while(i<total_lv)
{
	i++
	LV_GetText(r_fn1_m, i , 1)
	LV_GetText(r_fn1_r, i , 2)
	L_LVm .= r_fn1_m ":"
	L_LVr .= r_fn1_r ":"
}
IniWrite, %Path_in%, %A_WorkingDir%\setting.ini, main, Path_in
IniWrite, %Path_out%, %A_WorkingDir%\setting.ini, main, Path_out
IniWrite, %L_LVm%, %A_WorkingDir%\setting.ini, main, L_LVm
IniWrite, %L_LVr%, %A_WorkingDir%\setting.ini, main, L_LVr
Return

Load:
Gosub,GetUpdate
IniRead, Path_in, %A_WorkingDir%\setting.ini, main, Path_in, %A_Space%
IniRead, Path_out, %A_WorkingDir%\setting.ini, main, Path_out,  %A_Space%
IniRead, L_LVm, %A_WorkingDir%\setting.ini, main, L_LVm
IniRead, L_LVr, %A_WorkingDir%\setting.ini, main, L_LVr

GuiControl,,Path_in,%Path_in%
GuiControl,,Path_out,%Path_out%

i:=0
while(i<total_lv)
{
	i++
	LV_Delete(1)
}

j:=0
Loop, Parse, L_LVm , ":", ":"
{
	j := A_Index
}

StringSplit, L_LVm, L_LVm, ":", ":"
StringSplit, L_LVr, L_LVr, ":", ":"
i:=0
while(i<j)
{
	i++
	LV_Add("", L_LVm%i%, L_LVr%i%)
}
Gosub, GetUpdate
Return

;---------------------------------------------------

in_folder:
{
	Thread, NoTimers
	FileSelectFolder, Path_in,, 3
	Thread, NoTimers, false
	if(Path_in="")
		GuiControl,,Path_in,%Path_in%
}
Return

out_folder:
{
	Thread, NoTimers
	FileSelectFolder, Path_out,, 3
	Thread, NoTimers, false
	if(Path_out="")
		GuiControl,,Path_out,%Path_out%
}
Return

GuiDropFiles:
{
	StringSplit, drop_filepath, A_GuiEvent, `n
	SplitPath, drop_filepath1,, dir, ext
	if(ext="")
	{
		drop_folderpath := drop_filepath1
	}
	else
	{
		drop_folderpath := dir
	}
	drop_focus = %A_GuiControl%
	
	if(drop_focus = "Path_in")
		dd_path("d")
	else if(drop_focus = "Path_out")
		dd_path("d")
}
Return

dd_path(type)
{
	global drop_focus
	global drop_filepath1
	global drop_folderpath
	if(type = "f")
	{
		GuiControl,,%drop_focus%,%drop_filepath1%
	}
	else
	{
		GuiControl,,%drop_focus%,%drop_folderpath%
	}
}

;---------------------------------------------------

Restart:
Reload
Return

GuiClose:
ExitApp
Return