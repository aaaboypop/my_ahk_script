;-----------------------------------------------
;----------# Recoil AHK By HentaiRyuu #---------
;-# Hotkey
;-----------------------------------------------
;----------# Select Processes #-----------------

GroupAdd, AExE, ahk_exe PrincessConnectReDive.exe
GroupAdd, AExE, ahk_exe KFGame.exe
GroupAdd, AExE, ahk_exe AndroidEmulator.exe
;GroupAdd, AExE, ahk_exe dontstarve_steam.exe
;GroupAdd, AExE, ahk_exe 

;----------# System Vars #----------------------

#singleInstance, force
#IfWinActive ahk_group AExE
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

RecoilAmt := 1
,FireDelay := 20
,M := M1

;----------# Tray Control #---------------------

Menu, Tray, NoStandard
Menu, Tray, Add, Recoil AHK By HentaiRyuu, Dummy
Menu, Tray, Add
Menu, Tray, Add, Open GUI, OpenGui
Menu, Tray, Default, Open GUI
Menu, Tray, Add, Hide GUI, HideGui
Menu, Tray, Add
Menu, Tray, Add, Recoil 0, nRc0
Menu, Tray, Add, Recoil 3, nRc1
Menu, Tray, Add, Recoil 6, nRc2
Menu, Tray, Add, Recoil 10, nRc3
Menu, Tray, Add
Menu, Tray, Add, Toggle L, ToggleL
Menu, Tray, Add, Toggle M, ToggleM
Menu, Tray, Add, Toggle M Mode, ToggleMMode
Menu, Tray, Add
Menu, Tray, Add, Suspend, Suspend
Menu, Tray, Add, Restart, Restart
Menu, Tray, Add
Menu, Tray, Add, Exit, GuiClose
Menu, Tray, Tip, Reduce Recoil AHK `nBy HentaiRyuu `nBuild 180615

OnExit, GuiClose

;----------# Build UI #-------------------------

Gui,-Resize -MaximizeBox -MinimizeBox +ToolWindow
Gui, Show, Hide w280 h180, Reduce Recoil Tool v2 Semi-Auto
Gui, Add, GroupBox, x10 y10 w140 h115, Options:
Gui, Add, Text, x20 y30 cBlue, Recoil Amount:
Gui, Add, Edit
Gui, Add, UpDown, vRecoilAmt Range0-20, %RecoilAmt%
Gui, Add, Text, x20 y75 cBlue, Fire Delay (ms):
Gui, Add, Edit
Gui, Add, UpDown, vFireDelay Range0-999, %FireDelay%

Gui, Add, GroupBox, x10 y10 w140 h160, Options:
Gui, Add, Text, x18 y129 w140 vStatus, Status: Off
Gui, Add, Text, x18 y149, By HentaiRyuu B.180615

Gui, Add, GroupBox, x160 y10 w110 h160, Buttons:
Gui, Add, Button, x168 y29 h20 w90 gb0, !! Help !!
Gui, Add, Button, x168 y51 h20 w90 gb1, Toggle L
Gui, Add, Button, x168 y73 h20 w90 gb2, Toggle M
Gui, Add, Button, x168 y95 h20 w90 gb3, Toggle M Mode
Gui, Add, Button, x168 y117 h20 w90 grestart, Restart
Gui, Add, Button, x168 y139 h20 w44 ghidegui, Hide
Gui, Add, Button, x214 y139 h20 w44 gguiclose, Exit

return ; Prevent CODE below run

;----------# UI Control #-----------------------

OpenGui:
Gui,Show
return

HideGui:
Gui,Show,Hide
return

;----------# Toggle Key #-----------------------

*Up::
GuiControlGet, RecoilAmt
RecoilAmt := RecoilAmt + 1
gosub UpdateUI
return

*Down::
GuiControlGet, RecoilAmt
RecoilAmt := RecoilAmt - 1
gosub UpdateUI
return

*Right::
GuiControlGet, FireDelay
FireDelay := FireDelay + 10
gosub UpdateUI
return

*Left::
GuiControlGet, FireDelay
FireDelay := FireDelay - 10
gosub UpdateUI
return


*Numpad0::
nRc0:
RecoilAmt := 0
Send {Numpad0}
gosub UpdateUI
return

*Numpad1::
nRc1:
RecoilAmt := 3
Send {Numpad1}
gosub UpdateUI
return

*Numpad2::
nRc2:
RecoilAmt := 6
Send {Numpad2}
gosub UpdateUI
return

*Numpad3::
nRc3:
RecoilAmt := 10
Send {Numpad3}
gosub UpdateUI
return

*Numpad7::
b1:
ToggleL:
LMouse := !LMouse
Send {Numpad7}
gosub UpdateUI
return

*Numpad8::
b2:
ToggleM:
MMouse := !MMouse
Send {Numpad8}
gosub UpdateUI
return

*Numpad9::
b3:
ToggleMMode:
Send {Numpad9}
MMode := !MMode
if (MMode) {
  M = M2
  gosub UpdateUI
} else {
  M = M1
  gosub UpdateUI
}
return

*NumpadDot::
Suspend:
Suspend
return

#If WinActive("ahk_exe KFGame.exe")
*B::
While GetKeyState("B", "P")
{
    SendInput {B down}
	Sleep %FireDelay%
    SendInput {B up}
	Sleep 10
}
return



;----------# handles left click
#If WinActive("ahk_group AExE") && LMouse
*LButton::
GuiControlGet, NoRecoilAmt
GuiControlGet, FireDelay
GuiControlGet, Status
While GetKeyState("LButton", "P")
{
    Click down
    Sleep %FireDelay%
    Click up
    mouseXY(0, RecoilAmt)
    Sleep %FireDelay%
    If !GetKeyState("LButton", "P") 
    {
        break
    }
}
return

;----------# handles middle click
#If WinActive("ahk_group AExE") && MMouse && !MMode
MButton::LButton
return

#If WinActive("ahk_group AExE") && MMouse && MMode
MButton::
While GetKeyState("MButton", "P")
{
   Click M down
   Sleep 300
   Click M up
   Sleep 10
   SendInput {r down}
   Sleep 20
   SendInput {r up}
   Sleep 10
}
return

;----------# System #---------------------------

b0:
MsgBox, 0x0, Help, 
(Join
-----: About This :-----`n`n
This AHK works with :`n
Rules of Survival (ros.exe)`n
Killing Floor 2 (KFGame.exe)`n`n
Created By HentaiRyuu`nBuild 180615`n`n
-----: Hotkeys :-----`n`n
Arrow Up      : Recoil +1 `n
Arrow Down : Recoil -1 `n`n
Arrow Right : FireDelay +10 `n
Arrow Left    : FireDelay -10 `n`n
Numpad 0 : Recoil 0 `n
Numpad 1 : Recoil 3 `n
Numpad 2 : Recoil 6 `n
Numpad 3 : Recoil 10 `n`n
Numpad 7 : Toggle Left      Click (On/Off) `n
Numpad 8 : Toggle Middle Click (On/Off) `n
Numpad 9 : Toggle Middle Click Mode`n`n
Numpad . : Suspend`n`n
-----: Other :-----`n`n
Toggle Left Click :`n
  Enable Spam Left Click on hold (w/ recoil reducer)`n`n
Toggle Middle Click Mode :`n-Mode 1 :`n
  Rebind "Middle Click" to "Left Click"`n`n-Mode 2 :`n
  Macro KF2 Berserker Parry (M Click > R > Loop)
)
return

UpdateUI:
GuiControl,, RecoilAmt, %RecoilAmt%
GuiControl,, FireDelay, %FireDelay%
if (LMouse & !MMouse) {
  GuiControl,, Status, Status: L - On
} else if (LMouse & MMouse) {
  GuiControl,, Status, Status: L %M% - On
} else if (!LMouse & MMouse) {
  GuiControl,, Status, Status: %M% - On
} else {
  GuiControl,, Status, Status: Off
}
return

mouseXY(x, y) ;moves the mouse (relative movements)
{
    DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
}

Restart:
Reload
return

GuiClose:
ExitApp
return

Dummy:
return