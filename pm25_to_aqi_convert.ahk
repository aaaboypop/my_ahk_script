input := 100
pm25 := AQIPM25(input)
pm100 := AQIPM10(input)
msgbox, PM25 %pm25% `nPM100 %pm100%

Linear(AQIhigh, AQIlow, Conchigh, Conclow, Concentration){
    linear:=""
    Conc:=Concentration
    a:=""
    a:=((Conc-Conclow)/(Conchigh-Conclow))*(AQIhigh-AQIlow)+AQIlow
    linear:=round(a)
    return linear
}

AQIPM25(Concentration){
    AQI:=""
    c:=(floor(10*Concentration))/10
    if (c>=0 && c<12.1)
    {
        AQI:=Linear(50,0,12,0,c)
    }
    else if (c>=12.1 && c<35.5)
    {
        AQI:=Linear(100,51,35.4,12.1,c)
    }
    else if (c>=35.5 && c<55.5)
    {
        AQI:=Linear(150,101,55.4,35.5,c)
    }
    else if (c>=55.5 && c<150.5)
    {
        AQI:=Linear(200,151,150.4,55.5,c)
    }
    else if (c>=150.5 && c<250.5)
    {
        AQI:=Linear(300,201,250.4,150.5,c)
    }
    else if (c>=250.5 && c<350.5)
    {
        AQI:=Linear(400,301,350.4,250.5,c)
    }
    else if (c>=350.5 && c<500.5)
    {
        AQI:=Linear(500,401,500.4,350.5,c)
    }
    else 
    {
        msgbox, error 25
    }
    return AQI
}


AQIPM10(Concentration){
    AQI:=""
    c:=floor(Concentration)
    if (c>=0 && c<55)
    {
        AQI:=Linear(50,0,54,0,c)
    }
    else if (c>=55 && c<155)
    {
        AQI:=Linear(100,51,154,55,c)
    }
    else if (c>=155 && c<255)
    {
        AQI:=Linear(150,101,254,155,c)
    }
    else if (c>=255 && c<355)
    {
        AQI:=Linear(200,151,354,255,c)
    }
    else if (c>=355 && c<425)
    {
        AQI:=Linear(300,201,424,355,c)
    }
    else if (c>=425 && c<505)
    {
        AQI:=Linear(400,301,504,425,c)
    }
    else if (c>=505 && c<605)
    {
        AQI:=Linear(500,401,604,505,c)
    }
    else 
    {
        msgbox, error 100
    }
    return AQI
}
