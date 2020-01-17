copy_buffer%i% := 0

loop
{
	if(copy_buffer%p_cycle%=0)
	{
		buffer := ""
		copy_buffer%p_cycle% := 1
	}
	else
	{
		buffer := p_cycle
		copy_buffer%p_cycle% := 0
	}
}