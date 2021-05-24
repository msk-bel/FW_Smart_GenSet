/**
  ****************************************************************************************************
  * File:    SIMCOM.c
  * Author:  Ex-Employees
  * Co-Author M.Ahmad Naeem
  * Version: V1.0.0
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

 /* Includes ------------------------------------------------------------------*/
#include "SIMCom.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

uint8_t aunIMEI[20];
uint8_t PASS_KEY[16];

/*
==============================
*Function: SIMCom_setup
*
*Setup the SIM 868 module
==============================
*/
void SIMCom_setup(void)
{
	delay_ms(100);
	SIMComrestart(); //Restart the SICOM 868 module 
	delay_ms(10000);

	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
	delay_ms(20000); //need to adjust the delay
	delay_ms(1000);

	ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
	delay_ms(1000);

	ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
	delay_ms(1000);

	ms_send_cmd(GPS_ON, strlen((const char *)GPS_ON));
	delay_ms(1000);

	ms_send_cmd(rmc, strlen((const char *)rmc));
	delay_ms(1000);

	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
	delay_ms(1000);

	ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
	delay_ms(1000);

	ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
	delay_ms(1000);

	ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
	delay_ms(1000);

	ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
	delay_ms(1000);

	ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_SET_CONN_SINGLE, strlen((const char *)TCP_SET_CONN_SINGLE)); /* OPEN BEARER */
	delay_ms(1000);

	ms_send_cmd(TCP_MODE_TRANSPARENT_OFF, strlen((const char *)TCP_MODE_TRANSPARENT_OFF)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_MODE_RESPONSE_NORMAL, strlen((const char *)TCP_MODE_RESPONSE_NORMAL)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_MODE_SEND_PROMPT_ECHO, strlen((const char *)TCP_MODE_SEND_PROMPT_ECHO)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_MODE_REMOTE_IP_PORT_ON, strlen((const char *)TCP_MODE_REMOTE_IP_PORT_ON)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_MODE_HEADER_ON_RECV_ON, strlen((const char *)TCP_MODE_HEADER_ON_RECV_ON)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_SAVE_CONTEXT, strlen((const char *)TCP_SAVE_CONTEXT)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
	delay_ms(1000);

    ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
	delay_ms(1000);

	ms_send_cmd(BT_TURN_ON, strlen((const char *)BT_TURN_ON));
	delay_ms(5000);

	ms_send_cmd(BT_SET_NAME, strlen((const char *)BT_SET_NAME));
	delay_ms(3000);

	ms_send_cmd(BT_SET_PIN, strlen((const char *)BT_SET_PIN));
	delay_ms(3000);

	getIMEI();
	passkeyGenerator();
}

/*
==============================
*Function: GPRS_reconnect
*
*Reconnect to GPRS service.
==============================
*/
/*void GPRS_reconnect(void)
{
	/*------------------try connecting to GPRS if not connected ------------------

	//To do : cloud_connectivity_flag needs to be set by proper checking if gprs is connected
	// if (cloud_connectivity_flag!=1)
	// {
	//	 delay_ms(3000);

	//"ATE0"
	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); //  no echo
	delay_ms(200);
	//"AT+CGATT=1"
	ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); //  ATTACH TO GPRS SERVICE
	delay_ms(200);
	//"AT+SAPBR=3,1,\"CONTYPE\",\"GPRS\""
	ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); // CONFIG CONNECTION AS GPRS
	delay_ms(200);
	//"AT+SAPBR=3,1,\"APN\",\"\""
	ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); //  SET MOBILE NETWORK APN
	delay_ms(200);
	//"AT+SAPBR=1,1"

	ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); // OPEN BEARER
														   //delay_ms(300);
														   // OK=GSM_OK();
														   // if (OK==1)
	cloud_connectivity_flag = 1;
}*/

/*
==============================
*Function: SIMComrestart
*
*Restart the SIMCom module
==============================
*/
void SIMComrestart()
{
	ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
	delay_ms(800);

	GPIO_WriteHigh(PWRKEY);
	delay_ms(1000);

	GPIO_WriteLow(PWRKEY);
	delay_ms(1000);
}

void checkNum()
{
	uint16_t timeout = 0;
	uint8_t s;
	ms_send_cmd(check_num, strlen((const char *)check_num)); // SMS read

	for (s = 0; s < 75; s++)
	{
		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
			;
		response_buffer[s] = UART1_ReceiveData8();
		timeout = 0;
	}
}

void getIMEI(void)
{
	uint16_t ulTimout;
	uint8_t localBuffer[25];
	uint8_t i;
	uint8_t j;

	UART1_ITConfig(UART1_IT_RXNE, DISABLE);
	UART1_ITConfig(UART1_IT_IDLE, DISABLE);

	ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
	//delay_ms(200);

	for (i = 0; i < 25; i++)
	{
		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
			;
		localBuffer[i] = UART1_ReceiveData8();
		ulTimout = 0;
	}
	localBuffer[i] = '\0';
	j = 0;
	for (i = 2; i < 17; i++)
	{
		aunIMEI[j] = localBuffer[i];
		j++;
	}
	aunIMEI[j] = '\0';
	delay_ms(200);
	//ms_send_cmd(aunIMEI, strlen((const char *)aunIMEI)); //"AT+HTTPSSL=1"
	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
}

void passkeyGenerator()
{
	uint8_t temp[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	uint8_t i = 0;
	uint8_t checksum = 0;

	for (i = 0; i < 15; i++)
	{
		checksum ^= aunIMEI[i];
	}
	for (i = 0; i < 15; i++)
	{
		temp[i] = ((aunIMEI[i] + aunIMEI[(i + 1) % 15])
                   ^ (aunIMEI[(i + 2) % 15] + aunIMEI[(i + 3) % 15])
                   ^ (aunIMEI[(i + 4) % 15] + aunIMEI[(i + 5) % 15])
                   ^ (aunIMEI[(i + 6) % 15] + aunIMEI[(i + 7) % 15])
                   ^ (aunIMEI[(i + 8) % 15] + aunIMEI[(i + 9) % 15])
                   ^ (aunIMEI[(i + 10) % 15] + aunIMEI[(i + 11) % 15])
                   ^ (aunIMEI[(i + 12) % 15] + aunIMEI[(i + 13) % 15])
                   ^ (aunIMEI[(i + 14) % 15] + checksum)) % 10;
	}

	for (i = 0; i < 15; i++)
	{
		PASS_KEY[i] = getValue(temp[i], i);
	}
	PASS_KEY[i] = '\0';
	delay_ms(200);
	ms_send_cmd(PASS_KEY, strlen((const char *)PASS_KEY));
	delay_ms(200);
}

uint8_t getValue(uint8_t key, uint8_t pos)
{
	uint8_t temp;

	switch (pos)
    {
        case 0:
            if (key < 5)
                temp = key + 0x56;	// Ascii char from 0x56 to 0x5A
            else
                temp = key + 0x71;	// Ascii char from 0x76 to 0x7A
            break;
        case 1:
            temp = key + 0x30;	// Ascii char 0x30 to 0x39
            break;
        case 2:
            if (key < 5)
                temp = key + 0x35;	// Ascii char from 0x35 to 0x39
            else
                temp = key + 0x3C;	// Ascii char from 0x41 to 0x45
            break;
        case 3:
            if (key < 1)
                temp = key + 0x21;	// Ascii char 0x21
            else if (key < 5)
                temp = key + 0x22;	// Ascii char from 0x23 to 0x26
            else if (key < 7)
                temp = key + 0x29;	// Ascii char 0x2F
            else if (key < 8)
                temp = key + 0x55;	// Ascii char 0x5C
            else
                temp = key + 0x22;	// Ascii char 0x2A to 0x2B
            break;
        case 4:
            temp = key + 0x41;	// Ascii char 0x41 to 0x4A
            break;
        case 5:
            temp = key + 0x61;	// Ascii char 0x61 to 0x6A
            break;
        case 6:
            if (key < 7)
                temp = key + 0x3A;	// Ascii char 0x3A to 0x40
            else
                temp = key + 0x71;	// Ascii char 0x78 to 0x7A
            break;
        case 7:
            temp = key + 0x30;	// Ascii char 0x30 to 0x39
            break;
        case 8:
            temp = key + 0x6B;	// Ascii char 0x6B to 0x74
            break;
        case 9:
            temp = key + 0x4B;	// Ascii char 0x4B to 0x54
            break;
        case 10:
            if (key < 1)
                temp = key + 0x2D;	// Ascii char 0x2D
            else if (key < 3)
                temp = key + 0x22;	// Ascii char 0x23 to 0x24
            else if (key < 5)
                temp = key + 0x27;	// Ascii char 0x2A to 0x2B
            else
                temp = key + 0x2B;	// Ascii char 0x30 to 0x34
            break;
        case 11:
            if (key < 4)
                temp = key + 0x35;	// Ascii char 0x35 to 0x39
            else if (key < 7)
                temp = key + 0x50;	// Ascii char 0x54 to 0x56
            else
                temp = key + 0x70;	// Ascii char 0x74 to 0x76
            break;
        case 12:
            temp = key + 0x35;	//Ascii char 0x35 to 0x3E
            break;
        case 13:
            temp = key + 0x3F;	// Ascii char 0x3F to 0x48
            break;
        case 14:
            if (key == 0)
                temp = key + 0x21;	// Ascii char 0x21
            else if (key == 1 || key == 2)
                temp = key + 0x22;	// Ascii char 0x23 to 0x24
            else if (key == 3)
                temp = key + 0x27;	// Ascii char 0x2A
            else if (key == 4 || key == 5)
                temp = key + 0x36;	// Ascii char 0x3A to 0x3B
            else if (key == 6 || key == 7)
                temp = key + 0x39;	// Ascii char 0x3F to 0x40
            else if (key == 8)
                temp = key + 0x27;	// Ascii char 0x2F
            else
                temp = key + 0x53;	// Ascii char 0x5C
            break;
        default:
            temp = key + 70;
            break;
    }
    return temp;
}