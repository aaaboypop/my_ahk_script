text_save := ""
skip_line := 0
selection := ""
selection_id := 0

clip := Clipboard

Loop, parse, clip, `n, `r
{
    ;---- Selection Detection ----
    If (RegExMatch(A_LoopField, "<!DOCTYPE html>"))
    {
        selection := "head"
    }
    If (RegExMatch(A_LoopField, "Sample<\/h3>"))
    {
        selection := "sample_start"
    }
    
    If (selection_id = 2)
    {
        If (RegExMatch(A_LoopField, "<\/p>"))
        {
            selection := "sample_end"
        }
    }

    If (RegExMatch(A_LoopField, "<\/body>"))
    {
        break
    }

    ;------- Selection Rule --------
    If (selection = "head")
    {
        skip := 28
        text_save .= "<head>`n"
        text_save .= "<meta http-equiv='X-UA-Compatible' content='IE=edge'></meta>`n"
        text_save .= "<meta http-equiv='content-type' content='text/html; charset=utf-8'>`n"
        text_save .= "<style type='text/css'>`n"
        selection := ""
        selection_id := 1
    }

    If (selection = "sample_start")
    {
        text_save .= A_LoopField "`n"
        text_save .= "<button class='tspoiler' onclick='tspoiler();'>Show/Hide</button>`n"
        text_save .= "<div id='spoiler' style='display: none;'>`n"
        selection := ""
        selection_id := 2
        Continue
    }

    If (selection = "sample_end")
    {
        text_save .= A_LoopField "`n"
        text_save .= "</div>`n"
        selection := ""
        selection_id := 3
        Continue
    }
    
    ;--------------------------------

    If (A_Index < skip)
    {
        Continue
    }

    ;--------------------------------
    
    text_save .= A_LoopField "`n"

}
Clipboard := text_save
FileDelete, %A_WorkingDir%\info.html
FileAppend, %text_save%, %A_WorkingDir%\info.html

Gui, Add, Edit, w800 r40,% text_save
Gui, Show
MsgBox, 0x0, , Finished, 0.2
ExitApp
return

GuiClose:
ExitApp