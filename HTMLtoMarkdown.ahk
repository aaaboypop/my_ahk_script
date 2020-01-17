#singleInstance, force

Gui,+ToolWindow +AlwaysOnTop
Gui,Add,Text,x0 y80 w200 h100 +Center +cffffff vtext_err,Please drop only HTML / HTM!!
GuiControl,Hide,text_err
Gui,Add,Text,x0 y80 w200 h100 +Center vtext,Drop File HTML Here!
Gui,Show,,HTML to Markdown
Return

GuiClose:
ExitApp
Return


GuiDropFiles:
{
	StringSplit, drop_filepath, A_GuiEvent, `n
	SplitPath, drop_filepath1,, dir, ext
	
	if (ext = "html") || (ext = "htm")
	{
		Gui,Color,00dd00
		GuiControl,Show,text
		GuiControl,Hide,text_err
		Gosub, Start
	}
	else
	{
		Gui,Color,dd0000
		GuiControl,Hide,text
		GuiControl,Show,text_err
	}
}
Return



Start:

;Img Cover
text_output := ""

i:=0
Loop, read, %drop_filepath1%
{
	if RegExMatch(A_LoopReadLine, "<img s.*(jpg|png)", result)
	{
		rer :=  RegExReplace(result,"<img src=""","")		
		img_cover_%i% := rer
		i++
	}
	if(i>0)
	{
		if RegExMatch(A_LoopReadLine, "<table")
		{
			break
		}
	}
}

im:=0
img_cover := ""
while(im<i)
{
	img_cover .= "[![](" img_cover_%im% ")](" img_cover_%im% ")`r"
	im++
}
text_output .= img_cover

;-----------------------------------------------------------------
;General Info Table

i:=0
j:=1
Loop, read, %drop_filepath1%
{
	if RegExMatch(A_LoopReadLine, "<td id=""\d+"">.*", result)
	{
		rer :=  RegExReplace(result,"<td id=""\d+"">","")
		rer :=  RegExReplace(rer,"<\/td>","")
		
		
		i++
		m := Mod(i, 2)
		If(m = 1)
		{
			
			if RegExMatch(rer,"(<|<\/)strong>")
			{
				rer :=  RegExReplace(rer,"(<|<\/)strong>","**")
				column1_%j% := rer
			}
			else
			{
				column1_%j% := rer " : "
			}
		}
		else
		{
			column2_%j% := rer
			j++
		}
	}
}

max_row := j

i:=1
combine:=""
while(i<max_row)
{
	
	data1 .= column1_%i% "`r"
	data2 .= column2_%i% "`r"
	combine .= column1_%i% column2_%i% "`r"
	i++
}
text_output .= "`r**General**"
text_output .= "`r"combine

;-----------------------------------------------------------------
;Img Thumbnail

i:=0
found := 0
Loop, read, %drop_filepath1%
{
	if RegExMatch(A_LoopReadLine, "<\/table>")
	{
		found := 1
	}
	if(found = 1)
	{
		if RegExMatch(A_LoopReadLine, "<img s.*(jpg|png)", result)
		{
			rer :=  RegExReplace(result,"<img src=""","")		
			img_thumb_%i% := rer
			i++
		}
	}
	
	if(i>0)
	{
		if RegExMatch(A_LoopReadLine, "Sample")
		{
			break
		}
	}
}

im:=0
img_thumb:=""
while(im<i)
{
	img_thumb .= "[![](" img_thumb_%im% ")](" img_thumb_%im% ")`r"
	im++
}
text_output .= "`r"img_thumb

;-----------------------------------------------------------------
;Img Sample

i:=0
found := 0
Loop, read, %drop_filepath1%
{
	if RegExMatch(A_LoopReadLine, "<div id=""spoiler")
	{
		found := 1
	}
	if(found = 1)
	{
		if RegExMatch(A_LoopReadLine, "<img s.*(jpg|png)", result)
		{
			rer :=  RegExReplace(result,"<img src=""","")		
			img_sam_%i% := rer
			i++
		}
	}
	
	if(i>0)
	{
		if RegExMatch(A_LoopReadLine, "Sample")
		{
			break
		}
	}
}

im:=0
img_sam:=""
while(im<i)
{
	img_sam .= "[![](" img_sam_%im% ")](" img_sam_%im% ")`r"
	im++
}
text_output .= "`r### Sample"
text_output .= "`r"img_sam

;-----------------------------------------------------------------
;Credit
add_text = ### This Video create with Waifu2X UpRGB Model (and a lot of filter)`r`rGood news. I now have a patreon account! Please consider supporting me on there so that I can continue to make these upscaled hentai, and continue to work on my N4A V2 program. With your support I will continue to post superior resolution hentai here for free. And just so everyone understands, I am not simply increasing resolution for these videos, but I am increasing the quality using my program. This takes a lot of time and a lot of CPU and GPU power. I don’t mind doing it, but any support will really help.`r`r- Patreon https://www.patreon.com/net4anime`r- Discord https://discord.gg/nTN86Pm`r- Facebook Page https://www.facebook.com/Net4Anime`r`r---`r`r- ``Can make tutorial about this?`` - Why not, but i'm not ready. It's hard to teach user to type command, therefore i creating GUI tools for newbie, like https://github.com/aaaboypop/N4A-V2`r- If you want to ``Request video to upscaling`` https://discord.gg/nTN86Pm
text_output .= "`r" add_text
msgbox, %text_output%
Clipboard:= text_output
Return
