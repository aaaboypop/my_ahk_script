Gui, Font, s10, Courier New
Gui, Add, Edit, w640 r33 vMyEdit c1212F2, < Drop Your Text Files Here >
Gui, Show

Return

GuiDropFiles:
 StringSplit, drop_filepath, A_GuiEvent, `n
 
 SplitPath, drop_filepath1,, dir, ext
 
 if(ext="")
 {
	fullpath := drop_filepath1
	msgbox, it's a folder
 }
 else
 {
	fullpath := dir
	msgbox, it's a file
 }
 
 
 
; msgbox,% A_GuiControl
; msgbox,% A_EventInfo
; msgbox,% A_GuiX "/" A_GuiY
 
 
 /*
 Loop, Parse, A_GuiEvent, `n
 {
	msgbox,% A_LoopField
 }
 */
Return

GuiClose:
GuiEscape:
 ExitApp