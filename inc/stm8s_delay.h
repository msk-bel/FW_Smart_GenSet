#include "stm8s.h" 
#include "board.h" 

#define F_CPU 				16000000UL 
#define dly_const			(F_CPU / 16000000.0F) 
#define milliSec 2000//2000tics=1ms

void delay_us(unsigned int  value);
void delay_ms(unsigned int value);
uint32_t getTics(void);