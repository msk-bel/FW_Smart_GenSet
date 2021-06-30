/*-------------------------------Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#include "stm8s.h"
#include "board.h"
#include "uart_service.h"
#include "metering.h"
#include "string.h"
#include "SIMCom.h"
#include "stdio.h"
#include "stdlib.h"
#include "stm8s_flash.h"


void _ADC_Init(void);
void storeDataToSend(uint8_t, uint32_t);
void clearBuffer (void);
void sms_receive(void);
void sendSMSCurrent(uint32_t Current, uint8_t *cell_number);
void sendSMSVoltage(uint32_t Voltage,uint8_t *cell_number);
void sendSMSPower(uint32_t Power,uint8_t *cell_number);
void getbatteryvolt(void);
void gettemp1(void);
void gettemp2(void);
bool bSendSMS(char *message, uint8_t messageLength, char *Number);
void sendDataToCloud(void);
void systemSetup(void);
void getFuelLevel(void);

#define maxPeriodWidth 200000 //100ms: 1tics=0.5us so 200000=100ms
#define versionNumber "STM8s 0.2.000"

//void send_data_cloud(void);
//volatile uint8_t sms_generated_pin=0; //set it 32 bit in new board

//uint8_t powerCalibrationFactor1 = initialCalibrationFactor; /* to store powerCalibrationFactor1 recieved from ESP8266 */
//uint8_t powerCalibrationFactor2 = initialCalibrationFactor; /* to store powerCalibrationFactor1 recieved from ESP8266 */
//uint8_t powerCalibrationFactor3 = initialCalibrationFactor; /* to store powerCalibrationFactor1 recieved from ESP8266 */

/*
====================================
Voltage, Current, Energy & Power variables
====================================
*/
extern float/*uint32_t*/ voltagePeriod1;
extern float/*uint32_t*/ voltagePeriod2;
extern float/*uint32_t*/ voltagePeriod3;
extern float/*uint32_t*/ currentPeriod1;
extern float/*uint32_t*/ currentPeriod2;
extern float/*uint32_t*/ currentPeriod3;
extern float/*uint32_t*/ powerPeriod1;
extern float/*uint32_t*/ powerPeriod2;
extern float/*uint32_t*/ powerPeriod3;
extern uint32_t energyPhase1;
extern uint32_t energyPhase2;
extern uint32_t energyPhase3;
extern uint8_t voltageCalibrationFactor1;
extern uint8_t voltageCalibrationFactor2;
extern uint8_t voltageCalibrationFactor3;
extern uint8_t currentCalibrationFactor1;
extern uint8_t currentCalibrationFactor2;
extern uint8_t currentCalibrationFactor3;
extern uint8_t powerCalibrationFactor1;
extern uint8_t powerCalibrationFactor2;
extern uint8_t powerCalibrationFactor3;
extern uint8_t checkByte;
extern @near uint32_t Voltage_Phase1;
extern @near uint32_t Ampere_Phase1;
extern @near uint32_t Watt_Phase1;
extern @near uint32_t Voltage_Phase2;
extern @near uint32_t Ampere_Phase2;
extern @near uint32_t Watt_Phase2;
extern @near uint32_t Voltage_Phase3;
extern @near uint32_t Ampere_Phase3;
extern @near uint32_t Watt_Phase3;
//send and recieve
#define uartTimout 1000000 //500ms: 1tics=0.5us so 1000000=500ms
#define stmDataSendSize 48
#define stmDataReceiveSize 5
uint8_t stmDataReceive[stmDataReceiveSize] = {0, 0, 0, 0, 0};
uint32_t previousTics = 0;

#endif
