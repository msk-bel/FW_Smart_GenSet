/*--------Include Guard------------*/
#ifndef __SIMCom_H
#define __SIMCom_H

#include "stm8s.h"
#include "stm8s_delay.h"
#include "board.h"
#include "uart_service.h"
#include <string.h>
#include "mqtt_protocol.h"
#include "cloudService.h"

extern uint8_t noEchoFlag;
extern uint8_t cloud_connectivity_flag;
extern uint8_t OK;
extern uint8_t gprs_init_flag;
extern @near uint8_t response_buffer[100];

typedef enum TCP_STATUS_ENUM
{
	eTCP_STAT_UNKNOWN,
	eTCP_STAT_IP_INITIAL,
	eTCP_STAT_IP_START,
	eTCP_STAT_IP_CONFIG,
	eTCP_STAT_IP_GPRSACT,
	eTCP_STAT_IP_STATUS,
	eTCP_STAT_CONNECTING,
	eTCP_STAT_CONNECT_OK,
	eTCP_STAT_CLOSING,
	eTCP_STAT_CLOSED,
	eTCP_STAT_PDP_DEACT
}enTCP_STATUS;

void SIMCom_setup(void);
int GSM_OK(void);
// int GSM_DOWNLOAD(void);
void GPRS_connectvity_check(void);
void GPRS_reconnect(void);
void gprs_init(void);
// int GSM_OK_FAST(void);
void SIMComrestart(void);
void checkNum(void);
void getIMEI(void);
// void passkeyGenerator(void);
void vInit_MQTT (void);
bool bSendDataOverTCP (uint8_t *, uint8_t);
// uint8_t getValue(uint8_t , uint8_t);
void vClearBuffer(char *, uint8_t);
enum TCP_STATUS_ENUM enGet_TCP_Status(void);
void vHandle_MQTT( void );
uint8_t *punGetSIM_ICCID(void);
uint8_t *punGet_SIM_NUmber(void);

#endif