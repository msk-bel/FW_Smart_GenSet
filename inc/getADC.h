/*-------------------------------Define to prevent recursive inclusion -------------------------------------*/
#ifndef __getADC_H
#define __getADC_H

#include "stm8s_adc2.h"
#include "stm8s_delay.h"
#include <math.h>
#include "stdio.h"
#include "stdlib.h"

void calculateBatVolt(uint16_t);
void calculateTemp1(uint16_t);
void calculateTemp2(uint16_t);
void calculateFuelLevel(uint16_t);

#endif