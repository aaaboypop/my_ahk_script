#SingleInstance, Force
LAlt & c::
    Clip := Clipboard
	if RegExMatch(Clip, ".*illust_")
	{
		Sauce := RegExReplace(Clip, ".*illust_", "http://pixiv.net/member_illust.php?mode=medium&illust_id=")
		Sauce := RegExReplace(Sauce, "_201\d.*", "")
	}
	else if RegExMatch(Clip, "\/\d+_p(\d+|\d+_.*).(jpg|png)")
	{
		RegExMatch(Clip, "\/\d+_p(\d+|\d+_.*).(jpg|png)", Sauce)
		Sauce := RegExReplace(Sauce, "_p(\d+|\d+_.*).(jpg|png)", "")
		Sauce := RegExReplace(Sauce, ".*\/", "http://pixiv.net/member_illust.php?mode=medium&illust_id=")
	}
	else if RegExMatch(Clip, "\/yande.re(_|%20)\d+")
	{
		RegExMatch(Clip, "\/yande.re(_|%20)\d+", Sauce)
		Sauce := RegExReplace(Sauce, "\/yande.re(_|%20)", "https://yande.re/post/show/")
	}
	else if RegExMatch(Clip, "http\S\:\/\/drive.google.com\/a\/mail.ccsf.edu\/uc\?id=")
	{
		RegExMatch(Clip, "mail.ccsf.edu.*", Sauce)
		Sauce := RegExReplace(Sauce, ".*id=", "https://drive.google.com/uc?export=download&id=")
		Sleep 30
		Clipboard := Sauce
		Sleep 30
		Send ^!{a}
		Sleep 333
		Send {enter}
	}
	else if RegExMatch(Clip, "http\S\:\/\/filetransfer.io\/data-package\/")
	{
		RegExMatch(Clip, "http\S\:\/\/filetransfer.io\/data-package\/.*", Sauce)
		Sauce .= "?do=download"
		Sleep 30
		Clipboard := Sauce
		Sleep 30
		Send ^!{a}
		Sleep 333
	}
	else if RegExMatch(Clip, "http\S:\/\/drive.google.com.*export=download")
	{
		RegExMatch(Clip, "id=.*", Sauce)
		if RegExMatch(Sauce, "&")
		{
			Sauce1 := RegExReplace(Sauce, "&.*", "")
			Sauce := Sauce1
		}
		Sauce := RegExReplace(Sauce, "id=", "https://drive.google.com/open?id=")
	}
	Clipboard := Sauce
return
