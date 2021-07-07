/*-------------------------------Define to prevent recursive inclusion -------------------------------------*/
#ifndef __VIPE_Calculation_H
#define __VIPE_Calculation_H

#include "stm8s.h"
//#include "uart.h"
#include "uart_service.h"

#define accuracyFactor 100
#define powerMultiplier 58800743.78 //powerMultiplier = wattPerHertz*stm8TimerFrequency = 29.40037189*2000000
#define voltageMultiplier 893583.18 //voltageMultiplier = voltPerHertz*stm8TimerFrequency = 0.44679159*2000000
#define currentMultiplier 76328.058 //currentMultiplier = amperePerHertz*stm8TimerFrequency = 0.038164029*2000000

void calcVolt1(uint32_t voltagePeriod1);
void calcVolt2(uint32_t voltagePeriod2);
void calcVolt3(uint32_t voltagePeriod3);
void calcAmp1(uint32_t ampPeriod1);
void calcAmp2(uint32_t ampPeriod2);
void calcAmp3(uint32_t ampPeriod3);
void calcWatt1(uint32_t wattPeriod1);
void calcWatt2(uint32_t wattPeriod2);
void calcWatt3(uint32_t wattPeriod3);

extern uint16_t voltageCalibrationFactor1;
extern uint16_t voltageCalibrationFactor2;
extern uint16_t voltageCalibrationFactor3;
extern uint16_t currentCalibrationFactor1;
extern uint16_t currentCalibrationFactor2;
extern uint16_t currentCalibrationFactor3;
extern uint16_t powerCalibrationFactor1;
extern uint16_t powerCalibrationFactor2;
extern uint16_t powerCalibrationFactor3;
extern uint8_t checkByte;

#endif