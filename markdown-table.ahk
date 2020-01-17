text1 := "|General                        |                      |`r"
text1 .= "| ----------------------------- | -------------------------- |`r"
aaa := clipboard
Loop, parse, aaa, `n
{
	st := 1
	aaa2 := A_LoopField
	aaa1("File size")
	aaa1("Duration")
	aaa1("Overall bit rate")
	aaa1("Format")
	aaa1("Bit rate")
	aaa1("Width")
	aaa1("Height")
	aaa1("Display aspect ratio")
	aaa1("Frame rate mode")
	aaa1("Frame rate  ")
	aaa1("Chroma subsampling ")
	aaa1("Bit depth")
	aaa1("Scan type")
	aaa1("Codec configuration box")
	aaa1("Sampling rate")
	aaa1("Compression mode")
}
clipboard := text1
Return

aaa1(var1){
global text1
global aaa2
global st
	if(st=0)
	{
		Return
	}
	
	IfInString, aaa2, %var1%
	{
		aaa2 := StrReplace(aaa2, " : ", " | ")
		StringTrimRight, aaa2, aaa2, 1
		text1 .= "|" aaa2 "|`r"
		st := 0
		asd := "Overall bit rate  "
		asd1 := "Codec configuration box"
		IfInString, aaa2, %asd%
		{
			text1 .= "|**Video**                      |                            |`r"
		}
		else IfInString, aaa2, %asd1%
		{
			text1 .= "|**Audio**                      |                            |`r"
		}
	}
}
Return
