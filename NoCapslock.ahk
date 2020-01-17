CapsLock::
cap =: GetKeyState("Capslock", "T")
if(cap=1)
{
	SendPlay {CapsLock}
}
Return

