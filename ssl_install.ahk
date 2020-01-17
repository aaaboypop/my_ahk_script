Gui, Add, Text, x12 y9 w80 h20 , Input Path : 
Gui, Add, Edit, x102 y9 w180 h20 Readonly vin_path ggui_update, 



Gui, Add, Text, x12 y39 w80 h20 , Install Path :
Gui, Add, Edit, x102 y39 w180 h20 Readonly vinstall_path ggui_update, C:\xampp

Placeholder(hin_path, "Drop *.zip in Here")
Gui, Add, Button, x12 y69 w120 h60 vstart_bt gstart_install, Start

GuiControl, focus, start_bt

Gui, Show, x345 y137 h160 w300, SSL Install

gui_update:
{
	Gui, Submit, NoHide
}
return



GuiDropFiles:
{
	StringSplit, drop_filepath, A_GuiEvent, `n
	SplitPath, drop_filepath1,, dir, ext
	
	if(ext="")
	{
		drop_folderpath := drop_filepath1
	}
	else
	{
		drop_folderpath := dir
	}
	drop_focus = %A_GuiControl%
	
	if(drop_focus = "in_path")
	{
		dd_path("f")
	}
	if(drop_focus = "install_path")
	{
		dd_path("d")
	}
	
}
Return

dd_path(var1)
{
	global drop_focus
	global drop_filepath1
	global drop_folderpath
	if(var1 = "f")
	{
		GuiControl,,%drop_focus%,%drop_filepath1%
	}
	else
	{
		GuiControl,,%drop_focus%,%drop_folderpath%
	}
}




guiclose:
exit:
{
	exitapp
}
return



start_install:
{
	if (SubStr(install_path,-1)="\")
	{
		StringTrimRight, install_path, install_path, 1
	}
	FileCreateDir, %A_WorkingDir%\temp
	outpath := A_WorkingDir "\temp"
	SmartZip(in_path, outpath)  
	FileDelete, %install_path%\apache\conf\ssl\ca_bundle.crt
	FileDelete, %install_path%\apache\conf\ssl.crt\server.crt
	FileDelete, %install_path%\apache\conf\ssl.key\server.key
	
	FileMove, %outpath%\ca_bundle.crt, %install_path%\apache\conf\ssl\ca_bundle.crt
	FileMove, %outpath%\certificate.crt, %install_path%\apache\conf\ssl.crt\server.crt
	FileMove, %outpath%\private.key, %install_path%\apache\conf\ssl.key\server.key
}
Return





SmartZip(s, o, t = 4)
{
	IfNotExist, %s%
		return, -1        ; The souce is not exist. There may be misspelling.
	
	oShell := ComObjCreate("Shell.Application")
	
	if (SubStr(o, -3) = ".zip")	; Zip
	{
		IfNotExist, %o%        ; Create the object ZIP file if it's not exist.
			CreateZip(o)
		
		Loop, %o%, 1
			sObjectLongName := A_LoopFileLongPath

		oObject := oShell.NameSpace(sObjectLongName)
		
		Loop, %s%, 1
		{
			if (sObjectLongName = A_LoopFileLongPath)
			{
				continue
			}
			ToolTip, Zipping %A_LoopFileName% ..
			oObject.CopyHere(A_LoopFileLongPath, t)
			SplitPath, A_LoopFileLongPath, OutFileName
			Loop
			{
				oObject := "", oObject := oShell.NameSpace(sObjectLongName)	; This doesn't affect the copyhere above.
				if oObject.ParseName(OutFileName)
					break
			}
		}
		ToolTip
	}
	else if InStr(FileExist(o), "D") or (!FileExist(o) and (SubStr(s, -3) = ".zip"))	; Unzip
	{
		if !o
			o := A_ScriptDir        ; Use the working dir instead if the object is null.
		else IfNotExist, %o%
			FileCreateDir, %o%
		
		Loop, %o%, 1
			sObjectLongName := A_LoopFileLongPath
		
		oObject := oShell.NameSpace(sObjectLongName)
		
		Loop, %s%, 1
		{
			oSource := oShell.NameSpace(A_LoopFileLongPath)
			oObject.CopyHere(oSource.Items, 0x14)
		}
	}
}

CreateZip(n)	; Create empty Zip file
{
	ZIPHeader1 := "PK" . Chr(5) . Chr(6)
	VarSetCapacity(ZIPHeader2, 18, 0)
	ZIPFile := FileOpen(n, "w")
	ZIPFile.Write(ZIPHeader1)
	ZIPFile.RawWrite(ZIPHeader2, 18)
	ZIPFile.close()
}
;; ---------    FUNCTION END   ------------------------------------

; Placeholder() - by infogulch for AutoHotkey v1.1.05+
; 
; to set up your edit control with a placeholder, call: 
;   Placeholder(hwnd_of_edit_control, "your placeholder text")
; 
; If called with only the hwnd, the function returns True if a 
;   placeholder is being shown, and False if not.
;   isPlc := Placeholder(hwnd_edit)
; 
; to remove the placeholder call with a blank text param
;   Placeholder(hwnd_edit, "")
; 
; http://www.autohotkey.com/forum/viewtopic.php?p=482903#482903
; 

Placeholder(wParam, lParam = "`r", msg = "") {
    static init := OnMessage(0x111, "Placeholder"), list := []
    
    if (msg != 0x111) {
        if (lParam == "`r")
            return list[wParam].shown
        list[wParam] := { placeholder: lParam, shown: false }
        if (lParam == "")
            return "", list.remove(wParam, "")
        lParam := wParam
        wParam := 0x200 << 16
    }
    if (wParam >> 16 == 0x200) && list.HasKey(lParam) && !list[lParam].shown ;EN_KILLFOCUS  :=  0x200 
    {
        GuiControlGet, text, , %lParam%
        if (text == "")
        {
            Gui, Font, Ca0a0a0
            GuiControl, Font, %lParam%
            GuiControl,     , %lParam%, % list[lParam].placeholder
            list[lParam].shown := true
        }
    }
    else if (wParam >> 16 == 0x100) && list.HasKey(lParam) && list[lParam].shown ;EN_SETFOCUS := 0x100 
    {
        Gui, Font, cBlack
        GuiControl, Font, %lParam%
        GuiControl,     , %lParam%
        list[lParam].shown := false
    }
}