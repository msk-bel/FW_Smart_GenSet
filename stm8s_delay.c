#include "stm8s_delay.h"

uint32_t ticsOverflowCounter=0;

void delay_us(unsigned int  value)
{
	register unsigned int loops =  (dly_const * value) ;
	
	while(loops)
	{
		_asm ("nop");
		loops--;
	};
}


void delay_ms(unsigned int  value)
{
	while(value)
	{
		delay_us(1000);
		value--;
	};
}

uint32_t getTics(void)
{  
  uint16_t getTimerTics=TIM2_GetCounter();
 	return (uint32_t)ticsOverflowCounter*timer2MaxCount+getTimerTics;
}

