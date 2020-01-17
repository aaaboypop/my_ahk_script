;----------# Select Processes #-----------------

GroupAdd, AExE, ahk_exe opera.exe

GroupAdd, Slowmode, ahk_exe opera.exe

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
#NoTrayIcon

;----------# Vars #-----------------------------

DelayB := 10 ;Before [Holding]
DelayA := 20 ;After [Release]
SlowB := 10
SlowA := 100

;----------# Tray Control #---------------------

Menu, Tray, NoStandard
Menu, Tray, Add, Spam RClick AHK By HentaiRyuu, Dummy
Menu, Tray, Add
Menu, Tray, Add, Open GUI, OpenGui
Menu, Tray, Default, Open GUI
Menu, Tray, Add, Hide GUI, HideGui
Menu, Tray, Add
Menu, Tray, Add, Suspend, Suspend
Menu, Tray, Add, Restart, Restart
Menu, Tray, Add
Menu, Tray, Add, Exit, GuiClose
Menu, Tray, Tip, Spam RClick AHK `nBy HentaiRyuu

OnExit, GuiClose

;----------# Build UI #-------------------------

Gui,-Resize -MaximizeBox -MinimizeBox +ToolWindow
Gui, Show, Hide w280 h180, Spam w/RClick
Gui, Add, GroupBox, x10 y10 w140 h115, Options:
Gui, Add, Text, x20 y30 cBlue, Delay Before (ms):
Gui, Add, Edit
Gui, Add, UpDown, vDelayB Range0-20, %DelayB%
Gui, Add, Text, x20 y75 cBlue, Delay After (ms):
Gui, Add, Edit
Gui, Add, UpDown, vDelayA Range0-999, %DelayA%

Gui, Add, GroupBox, x10 y10 w140 h160, Options:
Gui, Add, Text, x18 y129 w140 vStatus, Status: On
Gui, Add, Text, x18 y149, By HentaiRyuu B.180615

Gui, Add, GroupBox, x160 y10 w110 h160, Buttons:
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

Suspend:
Suspend
return

;----------# handles left click
#If WinActive("ahk_group AExE")
*RButton::
GuiControlGet, DelayB
GuiControlGet, DelayA
While GetKeyState("RButton", "P")
{
    If WinActive("ahk_group Slowmode") {
        DelaySB := SlowB
        DelaySA := SlowA
    }
    Else
    {
        DelaySB := DelayB
        DelaySA := DelayA
    }
    Click down
    Sleep %DelaySB%
    Click up
    Sleep %DelaySA%
    If !GetKeyState("RButton", "P") 
    {
        break
    }
}
return

;----------# System #---------------------------

UpdateUI:
GuiControl,, DelayB, %DelayB%
GuiControl,, DelayA, %DelayA%
return

Restart:
Reload
return

GuiClose:
ExitApp
return

Dummy:
return