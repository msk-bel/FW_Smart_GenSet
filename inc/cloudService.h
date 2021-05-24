#ifndef __cloudService_H
#define __cloudService_H

#include "stm8s.h"
#include <string.h>
#include "stdio.h"
#include "uart_service.h"

int createStringToSend(uint8_t *);
void sendToHTTP(uint8_t *, uint8_t);
uint8_t unHTTPACTION_Response(void);
void vTerminateHTTP( void );

extern @near uint32_t Voltage_Phase1;
extern @near uint32_t Ampere_Phase1;
extern @near uint32_t Watt_Phase1;
extern @near uint32_t Voltage_Phase2;
extern @near uint32_t Ampere_Phase2;
extern @near uint32_t Watt_Phase2;
extern @near uint32_t Voltage_Phase3;
extern @near uint32_t Ampere_Phase3;
extern @near uint32_t Watt_Phase3;

#endif