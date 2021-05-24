/*--------Include Guard------------*/
#ifndef __SIMCom_H
#define __SIMCom_H

#include "stm8s.h"
#include "stm8s_delay.h"
#include "board.h"
#include "uart_service.h"
#include <string.h>

extern uint8_t noEchoFlag;
extern uint8_t cloud_connectivity_flag;
extern uint8_t OK;
extern uint8_t gprs_init_flag;
extern char response_buffer[75];

void SIMCom_setup(void);
void gps_data(uint8_t);
int GSM_OK(void);
int GSM_DOWNLOAD(void);
int GSM_HTTP_STATUS(void);
void GPRS_connectvity_check(void);
void GPRS_reconnect(void);
void gprs_init(void);
int GSM_OK_FAST(void);
void SIMComrestart(void);
void checkNum(void);
void getIMEI(void);
void passkeyGenerator(void);
uint8_t getValue(uint8_t , uint8_t);

#endif