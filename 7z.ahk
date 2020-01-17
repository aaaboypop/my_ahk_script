Get_Clip := Clipboard
SplitPath, Get_Clip, name, dir, ext, name_no_ext, drive
If((ext<>"") or (drive<>"c:"))
{
    ExitApp, 1
}
Else
{
    FileName = %name%.7z
    Pass = n4a
    Command = 7z a "%dir%\%FileName%" "%Get_Clip%" -mx0 -p%Pass%
    RunWait, %ComSpec% /c %Command%
    Command = explorer /select,"%dir%\%FileName%"
    ;Run, %ComSpec% /c %Command%
    Clipboard = %dir%\%FileName%
    ExitApp, 0
}
