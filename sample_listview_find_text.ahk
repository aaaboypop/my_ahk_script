Gui, Add, ListView, w600 h300 vLV_1 hide, C1|C2
Gui, Add, Edit, w600 vs_box gfind,
Gui, Add, Button, w60 gDEL_List,Del
Gui, Add, ListView, w600 h300 vLV_2 , ID|Action|Detail
LV_ModifyCol(1,0)

Gui, ListView, LV_1

;sample data
LV_Add("", "Run","TTS.ahk")
LV_Add("", "Run","low_priority.ahk")
LV_Add("", "Run","clip.ahk")
LV_Add("", "CMD","Rename.ahk clip")
LV_Add("", "CMD","ssl_install.ahk auto")
LV_Add("", "CMD","screen_snap.ahk 0 640 480")

Gosub, find

Gui, Show
Return



DEL_List:
Gui, ListView, LV_2
RowNumber := LV_GetNext("F")
LV_GetText(id,RowNumber,1)
Gui, ListView, LV_1
LV_Delete(id)
Gosub, find
Return

find:
Gui, Submit , NoHide
Gui, ListView, LV_2
LV_Delete()
Gui, ListView, LV_1
t := LV_GetCount()
i := 1
While (i<=t)
{
	Gui, ListView, LV_1
	LV_GetText(c1,i,1)
	LV_GetText(c2,i,2)
	If(RegExMatch(c2, "i)" . s_box))
	{
		Gui, ListView, LV_2
		LV_Add("",i,c1,c2)
	}
	i++
}
Return

GuiClose:
GuiEscape:
    ExitApp