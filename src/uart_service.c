/**
  ****************************************************************************************************
  * File:    uart_service.c
  * Author      M.Ahmad Naeem
  * Co-Author   Saqib Kamal
  * Version: V1.1.0
  * Date:    20-May-2021
  * Brief:   This file contains all the functions for reading .
   ***************************************************************************************************
  * Attention:
  *                         COPYRIGHT 2021 BlueEast
  *
  * Licensed under ************* License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ************************************************************************************************************
  */

/* Includes ------------------------------------------------------------------*/#include "uart_service.h"

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
  #ifdef MODULE_SIMCOM_SIM868
  if (strstr(response_buffer, "+IPD") || strstr(response_buffer, "RECV FROM:"))
  #endif
  #ifdef MODULE_QUECTEL_EC200U_DISABLED
  if (strstr(response_buffer, "+QIURC: \"recv\""))
  #endif
  #ifdef MODULE_QUECTEL_EC200U
  if (strstr(response_buffer, "+QMTRECV:"))
  #endif
  {
    //ms_send_cmd("response_buffer", strlen((const char *)"response_buffer")); //  no echo
    //ms_send_cmd(response_buffer, 100); //  no echo
    
    vHandleMevris_MQTT_Recv_Data();
  }
  //Added by Saqib
  if (strstr(response_buffer, "+CMTI:") )
  {
    sms_receive();
  }
}