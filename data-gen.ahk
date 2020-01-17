s_day := 1
s_month := 1
s_yeat := 2019

low_r := 10
high_r := 100
dif_r := 20

out_clip := ""

taget_day := 365

z:=0
while(z<=(taget_day*2)+1)
{
	Random, day_ran%z%, low_r, high_r
	if(z=0)
	{
		z++
		continue
	}
	
	zlast := z-1
	rnd_1 := day_ran%zlast%
	rnd_2 := day_ran%z%
	rnd_diff := rnd_1 - rnd_2
	Abs(rnd_diff)
	
	while(rnd_diff>dif_r)
	{
		Random, day_ran%z%, low_r, high_r
		rnd_1 := day_ran%zlast%
		rnd_2 := day_ran%z%
		rnd_diff := rnd_1 - rnd_2
		Abs(rnd_diff)
	}
	z++
}


f:=1
z:=1
a:=1
while(z<=taget_day*2)
{
	x1 := z-1
	x2 := z
	x3 := z+1
	
	p1 := day_ran%x1%
	p2 := day_ran%x2%
	p3 := day_ran%x3%
	
	d := p1-p2
	d := d*-1
	e0 := p1
	e1 := p1 + (0.02*d)
	e2 := p1 + (0.04*d) 
	e3 := p1 + (0.08*d) 
	e4 := p1 + (0.16*d)
	e5 := p1 + (0.30*d)
	e6 := p1 + (0.50*d)
	e7 := p1 + (0.70*d) 
	e8 := p1 + (0.84*d) 
	e9 := p1 + (0.92*d)
	e10 := p1 + (0.96*d)
	e11 := p1 + (0.98*d)
	e12 := p2
	z++
	
	
	s := 0
	while(s<=11)
	{
		pp1 := e%s%
		t := s+1
		pp2 := e%t%
		
		dd := pp1-pp2
		dd := dd*-1
		ee0 := pp1
		ee1 := pp1 + (0.04*dd) 
		ee2 := pp1 + (0.16*dd)
		ee3 := pp1 + (0.50*dd)
		ee4 := pp1 + (0.84*dd) 
		ee5 := pp1 + (0.96*dd)
		
		d_1_%f% := ee0
		f++
		d_1_%f% := ee1
		f++
		d_1_%f% := ee2
		f++
		d_1_%f% := ee3
		f++
		d_1_%f% := ee4
		f++
		d_1_%f% := ee5
		f++


		s++
	}
	

	
}


w := 1

x := 1
while(x<=taget_day)
{

	if((s_month = 1) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if(Mod(s_yeat, 4) = 0)
	{
		if((s_month = 2) and (s_day > 29))
		{
			s_month++
			s_day := 0
		}
	}
	else if((s_month = 2) and (s_day > 28))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 3) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 4) and (s_day > 30))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 5) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 6) and (s_day > 30))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 7) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 8) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 9) and (s_day > 30))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 10) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 11) and (s_day > 30))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 12) and (s_day > 31))
	{
		s_month++
		s_day := 0
	}
	if((s_month = 13) and (s_day = 0))
	{
		s_month := 1
		s_yeat++
	}
	if(s_day = 0)
	{
		s_day++
	}
	
	if (StrLen(s_day)<2)
	{
		s_day1 := "0" s_day
	}
	else
	{
		s_day1 := s_day
	}
	

	if (StrLen(s_month)<2)
	{
		s_month1 := "0" s_month
	}
	else
	{
		s_month1 := s_month
	}
	
	M := 0
	H := 0
	while(H<24)
	{
		If(M >59)
		{
			H++
			M:=0
			If(H>23)
				Break
		}
		
		if (StrLen(H)<2)
		{
			H1 := "0" H
		}
		else
		{
			H1 := H
		}
		if (StrLen(M)<2)
		{
			M1 := "0" M
		}
		else
		{
			M1 := M
		}
		
		i := 1
		while(i<=3)
		{
			aaa := d_1_%w%
			ex := Round(aaa)
			
			Random, pm100%i%,% ex,% ex*1.1
			pm100%i% := Abs(pm100%i%)
			pm100%i% := round(pm100%i%)
			Random, pm25%i%,% ex*0.90,% ex
			pm25%i% := Abs(pm25%i%)
			pm25%i% := round(pm25%i%)
			Random, pm10%i%,% ex*0.82,% ex*0.90
			pm10%i% := Abs(pm10%i%)
			pm10%i% := round(pm10%i%)
			i++
		}
		
		out_text := ""
		i := 1
		while(i<=3)
		{
			out_text .= ", " pm10%i% ", " pm25%i% ", "  pm100%i%
			i++
		}
		w++
		
		out_clip .= "('" s_yeat "-" s_month1 "-" s_day1 " " H1 ":" M1 ":00'" out_text "),`n"
		
		;tooltip,% "('" s_yeat "-" s_month1 "-" s_day1 " " H1 ":" M1 ":00'" out_text "),"
		
		;tooltip,% H1 ":" M1 " - " s_day1 " / " s_month1 " / " s_yeat
		
		M += 10
	}
	
	tooltip,% s_day1 " / " s_month1 " / " s_yeat
	
	x++
	s_day++
}
msgbox,% w-1
FileAppend, %out_clip%, %A_WorkingDir%\textout.txt




Return

