Process_Suspend("ffmpeg.exe")

MsgBox, Notepad.exe suspended

Process_Resume("ffmpeg.exe")

MsgBox, Notepad.exe resumed



;============================== Working on WinXP+

Process_Suspend(PID_or_Name){

    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name

    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)

    If !h   

        Return -1

    DllCall("ntdll.dll\NtSuspendProcess", "Int", h)

    DllCall("CloseHandle", "Int", h)

}



Process_Resume(PID_or_Name){

    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name

    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)

    If !h   

        Return -1

    DllCall("ntdll.dll\NtResumeProcess", "Int", h)

    DllCall("CloseHandle", "Int", h)

}



ProcExist(PID_or_Name=""){

    Process, Exist, % (PID_or_Name="") ? DllCall("GetCurrentProcessID") : PID_or_Name

    Return Errorlevel

}