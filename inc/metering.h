#ifndef __METERING_H
#define __METERING_H

#include "stm8s.h"
#include <stdbool.h>
#include "board.h"
#include "stm8s_delay.h"
#include "VIPE_Calculation.h"
//#define FREQUENCY_DEBUG_ON

#define powerOverflowCountMax 100//max period for power=timer2_time*powerOverflowCountMax =32m*100=3.2sec
#define powerMultiplier 58800743.78// powerMultiplier = powerPerHertz*stm8TimerFrequency = 5.8*2000000
#define energyResolution 36000000//0.1KWh=360000Ws and decimal accuracy=100 so energy resolution=360000*100
#define energyDecimalAccuracy 100//two decimal place accuracy
#define initialCalibrationFactor 100
#define discardPulseTimeout 6000000//3s: 1tics=0.5us so 6000000=3s
#define powerAccumulateCountMax 58
#define powerAccumulateTime 1.900544 //1.900544 sec with accuracy of two decimal place:58*0.032768*100

extern uint8_t voltCurrent1OverflowCount; // defined in stm8s_it.c
extern uint8_t voltCurrent2OverflowCount; // defined in stm8s_it.c
extern uint8_t voltCurrent3OverflowCount; // defined in stm8s_it.c

void calculateVoltCurrent(uint32_t timeout);

#endif 



