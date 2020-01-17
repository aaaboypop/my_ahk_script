Gui, Font, s10, Courier New
Gui, Add, Edit, w640 r33 vMyEdit c1212F2, < Drop Your Text Files Here >
Gui, Show
Return

GuiDropFiles:
 StringSplit, F, A_GuiEvent, `n
 FileRead, Text, %F1%
 GuiControl,, MyEdit, %Text%
 msgbox,% F1
Return

GuiClose:
GuiEscape:
 ExitApp