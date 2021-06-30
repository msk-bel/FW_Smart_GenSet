#include "uart_service.h"

@near uint8_t aunRecievedData[MAX_UART_RING_BUFF_SIZE];
extern @near uint8_t response_buffer[100];
bool bOkFlag;
uint8_t unRecievePtr = 0;
uint8_t unReadPtr = 0;
uint8_t dataLength = 0;
extern void sms_receive(void);
/*
==============================================================
*Function: SIMCom_uartInit
*
*wrapper function
===============================================================
*/
/*void SIMCom_uartInit(uint32_t baudRate, UARTCONFIG config)
{
  _SIMCom_uartInit(baudRate, config);
}*/

/*
==============================================================
*Function: ms_send_cmd
*
* Send Commands to SIMCom 868 
===============================================================
*/
void ms_send_cmd(uint8_t *cmd, uint8_t length)
{
  uint8_t i;
  for (i = 0; i < length; i++)
  {
    while (!UART1_GetFlagStatus(UART1_FLAG_TC))
      ;
    UART1_SendData8(*(cmd + i));
  }

  /* Send CR (Carriage Return) */
  while (!UART1_GetFlagStatus(UART1_FLAG_TC))
    ;
  UART1_SendData8(0x0D);
}

void ms_send_cmd_TCP(uint8_t *cmd, uint8_t length)
{
  uint8_t i;
  for (i = 0; i < length; i++)
  {
    while (!UART1_GetFlagStatus(UART1_FLAG_TC))
      ;
    UART1_SendData8(*(cmd + i));
  }

  /* Send CR (Carriage Return) */
  while (!UART1_GetFlagStatus(UART1_FLAG_TC))
    ;
  UART1_SendData8(0x1A);
}

void vSerialRecieveISR(void)
{
  aunRecievedData[unRecievePtr] = UART1_ReceiveData8();
  unRecievePtr++;
  if (unRecievePtr == MAX_UART_RING_BUFF_SIZE)
  {
    unRecievePtr = 0;
  }
}

void vHandleDataRecvUARTviaISR(void)
{
  uint8_t i = 0;
  bool start = FALSE, end = FALSE;
  clearBuffer();

  while (unReadPtr != unRecievePtr && i < 100)
  {
    response_buffer[i++] = aunRecievedData[unReadPtr++];
    if (unReadPtr == MAX_UART_RING_BUFF_SIZE)
    {
      unReadPtr = 0;
    }
  }
  //vRefresh_IWDT();//Feed Watchdog
  if (strstr(response_buffer, "OK"))
    bOkFlag = TRUE;
  else if (strstr(response_buffer, "DOWNLOAD"))
    bOkFlag = TRUE;
  else
    bOkFlag = FALSE;
  // if (strstr(response_buffer, "+BT"))
  // {
    //ms_send_cmd(response_buffer, strlen((const char *)response_buffer));
    // vHandle_BT_Add_Device_Flow();
  // }
  if (strstr(response_buffer, "+IPD") || strstr(response_buffer, "RECV FROM:"))
  {
    //ms_send_cmd("response_buffer", strlen((const char *)"response_buffer")); //  no echo
    //ms_send_cmd(response_buffer, 100); //  no echo
    
    vHandleMevris_MQTT_Recv_Data();
  }
  //Added by Saqib
  // if (strstr(response_buffer, "+CMTI:") )
  // {
    // sms_receive();
  // }
}