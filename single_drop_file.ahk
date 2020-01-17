Gui, Font, s10, Courier New
Gui, Add, Edit, w400 r2 vMyEdit1 cD21212, < Drop Your File Here >
Gui, Add, Edit, w400 r2 vMyEdit2 c129012, < Drop Your File Here >
Gui, Add, Edit, w400 r2 vMyEdit3 c1212D2, < Drop Your File Here >
Gui, Show
Return

GuiDropFiles:
    StringSplit, F, A_GuiEvent, `n
    Drop_File_Path := F1 ;<<< Get Drop File Path Here !!
    GuiControl,, %A_GuiControl%, %Drop_File_Path%
Return

GuiClose:
GuiEscape:
    ExitApp