/**
  ****************************************************************************************************
  * File:    bluetooth.c
  * Author:  M.Ahmad Naeem
  * Version: V1.0.0
  * Date:    20-May-2021
  * Brief:   This file contains all the functions for creating information string.
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

/* Includes ------------------------------------------------------------------*/
#include "bluetooth.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

extern uint8_t response_buffer[100];

void vHandle_BT_Add_Device_Flow(void)
{
    uint8_t i = 0, j = 0;
    char *ptr;
    bool myInterruptFlag = FALSE;
    uint8_t buff[20];
    uint16_t timeout;

    UART1_ITConfig(UART1_IT_RXNE, DISABLE);
    UART1_ITConfig(UART1_IT_IDLE, DISABLE);
    myInterruptFlag = TRUE;

    //vRefresh_IWDT();//Feed Watchdog
    if (strstr(response_buffer, "+BTCONNECTING:") && strstr(response_buffer, "SPP"))
    {
        delay_ms(100);
        ms_send_cmd(BT_ACCEPT_SPP_REQ, strlen((const char *)BT_ACCEPT_SPP_REQ));
        //vRefresh_IWDT();//Feed Watchdog
        timeout = 0;
        for (i = 0; i < 99; i++)
        {
            while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
                ;
            response_buffer[i] = UART1_ReceiveData8();
            timeout = 0;
        }
        response_buffer[i] = '\0';
    }

    else if (strstr(response_buffer, "KEY") && strstr(response_buffer, PASS_KEY))
    {
        //vRefresh_IWDT();//Feed Watchdog
        delay_ms(100);
        vSend_Data_Over_SPP(aunIMEI, strlen((const char *)aunIMEI), TRUE);
        delay_ms(200);
    }

    if (myInterruptFlag) // Handle UART RX Interrupt enable/disable
    {
        UART1_ITConfig(UART1_IT_RXNE, ENABLE);
        UART1_ITConfig(UART1_IT_IDLE, ENABLE);
        myInterruptFlag = FALSE;
    }
}

void vSend_Data_Over_SPP(char *ptr, uint8_t unLength, bool bAddSpecialChar)
{
    uint8_t temp[16] = "AT+BTSPPSEND=12";
    uint8_t i;

    if (bAddSpecialChar)
        unLength++;
    if (unLength < 10)
    {
        temp[13] = (unLength % 10) | 0x30;
        temp[14] = '\0';
        temp[15] = '\0';
    }
    else if (unLength < 100)
    {
        temp[13] = (unLength / 10) | 0x30;
        temp[14] = (unLength % 10) | 0x30;
        temp[15] = '\0';
    }
    ms_send_cmd(temp, strlen((const char *)temp));
    if (bAddSpecialChar)
        unLength--;
    delay_ms(1000);
    ms_send_cmd(ptr, unLength);
    delay_ms(1000);
    //vRefresh_IWDT();//Feed Watchdog
}