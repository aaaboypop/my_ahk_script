url := "https://www.autohotkey.com/boards/viewtopic.php?t=36869"

if !wb := GetIePagePwbByUrl(url) {
   wb := ComObjCreate("InternetExplorer.Application")
   wb.Visible := True
   wb.Navigate(url)
   while (wb.Busy || wb.ReadyState != 4) ;wait browser load
      Sleep 100
   
   Sleep, 1000 ;wait javascript load
   ;wb.document.querySelector("#profile87391 > .has-avatar.no-profile-rank > .avatar-container > .avatar > .avatar").click()
   Clipboard := wb.document.querySelector("#post_content169686 > div > div:nth-child(4) > div > pre > code").outerhtml
   ;Clipboard := Wb.document.documentElement.outerhtml

   MsgBox % InternetGetCookieEx(url)

   ;wb.quit ;exit ie
}

GetIePagePwbByUrl(url) {
   for window in ComObjCreate("Shell.Application").Windows
      if InStr(window.FullName, "iexplore.exe") && window.LocationURL = url
         Return window
}



; Requires Internet Explorer 8.0 or later.
InternetGetCookieEx(URL) {
	Loop, 2 {
		if (A_Index = 2) {
			VarSetCapacity(cookieData, size, 0)
		}
		DllCall( "Wininet.dll\InternetGetCookieEx"
		       , "ptr", &URL, "ptr", 0, "ptr", &cookieData, "int*", size
		       , "uint", 8192 ; INTERNET_COOKIE_HTTPONLY
		       , "ptr", 0 )
	}
	return StrGet(&cookieData)
}