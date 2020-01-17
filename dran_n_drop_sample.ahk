Gui, Font, s10, Courier New
Gui, Add, Edit, w640 r33 vMyEdit c1212F2, < Drop Your Text Files Here >
Gui, Show
Return

GuiDropFiles:
    Drop_Element := A_GuiControl
    Drop_File_Path := A_GuiEvent
    StringSplit, F, A_GuiEvent, `n ;Split to Presudo Array > F1, F2, F3
    ;Msgbox, F = %F1% , Event = %A_GuiControl%
    GuiControl,, MyEdit, %F1%
Return

GuiClose:
GuiEscape:
    ExitApp