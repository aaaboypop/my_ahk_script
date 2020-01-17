;------------ Setup -------------
event := 2
pToken := Gdip_Startup()
hdc := CreateCompatibleDC()
G := Gdip_GraphicsFromHDC(hdc)
Gdip_SetSmoothingMode(G, 4)
Font = Arial
Gdip_FontFamilyCreate(Font)
OnMessage(0x201, "WM_LBUTTONDOWN")
SetUpGDIP()
StartDrawGDIP()
ClearDrawGDIP()
Gdip_SetSmoothingMode(G, 4)
a := new Subtitle()
Return

F8::
D_Img("123.png","0","0","1026","795")
UpdateLayeredWindow(hwnd1, hdc, (A_ScreenWidth-Width)//2, (A_ScreenHeight-Height)//2, Width, Height)
Return

i:=0


F11::

return

imageSearchc(byRef out1,byRef out2,x1,y1,x2,y2,image,vari=0,trans="",direction=5,debug=0){
    static ptok:=gdip_startup()
    imageB:=gdip_createBitmapFromFile(image)
    scrn:=gdip_bitmapfromscreen(x1 . "|" . y1 . "|" . x2 - x1 . "|" . y2 - y1)
    if(debug)
        gdip_saveBitmapToFile(scrn,a_now . ".png")
    errorlev:=gdip_imageSearch(scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
    gdip_disposeImage(scrn)
    gdip_disposeImage(imageB)

    if(errorlev){
        out:=strSplit(tempxy,"`,")
        out1:=out[1] + x1
        out2:=out[2] + y1
        return % errorlev
    }
    return 0
}



F6::
i++


a.Render( i, "h150 cBlack", "yCenter s72 cWhite f(Arial)").ClickThrough()

;a.Destroy()
Return

F2::
;------------ Add Image -------------
D_Img("out.png","0","0","640","360")

;------------ Add FillRectangle -------------
D_R("100","500","200","200","ffffff","66")

;------------ Add OutLineRectangle -------------
D_LR("100","500","200","200","ee0000","aa","10")

;------------ Add FillCircle -------------
D_C("0","10","200","200","ffffff","aa")

;------------ Add OutLineCircle -------------
D_LC("0","10","200","200","ee0000","66","3")

;------------ Add Text -------------
Gdip_TextToGraphics(G, "ข้อความมมมมมมมม", "x-10p y30p w80p Centre cff111111 r4 s20 Underline Italic", Font, 100, 100)

;------------ Update -------------
UpdateLayeredWindow(hwnd1, hdc, (A_ScreenWidth-Width)//2, (A_ScreenHeight-Height)//2, Width, Height)
Return

F3::


loop
{
	FormatTime,today,,WDay
	FormatTime,t_hour,,H
	FormatTime,t_min,,m
	FormatTime,t_sec,,s
	Show_Text := "เวลา " t_hour ":" t_min "`nผลการค้นหา : 12"
	a := new Subtitle()
	a.Draw(Show_Text, {"x":10, "y":10, "c":"None"}, { "size":72 ,"color":"#FFFFFF", "font":"Thai Sans Lite", "outline":"5 #111111 3"})
	a.Render().ClickThrough()
	Sleep, 500

	a.Destroy()
	Sleep, 500
}


;Gdip_TextToGraphics(G, Show_Text, "x0p y0p w80p cffffffff s36 Bold", Font, 250, 200)
;UpdateLayeredWindow(hwnd1, hdc, (A_ScreenWidth-Width)//2, (A_ScreenHeight-Height)//2, Width, Height)

;a.Draw(i, {"h":100, "color":"Black"}, {"y":"Center", "size":72, "color":"White", "font":"Arial"})

;a.Render("7", {"x":485, "y":25, "w":100, "h":100, "radius":50, "color":"CC00CC"}, {"color":"White", "x":"Center", "y":"55%", "anchor":"Center", "size":72})


;a.Draw("Looks like the       train is late again.", "h150 cBlack", "yCenter s72 cWhite f(Arial)")
;a.Render("7", "x485 y25 w100 h100 r50 cCC00CC", "cWhite xCenter y55% aCenter s72")
;a.Save()

;a.Destroy()
Return



F4::
;------------ Clear -------------
D_Clear()
a.Destroy()
Return



F5::
;------------ Move Able -------------
If(event = 2)
{
	event := 1
}
else
{
	event := 2
}
Return



D_R(x,y,w,h,color,alpha){
    global pBrush,G
	set := "0x" alpha color
	pBrush := Gdip_BrushCreateSolid(set)
	Gdip_FillRectangle(G, pBrush, x, y, w, h)
	Gdip_DeletePen(pBrush)
    return
}

D_C(x,y,w,h,color,alpha){
    global pBrush,G
	set := "0x" alpha color
	pBrush := Gdip_BrushCreateSolid(set)
	Gdip_FillEllipse(G, pBrush, x, y, w, h)
	Gdip_DeletePen(pBrush)
    return
}

D_LR(x,y,w,h,color,alpha,tick){
    global pPen, G
	set := "0x" alpha color
	pPen := Gdip_CreatePen(set, tick)
	Gdip_DrawRectangle(G, pPen, x, y, w, h)
	Gdip_DeletePen(pPen)
    return
}

D_LC(x,y,w,h,color,alpha,tick){
    global pPen, G
	set := "0x" alpha color
	pPen := Gdip_CreatePen(set, tick)
	Gdip_DrawEllipse(G, pPen, x, y, w, h)
	Gdip_DeletePen(pPen)
    return
}

D_Img(aimg,x,y,w,h){
    global pBitmap, G
    pBitmap := Gdip_CreateBitmapFromFile(aimg)
    Gdip_DrawImage(G, pBitmap, x, y, w, h)
    Gdip_DisposeImage(pBitmap)
    return
}


WM_LBUTTONDOWN()
{
	global event
	PostMessage, 0xA1, %event%
}

Exit:
Gdip_Shutdown(pToken)
ExitApp
Return



D_Clear(){
global hdc, obm, hbm, hwnd1, Width, Height, G
SelectObject(hdc, obm)
DeleteObject(hbm)
DeleteDC(hdc)
Gdip_DeleteGraphics(G)
SetUpGDIP()
StartDrawGDIP()
ClearDrawGDIP()
UpdateLayeredWindow(hwnd1, hdc, (A_ScreenWidth-Width)//2, (A_ScreenHeight-Height)//2, Width, Height)
}
Return


JustTheBasics() {
	global
	
	; Start gdi+
	If !pToken := Gdip_Startup()
	{
		MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
		ExitApp
	}
	OnExit, Exit
	return
	
	

	Gdip_Shutdown(pToken)
	ExitApp
	Return

}

SetUpGDIP(iWidth=-1, iHeight=-1) {
	global
	Width := iWidth
	Height := iHeight
	If (iWidth < 0) {
		Width := A_ScreenWidth
	}
	if (iHeight < 0) {
		height := A_ScreenHeight
	}
	
	
	JustTheBasics()
	
	; Create a layered window (+E0x80000 : must be used for UpdateLayeredWindow to work!) that is always on top (+AlwaysOnTop), has no taskbar entry or caption
	Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs

	; Show the window
	Gui, 1: Show, NA

	; Get a handle to this window we have created in order to update it later
	hwnd1 := WinExist()
	return
}

StartDrawGDIP() {
	global
	
	; Create a gdi bitmap with width and height of what we are going to draw into it. This is the entire drawing area for everything
	hbm := CreateDIBSection(Width, Height)

	; Get a device context compatible with the screen
	hdc := CreateCompatibleDC()

	; Select the bitmap into the device context
	obm := SelectObject(hdc, hbm)

	; Get a pointer to the graphics of the bitmap, for use with drawing functions
	G := Gdip_GraphicsFromHDC(hdc)	
}

EndDrawGDIP() {
	global
	
	; Update the specified window we have created (hwnd1) with a handle to our bitmap (hdc), specifying the x,y,w,h we want it positioned on our screen
	; So this will position our gui at (0,0) with the Width and Height specified earlier
	UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)


	; Select the object back into the hdc
	SelectObject(hdc, obm)

	; Now the bitmap may be deleted
	DeleteObject(hbm)

	; Also the device context related to the bitmap may be deleted
	DeleteDC(hdc)

	; The graphics may now be deleted
	Gdip_DeleteGraphics(G)
}

ClearDrawGDIP() {
	global
	Gdip_GraphicsClear(G)
}

; Gdip standard library v1.54 on 11/15/2017
; Gdip standard library v1.53 on 6/19/2017
; Gdip standard library v1.52 on 6/11/2017
; Gdip standard library v1.51 on 1/27/2017
; Gdip standard library v1.50 on 11/20/16
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
;
; Updated 11/15/2017 - compatibility with both AHK v2 and v1, restored by nnnik
; Updated 6/19/2017 - Fixed few bugs from old syntax by Bartlomiej Uliasz
; Updated 6/11/2017 - made code compatible with new AHK v2.0-a079-be5df98 by Bartlomiej Uliasz
; Updated 1/27/2017 - fixed some bugs and made #Warn All compatible by Bartlomiej Uliasz
; Updated 11/20/2016 - fixed Gdip_BitmapFromBRA() by 'just me'
; Updated 11/18/2016 - backward compatible support for both AHK v1.1 and AHK v2
; Updated 11/15/2016 - initial AHK v2 support by guest3456
; Updated 2/20/2014 - fixed Gdip_CreateRegion() and Gdip_GetClipRegion() on AHK Unicode x86
; Updated 5/13/2013 - fixed Gdip_SetBitmapToClipboard() on AHK Unicode x64
;
;#####################################################################################
;#####################################################################################
; STATUS ENUMERATION
; Return values for functions specified to have status enumerated return type
;#####################################################################################
;
; Ok =						= 0
; GenericError				= 1
; InvalidParameter			= 2
; OutOfMemory				= 3
; ObjectBusy				= 4
; InsufficientBuffer		= 5
; NotImplemented			= 6
; Win32Error				= 7
; WrongState				= 8
; Aborted					= 9
; FileNotFound				= 10
; ValueOverflow				= 11
; AccessDenied				= 12
; UnknownImageFormat		= 13
; FontFamilyNotFound		= 14
; FontStyleNotFound			= 15
; NotTrueTypeFont			= 16
; UnsupportedGdiplusVersion	= 17
; GdiplusNotInitialized		= 18
; PropertyNotFound			= 19
; PropertyNotSupported		= 20
; ProfileNotFound			= 21
;
;#####################################################################################
;#####################################################################################
; FUNCTIONS
;#####################################################################################
;
; UpdateLayeredWindow(hwnd, hdc, x:="", y:="", w:="", h:="", Alpha:=255)
; BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster:="")
; StretchBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, sw, sh, Raster:="")
; SetImage(hwnd, hBitmap)
; Gdip_BitmapFromScreen(Screen:=0, Raster:="")
; CreateRectF(ByRef RectF, x, y, w, h)
; CreateSizeF(ByRef SizeF, w, h)
; CreateDIBSection
;
;#####################################################################################

; Function:					UpdateLayeredWindow
; Description:				Updates a layered window with the handle to the DC of a gdi bitmap
;
; hwnd						Handle of the layered window to update
; hdc						Handle to the DC of the GDI bitmap to update the window with
; Layeredx					x position to place the window
; Layeredy					y position to place the window
; Layeredw					Width of the window
; Layeredh					Height of the window
; Alpha						Default = 255 : The transparency (0-255) to set the window transparency
;
; return					If the function succeeds, the return value is nonzero
;
; notes						If x or y omitted, then layered window will use its current coordinates
;							If w or h omitted then current width and height will be used

UpdateLayeredWindow(hwnd, hdc, x:="", y:="", w:="", h:="", Alpha:=255)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0, "UInt"), NumPut(y, pt, 4, "UInt")

	if (w = "") || (h = "")
	{
		CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
		DllCall( "GetWindowRect", Ptr, hwnd, Ptr, &winRect )
		w := NumGet(winRect, 8, "UInt")  - NumGet(winRect, 0, "UInt")
		h := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
	}

	return DllCall("UpdateLayeredWindow"
	, Ptr, hwnd
	, Ptr, 0
	, Ptr, ((x = "") && (y = "")) ? 0 : &pt
	, "int64*", w|h<<32
	, Ptr, hdc
	, "int64*", 0
	, "uint", 0
	, "UInt*", Alpha<<16|1<<24
	, "uint", 2)
}

;#####################################################################################

; Function				BitBlt
; Description			The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle
;						of pixels from the specified source device context into a destination device context.
;
; dDC					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of the area to copy
; dh					height of the area to copy
; sDC					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used, which copies the source directly to the destination rectangle
;
; BLACKNESS				= 0x00000042
; NOTSRCERASE			= 0x001100A6
; NOTSRCCOPY			= 0x00330008
; SRCERASE				= 0x00440328
; DSTINVERT				= 0x00550009
; PATINVERT				= 0x005A0049
; SRCINVERT				= 0x00660046
; SRCAND				= 0x008800C6
; MERGEPAINT			= 0x00BB0226
; MERGECOPY				= 0x00C000CA
; SRCCOPY				= 0x00CC0020
; SRCPAINT				= 0x00EE0086
; PATCOPY				= 0x00F00021
; PATPAINT				= 0x00FB0A09
; WHITENESS				= 0x00FF0062
; CAPTUREBLT			= 0x40000000
; NOMIRRORBITMAP		= 0x80000000

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster:="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdi32\BitBlt"
					, Ptr, dDC
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sDC
					, "int", sx
					, "int", sy
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				StretchBlt
; Description			The StretchBlt function copies a bitmap from a source rectangle into a destination rectangle,
;						stretching or compressing the bitmap to fit the dimensions of the destination rectangle, if necessary.
;						The system stretches or compresses the bitmap according to the stretching mode currently set in the destination device context.
;
; ddc					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination rectangle
; dh					height of destination rectangle
; sdc					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used. It uses the same raster operations as BitBlt

StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster:="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdi32\StretchBlt"
					, Ptr, ddc
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sdc
					, "int", sx
					, "int", sy
					, "int", sw
					, "int", sh
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				SetStretchBltMode
; Description			The SetStretchBltMode function sets the bitmap stretching mode in the specified device context
;
; hdc					handle to the DC
; iStretchMode			The stretching mode, describing how the target will be stretched
;
; return				If the function succeeds, the return value is the previous stretching mode. If it fails it will return 0
;
; STRETCH_ANDSCANS 		= 0x01
; STRETCH_ORSCANS 		= 0x02
; STRETCH_DELETESCANS 	= 0x03
; STRETCH_HALFTONE 		= 0x04

SetStretchBltMode(hdc, iStretchMode:=4)
{
	return DllCall("gdi32\SetStretchBltMode"
					, A_PtrSize ? "UPtr" : "UInt", hdc
					, "int", iStretchMode)
}

;#####################################################################################

; Function				SetImage
; Description			Associates a new image with a static control
;
; hwnd					handle of the control to update
; hBitmap				a gdi bitmap to associate the static control with
;
; return				If the function succeeds, the return value is nonzero

SetImage(hwnd, hBitmap)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	E := DllCall( "SendMessage", Ptr, hwnd, "UInt", 0x172, "UInt", 0x0, Ptr, hBitmap )
	DeleteObject(E)
	return E
}

;#####################################################################################

; Function				SetSysColorToControl
; Description			Sets a solid colour to a control
;
; hwnd					handle of the control to update
; SysColor				A system colour to set to the control
;
; return				If the function succeeds, the return value is zero
;
; notes					A control must have the 0xE style set to it so it is recognised as a bitmap
;						By default SysColor=15 is used which is COLOR_3DFACE. This is the standard background for a control
;
; COLOR_3DDKSHADOW				= 21
; COLOR_3DFACE					= 15
; COLOR_3DHIGHLIGHT				= 20
; COLOR_3DHILIGHT				= 20
; COLOR_3DLIGHT					= 22
; COLOR_3DSHADOW				= 16
; COLOR_ACTIVEBORDER			= 10
; COLOR_ACTIVECAPTION			= 2
; COLOR_APPWORKSPACE			= 12
; COLOR_BACKGROUND				= 1
; COLOR_BTNFACE					= 15
; COLOR_BTNHIGHLIGHT			= 20
; COLOR_BTNHILIGHT				= 20
; COLOR_BTNSHADOW				= 16
; COLOR_BTNTEXT					= 18
; COLOR_CAPTIONTEXT				= 9
; COLOR_DESKTOP					= 1
; COLOR_GRADIENTACTIVECAPTION	= 27
; COLOR_GRADIENTINACTIVECAPTION	= 28
; COLOR_GRAYTEXT				= 17
; COLOR_HIGHLIGHT				= 13
; COLOR_HIGHLIGHTTEXT			= 14
; COLOR_HOTLIGHT				= 26
; COLOR_INACTIVEBORDER			= 11
; COLOR_INACTIVECAPTION			= 3
; COLOR_INACTIVECAPTIONTEXT		= 19
; COLOR_INFOBK					= 24
; COLOR_INFOTEXT				= 23
; COLOR_MENU					= 4
; COLOR_MENUHILIGHT				= 29
; COLOR_MENUBAR					= 30
; COLOR_MENUTEXT				= 7
; COLOR_SCROLLBAR				= 0
; COLOR_WINDOW					= 5
; COLOR_WINDOWFRAME				= 6
; COLOR_WINDOWTEXT				= 8

SetSysColorToControl(hwnd, SysColor:=15)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
	DllCall( "GetWindowRect", Ptr, hwnd, Ptr, &winRect )
	w := NumGet(winRect, 8, "UInt")  - NumGet(winRect, 0, "UInt")
	h := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
	bc := DllCall("GetSysColor", "Int", SysColor, "UInt")
	pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
	pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
	Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	SetImage(hwnd, hBitmap)
	Gdip_DeleteBrush(pBrushClear)
	Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
	return 0
}

;#####################################################################################

; Function				Gdip_BitmapFromScreen
; Description			Gets a gdi+ bitmap from the screen
;
; Screen				0 = All screens
;						Any numerical value = Just that screen
;						x|y|w|h = Take specific coordinates with a width and height
; Raster				raster operation code
;
; return					If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1:		one or more of x,y,w,h not passed properly
;
; notes					If no raster operation is specified, then SRCCOPY is used to the returned bitmap

Gdip_BitmapFromScreen(Screen:=0, Raster:="")
{
	hhdc := 0
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (Screen = 0)
	{
		_x := DllCall( "GetSystemMetrics", "Int", 76 )
		_y := DllCall( "GetSystemMetrics", "Int", 77 )
		_w := DllCall( "GetSystemMetrics", "Int", 78 )
		_h := DllCall( "GetSystemMetrics", "Int", 79 )
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist("ahk_id " Screen)
			return -2
		CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
		DllCall( "GetWindowRect", Ptr, Screen, Ptr, &winRect )
		_w := NumGet(winRect, 8, "UInt")  - NumGet(winRect, 0, "UInt")
		_h := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
		_x := _y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if IsInteger(Screen)
	{
		M := GetMonitorInfo(Screen)
		_x := M.Left, _y := M.Top, _w := M.Right-M.Left, _h := M.Bottom-M.Top
	}
	else
	{
		S := StrSplit(Screen, "|")
		_x := S[1], _y := S[2], _w := S[3], _h := S[4]
	}

	if (_x = "") || (_y = "") || (_w = "") || (_h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(_w, _h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, _w, _h, hhdc, _x, _y, Raster)
	ReleaseDC(hhdc)

	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_BitmapFromHWND
; Description			Uses PrintWindow to get a handle to the specified window and return a bitmap from it
;
; hwnd					handle to the window to get a bitmap from
;
; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
;
; notes					Window must not be not minimised in order to get a handle to it's client area

Gdip_BitmapFromHWND(hwnd)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
	DllCall( "GetWindowRect", Ptr, hwnd, Ptr, &winRect )
	Width := NumGet(winRect, 8, "UInt") - NumGet(winRect, 0, "UInt")
	Height := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}

;#####################################################################################

; Function				CreateRectF
; Description			Creates a RectF object, containing a the coordinates and dimensions of a rectangle
;
; RectF					Name to call the RectF object
; x						x-coordinate of the upper left corner of the rectangle
; y						y-coordinate of the upper left corner of the rectangle
; w						Width of the rectangle
; h						Height of the rectangle
;
; return				No return value

CreateRectF(ByRef RectF, x, y, w, h)
{
	VarSetCapacity(RectF, 16)
	NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}

;#####################################################################################

; Function				CreateRect
; Description			Creates a Rect object, containing a the coordinates and dimensions of a rectangle
;
; RectF		 			Name to call the RectF object
; x						x-coordinate of the upper left corner of the rectangle
; y						y-coordinate of the upper left corner of the rectangle
; w						Width of the rectangle
; h						Height of the rectangle
;
; return				No return value

CreateRect(ByRef Rect, x, y, w, h)
{
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
;#####################################################################################

; Function				CreateSizeF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF					Name to call the SizeF object
; w						w-value for the SizeF object
; h						h-value for the SizeF object
;
; return				No Return value

CreateSizeF(ByRef SizeF, w, h)
{
	VarSetCapacity(SizeF, 8)
	NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")
}
;#####################################################################################

; Function				CreatePointF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF					Name to call the SizeF object
; w						w-value for the SizeF object
; h						h-value for the SizeF object
;
; return				No Return value

CreatePointF(ByRef PointF, x, y)
{
	VarSetCapacity(PointF, 8)
	NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")
}
;#####################################################################################

; Function				CreateDIBSection
; Description			The CreateDIBSection function creates a DIB (Device Independent Bitmap) that applications can write to directly
;
; w						width of the bitmap to create
; h						height of the bitmap to create
; hdc					a handle to the device context to use the palette from
; bpp					bits per pixel (32 = ARGB)
; ppvBits				A pointer to a variable that receives a pointer to the location of the DIB bit values
;
; return				returns a DIB. A gdi bitmap
;
; notes					ppvBits will receive the location of the pixels in the DIB

CreateDIBSection(w, h, hdc:="", bpp:=32, ByRef ppvBits:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)

	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")

	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}

;#####################################################################################

; Function				PrintWindow
; Description			The PrintWindow function copies a visual window into the specified device context (DC), typically a printer DC
;
; hwnd					A handle to the window that will be copied
; hdc					A handle to the device context
; Flags					Drawing options
;
; return				If the function succeeds, it returns a nonzero value
;
; PW_CLIENTONLY			= 1

PrintWindow(hwnd, hdc, Flags:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}

;#####################################################################################

; Function				DestroyIcon
; Description			Destroys an icon and frees any memory the icon occupied
;
; hIcon					Handle to the icon to be destroyed. The icon must not be in use
;
; return				If the function succeeds, the return value is nonzero

DestroyIcon(hIcon)
{
	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
}

;#####################################################################################

; Function:				GetIconDimensions
; Description:			Retrieves a given icon/cursor's width and height 
;
; hIcon					Pointer to an icon or cursor
; Width					ByRef variable. This variable is set to the icon's width
; Height				ByRef variable. This variable is set to the icon's height
;
; return				If the function succeeds, the return value is zero, otherwise:
;						-1 = Could not retrieve the icon's info. Check A_LastError for extended information
;						-2 = Could not delete the icon's bitmask bitmap
;						-3 = Could not delete the icon's color bitmap

GetIconDimensions(hIcon, ByRef Width, ByRef Height) {
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	Width := Height := 0

	VarSetCapacity(ICONINFO, size := 16 + 2 * A_PtrSize, 0)

	if !DllCall("user32\GetIconInfo", Ptr, hIcon, Ptr, &ICONINFO)
		return -1
	
	hbmMask := NumGet(&ICONINFO, 16, Ptr)
	hbmColor := NumGet(&ICONINFO, 16 + A_PtrSize, Ptr)
	VarSetCapacity(BITMAP, size, 0)

	if DllCall("gdi32\GetObject", Ptr, hbmColor, "Int", size, Ptr, &BITMAP)
	{
		Width := NumGet(&BITMAP, 4, "Int")
		Height := NumGet(&BITMAP, 8, "Int")
	}

	if !DllCall("gdi32\DeleteObject", Ptr, hbmMask)
		return -2
	
	if !DllCall("gdi32\DeleteObject", Ptr, hbmColor)
		return -3

	return 0
}

;#####################################################################################

PaintDesktop(hdc)
{
	return DllCall("PaintDesktop", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

CreateCompatibleBitmap(hdc, w, h)
{
	return DllCall("gdi32\CreateCompatibleBitmap", A_PtrSize ? "UPtr" : "UInt", hdc, "int", w, "int", h)
}

;#####################################################################################

; Function				CreateCompatibleDC
; Description			This function creates a memory device context (DC) compatible with the specified device
;
; hdc					Handle to an existing device context
;
; return				returns the handle to a device context or 0 on failure
;
; notes					If this handle is 0 (by default), the function creates a memory device context compatible with the application's current screen

CreateCompatibleDC(hdc:=0)
{
	return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

; Function				SelectObject
; Description			The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type
;
; hdc					Handle to a DC
; hgdiobj				A handle to the object to be selected into the DC
;
; return				If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced
;
; notes					The specified object must have been created by using one of the following functions
;						Bitmap - CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection (A single bitmap cannot be selected into more than one DC at the same time)
;						Brush - CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush
;						Font - CreateFont, CreateFontIndirect
;						Pen - CreatePen, CreatePenIndirect
;						Region - CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect
;
; notes					If the selected object is a region and the function succeeds, the return value is one of the following value
;
; SIMPLEREGION			= 2 Region consists of a single rectangle
; COMPLEXREGION			= 3 Region consists of more than one rectangle
; NULLREGION			= 1 Region is empty

SelectObject(hdc, hgdiobj)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}

;#####################################################################################

; Function				DeleteObject
; Description			This function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object
;						After the object is deleted, the specified handle is no longer valid
;
; hObject				Handle to a logical pen, brush, font, bitmap, region, or palette to delete
;
; return				Nonzero indicates success. Zero indicates that the specified handle is not valid or that the handle is currently selected into a device context

DeleteObject(hObject)
{
	return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}

;#####################################################################################

; Function				GetDC
; Description			This function retrieves a handle to a display device context (DC) for the client area of the specified window.
;						The display device context can be used in subsequent graphics display interface (GDI) functions to draw in the client area of the window.
;
; hwnd					Handle to the window whose device context is to be retrieved. If this value is NULL, GetDC retrieves the device context for the entire screen
;
; return				The handle the device context for the specified window's client area indicates success. NULL indicates failure

GetDC(hwnd:=0)
{
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}

;#####################################################################################

; DCX_CACHE = 0x2
; DCX_CLIPCHILDREN = 0x8
; DCX_CLIPSIBLINGS = 0x10
; DCX_EXCLUDERGN = 0x40
; DCX_EXCLUDEUPDATE = 0x100
; DCX_INTERSECTRGN = 0x80
; DCX_INTERSECTUPDATE = 0x200
; DCX_LOCKWINDOWUPDATE = 0x400
; DCX_NORECOMPUTE = 0x100000
; DCX_NORESETATTRS = 0x4
; DCX_PARENTCLIP = 0x20
; DCX_VALIDATE = 0x200000
; DCX_WINDOW = 0x1

GetDCEx(hwnd, flags:=0, hrgnClip:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}

;#####################################################################################

; Function				ReleaseDC
; Description			This function releases a device context (DC), freeing it for use by other applications. The effect of ReleaseDC depends on the type of device context
;
; hdc					Handle to the device context to be released
; hwnd					Handle to the window whose device context is to be released
;
; return				1 = released
;						0 = not released
;
; notes					The application must call the ReleaseDC function for each call to the GetWindowDC function and for each call to the GetDC function that retrieves a common device context
;						An application cannot use the ReleaseDC function to release a device context that was created by calling the CreateDC function; instead, it must use the DeleteDC function.

ReleaseDC(hdc, hwnd:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}

;#####################################################################################

; Function				DeleteDC
; Description			The DeleteDC function deletes the specified device context (DC)
;
; hdc					A handle to the device context
;
; return				If the function succeeds, the return value is nonzero
;
; notes					An application must not delete a DC whose handle was obtained by calling the GetDC function. Instead, it must call the ReleaseDC function to free the DC

DeleteDC(hdc)
{
	return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
;#####################################################################################

; Function				Gdip_LibraryVersion
; Description			Get the current library version
;
; return				the library version
;
; notes					This is useful for non compiled programs to ensure that a person doesn't run an old version when testing your scripts

Gdip_LibraryVersion()
{
	return 1.45
}

;#####################################################################################

; Function				Gdip_LibrarySubVersion
; Description			Get the current library sub version
;
; return				the library sub version
;
; notes					This is the sub-version currently maintained by Rseding91
; 					Updated by guest3456 preliminary AHK v2 support
Gdip_LibrarySubVersion()
{
	return 1.54
}

;#####################################################################################

; Function:				Gdip_BitmapFromBRA
; Description: 			Gets a pointer to a gdi+ bitmap from a BRA file
;
; BRAFromMemIn			The variable for a BRA file read to memory
; File					The name of the file, or its number that you would like (This depends on alternate parameter)
; Alternate				Changes whether the File parameter is the file name or its number
;
; return					If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1 = The BRA variable is empty
;						-2 = The BRA has an incorrect header
;						-3 = The BRA has information missing
;						-4 = Could not find file inside the BRA

Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate := 0) {
	pBitmap := ""

	If !(BRAFromMemIn)
		Return -1
	Headers := StrSplit(StrGet(&BRAFromMemIn, 256, "CP0"), "`n")
	Header := StrSplit(Headers.1, "|")
	If (Header.Length() != 4) || (Header.2 != "BRA!")
		Return -2
	_Info := StrSplit(Headers.2, "|")
	If (_Info.Length() != 3)
		Return -3
	OffsetTOC := StrPut(Headers.1, "CP0") + StrPut(Headers.2, "CP0") ;  + 2
	OffsetData := _Info.2
	SearchIndex := Alternate ? 1 : 2
	TOC := StrGet(&BRAFromMemIn + OffsetTOC, OffsetData - OffsetTOC - 1, "CP0")
	RX1 := A_AhkVersion < "2" ? "mi`nO)^" : "mi`n)^"
	Offset := Size := 0
	If RegExMatch(TOC, RX1 . (Alternate ? File "\|.+?" : "\d+\|" . File) . "\|(\d+)\|(\d+)$", FileInfo) {
		Offset := OffsetData + FileInfo.1
		Size := FileInfo.2
	}
	If (Size = 0)
		Return -4
	hData := DllCall("GlobalAlloc", "UInt", 2, "UInt", Size, "UPtr")
	pData := DllCall("GlobalLock", "Ptr", hData, "UPtr")
	DllCall("RtlMoveMemory", "Ptr", pData, "Ptr", &BRAFromMemIn + Offset, "Ptr", Size)
	DllCall("GlobalUnlock", "Ptr", hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", 1, "PtrP", pStream)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream", "Ptr", pStream, "PtrP", pBitmap)
	ObjRelease(pStream)
	Return pBitmap
}

;#####################################################################################

; Function:				Gdip_BitmapFromBase64
; Description:			Creates a bitmap from a Base64 encoded string
;
; Base64				ByRef variable. Base64 encoded string. Immutable, ByRef to avoid performance overhead of passing long strings.
;
; return				If the function succeeds, the return value is a pointer to a bitmap, otherwise:
;						-1 = Could not calculate the length of the required buffer
;						-2 = Could not decode the Base64 encoded string
;						-3 = Could not create a memory stream

Gdip_BitmapFromBase64(ByRef Base64)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	; calculate the length of the buffer needed
	if !(DllCall("crypt32\CryptStringToBinary", Ptr, &Base64, "UInt", 0, "UInt", 0x01, Ptr, 0, "UIntP", DecLen, Ptr, 0, Ptr, 0))
		return -1

	VarSetCapacity(Dec, DecLen, 0)

	; decode the Base64 encoded string
	if !(DllCall("crypt32\CryptStringToBinary", Ptr, &Base64, "UInt", 0, "UInt", 0x01, Ptr, &Dec, "UIntP", DecLen, Ptr, 0, Ptr, 0))
		return -2

	; create a memory stream
	if !(pStream := DllCall("shlwapi\SHCreateMemStream", Ptr, &Dec, "UInt", DecLen, "UPtr"))
		return -3

	DllCall("gdiplus\GdipCreateBitmapFromStreamICM", Ptr, pStream, "PtrP", pBitmap)
	ObjRelease(pStream)

	return pBitmap
}

;#####################################################################################

; Function				Gdip_DrawRectangle
; Description			This function uses a pen to draw the outline of a rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawRoundedRectangle
; Description			This function uses a pen to draw the outline of a rounded rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r)
{
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	_E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return _E
}

;#####################################################################################

; Function				Gdip_DrawEllipse
; Description			This function uses a pen to draw the outline of an ellipse into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle the ellipse will be drawn into
; y						y-coordinate of the top left of the rectangle the ellipse will be drawn into
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawBezier
; Description			This function uses a pen to draw the outline of a bezier (a weighted curve) into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the bezier
; y1					y-coordinate of the start of the bezier
; x2					x-coordinate of the first arc of the bezier
; y2					y-coordinate of the first arc of the bezier
; x3					x-coordinate of the second arc of the bezier
; y3					y-coordinate of the second arc of the bezier
; x4					x-coordinate of the end of the bezier
; y4					y-coordinate of the end of the bezier
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawBezier"
					, Ptr, pgraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2
					, "float", x3
					, "float", y3
					, "float", x4
					, "float", y4)
}

;#####################################################################################

; Function				Gdip_DrawArc
; Description			This function uses a pen to draw the outline of an arc into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the arc
; y						y-coordinate of the start of the arc
; w						width of the arc
; h						height of the arc
; StartAngle			specifies the angle between the x-axis and the starting point of the arc
; SweepAngle			specifies the angle between the starting and ending points of the arc
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawArc"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawPie
; Description			This function uses a pen to draw the outline of a pie into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the pie
; y						y-coordinate of the start of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawLine
; Description			This function uses a pen to draw a line into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the line
; y1					y-coordinate of the start of the line
; x2					x-coordinate of the end of the line
; y2					y-coordinate of the end of the line
;
; return				status enumeration. 0 = success

Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawLine"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2)
}

;#####################################################################################

; Function				Gdip_DrawLines
; Description			This function uses a pen to draw a series of joined lines into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success

Gdip_DrawLines(pGraphics, pPen, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	Points := StrSplit(Points, "|")
	VarSetCapacity(PointF, 8*Points.Length())
	for eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points.Length())
}

;#####################################################################################

; Function				Gdip_FillRectangle
; Description			This function uses a brush to fill a rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success

Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillRectangle"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRoundedRectangle
; Description			This function uses a brush to fill a rounded rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success

Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
{
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	_E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return _E
}

;#####################################################################################

; Function				Gdip_FillPolygon
; Description			This function uses a brush to fill a polygon in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success
;
; notes					Alternate will fill the polygon as a whole, wheras winding will fill each new "segment"
; Alternate 			= 0
; Winding 				= 1

Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	Points := StrSplit(Points, "|")
	VarSetCapacity(PointF, 8*Points.Length())
	For eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points.Length(), "int", FillMode)
}

;#####################################################################################

; Function				Gdip_FillPie
; Description			This function uses a brush to fill a pie in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the pie
; y						y-coordinate of the top left of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success

Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillPie"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_FillEllipse
; Description			This function uses a brush to fill an ellipse in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the ellipse
; y						y-coordinate of the top left of the ellipse
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success

Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRegion
; Description			This function uses a brush to fill a region in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Region
;
; return				status enumeration. 0 = success
;
; notes					You can create a region Gdip_CreateRegion() and then add to this

Gdip_FillRegion(pGraphics, pBrush, Region)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}

;#####################################################################################

; Function				Gdip_FillPath
; Description			This function uses a brush to fill a path in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Path
;
; return				status enumeration. 0 = success

Gdip_FillPath(pGraphics, pBrush, pPath)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, pPath)
}

;#####################################################################################

; Function				Gdip_DrawImagePointsRect
; Description			This function draws a bitmap into the Graphics of another bitmap and skews it
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; Points				Points passed as x1,y1|x2,y2|x3,y3 (3 points: top left, top right, bottom left) describing the drawing of the bitmap
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter

Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx:="", sy:="", sw:="", sh:="", Matrix:=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	Points := StrSplit(Points, "|")
	VarSetCapacity(PointF, 8*Points.Length())
	For eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}

	if !IsNumber(Matrix)
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		sx := 0, sy := 0
		sw := Gdip_GetImageWidth(pBitmap)
		sh := Gdip_GetImageHeight(pBitmap)
	}

	_E := DllCall("gdiplus\GdipDrawImagePointsRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, Ptr, &PointF
				, "int", Points.Length()
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return _E
}

;#####################################################################################

; Function				Gdip_DrawImage
; Description			This function draws a bitmap into the Graphics of another bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination image
; dh					height of destination image
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source image
; sh					height of source image
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Gdip_DrawImage performs faster
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter. For example:
;						MatrixBright=
;						(
;						1.5		|0		|0		|0		|0
;						0		|1.5	|0		|0		|0
;						0		|0		|1.5	|0		|0
;						0		|0		|0		|1		|0
;						0.05	|0.05	|0.05	|0		|1
;						)
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|1|1|1|0|1

Gdip_DrawImage(pGraphics, pBitmap, dx:="", dy:="", dw:="", dh:="", sx:="", sy:="", sw:="", sh:="", Matrix:=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if !IsNumber(Matrix)
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	_E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return _E
}

;#####################################################################################

; Function				Gdip_SetImageAttributesColorMatrix
; Description			This function creates an image matrix ready for drawing
;
; Matrix				a matrix used to alter image attributes when drawing
;						passed with any delimeter
;
; return				returns an image matrix on sucess or 0 if it fails
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|1|1|1|0|1

Gdip_SetImageAttributesColorMatrix(Matrix)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", , 1), "[^\d-\.]+", "|")
	Matrix := StrSplit(Matrix, "|")
	Loop 25
	{
		M := (Matrix[A_Index] != "") ? Matrix[A_Index] : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(M, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}

;#####################################################################################

; Function				Gdip_GraphicsFromImage
; Description			This function gets the graphics for a bitmap used for drawing functions
;
; pBitmap				Pointer to a bitmap to get the pointer to its graphics
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					a bitmap can be drawn into the graphics of another bitmap

Gdip_GraphicsFromImage(pBitmap)
{
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}

;#####################################################################################

; Function				Gdip_GraphicsFromHDC
; Description			This function gets the graphics from the handle to a device context
;
; hdc					This is the handle to the device context
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					You can draw a bitmap into the graphics of another bitmap

Gdip_GraphicsFromHDC(hdc)
{
	pGraphics := ""

	DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}

;#####################################################################################

; Function				Gdip_GetDC
; Description			This function gets the device context of the passed Graphics
;
; hdc					This is the handle to the device context
;
; return				returns the device context for the graphics of a bitmap

Gdip_GetDC(pGraphics)
{
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}

;#####################################################################################

; Function				Gdip_ReleaseDC
; Description			This function releases a device context from use for further use
;
; pGraphics				Pointer to the graphics of a bitmap
; hdc					This is the handle to the device context
;
; return				status enumeration. 0 = success

Gdip_ReleaseDC(pGraphics, hdc)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipReleaseDC", Ptr, pGraphics, Ptr, hdc)
}

;#####################################################################################

; Function				Gdip_GraphicsClear
; Description			Clears the graphics of a bitmap ready for further drawing
;
; pGraphics				Pointer to the graphics of a bitmap
; ARGB					The colour to clear the graphics to
;
; return				status enumeration. 0 = success
;
; notes					By default this will make the background invisible
;						Using clipping regions you can clear a particular area on the graphics rather than clearing the entire graphics

Gdip_GraphicsClear(pGraphics, ARGB:=0x00ffffff)
{
	return DllCall("gdiplus\GdipGraphicsClear", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_BlurBitmap
; Description			Gives a pointer to a blurred bitmap from a pointer to a bitmap
;
; pBitmap				Pointer to a bitmap to be blurred
; Blur					The Amount to blur a bitmap by from 1 (least blur) to 100 (most blur)
;
; return				If the function succeeds, the return value is a pointer to the new blurred bitmap
;						-1 = The blur parameter is outside the range 1-100
;
; notes					This function will not dispose of the original bitmap

Gdip_BlurBitmap(pBitmap, Blur)
{
	if (Blur > 100) || (Blur < 1)
		return -1

	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur

	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

	Gdip_DeleteGraphics(G1)

	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}

;#####################################################################################

; Function:				Gdip_SaveBitmapToFile
; Description:			Saves a bitmap to a file in any supported format onto disk
;
; pBitmap				Pointer to a bitmap
; sOutput				The name of the file that the bitmap will be saved to. Supported extensions are: .BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
; Quality				If saving as jpg (.JPG,.JPEG,.JPE,.JFIF) then quality can be 1-100 with default at maximum quality
;
; return				If the function succeeds, the return value is zero, otherwise:
;						-1 = Extension supplied is not a supported file format
;						-2 = Could not get a list of encoders on system
;						-3 = Could not find matching encoder for specified file format
;						-4 = Could not get WideChar name of output file
;						-5 = Could not save file to disk
;
; notes					This function will use the extension supplied from the sOutput parameter to determine the output format

Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality:=75)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	nCount := 0
	nSize := 0
	_p := 0

	SplitPath sOutput,,, Extension
	if !RegExMatch(Extension, "^(?i:BMP|DIB|RLE|JPG|JPEG|JPE|JFIF|GIF|TIF|TIFF|PNG)$")
		return -1
	Extension := "." Extension

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2

	If (A_IsUnicode){
		StrGet_Name := "StrGet"

		N := (A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
		{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue

			pCodec := &ci+idx
			break
		}
	} else {
		N := (A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
		{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue

			pCodec := &ci+76*(A_Index-1)
			break
		}
	}

	if !pCodec
		return -3

	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if RegExMatch(Extension, "^\.(?i:JPG|JPEG|JPE|JFIF)$")
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			nCount := NumGet(EncoderParameters, "UInt")
			N := (A_AhkVersion < 2) ? nCount : "nCount"
			Loop %N%
			{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
				{
					_p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, _p+0)+20, "UInt")), "UInt")
					break
				}
			}
		}
	}

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		_E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", _p ? _p : 0)
	}
	else
		_E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", _p ? _p : 0)
	return _E ? -5 : 0
}

;#####################################################################################

; Function				Gdip_GetPixel
; Description			Gets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				Returns the ARGB value of the pixel

Gdip_GetPixel(pBitmap, x, y)
{
	ARGB := 0

	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "uint*", ARGB)
	return ARGB
}

;#####################################################################################

; Function				Gdip_SetPixel
; Description			Sets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				status enumeration. 0 = success

Gdip_SetPixel(pBitmap, x, y, ARGB)
{
	return DllCall("gdiplus\GdipBitmapSetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_GetImageWidth
; Description			Gives the width of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the width in pixels of the supplied bitmap

Gdip_GetImageWidth(pBitmap)
{
	DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
	return Width
}

;#####################################################################################

; Function				Gdip_GetImageHeight
; Description			Gives the height of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the height in pixels of the supplied bitmap

Gdip_GetImageHeight(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
	return Height
}

;#####################################################################################

; Function				Gdip_GetDimensions
; Description			Gives the width and height of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Width := 0
	Height := 0
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdipGetImageWidth", Ptr, pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", Ptr, pBitmap, "uint*", Height)
}

;#####################################################################################

Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Gdip_GetImageDimensions(pBitmap, Width, Height)
}

;#####################################################################################

Gdip_GetImagePixelFormat(pBitmap)
{
	DllCall("gdiplus\GdipGetImagePixelFormat", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", Format)
	return Format
}

;#####################################################################################

; Function				Gdip_GetDpiX
; Description			Gives the horizontal dots per inch of the graphics of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetDpiX(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiX", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetDpiY(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiY", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_GetImageHorizontalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHorizontalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetImageVerticalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageVerticalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_BitmapSetResolution(pBitmap, dpix, dpiy)
{
	return DllCall("gdiplus\GdipBitmapSetResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float", dpix, "float", dpiy)
}

;#####################################################################################

Gdip_CreateBitmapFromFile(sFile, IconNumber:=1, IconSize:="")
{
	pBitmap := ""
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"

	SplitPath sFile,,, Extension
	if RegExMatch(Extension, "^(?i:exe|dll)$")
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))

		VarSetCapacity(buf, BufSize, 0)
		For eachSize, Size in StrSplit( Sizes, "|" )
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", Size, "int", Size, PtrA, hIcon, PtrA, 0, "uint", 1, "uint", 0)

			if !hIcon
				continue

			if !DllCall("GetIconInfo", Ptr, hIcon, Ptr, &buf)
			{
				DestroyIcon(hIcon)
				continue
			}

			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4))
			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4))
			if !(hbmColor && DllCall("GetObject", Ptr, hbmColor, "int", BufSize, Ptr, &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1

		Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", Ptr, hdc, "int", 0, "int", 0, Ptr, hIcon, "uint", Width, "uint", Height, "uint", 0, Ptr, 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}

		VarSetCapacity(dib, 104)
		DllCall("GetObject", Ptr, hbm, "int", A_PtrSize = 8 ? 104 : 84, Ptr, &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, Ptr, Bits, PtrA, pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height)
		_G := Gdip_GraphicsFromImage(pBitmap)
		, Gdip_DrawImage(_G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(_G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wFile, 1024)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sFile, "int", -1, Ptr, &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &wFile, PtrA, pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	}

	return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	pBitmap := ""

	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHBITMAPFromBitmap(pBitmap, Background:=0xffffffff)
{
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}

;#####################################################################################

Gdip_CreateBitmapFromHICON(hIcon)
{
	pBitmap := ""

	DllCall("gdiplus\GdipCreateBitmapFromHICON", A_PtrSize ? "UPtr" : "UInt", hIcon, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHICONFromBitmap(pBitmap)
{
	pBitmap := ""
	hIcon := 0

	DllCall("gdiplus\GdipCreateHICONFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hIcon)
	return hIcon
}

;#####################################################################################

Gdip_CreateBitmap(Width, Height, Format:=0x26200A)
{
	pBitmap := ""

	DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	Return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromClipboard()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if !DllCall("OpenClipboard", Ptr, 0)
		return -1
	if !DllCall("IsClipboardFormatAvailable", "uint", 8)
		return -2
	if !hBitmap := DllCall("GetClipboardData", "uint", 2, Ptr)
		return -3
	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return -4
	if !DllCall("CloseClipboard")
		return -5
	DeleteObject(hBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_SetBitmapToClipboard(pBitmap)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	off1 := A_PtrSize = 8 ? 52 : 44, off2 := A_PtrSize = 8 ? 32 : 24
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject", Ptr, hBitmap, "int", VarSetCapacity(oi, A_PtrSize = 8 ? 104 : 84, 0), Ptr, &oi)
	hdib := DllCall("GlobalAlloc", "uint", 2, Ptr, 40+NumGet(oi, off1, "UInt"), Ptr)
	pdib := DllCall("GlobalLock", Ptr, hdib, Ptr)
	DllCall("RtlMoveMemory", Ptr, pdib, Ptr, &oi+off2, Ptr, 40)
	DllCall("RtlMoveMemory", Ptr, pdib+40, Ptr, NumGet(oi, off2 - (A_PtrSize ? A_PtrSize : 4), Ptr), Ptr, NumGet(oi, off1, "UInt"))
	DllCall("GlobalUnlock", Ptr, hdib)
	DllCall("DeleteObject", Ptr, hBitmap)
	DllCall("OpenClipboard", Ptr, 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "uint", 8, Ptr, hdib)
	DllCall("CloseClipboard")
}

;#####################################################################################

Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format:=0x26200A)
{
	DllCall("gdiplus\GdipCloneBitmapArea"
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "int", Format
					, A_PtrSize ? "UPtr" : "UInt", pBitmap
					, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
	return pBitmapDest
}

;#####################################################################################
; Create resources
;#####################################################################################

Gdip_CreatePen(ARGB, w)
{
	DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}

;#####################################################################################

Gdip_CreatePenFromBrush(pBrush, w)
{
	pPen := ""

	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}

;#####################################################################################

Gdip_BrushCreateSolid(ARGB:=0xff000000)
{
	pBrush := ""

	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}

;#####################################################################################

; HatchStyleHorizontal = 0
; HatchStyleVertical = 1
; HatchStyleForwardDiagonal = 2
; HatchStyleBackwardDiagonal = 3
; HatchStyleCross = 4
; HatchStyleDiagonalCross = 5
; HatchStyle05Percent = 6
; HatchStyle10Percent = 7
; HatchStyle20Percent = 8
; HatchStyle25Percent = 9
; HatchStyle30Percent = 10
; HatchStyle40Percent = 11
; HatchStyle50Percent = 12
; HatchStyle60Percent = 13
; HatchStyle70Percent = 14
; HatchStyle75Percent = 15
; HatchStyle80Percent = 16
; HatchStyle90Percent = 17
; HatchStyleLightDownwardDiagonal = 18
; HatchStyleLightUpwardDiagonal = 19
; HatchStyleDarkDownwardDiagonal = 20
; HatchStyleDarkUpwardDiagonal = 21
; HatchStyleWideDownwardDiagonal = 22
; HatchStyleWideUpwardDiagonal = 23
; HatchStyleLightVertical = 24
; HatchStyleLightHorizontal = 25
; HatchStyleNarrowVertical = 26
; HatchStyleNarrowHorizontal = 27
; HatchStyleDarkVertical = 28
; HatchStyleDarkHorizontal = 29
; HatchStyleDashedDownwardDiagonal = 30
; HatchStyleDashedUpwardDiagonal = 31
; HatchStyleDashedHorizontal = 32
; HatchStyleDashedVertical = 33
; HatchStyleSmallConfetti = 34
; HatchStyleLargeConfetti = 35
; HatchStyleZigZag = 36
; HatchStyleWave = 37
; HatchStyleDiagonalBrick = 38
; HatchStyleHorizontalBrick = 39
; HatchStyleWeave = 40
; HatchStylePlaid = 41
; HatchStyleDivot = 42
; HatchStyleDottedGrid = 43
; HatchStyleDottedDiamond = 44
; HatchStyleShingle = 45
; HatchStyleTrellis = 46
; HatchStyleSphere = 47
; HatchStyleSmallGrid = 48
; HatchStyleSmallCheckerBoard = 49
; HatchStyleLargeCheckerBoard = 50
; HatchStyleOutlinedDiamond = 51
; HatchStyleSolidDiamond = 52
; HatchStyleTotal = 53
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle:=0)
{
	pBrush := ""

	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}

;#####################################################################################

Gdip_CreateTextureBrush(pBitmap, WrapMode:=1, x:=0, y:=0, w:="", h:="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"

	if !(w && h)
		DllCall("gdiplus\GdipCreateTexture", Ptr, pBitmap, "int", WrapMode, PtrA, pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture2", Ptr, pBitmap, "int", WrapMode, "float", x, "float", y, "float", w, "float", h, PtrA, pBrush)
	return pBrush
}

;#####################################################################################

; WrapModeTile = 0
; WrapModeTileFlipX = 1
; WrapModeTileFlipY = 2
; WrapModeTileFlipXY = 3
; WrapModeClamp = 4
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode:=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

; LinearGradientModeHorizontal = 0
; LinearGradientModeVertical = 1
; LinearGradientModeForwardDiagonal = 2
; LinearGradientModeBackwardDiagonal = 3
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode:=1, WrapMode:=1)
{
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

Gdip_CloneBrush(pBrush)
{
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}

;#####################################################################################
; Delete resources
;#####################################################################################

Gdip_DeletePen(pPen)
{
	return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}

;#####################################################################################

Gdip_DeleteBrush(pBrush)
{
	return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}

;#####################################################################################

Gdip_DisposeImage(pBitmap)
{
	return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}

;#####################################################################################

Gdip_DeleteGraphics(pGraphics)
{
	return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

;#####################################################################################

Gdip_DisposeImageAttributes(ImageAttr)
{
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}

;#####################################################################################

Gdip_DeleteFont(hFont)
{
	return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}

;#####################################################################################

Gdip_DeleteStringFormat(hFormat)
{
	return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}

;#####################################################################################

Gdip_DeleteFontFamily(hFamily)
{
	return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}

;#####################################################################################

Gdip_DeleteMatrix(Matrix)
{
	return DllCall("gdiplus\GdipDeleteMatrix", A_PtrSize ? "UPtr" : "UInt", Matrix)
}

;#####################################################################################
; Text functions
;#####################################################################################

Gdip_TextToGraphics(pGraphics, Text, Options, Font:="Arial", Width:="", Height:="", Measure:=0)
{
	IWidth := Width, IHeight:= Height

	pattern_opts := (A_AhkVersion < "2") ? "iO)" : "i)"
	RegExMatch(Options, pattern_opts "X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, pattern_opts "Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, pattern_opts "W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, pattern_opts "H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, pattern_opts "C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, pattern_opts "Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, pattern_opts "NoWrap", NoWrap)
	RegExMatch(Options, pattern_opts "R(\d)", Rendering)
	RegExMatch(Options, pattern_opts "S(\d+)(p*)", Size)

	if Colour && !Gdip_DeleteBrush(Gdip_CloneBrush(Colour[2]))
		PassBrush := 1, pBrush := Colour[2]

	if !(IWidth && IHeight) && ((xpos && xpos[2]) || (ypos && ypos[2]) || (Width && Width[2]) || (Height && Height[2]) || (Size && Size[2]))
		return -1

	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	For eachStyle, valStyle in StrSplit( Styles, "|" )
	{
		if RegExMatch(Options, "\b" valStyle)
			Style |= (valStyle != "StrikeOut") ? (A_Index-1) : 8
	}

	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	For eachAlignment, valAlignment in StrSplit( Alignments, "|" )
	{
		if RegExMatch(Options, "\b" valAlignment)
			Align |= A_Index//2.1	; 0|0|1|1|2|2
	}

	xpos := (xpos && (xpos[1] != "")) ? xpos[2] ? IWidth*(xpos[1]/100) : xpos[1] : 0
	ypos := (ypos && (ypos[1] != "")) ? ypos[2] ? IHeight*(ypos[1]/100) : ypos[1] : 0
	Width := (Width && Width[1]) ? Width[2] ? IWidth*(Width[1]/100) : Width[1] : IWidth
	Height := (Height && Height[1]) ? Height[2] ? IHeight*(Height[1]/100) : Height[1] : IHeight
	if !PassBrush
		Colour := "0x" (Colour && Colour[2] ? Colour[2] : "ff000000")
	Rendering := (Rendering && (Rendering[1] >= 0) && (Rendering[1] <= 5)) ? Rendering[1] : 4
	Size := (Size && (Size[1] > 0)) ? Size[2] ? IHeight*(Size[1]/100) : Size[1] : 12

	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0

	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

	if vPos
	{
		ReturnRC := StrSplit(ReturnRC, "|")

		if (vPos[0] = "vCentre") || (vPos[0] = "vCenter")
			ypos += (Height-ReturnRC[4])//2
		else if (vPos[0] = "Top") || (vPos[0] = "Up")
			ypos := 0
		else if (vPos[0] = "Bottom") || (vPos[0] = "Down")
			ypos := Height-ReturnRC[4]

		CreateRectF(RC, xpos, ypos, Width, ReturnRC[4])
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}

	if !Measure
		_E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return _E ? _E : ReturnRC
}

;#####################################################################################

Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}

	return DllCall("gdiplus\GdipDrawString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, pBrush)
}

;#####################################################################################

Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}

	DllCall("gdiplus\GdipMeasureString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, &RC
					, "uint*", Chars
					, "uint*", Lines)

	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}

; Near = 0
; Center = 1
; Far = 2
Gdip_SetStringFormatAlign(hFormat, Align)
{
	return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}

; StringFormatFlagsDirectionRightToLeft    = 0x00000001
; StringFormatFlagsDirectionVertical       = 0x00000002
; StringFormatFlagsNoFitBlackBox           = 0x00000004
; StringFormatFlagsDisplayFormatControl    = 0x00000020
; StringFormatFlagsNoFontFallback          = 0x00000400
; StringFormatFlagsMeasureTrailingSpaces   = 0x00000800
; StringFormatFlagsNoWrap                  = 0x00001000
; StringFormatFlagsLineLimit               = 0x00002000
; StringFormatFlagsNoClip                  = 0x00004000
Gdip_StringFormatCreate(Format:=0, Lang:=0)
{
	DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
	return hFormat
}

; Regular = 0
; Bold = 1
; Italic = 2
; BoldItalic = 3
; Underline = 4
; Strikeout = 8
Gdip_FontCreate(hFamily, Size, Style:=0)
{
	DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
	return hFont
}

Gdip_FontFamilyCreate(Font)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}

	DllCall("gdiplus\GdipCreateFontFamilyFromName"
					, Ptr, A_IsUnicode ? &Font : &wFont
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "UInt*", hFamily)

	return hFamily
}

;#####################################################################################
; Matrix functions
;#####################################################################################

Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
{
	DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, A_PtrSize ? "UPtr*" : "UInt*", Matrix)
	return Matrix
}

Gdip_CreateMatrix()
{
	DllCall("gdiplus\GdipCreateMatrix", A_PtrSize ? "UPtr*" : "UInt*", Matrix)
	return Matrix
}

;#####################################################################################
; GraphicsPath functions
;#####################################################################################

; Alternate = 0
; Winding = 1
Gdip_CreatePath(BrushMode:=0)
{
	DllCall("gdiplus\GdipCreatePath", "int", BrushMode, A_PtrSize ? "UPtr*" : "UInt*", pPath)
	return pPath
}

Gdip_AddPathEllipse(pPath, x, y, w, h)
{
	return DllCall("gdiplus\GdipAddPathEllipse", A_PtrSize ? "UPtr" : "UInt", pPath, "float", x, "float", y, "float", w, "float", h)
}

Gdip_AddPathPolygon(pPath, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	Points := StrSplit(Points, "|")
	VarSetCapacity(PointF, 8*Points.Length())
	for eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}

	return DllCall("gdiplus\GdipAddPathPolygon", Ptr, pPath, Ptr, &PointF, "int", Points.Length())
}

Gdip_DeletePath(pPath)
{
	return DllCall("gdiplus\GdipDeletePath", A_PtrSize ? "UPtr" : "UInt", pPath)
}

;#####################################################################################
; Quality functions
;#####################################################################################

; SystemDefault = 0
; SingleBitPerPixelGridFit = 1
; SingleBitPerPixel = 2
; AntiAliasGridFit = 3
; AntiAlias = 4
Gdip_SetTextRenderingHint(pGraphics, RenderingHint)
{
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}

; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
	return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
}

; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
	return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}

; CompositingModeSourceOver = 0 (blended)
; CompositingModeSourceCopy = 1 (overwrite)
Gdip_SetCompositingMode(pGraphics, CompositingMode:=0)
{
	return DllCall("gdiplus\GdipSetCompositingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", CompositingMode)
}

;#####################################################################################
; Extra functions
;#####################################################################################

Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	pToken := 0

	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}

; Prepend = 0; The new operation is applied before the old operation.
; Append = 1; The new operation is applied after the old operation.
Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder:=0)
{
	return DllCall("gdiplus\GdipRotateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", Angle, "int", MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder:=0)
{
	return DllCall("gdiplus\GdipScaleWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder:=0)
{
	return DllCall("gdiplus\GdipTranslateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return DllCall("gdiplus\GdipResetWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation)
{
	pi := 3.14159, TAngle := Angle*(pi/180)

	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
	if ((Bound >= 0) && (Bound <= 90))
		xTranslation := Height*Sin(TAngle), yTranslation := 0
	else if ((Bound > 90) && (Bound <= 180))
		xTranslation := (Height*Sin(TAngle))-(Width*Cos(TAngle)), yTranslation := -Height*Cos(TAngle)
	else if ((Bound > 180) && (Bound <= 270))
		xTranslation := -(Width*Cos(TAngle)), yTranslation := -(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else if ((Bound > 270) && (Bound <= 360))
		xTranslation := 0, yTranslation := -Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight)
{
	pi := 3.14159, TAngle := Angle*(pi/180)
	if !(Width && Height)
		return -1
	RWidth := Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight := Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}

; RotateNoneFlipNone   = 0
; Rotate90FlipNone     = 1
; Rotate180FlipNone    = 2
; Rotate270FlipNone    = 3
; RotateNoneFlipX      = 4
; Rotate90FlipX        = 5
; Rotate180FlipX       = 6
; Rotate270FlipX       = 7
; RotateNoneFlipY      = Rotate180FlipX
; Rotate90FlipY        = Rotate270FlipX
; Rotate180FlipY       = RotateNoneFlipX
; Rotate270FlipY       = Rotate90FlipX
; RotateNoneFlipXY     = Rotate180FlipNone
; Rotate90FlipXY       = Rotate270FlipNone
; Rotate180FlipXY      = RotateNoneFlipNone
; Rotate270FlipXY      = Rotate90FlipNone

Gdip_ImageRotateFlip(pBitmap, RotateFlipType:=1)
{
	return DllCall("gdiplus\GdipImageRotateFlip", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", RotateFlipType)
}

; Replace = 0
; Intersect = 1
; Union = 2
; Xor = 3
; Exclude = 4
; Complement = 5
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode:=0)
{
	return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}

Gdip_SetClipPath(pGraphics, pPath, CombineMode:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, pPath, "int", CombineMode)
}

Gdip_ResetClip(pGraphics)
{
	return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt", Region)
	return Region
}

Gdip_SetClipRegion(pGraphics, Region, CombineMode:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}

Gdip_CreateRegion()
{
	DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
	return Region
}

Gdip_DeleteRegion(Region)
{
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}

;#####################################################################################
; BitmapLockBits
;#####################################################################################

Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode := 3, PixelFormat := 0x26200a)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	CreateRect(_Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4), 0)
	_E := DllCall("Gdiplus\GdipBitmapLockBits", Ptr, pBitmap, Ptr, &_Rect, "uint", LockMode, "int", PixelFormat, Ptr, &BitmapData)
	Stride := NumGet(BitmapData, 8, "Int")
	Scan0 := NumGet(BitmapData, 16, Ptr)
	return _E
}

;#####################################################################################

Gdip_UnlockBits(pBitmap, ByRef BitmapData)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("Gdiplus\GdipBitmapUnlockBits", Ptr, pBitmap, Ptr, &BitmapData)
}

;#####################################################################################

Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
{
	Numput(ARGB, Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan0, x, y, Stride)
{
	return NumGet(Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize)
{
	static PixelateBitmap

	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (!PixelateBitmap)
	{
		if A_PtrSize != 8 ; x86 machine code
		MCode_PixelateBitmap := "
		(LTrim Join
		558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
		397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
		8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
		4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
		C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
		8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
		148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
		B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
		F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
		038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
		1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
		FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
		D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
		45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
		89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
		0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
		75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
		8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
		B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
		451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
		75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
		8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
		)"
		else ; x64 machine code
		MCode_PixelateBitmap := "
		(LTrim Join
		4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
		448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
		4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
		C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
		24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
		004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
		0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
		DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
		024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
		99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
		8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
		4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
		000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
		ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
		4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
		99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
		8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
		2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
		FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
		83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
		F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
		0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
		413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
		)"

		VarSetCapacity(PixelateBitmap, StrLen(MCode_PixelateBitmap)//2)
		nCount := StrLen(MCode_PixelateBitmap)//2
		N := (A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
			NumPut("0x" SubStr(MCode_PixelateBitmap, (2*A_Index)-1, 2), PixelateBitmap, A_Index-1, "UChar")
		DllCall("VirtualProtect", Ptr, &PixelateBitmap, Ptr, VarSetCapacity(PixelateBitmap), "uint", 0x40, A_PtrSize ? "UPtr*" : "UInt*", 0)
	}

	Gdip_GetImageDimensions(pBitmap, Width, Height)

	if (Width != Gdip_GetImageWidth(pBitmapOut) || Height != Gdip_GetImageHeight(pBitmapOut))
		return -1
	if (BlockSize > Width || BlockSize > Height)
		return -2

	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)
	if (E1 || E2)
		return -3

	; E := - unused exit code
	DllCall(&PixelateBitmap, Ptr, Scan01, Ptr, Scan02, "int", Width, "int", Height, "int", Stride1, "int", BlockSize)

	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
	return 0
}

;#####################################################################################

Gdip_ToARGB(A, R, G, B)
{
	return (A << 24) | (R << 16) | (G << 8) | B
}

;#####################################################################################

Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B)
{
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return (0xff000000 & ARGB) >> 24
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return (0x00ff0000 & ARGB) >> 16
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return (0x0000ff00 & ARGB) >> 8
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return 0x000000ff & ARGB
}

;#####################################################################################

StrGetB(Address, Length:=-1, Encoding:=0)
{
	; Flexible parameter handling:
	if !IsInteger(Length)
		Encoding := Length,  Length := -1

	; Check for obvious errors.
	if (Address+0 < 1024)
		return

	; Ensure 'Encoding' contains a numeric identifier.
	if (Encoding = "UTF-16")
		Encoding := 1200
	else if (Encoding = "UTF-8")
		Encoding := 65001
	else if SubStr(Encoding,1,2)="CP"
		Encoding := SubStr(Encoding,3)

	if !Encoding ; "" or 0
	{
		; No conversion necessary, but we might not want the whole string.
		if (Length == -1)
			Length := DllCall("lstrlen", "uint", Address)
		VarSetCapacity(String, Length)
		DllCall("lstrcpyn", "str", String, "uint", Address, "int", Length + 1)
	}
	else if (Encoding = 1200) ; UTF-16
	{
		char_count := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "uint", 0, "uint", 0, "uint", 0, "uint", 0)
		VarSetCapacity(String, char_count)
		DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "str", String, "int", char_count, "uint", 0, "uint", 0)
	}
	else if IsInteger(Encoding)
	{
		; Convert from target encoding to UTF-16 then to the active code page.
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", 0, "int", 0)
		VarSetCapacity(String, char_count * 2)
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", &String, "int", char_count * 2)
		String := StrGetB(&String, char_count, 1200)
	}

	return String
}


;#####################################################################################
; in AHK v1: uses normal 'if var is' command
; in AHK v2: all if's are expression-if, so the Integer variable is dereferenced to the string
;#####################################################################################
IsInteger(Var) {
	Static Integer := "Integer"
	If Var Is Integer
		Return True
	Return False
}

IsNumber(Var) {
	Static number := "number"
	If Var Is number
		Return True
	Return False
}



; ======================================================================================================================
; Multiple Display Monitors Functions -> msdn.microsoft.com/en-us/library/dd145072(v=vs.85).aspx
; by 'just me'
; https://autohotkey.com/boards/viewtopic.php?f=6&t=4606
; ======================================================================================================================
GetMonitorCount()
{
	Monitors := MDMF_Enum()
	for k,v in Monitors
		count := A_Index
	return count
}

GetMonitorInfo(MonitorNum)
{
	Monitors := MDMF_Enum()
	for k,v in Monitors
		if (v.Num = MonitorNum)
			return v
}

GetPrimaryMonitor()
{
	Monitors := MDMF_Enum()
	for k,v in Monitors
		If (v.Primary)
			return v.Num
}
; ======================================================================================================================
; Enumerates display monitors and returns an object containing the properties of all monitors or the specified monitor.
; ======================================================================================================================
MDMF_Enum(HMON := "") {
	Static CbFunc := (A_AhkVersion < "2") ? Func("RegisterCallback") : Func("CallbackCreate")
	Static EnumProc := %CbFunc%("MDMF_EnumProc") 
	Static Monitors := {}
	If (HMON = "") ; new enumeration
		Monitors := {}
	If (Monitors.MaxIndex() = "") ; enumerate
		If !DllCall("User32.dll\EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", EnumProc, "Ptr", &Monitors, "UInt")
			Return False
	Return (HMON = "") ? Monitors : Monitors.HasKey(HMON) ? Monitors[HMON] : False
}
; ======================================================================================================================
;  Callback function that is called by the MDMF_Enum function.
; ======================================================================================================================
MDMF_EnumProc(HMON, HDC, PRECT, ObjectAddr) {
	Monitors := Object(ObjectAddr)
	Monitors[HMON] := MDMF_GetInfo(HMON)
	Return True
}
; ======================================================================================================================
;  Retrieves the display monitor that has the largest area of intersection with a specified window.
; ======================================================================================================================
MDMF_FromHWND(HWND) {
	Return DllCall("User32.dll\MonitorFromWindow", "Ptr", HWND, "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves the display monitor that contains a specified point.
; If either X or Y is empty, the function will use the current cursor position for this value.
; ======================================================================================================================
MDMF_FromPoint(X := "", Y := "") {
	VarSetCapacity(PT, 8, 0)
	If (X = "") || (Y = "") {
		DllCall("User32.dll\GetCursorPos", "Ptr", &PT)
		If (X = "")
			X := NumGet(PT, 0, "Int")
		If (Y = "")
			Y := NumGet(PT, 4, "Int")
	}
	Return DllCall("User32.dll\MonitorFromPoint", "Int64", (X & 0xFFFFFFFF) | (Y << 32), "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves the display monitor that has the largest area of intersection with a specified rectangle.
; Parameters are consistent with the common AHK definition of a rectangle, which is X, Y, W, H instead of
; Left, Top, Right, Bottom.
; ======================================================================================================================
MDMF_FromRect(X, Y, W, H) {
	VarSetCapacity(RC, 16, 0)
	NumPut(X, RC, 0, "Int"), NumPut(Y, RC, 4, Int), NumPut(X + W, RC, 8, "Int"), NumPut(Y + H, RC, 12, "Int")
	Return DllCall("User32.dll\MonitorFromRect", "Ptr", &RC, "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves information about a display monitor.
; ======================================================================================================================
MDMF_GetInfo(HMON) {
	NumPut(VarSetCapacity(MIEX, 40 + (32 << !!A_IsUnicode)), MIEX, 0, "UInt")
	If DllCall("User32.dll\GetMonitorInfo", "Ptr", HMON, "Ptr", &MIEX) {
		MonName := StrGet(&MIEX + 40, 32)	; CCHDEVICENAME = 32
		MonNum := RegExReplace(MonName, ".*(\d+)$", "$1")
		Return {	Name:		(Name := StrGet(&MIEX + 40, 32))
				,	Num:		RegExReplace(Name, ".*(\d+)$", "$1")
				,	Left:		NumGet(MIEX, 4, "Int")		; display rectangle
				,	Top:		NumGet(MIEX, 8, "Int")		; "
				,	Right:		NumGet(MIEX, 12, "Int")		; "
				,	Bottom:		NumGet(MIEX, 16, "Int")		; "
				,	WALeft:		NumGet(MIEX, 20, "Int")		; work area
				,	WATop:		NumGet(MIEX, 24, "Int")		; "
				,	WARight:	NumGet(MIEX, 28, "Int")		; "
				,	WABottom:	NumGet(MIEX, 32, "Int")		; "
				,	Primary:	NumGet(MIEX, 36, "UInt")}	; contains a non-zero value for the primary monitor.
	}
	Return False
}





---------- Lib Subtitle.render ----------











class Subtitle {

   layers := {}, ScreenWidth := A_ScreenWidth, ScreenHeight := A_ScreenHeight

   __New(title := "") {
      global pToken
      if !(this.outer.Startup())
         if !(pToken)
            if !(this.pToken := Gdip_Startup())
               throw Exception("Gdiplus failed to start. Please ensure you have gdiplus on your system.")

      Gui, New, +LastFound +AlwaysOnTop -Caption -DPIScale +E0x80000 +ToolWindow +hwndhwnd
      this.hwnd := hwnd
      this.title := (title != "") ? title : "Subtitle_" this.hwnd
      DllCall("ShowWindow", "ptr",this.hwnd, "int",8)
      DllCall("SetWindowText", "ptr",this.hwnd, "str",this.title)
      this.hbm := CreateDIBSection(this.ScreenWidth, this.ScreenHeight)
      this.hdc := CreateCompatibleDC()
      this.obm := SelectObject(this.hdc, this.hbm)
      this.G := Gdip_GraphicsFromHDC(this.hdc)
      return this
   }

   __Delete() {
      global pToken
      if (this.outer.pToken)
         return this.outer.Shutdown()
      if (pToken)
         return
      if (this.pToken)
         return Gdip_Shutdown(this.pToken)
   }

   FreeMemory() {
      SelectObject(this.hdc, this.obm)
      DeleteObject(this.hbm)
      DeleteDC(this.hdc)
      Gdip_DeleteGraphics(this.G)
      return this
   }

   Destroy() {
      this.FreeMemory()
      DllCall("DestroyWindow", "ptr",this.hwnd)
      return this
   }

   Hide() {
      DllCall("ShowWindow", "ptr",this.hwnd, "int",0)
      return this
   }

   Show(i := 8) {
      DllCall("ShowWindow", "ptr",this.hwnd, "int",i)
      return this
   }

   ToggleVisible() {
      return (this.isVisible()) ? this.Hide() : this.Show()
   }

   isVisible() {
      return DllCall("IsWindowVisible", "ptr",this.hwnd)
   }

   AlwaysOnTop() {
      WinSet, AlwaysOnTop, Toggle, % "ahk_id" this.hwnd
      return this
   }

   Bottom() {
      WinSet, Bottom,, % "ahk_id" this.hwnd
      return this
   }

   ClickThrough() {
      _dhw := A_DetectHiddenWindows
      DetectHiddenWindows On
      WinGet, ExStyle, ExStyle, % "ahk_id" this.hwnd
      if (ExStyle & 0x20)
         WinSet, ExStyle, -0x20, % "ahk_id" this.hwnd
      else
         WinSet, ExStyle, +0x20, % "ahk_id" this.hwnd
      DetectHiddenWindows %_dhw%
      return this
   }

   Desktop() {
      ; Based on: https://www.codeproject.com/Articles/856020/Draw-Behind-Desktop-Icons-in-Windows-plus?msg=5478543#xx5478543xx
      DllCall("SendMessage", "ptr",WinExist("ahk_class Progman"), "uint",0x052C, "ptr",0x0000000D, "ptr",0)
      DllCall("SendMessage", "ptr",WinExist("ahk_class Progman"), "uint",0x052C, "ptr",0x0000000D, "ptr",1) ; Post-Creator's Update Windows 10.
      WinGet, windows, List, ahk_class WorkerW
      Loop, %windows%
         if (DllCall("FindWindowEx", "ptr",windows%A_Index%, "ptr",0, "str","SHELLDLL_DefView", "ptr",0) != 0)
            WorkerW := DllCall("FindWindowEx", "ptr",0, "ptr",windows%A_Index%, "str","WorkerW", "ptr",0)

      if (WorkerW) {
         this.Destroy()
         this.hwnd := WorkerW
         DllCall("SetWindowPos", "uint",WorkerW, "uint",1, "int",0, "int",0, "int",this.ScreenWidth, "int",this.ScreenHeight, "uint",0)
         this.base.FreeMemory := ObjBindMethod(this, "DesktopFreeMemory")
         this.base.Destroy := ObjBindMethod(this, "DesktopDestroy")
         this.hdc := DllCall("GetDCEx", "ptr",WorkerW, "ptr",0, "int",0x403)
         this.G := Gdip_GraphicsFromHDC(this.hdc)
      }
      return this
   }

   DesktopFreeMemory() {
      ReleaseDC(this.hdc)
      Gdip_DeleteGraphics(this.G)
      return this
   }

   DesktopDestroy() {
      this.FreeMemory()
      DllCall("SendMessage", "ptr",WinExist("ahk_class Progman"), "uint",0x052C, "ptr",0x0000000D, "ptr",0)
      DllCall("SendMessage", "ptr",WinExist("ahk_class Progman"), "uint",0x052C, "ptr",0x0000000D, "ptr",1)
      return this
   }

   Normal() {
      WinSet, AlwaysOnTop, Off, % "ahk_id" this.hwnd
      return this
   }

   DetectScreenResolutionChange(width := "", height := "") {
      width := (width) ? width : A_ScreenWidth
      height := (height) ? height : A_ScreenHeight
      if (width != this.ScreenWidth || height != this.ScreenHeight) {
         this.ScreenWidth := width, this.ScreenHeight := height
         SelectObject(this.hdc, this.obm)
         DeleteObject(this.hbm)
         DeleteDC(this.hdc)
         Gdip_DeleteGraphics(this.G)
         this.hbm := CreateDIBSection(this.ScreenWidth, this.ScreenHeight)
         this.hdc := CreateCompatibleDC()
         this.obm := SelectObject(this.hdc, this.hbm)
         this.G := Gdip_GraphicsFromHDC(this.hdc)
         loop % this.layers.maxIndex()
            this.Draw(this.layers[A_Index].1, this.layers[A_Index].2, this.layers[A_Index].3, pGraphics)
      }
   }

   Bitmap(x := "", y := "", w := "", h := "") {
      x := (x != "") ? x : this.x
      y := (y != "") ? y : this.y
      w := (w != "") ? w : this.xx - this.x
      h := (h != "") ? h : this.yy - this.y

      pBitmap := Gdip_CreateBitmap(this.ScreenWidth, this.ScreenHeight)
      pGraphics := Gdip_GraphicsFromImage(pBitmap)
      loop % this.layers.maxIndex()
         this.Draw(this.layers[A_Index].1, this.layers[A_Index].2, this.layers[A_Index].3, pGraphics)
      Gdip_DeleteGraphics(pGraphics)
      pBitmapCopy := Gdip_CloneBitmapArea(pBitmap, x, y, w, h)
      Gdip_DisposeImage(pBitmap)
      return pBitmapCopy ; Please dispose of this image responsibly.
   }

   hBitmap(alpha := 0xFFFFFFFF) {
      ; hBitmap converts alpha channel to specified alpha color.
      ; Adds 1 pixel because Anti-Alias (SmoothingMode = 4)
      ; Should it be crop 1 pixel instead?
      pBitmap := this.Bitmap()
      hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap, alpha)
      Gdip_DisposeImage(pBitmap)
      return hBitmap
   }

   Save(filename := "", quality := 92) {
      filename := (filename ~= "i)\.(bmp|dib|rle|jpg|jpeg|jpe|jfif|gif|tif|tiff|png)$") ? filename
               : (filename != "") ? filename ".png" : this.title ".png"
      pBitmap := this.Bitmap()
      Gdip_SaveBitmapToFile(pBitmap, filename, quality)
      Gdip_DisposeImage(pBitmap)
      return this
   }

   Screenshot(filename := "", quality := 92) {
      filename := (filename ~= "i)\.(bmp|dib|rle|jpg|jpeg|jpe|jfif|gif|tif|tiff|png)$") ? filename
               : (filename != "") ? filename ".png" : this.title ".png"
      pBitmap := Gdip_BitmapFromScreen(this.x "|" this.y "|" this.xx - this.x "|" this.yy - this.y)
      Gdip_SaveBitmapToFile(pBitmap, filename, quality)
      Gdip_DisposeImage(pBitmap)
      return this
   }

   Render(text := "", style1 := "", style2 := "", update := true) {
      if !(this.hwnd){
         _subtitle := (this.outer) ? new this.outer.Subtitle() : new Subtitle()
         return _subtitle.Render(text, style1, style2, update)
      }
      else {
         Critical On
         this.Draw(text, style1, style2)
         this.DetectScreenResolutionChange()
         if (this.allowDrag == true)
            this.Reposition()
         if (update == true) {
            UpdateLayeredWindow(this.hwnd, this.hdc, 0, 0, this.ScreenWidth, this.ScreenHeight)
         }
         if (this.time) {
            self_destruct := ObjBindMethod(this, "Destroy")
            SetTimer, % self_destruct, % -1 * this.time
         }
         this.rendered := true
         Critical Off
         return this
      }
   }

   RenderToBitmap(text := "", style1 := "", style2 := "") {
      if !(this.hwnd){
         _subtitle := (this.outer) ? new this.outer.Subtitle() : new Subtitle()
         return _subtitle.RenderToBitmap(text, style1, style2)
      } else {
         this.Render(text, style1, style2, false)
         return this.Bitmap()
      }
   }

   RenderToHBitmap(text := "", style1 := "", style2 := "") {
      if !(this.hwnd){
         _subtitle := (this.outer) ? new this.outer.Subtitle() : new Subtitle()
         return _subtitle.RenderToHBitmap(text, style1, style2)
      } else {
         this.Render(text, style1, style2, false)
         return this.hBitmap()
      }
   }

   Reposition() {
      CoordMode, Mouse, Screen
      MouseGetPos, x_mouse, y_mouse
      this.LButton := GetKeyState("LButton", "P") ? 1 : 0
      this.keypress := (this.LButton && DllCall("GetForegroundWindow") == this.hwnd) ? ((!this.keypress) ? 1 : -1) : ((this.keypress == -1) ? 2 : 0)

      if (this.keypress == 1) {
         this.x_mouse := x_mouse, this.y_mouse := y_mouse
         this.hbm2 := CreateDIBSection(A_ScreenWidth, A_ScreenHeight)
         this.hdc2 := CreateCompatibleDC()
         this.obm2 := SelectObject(this.hdc2, this.hbm2)
         this.G2 := Gdip_GraphicsFromHDC(this.hdc2)
      }

      if (this.keypress == -1) {
         dx := x_mouse - this.x_mouse
         dy := y_mouse - this.y_mouse
         safe_x := (0 + dx <= 0) ? 0 : 0 + dx
         safe_y := (0 + dy <= 0) ? 0 : 0 + dy
         safe_w := (0 + this.ScreenWidth + dx >= this.ScreenWidth) ? this.ScreenWidth : 0 + this.ScreenWidth + dx
         safe_h := (0 + this.ScreenHeight + dy >= this.ScreenHeight) ? this.ScreenHeight : 0 + this.ScreenHeight + dy
         source_x := (dx < 0) ? -dx : 0
         source_y := (dy < 0) ? -dy : 0
         ;Tooltip % dx ", " dy "`n" safe_x ", " safe_y ", " safe_w ", " safe_h
         Gdip_GraphicsClear(this.G2)
         BitBlt(this.hdc2, safe_x, safe_y, safe_w, safe_h, this.hdc, source_x, source_y)
         UpdateLayeredWindow(this.hwnd, this.hdc2, 0, 0, this.ScreenWidth, this.ScreenHeight)
      }

      if (this.keypress == 2) {
         Gdip_DeleteGraphics(this.G)
         SelectObject(this.hdc, this.obm)
         DeleteObject(this.hbm)
         DeleteDC(this.hdc)
         this.hdc := this.hdc2
         this.obm := this.obm2
         this.hbm := this.hbm2
         this.G := Gdip_GraphicsFromHDC(this.hdc2)
      }

      Reposition := ObjBindMethod(this, "Reposition")
      SetTimer, % Reposition, -10
   }

   Draw(text := "", style1 := "", style2 := "", pGraphics := "") {
      ; If the image was previously rendered, reset everything like a new Subtitle object.
      if (pGraphics == "") {
         if (this.rendered == true) {
            this.rendered := false
            this.layers := {}
            this.x := this.y := this.xx := this.yy := "" ; not 0!
            Gdip_GraphicsClear(this.G)
         }
         this.layers.push([text, style1, style2]) ; Saves each call of Draw()
         pGraphics := this.G
      }

      ; Remove excess whitespace. This is required for proper RegEx detection.
      style1 := !IsObject(style1) ? RegExReplace(style1, "\s+", " ") : style1
      style2 := !IsObject(style2) ? RegExReplace(style2, "\s+", " ") : style2

      ; Load saved styles if and only if both styles are blank.
      if (style1 == "" && style2 == "")
         style1 := this.style1, style2 := this.style2
      else
         this.style1 := style1, this.style2 := style2 ; Remember styles so that they can be loaded next time.

      ; RegEx help? https://regex101.com/r/xLzZzO/2
      static q1 := "(?i)^.*?\b(?<!:|:\s)\b"
      static q2 := "(?!(?>\([^()]*\)|[^()]*)*\))(:\s*)?\(?(?<value>(?<=\()([\s:#%_a-z\-\.\d]+|\([\s:#%_a-z\-\.\d]*\))*(?=\))|[#%_a-z\-\.\d]+).*$"

      ; Extract the time variable and save it for later when we Render() everything.
      this.time := (style1.time) ? style1.time : (style1.t) ? style1.t
         : (!IsObject(style1) && (___ := RegExReplace(style1, q1 "(t(ime)?)" q2, "${value}")) != style1) ? ___
         : (style2.time) ? style2.time : (style2.t) ? style2.t
         : (!IsObject(style2) && (___ := RegExReplace(style2, q1 "(t(ime)?)" q2, "${value}")) != style2) ? ___
         : this.time

      ; Extract styles from the background styles parameter.
      if IsObject(style1) {
         _a  := (style1.anchor != "")   ? style1.anchor   : style1.a
         _x  := (style1.left != "")     ? style1.left     : style1.x
         _y  := (style1.top != "")      ? style1.top      : style1.y
         _w  := (style1.width != "")    ? style1.width    : style1.w
         _h  := (style1.height != "")   ? style1.height   : style1.h
         _r  := (style1.radius != "")   ? style1.radius   : style1.r
         _c  := (style1.color != "")    ? style1.color    : style1.c
         _m  := (style1.margin != "")   ? style1.margin   : style1.m
         _p  := (style1.padding != "")  ? style1.padding  : style1.p
         _q  := (style1.quality != "")  ? style1.quality  : (style1.q) ? style1.q : style1.SmoothingMode
      } else {
         _a  := ((___ := RegExReplace(style1, q1    "(a(nchor)?)"        q2, "${value}")) != style1) ? ___ : ""
         _x  := ((___ := RegExReplace(style1, q1    "(x|left)"           q2, "${value}")) != style1) ? ___ : ""
         _y  := ((___ := RegExReplace(style1, q1    "(y|top)"            q2, "${value}")) != style1) ? ___ : ""
         _w  := ((___ := RegExReplace(style1, q1    "(w(idth)?)"         q2, "${value}")) != style1) ? ___ : ""
         _h  := ((___ := RegExReplace(style1, q1    "(h(eight)?)"        q2, "${value}")) != style1) ? ___ : ""
         _r  := ((___ := RegExReplace(style1, q1    "(r(adius)?)"        q2, "${value}")) != style1) ? ___ : ""
         _c  := ((___ := RegExReplace(style1, q1    "(c(olor)?)"         q2, "${value}")) != style1) ? ___ : ""
         _m  := ((___ := RegExReplace(style1, q1    "(m(argin)?)"        q2, "${value}")) != style1) ? ___ : ""
         _p  := ((___ := RegExReplace(style1, q1    "(p(adding)?)"       q2, "${value}")) != style1) ? ___ : ""
         _q  := ((___ := RegExReplace(style1, q1    "(q(uality)?)"       q2, "${value}")) != style1) ? ___ : ""
      }

      ; Extract styles from the text styles parameter.
      if IsObject(style2) {
         a  := (style2.anchor != "")      ? style2.anchor      : style2.a
         x  := (style2.left != "")        ? style2.left        : style2.x
         y  := (style2.top != "")         ? style2.top         : style2.y
         w  := (style2.width != "")       ? style2.width       : style2.w
         h  := (style2.height != "")      ? style2.height      : style2.h
         m  := (style2.margin != "")      ? style2.margin      : style2.m
         f  := (style2.font != "")        ? style2.font        : style2.f
         s  := (style2.size != "")        ? style2.size        : style2.s
         c  := (style2.color != "")       ? style2.color       : style2.c
         b  := (style2.bold != "")        ? style2.bold        : style2.b
         i  := (style2.italic != "")      ? style2.italic      : style2.i
         u  := (style2.underline != "")   ? style2.underline   : style2.u
         j  := (style2.justify != "")     ? style2.justify     : style2.j
         n  := (style2.noWrap != "")      ? style2.noWrap      : style2.n
         z  := (style2.condensed != "")   ? style2.condensed   : style2.z
         d  := (style2.dropShadow != "")  ? style2.dropShadow  : style2.d
         o  := (style2.outline != "")     ? style2.outline     : style2.o
         q  := (style2.quality != "")     ? style2.quality     : (style2.q) ? style2.q : style2.TextRenderingHint
      } else {
         a  := ((___ := RegExReplace(style2, q1    "(a(nchor)?)"        q2, "${value}")) != style2) ? ___ : ""
         x  := ((___ := RegExReplace(style2, q1    "(x|left)"           q2, "${value}")) != style2) ? ___ : ""
         y  := ((___ := RegExReplace(style2, q1    "(y|top)"            q2, "${value}")) != style2) ? ___ : ""
         w  := ((___ := RegExReplace(style2, q1    "(w(idth)?)"         q2, "${value}")) != style2) ? ___ : ""
         h  := ((___ := RegExReplace(style2, q1    "(h(eight)?)"        q2, "${value}")) != style2) ? ___ : ""
         m  := ((___ := RegExReplace(style2, q1    "(m(argin)?)"        q2, "${value}")) != style2) ? ___ : ""
         f  := ((___ := RegExReplace(style2, q1    "(f(ont)?)"          q2, "${value}")) != style2) ? ___ : ""
         s  := ((___ := RegExReplace(style2, q1    "(s(ize)?)"          q2, "${value}")) != style2) ? ___ : ""
         c  := ((___ := RegExReplace(style2, q1    "(c(olor)?)"         q2, "${value}")) != style2) ? ___ : ""
         b  := ((___ := RegExReplace(style2, q1    "(b(old)?)"          q2, "${value}")) != style2) ? ___ : ""
         i  := ((___ := RegExReplace(style2, q1    "(i(talic)?)"        q2, "${value}")) != style2) ? ___ : ""
         u  := ((___ := RegExReplace(style2, q1    "(u(nderline)?)"     q2, "${value}")) != style2) ? ___ : ""
         j  := ((___ := RegExReplace(style2, q1    "(j(ustify)?)"       q2, "${value}")) != style2) ? ___ : ""
         n  := ((___ := RegExReplace(style2, q1    "(n(oWrap)?)"        q2, "${value}")) != style2) ? ___ : ""
         z  := ((___ := RegExReplace(style2, q1    "(z|condensed)"      q2, "${value}")) != style2) ? ___ : ""
         d  := ((___ := RegExReplace(style2, q1    "(d(ropShadow)?)"    q2, "${value}")) != style2) ? ___ : ""
         o  := ((___ := RegExReplace(style2, q1    "(o(utline)?)"       q2, "${value}")) != style2) ? ___ : ""
         q  := ((___ := RegExReplace(style2, q1    "(q(uality)?)"       q2, "${value}")) != style2) ? ___ : ""
      }

      ; These are the type checkers.
      static valid := "^\s*(\-?\d+(?:\.\d*)?)\s*(%|pt|px|vh|vmin|vw)?\s*$"
      static valid_positive := "^\s*(\d+(?:\.\d*)?)\s*(%|pt|px|vh|vmin|vw)?\s*$"

      ; Define viewport width and height. This is the visible screen area.
      this.vw := 0.01 * this.ScreenWidth    ; 1% of viewport width.
      this.vh := 0.01 * this.ScreenHeight   ; 1% of viewport height.
      this.vmin := (this.vw < this.vh) ? this.vw : this.vh ; 1vw or 1vh, whichever is smaller.

      ; Get Rendering Quality.
      _q := (_q >= 0 && _q <= 4) ? _q : 4          ; Default SmoothingMode is 4 if radius is set. See Draw 1.
      q  := (q >= 0 && q <= 5) ? q : 4             ; Default TextRenderingHint is 4 (antialias).

      ; Get Font size.
      s  := (s ~= valid_positive) ? RegExReplace(s, "\s", "") : "2.23vh"           ; Default font size is 2.23vh.
      s  := (s ~= "(pt|px)$") ? SubStr(s, 1, -2) : s                               ; Strip spaces, px, and pt.
      s  := (s ~= "vh$") ? RegExReplace(s, "vh$", "") * this.vh : s                ; Relative to viewport height.
      s  := (s ~= "vw$") ? RegExReplace(s, "vw$", "") * this.vw : s                ; Relative to viewport width.
      s  := (s ~= "(%|vmin)$") ? RegExReplace(s, "(%|vmin)$", "") * this.vmin : s  ; Relative to viewport minimum.

      ; Get Bold, Italic, Underline, NoWrap, and Justification of text.
      style += (b) ? 1 : 0         ; bold
      style += (i) ? 2 : 0         ; italic
      style += (u) ? 4 : 0         ; underline
      style += (strikeout) ? 8 : 0 ; strikeout, not implemented.
      n  := (n) ? 0x4000 | 0x1000 : 0x4000
      j  := (j ~= "i)cent(er|re)") ? 1 : (j ~= "i)(far|right)") ? 2 : 0   ; Left/near, center/centre, far/right.

      ; Later when text x and w are finalized and it is found that x + ReturnRC[3] exceeds the screen,
      ; then the _redrawBecauseOfCondensedFont flag is set to true.
      if (this._redrawBecauseOfCondensedFont == true)
         f:=z, z:=0, this._redrawBecauseOfCondensedFont := false

      ; Create Font.
      hFamily := (___ := Gdip_FontFamilyCreate(f)) ? ___ : Gdip_FontFamilyCreate("Arial") ; Default font is Arial.
      hFont := Gdip_FontCreate(hFamily, s, style)
      hFormat := Gdip_StringFormatCreate(n)
      Gdip_SetStringFormatAlign(hFormat, j)  ; Left = 0, Center = 1, Right = 2

      ; Simulate string width and height. This will get the exact width and height of the text.
      CreateRectF(RC, 0, 0, 0, 0)
      Gdip_SetSmoothingMode(pGraphics, _q)     ; None = 3, AntiAlias = 4
      Gdip_SetTextRenderingHint(pGraphics, q)  ; Anti-Alias = 4, Cleartype = 5 (and gives weird effects.)
      ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
      ReturnRC := StrSplit(ReturnRC, "|")      ; Contains the values for measured x, y, w, h text.

      ; Get background width and height. Default width and height are simulated width and height.
      _w := (_w ~= valid_positive) ? RegExReplace(_w, "\s", "") : ReturnRC[3]
      _w := (_w ~= "(pt|px)$") ? SubStr(_w, 1, -2) : _w
      _w := (_w ~= "(%|vw)$") ? RegExReplace(_w, "(%|vw)$", "") * this.vw : _w
      _w := (_w ~= "vh$") ? RegExReplace(_w, "vh$", "") * this.vh : _w
      _w := (_w ~= "vmin$") ? RegExReplace(_w, "vmin$", "") * this.vmin : _w
      ; Output is a decimal with pixel units.

      _h := (_h ~= valid_positive) ? RegExReplace(_h, "\s", "") : ReturnRC[4]
      _h := (_h ~= "(pt|px)$") ? SubStr(_h, 1, -2) : _h
      _h := (_h ~= "vw$") ? RegExReplace(_h, "vw$", "") * this.vw : _h
      _h := (_h ~= "(%|vh)$") ? RegExReplace(_h, "(%|vh)$", "") * this.vh : _h
      _h := (_h ~= "vmin$") ? RegExReplace(_h, "vmin$", "") * this.vmin : _h
      ; Output is a decimal with pixel units.

      ; Get background anchor. This is where the origin of the image is located.
      ; The default origin is the top left corner. Default anchor is 1.
      _a := RegExReplace(_a, "\s", "")
      _a := (_a = "top") ? 2 : (_a = "left") ? 4 : (_a = "right") ? 6 : (_a = "bottom") ? 8
         : (_a ~= "i)top" && _a ~= "i)left") ? 1 : (_a ~= "i)top" && _a ~= "i)cent(er|re)") ? 2
         : (_a ~= "i)top" && _a ~= "i)bottom") ? 3 : (_a ~= "i)cent(er|re)" && _a ~= "i)left") ? 4
         : (_a ~= "i)cent(er|re)") ? 5 : (_a ~= "i)cent(er|re)" && _a ~= "i)bottom") ? 6
         : (_a ~= "i)bottom" && _a ~= "i)left") ? 7 : (_a ~= "i)bottom" && _a ~= "i)cent(er|re)") ? 8
         : (_a ~= "i)bottom" && _a ~= "i)right") ? 9 : (_a ~= "^[1-9]$") ? _a : 1 ; Default anchor is top-left.

      ; _x and _y can be specified as locations (left, center, right, top, bottom).
      ; These location words in _x and _y take precedence over the values in _a.
      _a  := (_x ~= "i)left") ? 1+(((_a-1)//3)*3) : (_x ~= "i)cent(er|re)") ? 2+(((_a-1)//3)*3) : (_x ~= "i)right") ? 3+(((_a-1)//3)*3) : _a
      _a  := (_y ~= "i)top") ? 1+(mod(_a-1,3)) : (_y ~= "i)cent(er|re)") ? 4+(mod(_a-1,3)) : (_y ~= "i)bottom") ? 7+(mod(_a-1,3)) : _a

      ; Convert English words to numbers. Don't mess with these values any further.
      _x  := (_x ~= "i)left") ? 0 : (_x ~= "i)cent(er|re)") ? 0.5*this.ScreenWidth : (_x ~= "i)right") ? this.ScreenWidth : _x
      _y  := (_y ~= "i)top") ? 0 : (_y ~= "i)cent(er|re)") ? 0.5*this.ScreenHeight : (_y ~= "i)bottom") ? this.ScreenHeight : _y

      ; Get _x value.
      _x := (_x ~= valid) ? RegExReplace(_x, "\s", "") : 0  ; Default _x is 0.
      _x := (_x ~= "(pt|px)$") ? SubStr(_x, 1, -2) : _x
      _x := (_x ~= "(%|vw)$") ? RegExReplace(_x, "(%|vw)$", "") * this.vw : _x
      _x := (_x ~= "vh$") ? RegExReplace(_x, "vh$", "") * this.vh : _x
      _x := (_x ~= "vmin$") ? RegExReplace(_x, "vmin$", "") * this.vmin : _x

      ; Get _y value.
      _y := (_y ~= valid) ? RegExReplace(_y, "\s", "") : 0  ; Default _y is 0.
      _y := (_y ~= "(pt|px)$") ? SubStr(_y, 1, -2) : _y
      _y := (_y ~= "vw$") ? RegExReplace(_y, "vw$", "") * this.vw : _y
      _y := (_y ~= "(%|vh)$") ? RegExReplace(_y, "(%|vh)$", "") * this.vh : _y
      _y := (_y ~= "vmin$") ? RegExReplace(_y, "vmin$", "") * this.vmin : _y

      ; Now let's modify the _x and _y values with the _anchor, so that the image has a new point of origin.
      ; We need our calculated _width and _height for this.
      _x  -= (mod(_a-1,3) == 0) ? 0 : (mod(_a-1,3) == 1) ? _w/2 : (mod(_a-1,3) == 2) ? _w : 0
      _y  -= (((_a-1)//3) == 0) ? 0 : (((_a-1)//3) == 1) ? _h/2 : (((_a-1)//3) == 2) ? _h : 0
      ; Fractional y values might cause gdi+ slowdown.


      ; Get the text width and text height.
      ; Note that there are two new lines. Matching a percent symbol (%) will give text width/height
      ; that is relative to the background width/height. This is undesirable behavior, and so
      ; the user should use "vh" and "vw" whenever possible.
      w  := ( w ~= valid_positive) ? RegExReplace( w, "\s", "") : ReturnRC[3] ; Default is simulated text width.
      w  := ( w ~= "(pt|px)$") ? SubStr( w, 1, -2) :  w
      w  := ( w ~= "vw$") ? RegExReplace( w, "vw$", "") * this.vw :  w
      w  := ( w ~= "vh$") ? RegExReplace( w, "vh$", "") * this.vh :  w
      w  := ( w ~= "vmin$") ? RegExReplace( w, "vmin$", "") * this.vmin :  w
      w  := ( w ~= "%$") ? RegExReplace( w, "%$", "") * 0.01 * _w :  w

      h  := ( h ~= valid_positive) ? RegExReplace( h, "\s", "") : ReturnRC[4] ; Default is simulated text height.
      h  := ( h ~= "(pt|px)$") ? SubStr( h, 1, -2) :  h
      h  := ( h ~= "vw$") ? RegExReplace( h, "vw$", "") * this.vw :  h
      h  := ( h ~= "vh$") ? RegExReplace( h, "vh$", "") * this.vh :  h
      h  := ( h ~= "vmin$") ? RegExReplace( h, "vmin$", "") * this.vmin :  h
      h  := ( h ~= "%$") ? RegExReplace( h, "%$", "") * 0.01 * _h :  h

      ; If text justification is set but x is not, align the justified text relative to the center
      ; or right of the backgound, after taking into account the text width.
      if (x == "")
         x  := (j = 1) ? _x + (_w/2) - (w/2) : (j = 2) ? _x + _w - w : x

      ; Get anchor.
      a  := RegExReplace( a, "\s", "")
      a  := (a = "top") ? 2 : (a = "left") ? 4 : (a = "right") ? 6 : (a = "bottom") ? 8
         : (a ~= "i)top" && a ~= "i)left") ? 1 : (a ~= "i)top" && a ~= "i)cent(er|re)") ? 2
         : (a ~= "i)top" && a ~= "i)bottom") ? 3 : (a ~= "i)cent(er|re)" && a ~= "i)left") ? 4
         : (a ~= "i)cent(er|re)") ? 5 : (a ~= "i)cent(er|re)" && a ~= "i)bottom") ? 6
         : (a ~= "i)bottom" && a ~= "i)left") ? 7 : (a ~= "i)bottom" && a ~= "i)cent(er|re)") ? 8
         : (a ~= "i)bottom" && a ~= "i)right") ? 9 : (a ~= "^[1-9]$") ? a : 1 ; Default anchor is top-left.

      ; Text x and text y can be specified as locations (left, center, right, top, bottom).
      ; These location words in text x and text y take precedence over the values in the text anchor.
      a  := ( x ~= "i)left") ? 1+((( a-1)//3)*3) : ( x ~= "i)cent(er|re)") ? 2+((( a-1)//3)*3) : ( x ~= "i)right") ? 3+((( a-1)//3)*3) :  a
      a  := ( y ~= "i)top") ? 1+(mod( a-1,3)) : ( y ~= "i)cent(er|re)") ? 4+(mod( a-1,3)) : ( y ~= "i)bottom") ? 7+(mod( a-1,3)) :  a

      ; Convert English words to numbers. Don't mess with these values any further.
      ; Also, these values are relative to the background.
      x  := ( x ~= "i)left") ? _x : (x ~= "i)cent(er|re)") ? _x + 0.5*_w : (x ~= "i)right") ? _x + _w : x
      y  := ( y ~= "i)top") ? _y : (y ~= "i)cent(er|re)") ? _y + 0.5*_h : (y ~= "i)bottom") ? _y + _h : y

      ; Validate text x and y, convert to pixels.
      x  := ( x ~= valid) ? RegExReplace( x, "\s", "") : _x ; Default text x is background x.
      x  := ( x ~= "(pt|px)$") ? SubStr( x, 1, -2) :  x
      x  := ( x ~= "vw$") ? RegExReplace( x, "vw$", "") * this.vw :  x
      x  := ( x ~= "vh$") ? RegExReplace( x, "vh$", "") * this.vh :  x
      x  := ( x ~= "vmin$") ? RegExReplace( x, "vmin$", "") * this.vmin :  x
      x  := ( x ~= "%$") ? RegExReplace( x, "%$", "") * 0.01 * _w :  x

      y  := ( y ~= valid) ? RegExReplace( y, "\s", "") : _y ; Default text y is background y.
      y  := ( y ~= "(pt|px)$") ? SubStr( y, 1, -2) :  y
      y  := ( y ~= "vw$") ? RegExReplace( y, "vw$", "") * this.vw :  y
      y  := ( y ~= "vh$") ? RegExReplace( y, "vh$", "") * this.vh :  y
      y  := ( y ~= "vmin$") ? RegExReplace( y, "vmin$", "") * this.vmin :  y
      y  := ( y ~= "%$") ? RegExReplace( y, "%$", "") * 0.01 * _h :  y

      ; Modify text x and text y values with the anchor, so that the text has a new point of origin.
      ; The text anchor is relative to the text width and height before margin/padding.
      ; This is NOT relative to the background width and height.
      x  -= (mod(a-1,3) == 0) ? 0 : (mod(a-1,3) == 1) ? w/2 : (mod(a-1,3) == 2) ? w : 0
      y  -= (((a-1)//3) == 0) ? 0 : (((a-1)//3) == 1) ? h/2 : (((a-1)//3) == 2) ? h : 0

      ; Define margin and padding. Both parameters will leave the text unchanged,
      ; expanding the background box. The difference between the two is NON-EXISTENT.
      ; What does matter is if the margin/padding is a background style, the position of the text will not change.
      ; If the margin/padding is a text style, the text position will change.
      ; THERE REALLY IS NO DIFFERENCE BETWEEN MARGIN AND PADDING.
      _p := this.margin_and_padding(_p)
      _m := this.margin_and_padding(_m)
      p  := this.margin_and_padding( p)
      m  := this.margin_and_padding( m)

      ; Modify _x, _y, _w, _h with margin and padding, increasing the size of the background.
      if (_w || _h) {
         _w  += (_m.2 + _m.4 + _p.2 + _p.4) + (m.2 + m.4 + p.2 + p.4)
         _h  += (_m.1 + _m.3 + _p.1 + _p.3) + (m.1 + m.3 + p.1 + p.3)
         _x  -= (_m.4 + _p.4)
         _y  -= (_m.1 + _p.1)
      }

      ; If margin/padding are defined in the text parameter, shift the position of the text.
      x  += (m.4 + p.4)
      y  += (m.1 + p.1)

      ; Re-run: Condense Text using a Condensed Font if simulated text width exceeds screen width.
      if (Gdip_FontFamilyCreate(z)) {
         if (ReturnRC[3] + x > this.ScreenWidth) {
            this._redrawBecauseOfCondensedFont := true
            return this.Draw(text, style1, style2, pGraphics)
         }
      }

      ; Define radius of rounded corners.
      _r := (_r ~= valid_positive) ? RegExReplace(_r, "\s", "") : 0  ; Default radius is 0, or square corners.
      _r := (_r ~= "(pt|px)$") ? SubStr(_r, 1, -2) : _r
      _r := (_r ~= "vw$") ? RegExReplace(_r, "vw$", "") * this.vw : _r
      _r := (_r ~= "vh$") ? RegExReplace(_r, "vh$", "") * this.vh : _r
      _r := (_r ~= "vmin$") ? RegExReplace(_r, "vmin$", "") * this.vmin : _r
      ; percentage is defined as a percentage of the smaller background width/height.
      _r := (_r ~= "%$") ? RegExReplace(_r, "%$", "") * 0.01 * ((_w > _h) ? _h : _w) : _r
      ; the radius cannot exceed the half width or half height, whichever is smaller.
      _r  := (_r <= ((_w > _h) ? _h : _w) / 2) ? _r : 0

      ; Define color.
      _c := this.color(_c, 0xDD424242) ; Default background color is transparent gray.
      SourceCopy := (c ~= "i)(delete|eraser?|overwrite|sourceCopy)") ? 1 : 0 ; Eraser brush for text.
      c  := (SourceCopy) ? 0x00000000 : this.color( c, 0xFFFFFFFF) ; Default text color is white.

      ; Define outline and dropShadow.
      o := this.outline(o, s, c)
      d := this.dropShadow(d, ReturnRC[3], ReturnRC[4], s)

      ; Round 9 - Define Text
      if (!A_IsUnicode){
         nSize := DllCall("MultiByteToWideChar", "uint",0, "uint",0, "ptr",&text, "int",-1, "ptr",0, "int",0)
         VarSetCapacity(wtext, nSize*2)
         DllCall("MultiByteToWideChar", "uint",0, "uint",0, "ptr",&text, "int",-1, "ptr",&wtext, "int",nSize)
      }

      ; Round 10 - Finalize _x, _y, _w, _h
      _x  := Round(_x)
      _y  := Round(_y)
      _w  := Round(_w)
      _h  := Round(_h)

      ; Define image boundaries using the background boundaries.
      this.x  := (this.x  = "" || _x < this.x) ? _x : this.x
      this.y  := (this.y  = "" || _y < this.y) ? _y : this.y
      this.xx := (this.xx = "" || _x + _w > this.xx) ? _x + _w : this.xx
      this.yy := (this.yy = "" || _y + _h > this.yy) ? _y + _h : this.yy

      ; Define image boundaries using the text boundaries + outline boundaries.
      artifacts := Ceil(o.3 + 0.5*o.1)
      this.x  := (x - artifacts < this.x) ? x - artifacts : this.x
      this.y  := (y - artifacts < this.y) ? y - artifacts : this.y
      this.xx := (x + w + artifacts > this.xx) ? x + w + artifacts : this.xx
      this.yy := (y + h + artifacts > this.yy) ? y + h + artifacts : this.yy

      ; Define image boundaries using the dropShadow boundaries.
      artifacts := Ceil(d.3 + d.6 + 0.5*o.1)
      this.x  := (x + d.1 - artifacts < this.x) ? x + d.1 - artifacts : this.x
      this.y  := (y + d.2 - artifacts < this.y) ? y + d.2 - artifacts : this.y
      this.xx := (x + d.1 + w + artifacts > this.xx) ? x + d.1 + w + artifacts : this.xx
      this.yy := (y + d.2 + h + artifacts > this.yy) ? y + d.2 + h + artifacts : this.yy

      ; Round to the nearest integer.
      this.x := Floor(this.x)
      this.y := Floor(this.y)
      this.xx := Ceil(this.xx)
      this.yy := Ceil(this.yy)

      ; Draw 1 - Background
      if (_w && _h && _c && (_c & 0xFF000000)) {
         if (_r == 0)
            Gdip_SetSmoothingMode(pGraphics, 1) ; Turn antialiasing off if not a rounded rectangle.
         pBrushBackground := Gdip_BrushCreateSolid(_c)
         Gdip_FillRoundedRectangle(pGraphics, pBrushBackground, _x, _y, _w, _h, _r) ; DRAWING!
         Gdip_DeleteBrush(pBrushBackground)
         if (_r == 0)
            Gdip_SetSmoothingMode(pGraphics, _q) ; Turn antialiasing on for text rendering.
      }

      ; Draw 2 - DropShadow
      if (!d.void) {
         offset2 := d.3 + d.6 + Ceil(0.5*o.1)

         if (d.3) {
            DropShadow := Gdip_CreateBitmap(w + 2*offset2, h + 2*offset2)
            DropShadowG := Gdip_GraphicsFromImage(DropShadow)
            Gdip_SetSmoothingMode(DropShadowG, _q)
            Gdip_SetTextRenderingHint(DropShadowG, q)
            CreateRectF(RC, offset2, offset2, w + 2*offset2, h + 2*offset2)
         } else {
            CreateRectF(RC, x + d.1, y + d.2, w, h)
            DropShadowG := pGraphics
         }

         ; Use Gdip_DrawString if and only if there is a horizontal/vertical offset.
         if (o.void && d.6 == 0)
         {
            pBrush := Gdip_BrushCreateSolid(d.4)
            Gdip_DrawString(DropShadowG, Text, hFont, hFormat, pBrush, RC) ; DRAWING!
            Gdip_DeleteBrush(pBrush)
         }
         else ; Otherwise, use the below code if blur, size, and opacity are set.
         {
            ; Draw the outer edge of the text string.
            DllCall("gdiplus\GdipCreatePath", "int",1, "uptr*",pPath)
            DllCall("gdiplus\GdipAddPathString", "ptr",pPath, "ptr", A_IsUnicode ? &text : &wtext, "int",-1
                                               , "ptr",hFamily, "int",style, "float",s, "ptr",&RC, "ptr",hFormat)
            pPen := Gdip_CreatePen(d.4, 2*d.6 + o.1)
            DllCall("gdiplus\GdipSetPenLineJoin", "ptr",pPen, "uint",2)
            DllCall("gdiplus\GdipDrawPath", "ptr",DropShadowG, "ptr",pPen, "ptr",pPath)
            Gdip_DeletePen(pPen)

            ; Fill in the outline. Turn off antialiasing and alpha blending so the gaps are 100% filled.
            pBrush := Gdip_BrushCreateSolid(d.4)
            Gdip_SetCompositingMode(DropShadowG, 1) ; Turn off alpha blending
            Gdip_SetSmoothingMode(DropShadowG, 3)   ; Turn off anti-aliasing
            Gdip_FillPath(DropShadowG, pBrush, pPath)
            Gdip_DeleteBrush(pBrush)
            Gdip_DeletePath(pPath)
            Gdip_SetCompositingMode(DropShadowG, 0)
            Gdip_SetSmoothingMode(DropShadowG, _q)
         }

         if (d.3) {
            Gdip_DeleteGraphics(DropShadowG)
            this.GaussianBlur(DropShadow, d.3, d.5)
            Gdip_SetInterpolationMode(pGraphics, 5) ; NearestNeighbor
            Gdip_SetSmoothingMode(pGraphics, 3) ; Turn off anti-aliasing
            Gdip_DrawImage(pGraphics, DropShadow, x + d.1 - offset2, y + d.2 - offset2, w + 2*offset2, h + 2*offset2) ; DRAWING!
            Gdip_SetSmoothingMode(pGraphics, _q)
            Gdip_DisposeImage(DropShadow)
         }
      }

      ; Draw 3 - Text Outline
      if (!o.void) {
         ; Convert our text to a path.
         CreateRectF(RC, x, y, w, h)
         DllCall("gdiplus\GdipCreatePath", "int",1, "uptr*",pPath)
         DllCall("gdiplus\GdipAddPathString", "ptr",pPath, "ptr", A_IsUnicode ? &text : &wtext, "int",-1
                                            , "ptr",hFamily, "int",style, "float",s, "ptr",&RC, "ptr",hFormat)

         ; Create a glow effect around the edges.
         if (o.3) {
            Gdip_SetClipPath(pGraphics, pPath, 3) ; Exclude original text region from being drawn on.
            pPenGlow := Gdip_CreatePen(Format("0x{:02X}",((o.4 & 0xFF000000) >> 24)/o.3) . Format("{:06X}",(o.4 & 0x00FFFFFF)), 1)
            DllCall("gdiplus\GdipSetPenLineJoin", "ptr",pPenGlow, "uint",2)

            loop % o.3
            {
               DllCall("gdiplus\GdipSetPenWidth", "ptr",pPenGlow, "float",o.1 + 2*A_Index)
               DllCall("gdiplus\GdipDrawPath", "ptr",pGraphics, "ptr",pPenGlow, "ptr",pPath) ; DRAWING!
            }
            Gdip_DeletePen(pPenGlow)
            Gdip_ResetClip(pGraphics)
         }

         ; Draw outline text.
         if (o.1) {
            pPen := Gdip_CreatePen(o.2, o.1)
            DllCall("gdiplus\GdipSetPenLineJoin", "ptr",pPen, "uint",2)
            DllCall("gdiplus\GdipDrawPath", "ptr",pGraphics, "ptr",pPen, "ptr",pPath) ; DRAWING!
            Gdip_DeletePen(pPen)
         }

         ; Fill outline text.
         pBrush := Gdip_BrushCreateSolid(c)
         Gdip_SetCompositingMode(pGraphics, SourceCopy)
         Gdip_FillPath(pGraphics, pBrush, pPath) ; DRAWING!
         Gdip_SetCompositingMode(pGraphics, 0)
         Gdip_DeleteBrush(pBrush)
         Gdip_DeletePath(pPath)
      }

      ; Draw Text if outline is not are not specified.
      if (text != "" && o.void) {
         CreateRectF(RC, x, y, w, h)
         pBrushText := Gdip_BrushCreateSolid(c)
         Gdip_SetCompositingMode(pGraphics, SourceCopy)
         Gdip_DrawString(pGraphics, A_IsUnicode ? text : wtext, hFont, hFormat, pBrushText, RC) ; DRAWING!
         Gdip_SetCompositingMode(pGraphics, 0)
         Gdip_DeleteBrush(pBrushText)
      }

      ; Delete Font Objects.
      Gdip_DeleteStringFormat(hFormat)
      Gdip_DeleteFont(hFont)
      Gdip_DeleteFontFamily(hFamily)

      return (pGraphics == "") ? this : ""
   }

   color(c, default := 0xDD424242) {
      static colorRGB  := "^0x([0-9A-Fa-f]{6})$"
      static colorARGB := "^0x([0-9A-Fa-f]{8})$"
      static hex6      :=   "^([0-9A-Fa-f]{6})$"
      static hex8      :=   "^([0-9A-Fa-f]{8})$"

      if ObjGetCapacity([c], 1) {
         c  := (c ~= "^#") ? SubStr(c, 2) : c
         c  := ((___ := this.colorMap(c)) != "") ? ___ : c
         c  := (c ~= colorRGB) ? "0xFF" RegExReplace(c, colorRGB, "$1") : (c ~= hex8) ? "0x" c : (c ~= hex6) ? "0xFF" c : c
         c  := (c ~= colorARGB) ? c : default
      }
      return (c != "") ? c : default
   }

   dropShadow(d, x_simulated, y_simulated, font_size) {
      static valid := "^\s*(\-?\d+(?:\.\d*)?)\s*(%|pt|px|vh|vmin|vw)?\s*$"
      static q1 := "(?i)^.*?\b(?<!:|:\s)\b"
      static q2 := "(?!(?>\([^()]*\)|[^()]*)*\))(:\s*)?\(?(?<value>(?<=\()([\s:#%_a-z\-\.\d]+|\([\s:#%_a-z\-\.\d]*\))*(?=\))|[#%_a-z\-\.\d]+).*$"

      if IsObject(d) {
         d.1 := (d.1) ? d.1 : (d.horizontal != "") ? d.horizontal : d.h
         d.2 := (d.2) ? d.2 : (d.vertical   != "") ? d.vertical   : d.v
         d.3 := (d.3) ? d.3 : (d.blur       != "") ? d.blur       : d.b
         d.4 := (d.4) ? d.4 : (d.color      != "") ? d.color      : d.c
         d.5 := (d.5) ? d.5 : (d.opacity    != "") ? d.opacity    : d.o
         d.6 := (d.6) ? d.6 : (d.size       != "") ? d.size       : d.s
      } else if (d != "") {
         _ := RegExReplace(d, ":\s+", ":")
         _ := RegExReplace(_, "\s+", " ")
         _ := StrSplit(_, " ")
         _.1 := ((___ := RegExReplace(d, q1    "(h(orizontal)?)"    q2, "${value}")) != d) ? ___ : _.1
         _.2 := ((___ := RegExReplace(d, q1    "(v(ertical)?)"      q2, "${value}")) != d) ? ___ : _.2
         _.3 := ((___ := RegExReplace(d, q1    "(b(lur)?)"          q2, "${value}")) != d) ? ___ : _.3
         _.4 := ((___ := RegExReplace(d, q1    "(c(olor)?)"         q2, "${value}")) != d) ? ___ : _.4
         _.5 := ((___ := RegExReplace(d, q1    "(o(pacity)?)"       q2, "${value}")) != d) ? ___ : _.5
         _.6 := ((___ := RegExReplace(d, q1    "(s(ize)?)"          q2, "${value}")) != d) ? ___ : _.6
         d := _
      }
      else return {"void":true, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0}

      for key, value in d {
         if (key = 4) ; Don't mess with color data.
            continue
         d[key] := (d[key] ~= valid) ? RegExReplace(d[key], "\s", "") : 0 ; Default for everything is 0.
         d[key] := (d[key] ~= "(pt|px)$") ? SubStr(d[key], 1, -2) : d[key]
         d[key] := (d[key] ~= "vw$") ? RegExReplace(d[key], "vw$", "") * this.vw : d[key]
         d[key] := (d[key] ~= "vh$") ? RegExReplace(d[key], "vh$", "") * this.vh : d[key]
         d[key] := (d[key] ~= "vmin$") ? RegExReplace(d[key], "vmin$", "") * this.vmin : d[key]
      }

      d.1 := (d.1 ~= "%$") ? SubStr(d.1, 1, -1) * 0.01 * x_simulated : d.1
      d.2 := (d.2 ~= "%$") ? SubStr(d.2, 1, -1) * 0.01 * y_simulated : d.2
      d.3 := (d.3 ~= "%$") ? SubStr(d.3, 1, -1) * 0.01 * font_size : d.3
      d.4 := this.color(d.4, 0xFFFF0000) ; Default color is red.
      d.5 := (d.5 ~= "%$") ? SubStr(d.5, 1, -1) / 100 : d.5
      d.5 := (d.5 <= 0 || d.5 > 1) ? 1 : d.5 ; Range Opacity is a float from 0-1.
      d.6 := (d.6 ~= "%$") ? SubStr(d.6, 1, -1) * 0.01 * font_size : d.6
      return d
   }

   font(f, default := "Arial"){

   }

   margin_and_padding(m, default := 0) {
      static valid := "^\s*(\-?\d+(?:\.\d*)?)\s*(%|pt|px|vh|vmin|vw)?\s*$"
      static q1 := "(?i)^.*?\b(?<!:|:\s)\b"
      static q2 := "(?!(?>\([^()]*\)|[^()]*)*\))(:\s*)?\(?(?<value>(?<=\()([\s:#%_a-z\-\.\d]+|\([\s:#%_a-z\-\.\d]*\))*(?=\))|[#%_a-z\-\.\d]+).*$"

      if IsObject(m) {
         m.1 := (m.top    != "") ? m.top    : m.t
         m.2 := (m.right  != "") ? m.right  : m.r
         m.3 := (m.bottom != "") ? m.bottom : m.b
         m.4 := (m.left   != "") ? m.left   : m.l
      } else if (m != "") {
         _ := RegExReplace(m, ":\s+", ":")
         _ := RegExReplace(_, "\s+", " ")
         _ := StrSplit(_, " ")
         _.1 := ((___ := RegExReplace(m, q1    "(t(op)?)"           q2, "${value}")) != m) ? ___ : _.1
         _.2 := ((___ := RegExReplace(m, q1    "(r(ight)?)"         q2, "${value}")) != m) ? ___ : _.2
         _.3 := ((___ := RegExReplace(m, q1    "(b(ottom)?)"        q2, "${value}")) != m) ? ___ : _.3
         _.4 := ((___ := RegExReplace(m, q1    "(l(eft)?)"          q2, "${value}")) != m) ? ___ : _.4
         m := _
      }
      else return {1:default, 2:default, 3:default, 4:default}

      ; Follow CSS guidelines for margin!
      if (m.2 == "" && m.3 == "" && m.4 == "")
         m.4 := m.3 := m.2 := m.1, exception := true
      if (m.3 == "" && m.4 == "")
         m.4 := m.2, m.3 := m.1
      if (m.4 == "")
         m.4 := m.2

      for key, value in m {
         m[key] := (m[key] ~= valid) ? RegExReplace(m[key], "\s", "") : default
         m[key] := (m[key] ~= "(pt|px)$") ? SubStr(m[key], 1, -2) : m[key]
         m[key] := (m[key] ~= "vw$") ? RegExReplace(m[key], "vw$", "") * this.vw : m[key]
         m[key] := (m[key] ~= "vh$") ? RegExReplace(m[key], "vh$", "") * this.vh : m[key]
         m[key] := (m[key] ~= "vmin$") ? RegExReplace(m[key], "vmin$", "") * this.vmin : m[key]
      }
      m.1 := (m.1 ~= "%$") ? SubStr(m.1, 1, -1) * this.vh : m.1
      m.2 := (m.2 ~= "%$") ? SubStr(m.2, 1, -1) * (exception ? this.vh : this.vw) : m.2
      m.3 := (m.3 ~= "%$") ? SubStr(m.3, 1, -1) * this.vh : m.3
      m.4 := (m.4 ~= "%$") ? SubStr(m.4, 1, -1) * (exception ? this.vh : this.vw) : m.4
      return m
   }

   outline(o, font_size, font_color) {
      static valid_positive := "^\s*(\d+(?:\.\d*)?)\s*(%|pt|px|vh|vmin|vw)?\s*$"
      static q1 := "(?i)^.*?\b(?<!:|:\s)\b"
      static q2 := "(?!(?>\([^()]*\)|[^()]*)*\))(:\s*)?\(?(?<value>(?<=\()([\s:#%_a-z\-\.\d]+|\([\s:#%_a-z\-\.\d]*\))*(?=\))|[#%_a-z\-\.\d]+).*$"

      if IsObject(o) {
         o.1 := (o.1) ? o.1 : (o.stroke != "") ? o.stroke : o.s
         o.2 := (o.2) ? o.2 : (o.color  != "") ? o.color  : o.c
         o.3 := (o.3) ? o.3 : (o.glow   != "") ? o.glow   : o.g
         o.4 := (o.4) ? o.4 : (o.tint   != "") ? o.tint   : o.t
      } else if (o != "") {
         _ := RegExReplace(o, ":\s+", ":")
         _ := RegExReplace(_, "\s+", " ")
         _ := StrSplit(_, " ")
         _.1 := ((___ := RegExReplace(o, q1    "(s(troke)?)"        q2, "${value}")) != o) ? ___ : _.1
         _.2 := ((___ := RegExReplace(o, q1    "(c(olor)?)"         q2, "${value}")) != o) ? ___ : _.2
         _.3 := ((___ := RegExReplace(o, q1    "(g(low)?)"          q2, "${value}")) != o) ? ___ : _.3
         _.4 := ((___ := RegExReplace(o, q1    "(t(int)?)"          q2, "${value}")) != o) ? ___ : _.4
         o := _
      }
      else return {"void":true, 1:0, 2:0, 3:0, 4:0}

      for key, value in o {
         if (key = 2) || (key = 4) ; Don't mess with color data.
            continue
         o[key] := (o[key] ~= valid_positive) ? RegExReplace(o[key], "\s", "") : 0 ; Default for everything is 0.
         o[key] := (o[key] ~= "(pt|px)$") ? SubStr(o[key], 1, -2) : o[key]
         o[key] := (o[key] ~= "vw$") ? RegExReplace(o[key], "vw$", "") * this.vw : o[key]
         o[key] := (o[key] ~= "vh$") ? RegExReplace(o[key], "vh$", "") * this.vh : o[key]
         o[key] := (o[key] ~= "vmin$") ? RegExReplace(o[key], "vmin$", "") * this.vmin : o[key]
      }

      o.1 := (o.1 ~= "%$") ? SubStr(o.1, 1, -1) * 0.01 * font_size : o.1
      o.2 := this.color(o.2, font_color) ; Default color is the text font color.
      o.3 := (o.3 ~= "%$") ? SubStr(o.3, 1, -1) * 0.01 * font_size : o.3
      o.4 := this.color(o.4, o.2) ; Default color is outline color.
      return o
   }

   colorMap(c) {
      static map

      if !(map) {
      color := [] ; 73 LINES MAX
      color["Clear"] := color["Off"] := color["None"] := color["Transparent"] := "0x00000000"

         color["AliceBlue"]             := "0xFFF0F8FF"
      ,  color["AntiqueWhite"]          := "0xFFFAEBD7"
      ,  color["Aqua"]                  := "0xFF00FFFF"
      ,  color["Aquamarine"]            := "0xFF7FFFD4"
      ,  color["Azure"]                 := "0xFFF0FFFF"
      ,  color["Beige"]                 := "0xFFF5F5DC"
      ,  color["Bisque"]                := "0xFFFFE4C4"
      ,  color["Black"]                 := "0xFF000000"
      ,  color["BlanchedAlmond"]        := "0xFFFFEBCD"
      ,  color["Blue"]                  := "0xFF0000FF"
      ,  color["BlueViolet"]            := "0xFF8A2BE2"
      ,  color["Brown"]                 := "0xFFA52A2A"
      ,  color["BurlyWood"]             := "0xFFDEB887"
      ,  color["CadetBlue"]             := "0xFF5F9EA0"
      ,  color["Chartreuse"]            := "0xFF7FFF00"
      ,  color["Chocolate"]             := "0xFFD2691E"
      ,  color["Coral"]                 := "0xFFFF7F50"
      ,  color["CornflowerBlue"]        := "0xFF6495ED"
      ,  color["Cornsilk"]              := "0xFFFFF8DC"
      ,  color["Crimson"]               := "0xFFDC143C"
      ,  color["Cyan"]                  := "0xFF00FFFF"
      ,  color["DarkBlue"]              := "0xFF00008B"
      ,  color["DarkCyan"]              := "0xFF008B8B"
      ,  color["DarkGoldenRod"]         := "0xFFB8860B"
      ,  color["DarkGray"]              := "0xFFA9A9A9"
      ,  color["DarkGrey"]              := "0xFFA9A9A9"
      ,  color["DarkGreen"]             := "0xFF006400"
      ,  color["DarkKhaki"]             := "0xFFBDB76B"
      ,  color["DarkMagenta"]           := "0xFF8B008B"
      ,  color["DarkOliveGreen"]        := "0xFF556B2F"
      ,  color["DarkOrange"]            := "0xFFFF8C00"
      ,  color["DarkOrchid"]            := "0xFF9932CC"
      ,  color["DarkRed"]               := "0xFF8B0000"
      ,  color["DarkSalmon"]            := "0xFFE9967A"
      ,  color["DarkSeaGreen"]          := "0xFF8FBC8F"
      ,  color["DarkSlateBlue"]         := "0xFF483D8B"
      ,  color["DarkSlateGray"]         := "0xFF2F4F4F"
      ,  color["DarkSlateGrey"]         := "0xFF2F4F4F"
      ,  color["DarkTurquoise"]         := "0xFF00CED1"
      ,  color["DarkViolet"]            := "0xFF9400D3"
      ,  color["DeepPink"]              := "0xFFFF1493"
      ,  color["DeepSkyBlue"]           := "0xFF00BFFF"
      ,  color["DimGray"]               := "0xFF696969"
      ,  color["DimGrey"]               := "0xFF696969"
      ,  color["DodgerBlue"]            := "0xFF1E90FF"
      ,  color["FireBrick"]             := "0xFFB22222"
      ,  color["FloralWhite"]           := "0xFFFFFAF0"
      ,  color["ForestGreen"]           := "0xFF228B22"
      ,  color["Fuchsia"]               := "0xFFFF00FF"
      ,  color["Gainsboro"]             := "0xFFDCDCDC"
      ,  color["GhostWhite"]            := "0xFFF8F8FF"
      ,  color["Gold"]                  := "0xFFFFD700"
      ,  color["GoldenRod"]             := "0xFFDAA520"
      ,  color["Gray"]                  := "0xFF808080"
      ,  color["Grey"]                  := "0xFF808080"
      ,  color["Green"]                 := "0xFF008000"
      ,  color["GreenYellow"]           := "0xFFADFF2F"
      ,  color["HoneyDew"]              := "0xFFF0FFF0"
      ,  color["HotPink"]               := "0xFFFF69B4"
      ,  color["IndianRed"]             := "0xFFCD5C5C"
      ,  color["Indigo"]                := "0xFF4B0082"
      ,  color["Ivory"]                 := "0xFFFFFFF0"
      ,  color["Khaki"]                 := "0xFFF0E68C"
      ,  color["Lavender"]              := "0xFFE6E6FA"
      ,  color["LavenderBlush"]         := "0xFFFFF0F5"
      ,  color["LawnGreen"]             := "0xFF7CFC00"
      ,  color["LemonChiffon"]          := "0xFFFFFACD"
      ,  color["LightBlue"]             := "0xFFADD8E6"
      ,  color["LightCoral"]            := "0xFFF08080"
      ,  color["LightCyan"]             := "0xFFE0FFFF"
      ,  color["LightGoldenRodYellow"]  := "0xFFFAFAD2"
      ,  color["LightGray"]             := "0xFFD3D3D3"
      ,  color["LightGrey"]             := "0xFFD3D3D3"
         color["LightGreen"]            := "0xFF90EE90"
      ,  color["LightPink"]             := "0xFFFFB6C1"
      ,  color["LightSalmon"]           := "0xFFFFA07A"
      ,  color["LightSeaGreen"]         := "0xFF20B2AA"
      ,  color["LightSkyBlue"]          := "0xFF87CEFA"
      ,  color["LightSlateGray"]        := "0xFF778899"
      ,  color["LightSlateGrey"]        := "0xFF778899"
      ,  color["LightSteelBlue"]        := "0xFFB0C4DE"
      ,  color["LightYellow"]           := "0xFFFFFFE0"
      ,  color["Lime"]                  := "0xFF00FF00"
      ,  color["LimeGreen"]             := "0xFF32CD32"
      ,  color["Linen"]                 := "0xFFFAF0E6"
      ,  color["Magenta"]               := "0xFFFF00FF"
      ,  color["Maroon"]                := "0xFF800000"
      ,  color["MediumAquaMarine"]      := "0xFF66CDAA"
      ,  color["MediumBlue"]            := "0xFF0000CD"
      ,  color["MediumOrchid"]          := "0xFFBA55D3"
      ,  color["MediumPurple"]          := "0xFF9370DB"
      ,  color["MediumSeaGreen"]        := "0xFF3CB371"
      ,  color["MediumSlateBlue"]       := "0xFF7B68EE"
      ,  color["MediumSpringGreen"]     := "0xFF00FA9A"
      ,  color["MediumTurquoise"]       := "0xFF48D1CC"
      ,  color["MediumVioletRed"]       := "0xFFC71585"
      ,  color["MidnightBlue"]          := "0xFF191970"
      ,  color["MintCream"]             := "0xFFF5FFFA"
      ,  color["MistyRose"]             := "0xFFFFE4E1"
      ,  color["Moccasin"]              := "0xFFFFE4B5"
      ,  color["NavajoWhite"]           := "0xFFFFDEAD"
      ,  color["Navy"]                  := "0xFF000080"
      ,  color["OldLace"]               := "0xFFFDF5E6"
      ,  color["Olive"]                 := "0xFF808000"
      ,  color["OliveDrab"]             := "0xFF6B8E23"
      ,  color["Orange"]                := "0xFFFFA500"
      ,  color["OrangeRed"]             := "0xFFFF4500"
      ,  color["Orchid"]                := "0xFFDA70D6"
      ,  color["PaleGoldenRod"]         := "0xFFEEE8AA"
      ,  color["PaleGreen"]             := "0xFF98FB98"
      ,  color["PaleTurquoise"]         := "0xFFAFEEEE"
      ,  color["PaleVioletRed"]         := "0xFFDB7093"
      ,  color["PapayaWhip"]            := "0xFFFFEFD5"
      ,  color["PeachPuff"]             := "0xFFFFDAB9"
      ,  color["Peru"]                  := "0xFFCD853F"
      ,  color["Pink"]                  := "0xFFFFC0CB"
      ,  color["Plum"]                  := "0xFFDDA0DD"
      ,  color["PowderBlue"]            := "0xFFB0E0E6"
      ,  color["Purple"]                := "0xFF800080"
      ,  color["RebeccaPurple"]         := "0xFF663399"
      ,  color["Red"]                   := "0xFFFF0000"
      ,  color["RosyBrown"]             := "0xFFBC8F8F"
      ,  color["RoyalBlue"]             := "0xFF4169E1"
      ,  color["SaddleBrown"]           := "0xFF8B4513"
      ,  color["Salmon"]                := "0xFFFA8072"
      ,  color["SandyBrown"]            := "0xFFF4A460"
      ,  color["SeaGreen"]              := "0xFF2E8B57"
      ,  color["SeaShell"]              := "0xFFFFF5EE"
      ,  color["Sienna"]                := "0xFFA0522D"
      ,  color["Silver"]                := "0xFFC0C0C0"
      ,  color["SkyBlue"]               := "0xFF87CEEB"
      ,  color["SlateBlue"]             := "0xFF6A5ACD"
      ,  color["SlateGray"]             := "0xFF708090"
      ,  color["SlateGrey"]             := "0xFF708090"
      ,  color["Snow"]                  := "0xFFFFFAFA"
      ,  color["SpringGreen"]           := "0xFF00FF7F"
      ,  color["SteelBlue"]             := "0xFF4682B4"
      ,  color["Tan"]                   := "0xFFD2B48C"
      ,  color["Teal"]                  := "0xFF008080"
      ,  color["Thistle"]               := "0xFFD8BFD8"
      ,  color["Tomato"]                := "0xFFFF6347"
      ,  color["Turquoise"]             := "0xFF40E0D0"
      ,  color["Violet"]                := "0xFFEE82EE"
      ,  color["Wheat"]                 := "0xFFF5DEB3"
      ,  color["White"]                 := "0xFFFFFFFF"
      ,  color["WhiteSmoke"]            := "0xFFF5F5F5"
         color["Yellow"]                := "0xFFFFFF00"
      ,  color["YellowGreen"]           := "0xFF9ACD32"
      map := color
      }

      return map[c]
   }

   GaussianBlur(ByRef pBitmap, radius, opacity := 1) {
      static x86 := "
      (LTrim
      VYnlV1ZTg+xci0Uci30c2UUgx0WsAwAAAI1EAAGJRdiLRRAPr0UYicOJRdSLRRwP
      r/sPr0UYiX2ki30UiUWoi0UQjVf/i30YSA+vRRgDRQgPr9ONPL0SAAAAiUWci0Uc
      iX3Eg2XE8ECJVbCJRcCLRcSJZbToAAAAACnEi0XEiWXk6AAAAAApxItFxIllzOgA
      AAAAKcSLRaiJZcjHRdwAAAAAx0W8AAAAAIlF0ItFvDtFFA+NcAEAAItV3DHAi12c
      i3XQiVXgAdOLfQiLVdw7RRiNDDp9IQ+2FAGLTcyLfciJFIEPtgwDD69VwIkMh4tN
      5IkUgUDr0THSO1UcfBKLXdwDXQzHRbgAAAAAK13Q6yAxwDtFGH0Ni33kD7YcAQEc
      h0Dr7kIDTRjrz/9FuAN1GItF3CtF0AHwiceLRbg7RRx/LDHJO00YfeGLRQiLfcwB
      8A+2BAgrBI+LfeQDBI+ZiQSPjTwz933YiAQPQevWi0UIK0Xci03AAfCJRbiLXRCJ
      /itdHCt13AN14DnZfAgDdQwrdeDrSot1DDHbK3XcAf4DdeA7XRh9KItV4ItFuAHQ
      A1UID7YEGA+2FBop0ItV5AMEmokEmpn3fdiIBB5D69OLRRhBAUXg66OLRRhDAUXg
      O10QfTIxyTtNGH3ti33Ii0XgA0UID7YUCIsEjynQi1XkAwSKiQSKi1XgjTwWmfd9
      2IgED0Hr0ItF1P9FvAFF3AFF0OmE/v//i0Wkx0XcAAAAAMdFvAAAAACJRdCLRbAD
      RQyJRaCLRbw7RRAPjXABAACLTdwxwItdoIt10IlN4AHLi30Mi1XcO0UYjQw6fSEP
      thQBi33MD7YMA4kUh4t9yA+vVcCJDIeLTeSJFIFA69Ex0jtVHHwSi13cA10Ix0W4
      AAAAACtd0OsgMcA7RRh9DYt95A+2HAEBHIdA6+5CA03U68//RbgDddSLRdwrRdAB
      8InHi0W4O0UcfywxyTtNGH3hi0UMi33MAfAPtgQIKwSPi33kAwSPmYkEj408M/d9
      2IgED0Hr1otFDCtF3ItNwAHwiUW4i10Uif4rXRwrddwDdeA52XwIA3UIK3Xg60qL
      dQgx2yt13AH+A3XgO10YfSiLVeCLRbgB0ANVDA+2BBgPthQaKdCLVeQDBJqJBJqZ
      933YiAQeQ+vTi0XUQQFF4Ouji0XUQwFF4DtdFH0yMck7TRh97Yt9yItF4ANFDA+2
      FAiLBI+LfeQp0ItV4AMEj4kEj408Fpn3fdiIBA9B69CLRRj/RbwBRdwBRdDphP7/
      //9NrItltA+Fofz//9no3+l2PzHJMds7XRR9OotFGIt9CA+vwY1EBwMx/zt9EH0c
      D7Yw2cBHVtoMJFrZXeTzDyx15InyiBADRRjr30MDTRDrxd3Y6wLd2I1l9DHAW15f
      XcM=
      )"
      static x64 := "
      (LTrim
      VUFXQVZBVUFUV1ZTSIHsqAAAAEiNrCSAAAAARIutkAAAAIuFmAAAAESJxkiJVRhB
      jVH/SYnPi42YAAAARInHQQ+v9Y1EAAErvZgAAABEiUUARIlN2IlFFEljxcdFtAMA
      AABIY96LtZgAAABIiUUID6/TiV0ESIld4A+vy4udmAAAAIl9qPMPEI2gAAAAiVXQ
      SI0UhRIAAABBD6/1/8OJTbBIiVXoSINl6PCJXdxBifaJdbxBjXD/SWPGQQ+v9UiJ
      RZhIY8FIiUWQiXW4RInOK7WYAAAAiXWMSItF6EiJZcDoAAAAAEgpxEiLRehIieHo
      AAAAAEgpxEiLRehIiWX46AAAAABIKcRIi0UYTYn6SIll8MdFEAAAAADHRdQAAAAA
      SIlFyItF2DlF1A+NqgEAAESLTRAxwEWJyEQDTbhNY8lNAflBOcV+JUEPthQCSIt9
      +EUPthwBSItd8IkUhw+vVdxEiRyDiRSBSP/A69aLVRBFMclEO42YAAAAfA9Ii0WY
      RTHbMdtNjSQC6ytMY9oxwE0B+0E5xX4NQQ+2HAMBHIFI/8Dr7kH/wUQB6uvGTANd
      CP/DRQHoO52YAAAAi0W8Ro00AH82SItFyEuNPCNFMclJjTQDRTnNftRIi1X4Qg+2
      BA9CKwSKQgMEiZlCiQSJ930UQogEDkn/wevZi0UQSWP4SAN9GItd3E1j9kUx200B
      /kQpwIlFrEiJfaCLdaiLRaxEAcA580GJ8XwRSGP4TWPAMdtMAf9MA0UY60tIi0Wg
      S408Hk+NJBNFMclKjTQYRTnNfiFDD7YUDEIPtgQPKdBCAwSJmUKJBIn3fRRCiAQO
      Sf/B69r/w0UB6EwDXQjrm0gDXQhB/8FEO00AfTRMjSQfSY00GEUx20U53X7jSItF
      8EMPthQcQosEmCnQQgMEmZlCiQSZ930UQogEHkn/w+vXi0UEAUUQSItF4P9F1EgB
      RchJAcLpSv7//0yLVRhMiX3Ix0UQAAAAAMdF1AAAAACLRQA5RdQPja0BAABEi00Q
      McBFichEA03QTWPJTANNGEE5xX4lQQ+2FAJIi3X4RQ+2HAFIi33wiRSGD69V3ESJ
      HIeJFIFI/8Dr1otVEEUxyUQ7jZgAAAB8D0iLRZBFMdsx202NJALrLUxj2kwDXRgx
      wEE5xX4NQQ+2HAMBHIFI/8Dr7kH/wQNVBOvFRANFBEwDXeD/wzudmAAAAItFsEaN
      NAB/NkiLRchLjTwjRTHJSY00A0U5zX7TSItV+EIPtgQPQisEikIDBImZQokEifd9
      FEKIBA5J/8Hr2YtFEE1j9klj+EwDdRiLXdxFMdtEKcCJRaxJjQQ/SIlFoIt1jItF
      rEQBwDnzQYnxfBFNY8BIY/gx20gDfRhNAfjrTEiLRaBLjTweT40kE0UxyUqNNBhF
      Oc1+IUMPthQMQg+2BA8p0EIDBImZQokEifd9FEKIBA5J/8Hr2v/DRANFBEwDXeDr
      mkgDXeBB/8FEO03YfTRMjSQfSY00GEUx20U53X7jSItF8EMPthQcQosEmCnQQgME
      mZlCiQSZ930UQogEHkn/w+vXSItFCP9F1EQBbRBIAUXISQHC6Uf+////TbRIi2XA
      D4Ui/P//8w8QBQAAAAAPLsF2TTHJRTHARDtF2H1Cicgx0kEPr8VImEgrRQhNjQwH
      McBIA0UIO1UAfR1FD7ZUAQP/wvNBDyrC8w9ZwfNEDyzQRYhUAQPr2kH/wANNAOu4
      McBIjWUoW15fQVxBXUFeQV9dw5CQkJCQkJCQkJCQkJAAAIA/
      )"
      width := Gdip_GetImageWidth(pBitmap)
      height := Gdip_GetImageHeight(pBitmap)
      clone := Gdip_CloneBitmapArea(pBitmap, 0, 0, width, height)
      E1 := Gdip_LockBits(pBitmap, 0, 0, width, height, Stride1, Scan01, BitmapData1)
      E2 := Gdip_LockBits(clone, 0, 0, width, height, Stride2, Scan02, BitmapData2)

      DllCall("crypt32\CryptStringToBinary", "str",(A_PtrSize == 8) ? x64 : x86, "uint",0, "uint",0x1, "ptr",0, "uint*",s, "ptr",0, "ptr",0)
      p := DllCall("GlobalAlloc", "uint",0, "ptr",s, "ptr")
      if (A_PtrSize == 8)
         DllCall("VirtualProtect", "ptr",p, "ptr",s, "uint",0x40, "uint*",op)
      DllCall("crypt32\CryptStringToBinary", "str",(A_PtrSize == 8) ? x64 : x86, "uint",0, "uint",0x1, "ptr",p, "uint*",s, "ptr",0, "ptr",0)
      value := DllCall(p, "ptr",Scan01, "ptr",Scan02, "uint",width, "uint",height, "uint",4, "uint",radius, "float",opacity)
      DllCall("GlobalFree", "ptr", p)

      Gdip_UnlockBits(pBitmap, BitmapData1)
      Gdip_UnlockBits(clone, BitmapData2)
      Gdip_DisposeImage(clone)
      return value
   }

   outer[]
   {
      get {
         ; Determine if there is a parent class. this.__class will retrive the
         ; current instance's class name. Array notation [] will dereference.
         ; Returns void if this function is not nested in at least 2 classes.
         if ((_class := RegExReplace(this.__class, "^(.*)\..*$", "$1")) != this.__class)
            Loop, Parse, _class, .
               outer := (A_Index=1) ? %A_LoopField% : outer[A_LoopField]
         return outer
      }
   }

   x1() {
      return this.x
   }

   y1() {
      return this.y
   }

   x2() {
      return this.xx
   }

   y2() {
      return this.yy
   }

   width() {
      return this.xx - this.x
   }

   height() {
      return this.yy - this.y
   }
} ; End of Subtitle class.






