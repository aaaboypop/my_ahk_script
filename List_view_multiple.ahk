Gui, Add, ListView, w600 h300 vLV_1 gListView_1, C1|C2
Gui, Add, ListView, w600 h300 vLV_2 gListView_2, C1|C2
Gui, Show
Return



ListView_1:
	Gui, ListView, LV_1
    LV_Add("", "1","2")
	;LastEventInfo := LV_GetNext(0, "F")
	;LV_GetText(I_Edit, LastEventInfo, 1)
	;Guicontrol,,Edit_1,%I_Edit%
Return


ListView_2:
	Gui, ListView, LV_2
    LV_Add("", "1","2")
	;LastEventInfo := LV_GetNext(0, "F")
	;LV_GetText(I_Edit, LastEventInfo, 1)
	;Guicontrol,,Edit_1,%I_Edit%
Return