;----------# System Vars #----------------------

#singleInstance, force
#NoEnv
#MaxHotkeysPerInterval 999999
#HotkeyInterval 999999
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1

;----------# Vars #-----------------------------

Hotkey := 1 ; Set to 0 to turn off
save_location := A_WorkingDir . "\SS\"

;----------# Tray Control #---------------------

Menu, Tray, NoStandard
Menu, Tray, Add, Open GUI, OpenGui
Menu, Tray, Default, Open GUI
Menu, Tray, Add, Hide GUI, HideGui
Menu, Tray, Add
Menu, Tray, Add, Save, Save
Menu, Tray, Add, Load, Load
Menu, Tray, Add
;Menu, Tray, Add, Suspend, Suspend
Menu, Tray, Add, Restart, Restart
Menu, Tray, Add, Exit, GuiClose
Menu, Tray, Tip, Screen Capture by HentaiRyuu & pondpop

;----------# Build UI #-------------------------

Gui,-Resize +ToolWindow
;Gui, Show, Hide, Screen Capture by HentaiRyuu pondpop
Gui, Add, GroupBox, x10 y6 w126 h115, Options:
Gui, Add, Text, x20 y26 cBlue, Start X Y:
Gui, Add, Edit, x20 y46 w50 vMx1, 0
Gui, Add, Edit, x75 y46 w50 vMy1, 0
Gui, Add, Text, x20 y71 cBlue, End X Y:
Gui, Add, Edit, x20 y91 w50 vMx2, 0
Gui, Add, Edit, x75 y91 w50 vMy2, 0

Gui, Add, GroupBox, x10 y126 w126 h124, Controls:
Gui, Add, Button, x16 y140 h20 w112 gEHotkey, Enable Hotkey
;
;Gui, Add, Button, x16 y161 h20 w56 g, Button1
;Gui, Add, Button, x72 y161 h20 w56 g, Button2
;
Gui, Add, Button, x16 y182 h20 w56 gSave, Save
Gui, Add, Button, x72 y182 h20 w56 gLoad, Load
;
Gui, Add, Button, x16 y203 h20 w112 gRestart, Restart
;
Gui, Add, Button, x16 y224 h20 w56 gHideGui, Hide
Gui, Add, Button, x72 y224 h20 w56 gGuiClose, Exit

;Button
Gui, Add, button, x142 y9 w65 h40 gr_Edit, Edit
Gui, Add, button, x210 y9 w65 h40 gr_Add, Add
Gui, Add, button, x278 y9 w65 h40 gr_Del, Delete
;ListView
Gui, Add, ListView, x143 y50 w199 r10 gr_ListView,X1|Y1|X2|Y2

Gui, Show

;----------# Init #-----------------------------
;Load Setting
if FileExist( A_WorkingDir "\Settings\screen_cap.ini")
{
	Gosub,Load
}
OnExit, GuiClose

return ; Prevent CODE below run

;---------------------------------------------------
; ListView Control

r_ListView:
	LastEventInfo := LV_GetNext(0, "F")
	LV_GetText(out_var1, LastEventInfo, 1)
	LV_GetText(out_var2, LastEventInfo, 2)
	LV_GetText(out_var3, LastEventInfo, 3)
	LV_GetText(out_var4, LastEventInfo, 4)
	Guicontrol,,Mx1,%out_var1%
	Guicontrol,,My1,%out_var2%
	Guicontrol,,Mx2,%out_var3%
	Guicontrol,,My2,%out_var4%
Return

r_Edit:
Gosub, gui_update
	LastEventInfo := LV_GetNext(0, "F")
	LV_Modify(LastEventInfo,"",Mx1,My1,Mx2,My2)
	LV_ModifyCol()
Return

r_Add:
Gosub, gui_update
	LV_Add("",Mx1,My1,Mx2,My2)
	LV_ModifyCol()
Return

r_Del:
Gosub, gui_update
	LastEventInfo := LV_GetNext(0, "F")
	LV_Delete(LastEventInfo)
	LV_ModifyCol()
Return

;---------------------------------------------------
; Set Capture Position [By Mouse Position]
;Start Position
F1::
If (Hotkey = 1)
{
	WinGetActiveStats, WinTitle, WinWidth1, WinHeight1, Winx1, Winy1
	MouseGetPos, Mx1, My1
	GuiControl,,Mx1,%Mx1%
	GuiControl,,My1,%My1%
}
Else
{
	Send, {F1}
}
return

;End Position
F2::
If (Hotkey = 1)
{
	WinGetActiveStats, WinTitle, WinWidth2, WinHeight2, Winx2, Winy2
	MouseGetPos, Mx2, My2
	GuiControl,,Mx2,%Mx2%
	GuiControl,,My2,%My2%
	gosub,r_Add
}
Else
{
	Send, {F2}
}
return

;---------------------------------------------------
; Main Function [Screen Capture]

F3::
If (Hotkey = 1)
{
	WinGetActiveStats, WinTitle, WinWidth, WinHeight, Winx, Winy
	Gosub, gui_update
	
	IfNotExist, %save_location%
	{
		FileCreateDir, %save_location%
	}
	
	i:=0
	r_Start_Num := 1
	StartTime := A_TickCount
	
	while(i<total_lv)
	{
		i++
		LV_GetText(Mx1, i , 1)
		LV_GetText(My1, i , 2)
		LV_GetText(Mx2, i , 3)
		LV_GetText(My2, i , 4)

		s_pos_x1 := Mx1 + Winx
		s_pos_y1 := My1 + Winy
		e_pos_x1 := Mx2 + Winx
		e_pos_y1 := My2 + Winy

		p2 := s_pos_x1 "," s_pos_y1 "," e_pos_x1 "," e_pos_y1
		
		s_pos_x1 += 24 
		s_pos_y1 += 24
		e_pos_x1 -= 24
		e_pos_y1 -= 24

		p := s_pos_x1 "," s_pos_y1 "," e_pos_x1 "," e_pos_y1

		scan_x1 := s_pos_x1 - Winx
		scan_y1 := s_pos_y1 - Winy
		scan_x2 := e_pos_x1 - Winx
		scan_y2 := e_pos_y1 - Winy
		
		;msgbox,% Mx1 " " My1 " " Mx2 " " My2
		match := 0
		Loop, Files, %save_location%*.*, F
		{
			CoordMode, Pixel, Window
			ImageSearch, FoundX, FoundY, %scan_x1%, %scan_y1%, %scan_x2%, %scan_y2%, *0 %A_LoopFileFullPath%
			If ErrorLevel = 0
			{
				match := 1
				Break
			}
		}
		If(match<>1)
		{
			;Replace By Number00001 Digit
			Num := r_Start_Num
			Num_gen := (SubStr(0000, 1, StrLen(0000) - StrLen(Num)) . Num)
			r_Start_Num++
			f1:= save_location . a_now "_" Num_gen . ".bmp"
			CaptureScreen(p,false,F1)
		}
			
	}

ElapsedTime := A_TickCount - StartTime
ToolTip, % ElapsedTime
Remove_Tooltip(2000)
;msgbox, % ElapsedTime
}
Else
{
	Send, {F5}
}
Return

;---------------------------------------------------
; Other Function

Remove_Tooltip(delay)
{
	Sleep, delay
	ToolTip,
}

EHotkey:
If (Hotkey = 1)
{
	Hotkey := 0
}
Else
{
	Hotkey := 1
}
Return

gui_update:
	Gui, Submit, NoHide
	LV_ModifyCol()
	Total_LV := LV_GetCount()
Return

g_destroy:
	Gui, 2:Submit, NoHide
	Gui, 2:Destroy
	Gui, 1:Default
	fn:= save_location . fn1 ".png"
	p := s_pos_x1 "," s_pos_y1 "," e_pos_x1 "," e_pos_y1
	msgbox, %fn1%`r%fn%`r%p%
	CaptureScreen(p,false,fn,100)
Return

;---------------------------------------------------
; Save & Load

Save:
i:=0
out1:=""
out2:=""
out3:=""
out4:=""
sum_mx1:=""
sum_my1:=""
sum_mx2:=""
sum_my2:=""
Gosub, gui_update
while(i<total_lv)
{
	i++
	LV_GetText(out1, i , 1)
	LV_GetText(out2, i , 2)
	LV_GetText(out3, i , 3)
	LV_GetText(out4, i , 4)
	sum_mx1 .= out1 ":"
	sum_my1 .= out2 ":"
	sum_mx2 .= out3 ":"
	sum_my2 .= out4 ":"
}
IfNotExist, %A_WorkingDir%\Settings
{
	FileCreateDir, %A_WorkingDir%\Settings
}
IniWrite, %sum_mx1%, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_mx1
IniWrite, %sum_my1%, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_my1
IniWrite, %sum_mx2%, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_mx2
IniWrite, %sum_my2%, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_my2
Return

Load:
Gosub, gui_update
IniRead, sum_mx1, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_mx1
IniRead, sum_my1, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_my1
IniRead, sum_mx2, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_mx2
IniRead, sum_my2, %A_WorkingDir%\Settings\screen_cap.ini, main, sum_my2

i:=0
while(i<total_lv)
{
	i++
	LV_Delete(1)
}

j:=0
Loop, Parse, sum_mx1, ":", ":"
{
	j := A_Index
}

StringSplit, sum_mx1, sum_mx1, ":", ":"
StringSplit, sum_my1, sum_my1, ":", ":"
StringSplit, sum_mx2, sum_mx2, ":", ":"
StringSplit, sum_my2, sum_my2, ":", ":"
i:=0
while(i<j)
{
	i++
	;LV_Add("", L_LVm%i%, L_LVr%i%)
	LV_Add("", sum_Mx1%i%, sum_My1%i%, sum_Mx2%i%, sum_My2%i%)
}
Gosub, gui_update
Return

;---------------------------------------------------
; UI Control

OpenGui:
Gui,Show
return

HideGui:
Gui,Show,Hide
return

;---------------------------------------------------
; System

Suspend:
Suspend
return

Restart:
Reload
return

GuiClose:
ExitApp
return

Dummy:
return

;---------------------------------------------------
; Capture Function

;f1:= save_location . a_now . ".png"
;CaptureScreen(0,,F1)
;CaptureScreen(1,F1)
;CaptureScreen(2)
;CaptureScreen(3)
;CaptureScreen("0, 0, 200, 200")
;CaptureScreen("100, 100, 200, 200, 400, 400")
;run,%f1%
return

/* CaptureScreen(aRect, bCursor, sFileTo, nQuality)
1) If the optional parameter bCursor is True, captures the cursor too.
2) If the optional parameter sFileTo is 0, set the image to Clipboard.
    If it is omitted or "", saves to screen.bmp in the script folder,
	otherwise to sFileTo which can be BMP/JPG/PNG/GIF/TIF.
3) The optional parameter nQuality is applicable only when sFileTo is JPG. Set it to the desired quality level of the resulting JPG, an integer between 0 - 100.
4) If aRect is 0/1/2/3, captures the entire 
	0:desktop/active
	1:window/active
	2:client
	3:area/active monitor.
5) aRect can be comma delimited sequence of coordinates, 
	e.g., "Left, Top, Right, Bottom" or 
		  "Left, Top, Right, Bottom, Width_Zoomed, Height_Zoomed".
	In this case, only that portion of the rectangle will be captured. Additionally, in the latter case, zoomed to the new width/height, Width_Zoomed/Height_Zoomed.

Example:
CaptureScreen(0)
CaptureScreen(1)
CaptureScreen(2)
CaptureScreen(3)
CaptureScreen("100, 100, 200, 200")
CaptureScreen("100, 100, 200, 200, 400, 400")	 ; Zoomed
*/

/* Convert(sFileFr, sFileTo, nQuality)
Convert("C:\image.bmp", "C:\image.jpg")
Convert("C:\image.bmp", "C:\image.jpg", 95)
Convert(0, "C:\clip.png")	 ; Save the bitmap in the clipboard to sFileTo if sFileFr is "" or 0.
*/


CaptureScreen(aRect = 0, bCursor = False, sFile = "", nQuality = "")
{
	If !aRect
	{
		SysGet, nL, 76	; virtual screen left & top
		SysGet, nT, 77
		SysGet, nW, 78	; virtual screen width and height
		SysGet, nH, 79
	}
	Else If aRect = 1
		WinGetPos, nL, nT, nW, nH, A
	Else If aRect = 2
	{
		WinGet, hWnd, ID, A
		VarSetCapacity(rt, 16, 0)
		DllCall("GetClientRect" , "ptr", hWnd, "ptr", &rt)
		DllCall("ClientToScreen", "ptr", hWnd, "ptr", &rt)
		nL := NumGet(rt, 0, "int")
		nT := NumGet(rt, 4, "int")
		nW := NumGet(rt, 8)
		nH := NumGet(rt,12)
	}
	Else If aRect = 3
	{
		VarSetCapacity(mi, 40, 0)
		DllCall("GetCursorPos", "int64P", pt), NumPut(40,mi,0,"uint")
		DllCall("GetMonitorInfo", "ptr", DllCall("MonitorFromPoint", "int64", pt, "Uint", 2, "ptr"), "ptr", &mi)
		nL := NumGet(mi, 4, "int")
		nT := NumGet(mi, 8, "int")
		nW := NumGet(mi,12, "int") - nL
		nH := NumGet(mi,16, "int") - nT
	}
	Else
	{
		StringSplit, rt, aRect, `,, %A_Space%%A_Tab%
		nL := rt1	; convert the Left,top, right, bottom into left, top, width, height
		nT := rt2
		nW := rt3 - rt1
		nH := rt4 - rt2
		znW := rt5
		znH := rt6
	}

	mDC := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	hBM := CreateDIBSection(mDC, nW, nH)
	oBM := DllCall("SelectObject", "ptr", mDC, "ptr", hBM, "ptr")
	hDC := DllCall("GetDC", "ptr", 0, "ptr")
	DllCall("BitBlt", "ptr", mDC, "int", 0, "int", 0, "int", nW, "int", nH, "ptr", hDC, "int", nL, "int", nT, "Uint", 0x40CC0020)
	DllCall("ReleaseDC", "ptr", 0, "ptr", hDC)
	If bCursor
		CaptureCursor(mDC, nL, nT)
	DllCall("SelectObject", "ptr", mDC, "ptr", oBM)
	DllCall("DeleteDC", "ptr", mDC)
	If znW && znH
		hBM := Zoomer(hBM, nW, nH, znW, znH)
	If sFile = 0
		SetClipboardData(hBM)
	Else Convert(hBM, sFile, nQuality), DllCall("DeleteObject", "ptr", hBM)
}

CaptureCursor(hDC, nL, nT)
{
	VarSetCapacity(mi, 32, 0), Numput(16+A_PtrSize, mi, 0, "uint")
	DllCall("GetCursorInfo", "ptr", &mi)
	bShow	 := NumGet(mi, 4, "uint")
	hCursor := NumGet(mi, 8)
	xCursor := NumGet(mi,8+A_PtrSize, "int")
	yCursor := NumGet(mi,12+A_PtrSize, "int")

	DllCall("GetIconInfo", "ptr", hCursor, "ptr", &mi)
	xHotspot := NumGet(mi, 4, "uint")
	yHotspot := NumGet(mi, 8, "uint")
	hBMMask	:= NumGet(mi,8+A_PtrSize)
	hBMColor := NumGet(mi,16+A_PtrSize)

	If bShow
		DllCall("DrawIcon", "ptr", hDC, "int", xCursor - xHotspot - nL, "int", yCursor - yHotspot - nT, "ptr", hCursor)
	If hBMMask
		DllCall("DeleteObject", "ptr", hBMMask)
	If hBMColor
		DllCall("DeleteObject", "ptr", hBMColor)
}

Zoomer(hBM, nW, nH, znW, znH)
{
	mDC1 := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	mDC2 := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	zhBM := CreateDIBSection(mDC2, znW, znH)
	oBM1 := DllCall("SelectObject", "ptr", mDC1, "ptr",	hBM, "ptr")
	oBM2 := DllCall("SelectObject", "ptr", mDC2, "ptr", zhBM, "ptr")
	DllCall("SetStretchBltMode", "ptr", mDC2, "int", 4)
	DllCall("StretchBlt", "ptr", mDC2, "int", 0, "int", 0, "int", znW, "int", znH, "ptr", mDC1, "int", 0, "int", 0, "int", nW, "int", nH, "Uint", 0x00CC0020)
	DllCall("SelectObject", "ptr", mDC1, "ptr", oBM1)
	DllCall("SelectObject", "ptr", mDC2, "ptr", oBM2)
	DllCall("DeleteDC", "ptr", mDC1)
	DllCall("DeleteDC", "ptr", mDC2)
	DllCall("DeleteObject", "ptr", hBM)
	Return zhBM
}

Convert(sFileFr = "", sFileTo = "", nQuality = "")
{
	If (sFileTo = "")
		sFileTo := A_ScriptDir . "\screen.bmp"
	SplitPath, sFileTo, , sDirTo, sExtTo, sNameTo
	
	If Not hGdiPlus := DllCall("LoadLibrary", "str", "gdiplus.dll", "ptr")
		Return	sFileFr+0 ? SaveHBITMAPToFile(sFileFr, sDirTo (sDirTo = "" ? "" : "\") sNameTo ".bmp") : ""
	VarSetCapacity(si, 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", "UintP", pToken, "ptr", &si, "ptr", 0)

	If !sFileFr
	{
		DllCall("OpenClipboard", "ptr", 0)
		If	(DllCall("IsClipboardFormatAvailable", "Uint", 2) && (hBM:=DllCall("GetClipboardData", "Uint", 2, "ptr")))
			DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hBM, "ptr", 0, "ptr*", pImage)
		DllCall("CloseClipboard")
	}
	Else If	sFileFr Is Integer
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", sFileFr, "ptr", 0, "ptr*", pImage)
	Else	DllCall("gdiplus\GdipLoadImageFromFile", "wstr", sFileFr, "ptr*", pImage)
	DllCall("gdiplus\GdipGetImageEncodersSize", "UintP", nCount, "UintP", nSize)
	VarSetCapacity(ci,nSize,0)
	DllCall("gdiplus\GdipGetImageEncoders", "Uint", nCount, "Uint", nSize, "ptr", &ci)
	struct_size := 48+7*A_PtrSize, offset := 32 + 3*A_PtrSize, pCodec := &ci - struct_size
	Loop, %	nCount
		If InStr(StrGet(Numget(offset + (pCodec+=struct_size)), "utf-16") , "." . sExtTo)
			break

	If (InStr(".JPG.JPEG.JPE.JFIF", "." . sExtTo) && nQuality<>"" && pImage && pCodec < &ci + nSize)
	{
		DllCall("gdiplus\GdipGetEncoderParameterListSize", "ptr", pImage, "ptr", pCodec, "UintP", nCount)
		VarSetCapacity(pi,nCount,0), struct_size := 24 + A_PtrSize
		DllCall("gdiplus\GdipGetEncoderParameterList", "ptr", pImage, "ptr", pCodec, "Uint", nCount, "ptr", &pi)
		Loop, %	NumGet(pi,0,"uint")
			If (NumGet(pi,struct_size*(A_Index-1)+16+A_PtrSize,"uint")=1 && NumGet(pi,struct_size*(A_Index-1)+20+A_PtrSize,"uint")=6)
			{
				pParam := &pi+struct_size*(A_Index-1)
				NumPut(nQuality,NumGet(NumPut(4,NumPut(1,pParam+0,"uint")+16+A_PtrSize,"uint")),"uint")
				Break
			}
	}

	If pImage
		pCodec < &ci + nSize	? DllCall("gdiplus\GdipSaveImageToFile", "ptr", pImage, "wstr", sFileTo, "ptr", pCodec, "ptr", pParam) : DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "ptr", pImage, "ptr*", hBitmap, "Uint", 0) . SetClipboardData(hBitmap), DllCall("gdiplus\GdipDisposeImage", "ptr", pImage)

	DllCall("gdiplus\GdiplusShutdown" , "Uint", pToken)
	DllCall("FreeLibrary", "ptr", hGdiPlus)
}


CreateDIBSection(hDC, nW, nH, bpp = 32, ByRef pBits = "")
{
	VarSetCapacity(bi, 40, 0)
	NumPut(40, bi, "uint")
	NumPut(nW, bi, 4, "int")
	NumPut(nH, bi, 8, "int")
	NumPut(bpp, NumPut(1, bi, 12, "UShort"), 0, "Ushort")
	Return DllCall("gdi32\CreateDIBSection", "ptr", hDC, "ptr", &bi, "Uint", 0, "UintP", pBits, "ptr", 0, "Uint", 0, "ptr")
}

SaveHBITMAPToFile(hBitmap, sFile)
{
	VarSetCapacity(oi,104,0)
	DllCall("GetObject", "ptr", hBitmap, "int", 64+5*A_PtrSize, "ptr", &oi)
	fObj := FileOpen(sFile, "w")
	fObj.WriteShort(0x4D42)
	fObj.WriteInt(54+NumGet(oi,36+2*A_PtrSize,"uint"))
	fObj.WriteInt64(54<<32)
	fObj.RawWrite(&oi + 16 + 2*A_PtrSize, 40)
	fObj.RawWrite(NumGet(oi, 16+A_PtrSize), NumGet(oi,36+2*A_PtrSize,"uint"))
	fObj.Close()
}

SetClipboardData(hBitmap)
{
	VarSetCapacity(oi,104,0)
	DllCall("GetObject", "ptr", hBitmap, "int", 64+5*A_PtrSize, "ptr", &oi)
	sz := NumGet(oi,36+2*A_PtrSize,"uint")
	hDIB :=	DllCall("GlobalAlloc", "Uint", 2, "Uptr", 40+sz, "ptr")
	pDIB := DllCall("GlobalLock", "ptr", hDIB, "ptr")
	DllCall("RtlMoveMemory", "ptr", pDIB, "ptr", &oi + 16 + 2*A_PtrSize, "Uptr", 40)
	DllCall("RtlMoveMemory", "ptr", pDIB+40, "ptr", NumGet(oi, 16+A_PtrSize), "Uptr", sz)
	DllCall("GlobalUnlock", "ptr", hDIB)
	DllCall("DeleteObject", "ptr", hBitmap)
	DllCall("OpenClipboard", "ptr", 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "Uint", 8, "ptr", hDIB)
	DllCall("CloseClipboard")
}