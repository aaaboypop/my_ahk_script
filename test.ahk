asd := 123
myfunc4()

myfunc4(){
	global asd
	msgbox,% asd
	Return 
}


msgbox,% myfunc0("pond_pop")

myfunc0(w){
	word1 := "Hi, " w " nice to meet you!"
	Return word1
}

;-------------------------------

a:=5
b:=15
msgbox,% myfunc1(a)

msgbox,% myfunc3()

myfunc3(){
	global a, b
	Return b
}

myfunc1(Byref var1){
	;global var1
	Return var1
}

;-------------------------------

msgbox,% myfunc2(1,10)

myfunc2(a,b){
	
	i := 0
	while(i<b)
	{
		sum += a
		a+=1
		i+=1
	}
	Return sum
}