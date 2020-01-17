for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where name like '%autohotkey%'")
output .= process.CommandLine "`r" process.ProcessId "`r`r"
Clipboard := output