Gui, Add, ListView, x22 y212 w1330 h400 glist_view, Filter|Data
Gui, Add, DropDownList, x2 y2 vtype ggui_update, AA|Resize||
Gui, Add, Edit, x22 y39 w100 h20 vtext1 ggui_update,aaa
Gui, Add, Edit, x22 y59 w100 h20 vtext2 ggui_update,text2

Gui, Add, Edit, x22 y39 w100 h20 vtext3 ggui_update,bbb
Gui, Add, Edit, x22 y59 w100 h20 vtext4 ggui_update,text4

GuiControl,Hide,text1
GuiControl,Hide,text2
GuiControl,Hide,text3
GuiControl,Hide,text4

Gui, Add, button, w80 h20 glist_add, Add
Gui, Show, x413 y187 h560 w900, N4A-V2
return

gui_update:
	Gui, Submit, NoHide
	
	
	If(type="AA")
	{
		GuiControl,Show,text1
		GuiControl,Show,text2
		GuiControl,Hide,text3
		GuiControl,Hide,text4
	}
	else If(type="Resize")
	{
		GuiControl,Hide,text1
		GuiControl,Hide,text2
		GuiControl,Show,text3
		GuiControl,Show,text4
	}
		
return

list_view:
	LastEventInfo := LV_GetNext(0, "F")
	LV_GetText(var1, LastEventInfo, 3)
return

list_add:
	if(type="AA")
		LV_Add("", text1, text2)
	else if (type="Resize")
		LV_Add("", text3, text4)
return

GuiClose:
GuiEscape:
ExitApp