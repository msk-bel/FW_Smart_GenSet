#ifndef __UART_SERVICE_H
#define __UART_SERVICE_H

#include "stm8s.h"
#include "board.h"
#include "bluetooth.h"

//#define DEBUG_ON
void ms_send_cmd(uint8_t *cmd, uint8_t length);
void mevris_uartSendByte(uint8_t data , uint8_t type);
void mevris_uartSendMultiBytes(uint8_t * , uint8_t, uint8_t );
bool mevris_uartReceiveMultiBytes(uint8_t*);
void SIMCom_uartInit(uint32_t baudRate, UARTCONFIG config);
void vSerialRecieveISR (void);
void vHandleDataRecvUARTviaISR(void);
void clearBuffer (void);

#define MAX_UART_RING_BUFF_SIZE 100

#endif
