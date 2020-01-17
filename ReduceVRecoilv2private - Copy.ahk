;----------# System Vars #----------------------

#singleInstance, force
#IfWinActive ahk_group AExE
#NoEnv
#MaxHotkeysPerInterval 999999
#HotkeyInterval 999999
#KeyHistory 0
;ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1

;----------# Vars #-----------------------------



;----------# Tray Control #---------------------

Menu, Tray, NoStandard
Menu, Tray, Add, Clip Name_Space, ClipName
Menu, Tray, Add, Clip MarkDown_Info, MD_Info
Menu, Tray, Add, Clip HTML_Spoiler, ClipHTML
Menu, Tray, Add
Menu, Tray, Add, Restart, Restart
Menu, Tray, Add
Menu, Tray, Add, Exit, GuiClose
Menu, Tray, Tip, N4A Script Player

OnExit, GuiClose

return ; Prevent CODE below run

F13::
return

Restart:
Reload
return

GuiClose:
ExitApp
return

Dummy:
return

ClipName:
aaa := clipboard
Clipboard := StrReplace(aaa, " ", "_")
Return


ClipHTML:
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

MsgBox, 0x0, , Finished, 0.2
Return


MD_Info:
text1 := "|General                        |                      |`r"
text1 .= "| ----------------------------- | -------------------------- |`r"
aaa := clipboard
Loop, parse, aaa, `n
{
	st := 1
	aaa2 := A_LoopField
	aaa1("File size")
	aaa1("Duration")
	aaa1("Overall bit rate")
	aaa1("Format")
	aaa1("Bit rate")
	aaa1("Width")
	aaa1("Height")
	aaa1("Display aspect ratio")
	aaa1("Frame rate mode")
	aaa1("Frame rate  ")
	aaa1("Chroma subsampling ")
	aaa1("Bit depth")
	aaa1("Scan type")
	aaa1("Codec configuration box")
	aaa1("Sampling rate")
	aaa1("Compression mode")
}
clipboard := text1
Return

aaa1(var1){
global text1
global aaa2
global st
	if(st=0)
	{
		Return
	}
	
	IfInString, aaa2, %var1%
	{
		aaa2 := StrReplace(aaa2, " : ", " | ")
		StringTrimRight, aaa2, aaa2, 1
		text1 .= "|" aaa2 "|`r"
		st := 0
		asd := "Overall bit rate  "
		asd1 := "Codec configuration box"
		IfInString, aaa2, %asd%
		{
			text1 .= "|**Video**                      |                            |`r"
		}
		else IfInString, aaa2, %asd1%
		{
			text1 .= "|**Audio**                      |                            |`r"
		}
	}
}
Return
