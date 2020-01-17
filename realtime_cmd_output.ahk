#SingleInstance, Force
DetectHiddenWindows,On
Run,%ComSpec% /k,,Hide UseErrorLevel,pid
if not ErrorLevel
{
while !WinExist("ahk_pid" pid)
Sleep,10
DllCall("AttachConsole","UInt",pid)
}

CMD=ping -n 10 8.8.8.8
objShell:=ComObjCreate("WScript.Shell")
objExec:=objShell.Exec(CMD)

while,!objExec.StdOut.AtEndOfStream
{
  strStdOut:=objExec.StdOut.readline()
  MsgBox,,, %strStdOut%,0.5
}
MsgBox, %Pid%
Process, Close, %Pid%
exitapp