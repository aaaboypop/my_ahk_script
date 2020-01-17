#SingleInstance, Force
;----------------------------------------: Control
A:: ; Move Left
If (TestCord)
{
	MouseGetPos, ox, oy
	ox := ox - 1
	Gosub,TestCord
}
Else
{
	Send, A
}
return

D:: ;Move Right
If (TestCord)
{
	MouseGetPos, ox, oy
	ox := ox + 1
	Gosub,TestCord
}
Else
{
	Send, D
}
return

W:: ;Move Up
If (TestCord)
{
	MouseGetPos, ox, oy
	oy := oy - 1
	Gosub,TestCord
}
Else
{
	Send, W
}
return

S:: ;Move Down
If (TestCord)
{
	MouseGetPos, ox, oy
	oy := oy + 1
	Gosub,TestCord
}
Else
{
	Send, S
}
return

;----------------------------------------: Start

Capslock:: ;Enable Test Cord
TestCord := !TestCord
return

;----------------------------------------: Update

TestCord:
Click, %ox%, %oy%, 0
return