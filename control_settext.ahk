Select_File = %1%
WinWait, Choose File to Upload, , 10
ControlSetText, Edit1, %Select_File%, Choose File to Upload
Sleep, 500
ControlClick , Button1, Choose File to Upload