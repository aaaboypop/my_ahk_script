Gui, Add, Edit, x22 y29 w1250 h50 vEdit_1 gGetUpdate, 
Gui, Add, Button, x22 y89 w100 h30 gAdd_1, ADD
Gui, Add, Button, x132 y89 w100 h30 gEdit_1, EDIT
Gui, Add, Button, x242 y89 w100 h30 gDel_1, DELETE
Gui, Add, GroupBox, x12 y9 w1270 h300, GroupBox
Gui, Add, ListView, x22 y129 w1250 h170 vLV_1 gListView_1, Cookie
Gui, Add, Edit, x22 y339 w330 h20 vEdit_2 gGetUpdate, 
Gui, Add, Button, x22 y369 w100 h30 gAdd_2, ADD
Gui, Add, Button, x132 y369 w100 h30 gEdit_2, EDIT
Gui, Add, Button, x242 y369 w100 h30 gDel_2, DELETE
Gui, Add, ListView, x372 y339 w220 h380 vLV_2 gListView_2, Page ID
Gui, Add, Button, x972 y689 w100 h30 gSave, Save
Gui, Add, Button, x1082 y689 w100 h30 gLoad, Load
Gui, Add, Button, x1192 y689 w100 h30 gStart, Start
; Generated using SmartGUI Creator 4.0
Gui, Show, x458 y170 h734 w1307, New GUI Window
Return


;---------------------------------------------------
;LV1

ListView_1:
	Gui, ListView, LV_1
	LastEventInfo := LV_GetNext(0, "F")
	LV_GetText(I_Edit, LastEventInfo, 1)
	Guicontrol,,Edit_1,%I_Edit%
Return

Edit_1:
Gosub, GetUpdate1
	Gui, ListView, LV_1
	LastEventInfo := LV_GetNext(0, "F")
	LV_Modify(LastEventInfo,"",Edit_1)
	LV_ModifyCol()
Return

Add_1:
Gosub, GetUpdate1
	Gui, ListView, LV_1
	LV_Add("", Edit_1)
	LV_ModifyCol()
Return

Del_1:
Gosub, GetUpdate1
	Gui, ListView, LV_1
	LastEventInfo := LV_GetNext(0, "F")
	LV_Delete(LastEventInfo)
	LV_ModifyCol()
Return


;---------------------------------------------------
;LV2

ListView_2:
	Gui, ListView, LV_2
	LastEventInfo := LV_GetNext(0, "F")
	LV_GetText(I_Edit, LastEventInfo, 1)
	Guicontrol,,Edit_2,%I_Edit%
Return

Edit_2:
Gosub, GetUpdate2
	Gui, ListView, LV_2
	LastEventInfo := LV_GetNext(0, "F")
	LV_Modify(LastEventInfo,"",Edit_2)
	LV_ModifyCol()
Return

Add_2:
Gosub, GetUpdate2
	Gui, ListView, LV_2
	LV_Add("", Edit_2)
	LV_ModifyCol()
Return

Del_2:
Gosub, GetUpdate2
	Gui, ListView, LV_2
	LastEventInfo := LV_GetNext(0, "F")
	LV_Delete(LastEventInfo)
	LV_ModifyCol()
Return

;---------------------------------------------------

GetUpdate:
	Gui, Submit, NoHide
Return

GetUpdate1:
	Gui, Submit, NoHide
	Gui, ListView, LV_1
	Total_LV1 := LV_GetCount()
Return

GetUpdate2:
	Gui, Submit, NoHide
	Gui, ListView, LV_2
	Total_LV2 := LV_GetCount()
Return

;---------------------------------------------------


Start:
	Gosub, GetUpdate1
	Gosub, GetUpdate2
	
	i:=1 ;PID
	j:=1 ;Cookie
	while(i<=Total_LV2)
	{
		if(j>Total_LV1)
		{
			j:=1
		}
		
		Gui, ListView, LV_1 ;Cookie
		LV_GetText(S_Cookie, j ,1)
		
		
		Gui, ListView, LV_2 ;PID
		LV_GetText(S_id, i ,1)
		
		
		;msgbox, Cookie : %S_Cookie% `rPID : %S_id%
		
		
		get_url := "https://n4a.dynu.net/0.php?cookie="  S_Cookie "&pid=" S_id
		
		UrlDownloadToFile, %get_url%, %A_WorkingDir%\%S_id%.txt
		
		Tooltip,%A_WorkingDir%\%S_id%.txt
		i++
		j++
		
	}
Return

;---------------------------------------------------

Save:
i:=1
L_LVc:= ""	;Cookie
Gosub, GetUpdate1
Gui, ListView, LV_1
while(i<=total_lv1)
{
	LV_GetText(Edit_1, i ,1)
	L_LVc .= Edit_1 "\"
	i++
}




i:=1
L_LVp:= ""	;PID
Gosub, GetUpdate2
Gui, ListView, LV_2
while(i<=total_lv2)
{
	LV_GetText(Edit_2, i , 1)
	L_LVp .= Edit_2 "\"
	i++
}




IniWrite, %L_LVc%, %A_WorkingDir%\setting.ini, main, L_LVc
IniWrite, %L_LVp%, %A_WorkingDir%\setting.ini, main, L_LVp
Return

;---------------------------------------------------


Load:
Gosub,GetUpdate1
Gosub,GetUpdate2
IniRead, L_LVc, %A_WorkingDir%\setting.ini, main, L_LVc
IniRead, L_LVp, %A_WorkingDir%\setting.ini, main, L_LVp


;DELETE ALL ROW
i:=0
Gui, ListView, LV_1
while(i<total_lv1)
{
	i++
	LV_Delete(1)
}

;Word Count
j:=0
Loop, Parse, L_LVc , "\", "\"
{
	j := A_Index
}

j--

StringSplit, L_LVc, L_LVc, "\", "\"
i:=0
while(i<j)
{
	i++
	LV_Add("", L_LVc%i%)
}





;DELETE ALL ROW
i:=0
Gui, ListView, LV_2
while(i<total_lv2)
{
	i++
	LV_Delete(1)
}



j:=0
Loop, Parse, L_LVc , "\", "\"
{
	j := A_Index
}

j--

StringSplit, L_LVp, L_LVp, "\", "\"
i:=0
while(i<j)
{
	i++
	LV_Add("", L_LVp%i%)
}
Gosub, GetUpdate
Return

;---------------------------------------------------

GuiClose:
ExitApp