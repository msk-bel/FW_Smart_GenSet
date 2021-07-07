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
void vHandle_MQTT(void);      //Added by Saqib
void vSend_MQTT_Ping(void);   //Added by Saqib
void vTCP_Reconnect(void);    //Added by Saqib
void vPrintStickerInfo(void); //Added by Saqib
/* Public functions ----------------------------------------------------------*/

uint8_t aunIMEI[20];
uint8_t PASS_KEY[16];
extern @near uint8_t aunPushed_Data[100];
extern uint8_t IMEIRecievedOKFlag;
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
    SIMComrestart(); //Restart the SIMCOMM 868 module
    delay_ms(10000);

    ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
    delay_ms(20000);                                   //need to adjust the delay
    delay_ms(1000);

    ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
    delay_ms(1000);

    ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
    delay_ms(1000);

    vPrintStickerInfo(); //Added by Saqib
    delay_ms(1000);
    // Disable Ringer Interrupt
    ms_send_cmd("AT+CFGRI=0", strlen((const char *)"AT+CFGRI=0")); /* Disable power saving mode */
    delay_ms(1000);

    ms_send_cmd(GPS_ON, strlen((const char *)GPS_ON));
    delay_ms(1000);

    ms_send_cmd(rmc, strlen((const char *)rmc));
    delay_ms(1000);

    ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
    delay_ms(1000);

    ms_send_cmd("AT+CMEE=2", strlen((const char *)"AT+CMEE=2")); /* No echo */
    delay_ms(1000);

    ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
    delay_ms(1000);

    ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
    delay_ms(1000);

    ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
    delay_ms(1000);

    ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
    delay_ms(1000);

    // getIMEI();//Added by Saqib
    // vPrintStickerInfo(); //Added by Saqib
    // passkeyGenerator(); //Added by Saqib
    delay_ms(1000); //Added by Saqib

    ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
    delay_ms(1000);

    ms_send_cmd(TCP_SINGLE_CONN_MODE, strlen((const char *)TCP_SINGLE_CONN_MODE)); /* OPEN BEARER */
    delay_ms(1000);

    ms_send_cmd(TCP_NON_TRANSPARENT_MODE, strlen((const char *)TCP_NON_TRANSPARENT_MODE)); /* OPEN BEARER */
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

    ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
    delay_ms(1000);

    ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
    delay_ms(1000);

    enGet_TCP_Status();
    delay_ms(500);

    // ms_send_cmd(BT_TURN_ON, strlen((const char *)BT_TURN_ON));
    // delay_ms(1000);

    // ms_send_cmd(BT_SET_NAME, strlen((const char *)BT_SET_NAME));
    // delay_ms(3000);

    // ms_send_cmd(BT_SET_PIN, strlen((const char *)BT_SET_PIN));
    // delay_ms(3000);
    checkit = 1; //Recieve data through Ringer Interrupt
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

// void passkeyGenerator()
// {
//     uint8_t temp[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
//     uint8_t i = 0;
//     uint8_t checksum = 0;

//     for (i = 0; i < 15; i++)
//     {
//         checksum ^= aunIMEI[i];
//     }
//     for (i = 0; i < 15; i++)
//     {
//         temp[i] = ((aunIMEI[i] + aunIMEI[(i + 1) % 15]) ^ (aunIMEI[(i + 2) % 15] + aunIMEI[(i + 3) % 15]) ^ (aunIMEI[(i + 4) % 15] + aunIMEI[(i + 5) % 15]) ^ (aunIMEI[(i + 6) % 15] + aunIMEI[(i + 7) % 15]) ^ (aunIMEI[(i + 8) % 15] + aunIMEI[(i + 9) % 15]) ^ (aunIMEI[(i + 10) % 15] + aunIMEI[(i + 11) % 15]) ^ (aunIMEI[(i + 12) % 15] + aunIMEI[(i + 13) % 15]) ^ (aunIMEI[(i + 14) % 15] + checksum)) % 10;
//     }

//     for (i = 0; i < 15; i++)
//     {
//         PASS_KEY[i] = getValue(temp[i], i);
//     }
//     PASS_KEY[i] = '\0';
//     delay_ms(200);
//     ms_send_cmd(PASS_KEY, strlen((const char *)PASS_KEY));
//     delay_ms(200);
// }

// uint8_t getValue(uint8_t key, uint8_t pos)
// {
//     uint8_t temp;

//     switch (pos)
//     {
//     case 0:
//         if (key < 5)
//             temp = key + 0x56; // Ascii char from 0x56 to 0x5A
//         else
//             temp = key + 0x71; // Ascii char from 0x76 to 0x7A
//         break;
//     case 1:
//         temp = key + 0x30; // Ascii char 0x30 to 0x39
//         break;
//     case 2:
//         if (key < 5)
//             temp = key + 0x35; // Ascii char from 0x35 to 0x39
//         else
//             temp = key + 0x3C; // Ascii char from 0x41 to 0x45
//         break;
//     case 3:
//         if (key < 1)
//             temp = key + 0x21; // Ascii char 0x21
//         else if (key < 5)
//             temp = key + 0x22; // Ascii char from 0x23 to 0x26
//         else if (key < 7)
//             temp = key + 0x29; // Ascii char 0x2F
//         else if (key < 8)
//             temp = key + 0x55; // Ascii char 0x5C
//         else
//             temp = key + 0x22; // Ascii char 0x2A to 0x2B
//         break;
//     case 4:
//         temp = key + 0x41; // Ascii char 0x41 to 0x4A
//         break;
//     case 5:
//         temp = key + 0x61; // Ascii char 0x61 to 0x6A
//         break;
//     case 6:
//         if (key < 7)
//             temp = key + 0x3A; // Ascii char 0x3A to 0x40
//         else
//             temp = key + 0x71; // Ascii char 0x78 to 0x7A
//         break;
//     case 7:
//         temp = key + 0x30; // Ascii char 0x30 to 0x39
//         break;
//     case 8:
//         temp = key + 0x6B; // Ascii char 0x6B to 0x74
//         break;
//     case 9:
//         temp = key + 0x4B; // Ascii char 0x4B to 0x54
//         break;
//     case 10:
//         if (key < 1)
//             temp = key + 0x2D; // Ascii char 0x2D
//         else if (key < 3)
//             temp = key + 0x22; // Ascii char 0x23 to 0x24
//         else if (key < 5)
//             temp = key + 0x27; // Ascii char 0x2A to 0x2B
//         else
//             temp = key + 0x2B; // Ascii char 0x30 to 0x34
//         break;
//     case 11:
//         if (key < 4)
//             temp = key + 0x35; // Ascii char 0x35 to 0x39
//         else if (key < 7)
//             temp = key + 0x50; // Ascii char 0x54 to 0x56
//         else
//             temp = key + 0x70; // Ascii char 0x74 to 0x76
//         break;
//     case 12:
//         temp = key + 0x35; //Ascii char 0x35 to 0x3E
//         break;
//     case 13:
//         temp = key + 0x3F; // Ascii char 0x3F to 0x48
//         break;
//     case 14:
//         if (key == 0)
//             temp = key + 0x21; // Ascii char 0x21
//         else if (key == 1 || key == 2)
//             temp = key + 0x22; // Ascii char 0x23 to 0x24
//         else if (key == 3)
//             temp = key + 0x27; // Ascii char 0x2A
//         else if (key == 4 || key == 5)
//             temp = key + 0x36; // Ascii char 0x3A to 0x3B
//         else if (key == 6 || key == 7)
//             temp = key + 0x39; // Ascii char 0x3F to 0x40
//         else if (key == 8)
//             temp = key + 0x27; // Ascii char 0x2F
//         else
//             temp = key + 0x53; // Ascii char 0x5C
//         break;
//     default:
//         temp = key + 70;
//         break;
//     }
//     return temp;
// }

//Added By Saqib
// bool bSendDataOverTCP_sub(uint8_t *Data, uint8_t unLength)
// {
//     uint8_t timeout = 0;
//     uint8_t tempData[15] = "";
//     uint8_t temp1[3] = "";
//     vClearBuffer(tempData, 15);
//     strcpy(tempData, "AT+CIPSEND=");
//     vClearBuffer(temp1,3);
//     sprintf(temp1, "%d", (uint16_t)unLength);
//     strcat(tempData,temp1);
//     ms_send_cmd(tempData, strlen((const char *)tempData));
//     delay_ms(100);
//     ms_send_cmd_TCP(Data, unLength);
//     delay_ms(200);

//     while (!strstr(response_buffer, "SEND") && (++timeout != 100))
//         delay_ms(100);
//     if (strstr(response_buffer, "SEND OK"))
//     {
//         return TRUE;
//     }
//     else
//     {
//         return FALSE;
//     }
// }

void vHandle_MQTT(void)
{
    uint8_t unLength = 0;
    static uint8_t unMQTTCounter = 0;
    enTCP_STATUS eTCP_Status;
    static uint8_t unMQQT_PingCounter = 0;
    eTCP_Status = enGet_TCP_Status();

    if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
    {
        if (unMQTTCounter == 0 /*&& !bCONNACK_Recieved*/)
        {
            vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
            unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, aunMQTT_ClientID/*punGet_Client_ID()*/ /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
            if (bSendDataOverTCP(aunPushed_Data, unLength))
                unMQTTCounter++;
            unMQQT_PingCounter = 0;
        }
        else if (unMQTTCounter == 1)
        {
            vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
            unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, aunMQTT_Subscribe_Topic/*punGet_Command_Topic()*/ /*, eQOS_0, 1*/);
            if (bSendDataOverTCP(aunPushed_Data, unLength))
                unMQTTCounter++;
            unMQQT_PingCounter = 0;
        }
        else if (unMQTTCounter == 2)
        {
            delay_ms(100);
            vMevris_Send_IMEI();
            unMQTTCounter++;
            unMQQT_PingCounter = 0;
        }
        else if (unMQTTCounter == 3)
        {
            delay_ms(100);
            vMevris_Send_Version();
            unMQTTCounter++;
            unMQQT_PingCounter = 0;
        }
        else if (unMQTTCounter == 4)
        {
            unMQQT_PingCounter++;
            if (unMQQT_PingCounter >> 5)
            {
                vSend_MQTT_Ping();
                unMQQT_PingCounter = 0;
            }
        }
    }
    else if (eTCP_Status == eTCP_STAT_CONNECTING)
    {
        delay_ms(200);
        unMQTTCounter = 0;
        unMQQT_PingCounter = 0;
    }
    else
    {
        vTCP_Reconnect();
        unMQQT_PingCounter = 0;
        unMQTTCounter = 0;
    }
    if (IMEIRecievedOKFlag == 0)
    {
        vPrintStickerInfo();
    }
}
//Added by Saqib
void vSend_MQTT_Ping(void)
{
    uint8_t unLength = 0;
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    //if(enGet_TCP_Status() == eTCP_STAT_CONNECT_OK)
    {
        unLength = (uint8_t)unMQTT_PingRequest(aunPushed_Data);
        bSendDataOverTCP(aunPushed_Data, unLength);
    }
}

void vInit_MQTT(void)
{
    uint8_t unLength = 0;

    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, punGet_Client_ID() /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
    bSendDataOverTCP(aunPushed_Data, unLength);
    delay_ms(1000);
    delay_ms(1000);
    delay_ms(1000);
    delay_ms(1000);
    delay_ms(1000);
    vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
    unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, punGet_Command_Topic() /*, eQOS_0, 1*/);
    bSendDataOverTCP(aunPushed_Data, unLength);
    delay_ms(1000);
    delay_ms(1000);
    delay_ms(1000);
    delay_ms(1000);
    delay_ms(1000);
}


bool bSendDataOverTCP(uint8_t *Data, uint8_t unLength)
{
    uint8_t timeout = 0;
    uint8_t tempData[15] = "";
    uint8_t temp1[5] = "";
    vClearBuffer(tempData, 15);
    strcpy(tempData, "AT+CIPSEND=");
    vClearBuffer(temp1,5);
    sprintf(temp1, "%d", (uint16_t)unLength);
    strcat(tempData,temp1);
    // ms_send_cmd(TCP_SEND_VARIABLE_LENGTH, strlen((const char *)TCP_SEND_VARIABLE_LENGTH));
    ms_send_cmd(tempData, strlen((const char *)tempData));
    delay_ms(100);
    ms_send_cmd_TCP(Data, unLength);
    delay_ms(200);

    while (!strstr(response_buffer, "SEND") && (++timeout != 100))
        delay_ms(100);
    if (strstr(response_buffer, "SEND OK"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

void vClearBuffer(char *temp, uint8_t unLen)
{
    uint8_t i;
    for (i = 0; i < unLen; i++)
    {
        *(temp + i) = '\0';
    }
}

enTCP_STATUS enGet_TCP_Status(void)
{
    enTCP_STATUS eStatus;

    ms_send_cmd(TCP_GET_STATUS, strlen((const char *)TCP_GET_STATUS));
    delay_ms(1000);

    if (strstr(response_buffer, "STATE:"))
    {
        if (strstr(response_buffer, "IP INITIAL"))
        {
            eStatus = eTCP_STAT_IP_INITIAL;
        }
        else if (strstr(response_buffer, "IP START"))
        {
            eStatus = eTCP_STAT_IP_START;
        }
        else if (strstr(response_buffer, "IP CONFIG"))
        {
            eStatus = eTCP_STAT_IP_CONFIG;
        }
        else if (strstr(response_buffer, "IP GPRSACT"))
        {
            eStatus = eTCP_STAT_IP_GPRSACT;
        }
        else if (strstr(response_buffer, "IP STATUS"))
        {
            eStatus = eTCP_STAT_IP_STATUS;
        }
        else if (strstr(response_buffer, "TCP CONNECTING"))
        {
            eStatus = eTCP_STAT_CONNECTING;
        }
        else if (strstr(response_buffer, "CONNECT OK"))
        {
            eStatus = eTCP_STAT_CONNECT_OK;
        }
        else if (strstr(response_buffer, "TCP CLOSING"))
        {
            eStatus = eTCP_STAT_CLOSING;
        }
        else if (strstr(response_buffer, "TCP CLOSED"))
        {
            eStatus = eTCP_STAT_CLOSED;
        }
        else if (strstr(response_buffer, "PDP DEACT"))
        {
            eStatus = eTCP_STAT_PDP_DEACT;
        }
        else
        {
            eStatus = eTCP_STAT_UNKNOWN;
        }
    }
    else
    {
        eStatus = eTCP_STAT_UNKNOWN;
    }
    return eStatus;
}

//Added By Saqib
void vTCP_Reconnect(void)
{
    ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
    delay_ms(1000);
    ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
    delay_ms(1000);
    ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
    delay_ms(1000);
    ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
    delay_ms(1000);
    ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
    delay_ms(1000);
    // vHandle_MQTT();
}

//Added By Saqib
bool bValidIMEIRecieved(char *myArray)
{
    uint8_t i = 0, j = 0, k = 0;
    for (j = 0; j < 20; j++)
    {
        if (myArray[j] > 0x39 || myArray[j] < 0x30)
        {
            nop();
        }
        else
        {
            aunIMEI[k++] = myArray[j];
        }
    }
    if (k == 15)
    {
        aunIMEI[k] = '\0';
        return TRUE;
    }
    else
    {
        vClearBuffer(aunIMEI, 16);
        return FALSE;
    }
}

//Added By Saqib
void vPrintStickerInfo(void)
{
    uint8_t p = 0, i = 0;
    uint8_t NotRespondingCounter = 0;
    uint16_t gsm_ok_timeout = 10000;
    uint8_t imei_array[20] = {0};
    bool ModuleResponding = FALSE;
    bool myInterruptFlag = TRUE;

    UART1_ITConfig(UART1_IT_RXNE, DISABLE);
    UART1_ITConfig(UART1_IT_IDLE, DISABLE);
    delay_ms(100);
    do
    {
        // vSendATCommandOverSerial(AT, strlen((const char *)AT));
        ms_send_cmd(AT, strlen((const char *)AT));
        if (GSM_OK())
        {
            delay_ms(200);

            getIMEI();
            if (bValidIMEIRecieved(aunIMEI))
            {
                delay_ms(100);
                for (i = 0; i < 20; i++)
                {
                    while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                        ;
                    UART1_SendData8('*');
                }
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('\n');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('I');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('M');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('E');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('I');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8(' ');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('i');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('s');
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('\n');
                // ms_send_cmd("IMEI is", strlen((const char *)"IMEI is"));
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('\n');
                for (i = 0; i < 15; i++)
                {
                    while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                        ;
                    UART1_SendData8(aunIMEI[i]);
                }
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                // UART1_SendData8(0x0A);
                UART1_SendData8('\n');
                for (i = 0; i < 20; i++)
                {
                    while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                        ;
                    UART1_SendData8('*');
                }
                while (!UART1_GetFlagStatus(UART1_FLAG_TC))
                    ;
                UART1_SendData8('\r');
                delay_ms(100);
                //
                punGet_Client_ID();
                punGet_Command_Topic();
                punGet_Event_Topic();
                //
                ModuleResponding = TRUE;
                IMEIRecievedOKFlag = 1;
            }
            else
            {
                delay_ms(200);
                ModuleResponding = FALSE;
                NotRespondingCounter++;
                // IMEIRecievedOKFlag = FALSE;
            }
        }
        else
        {
            delay_ms(200);
            ms_send_cmd("No Response from Module", strlen((const char *)"No Response from Module"));
            delay_ms(200);
            ModuleResponding = FALSE;
            NotRespondingCounter++;
            // IMEIRecievedOKFlag = FALSE;
        }
        delay_ms(200);
    } while (!ModuleResponding && NotRespondingCounter < 10);

    if (NotRespondingCounter < 10)
        IMEIRecievedOKFlag = 1;
    else
        IMEIRecievedOKFlag = 0;
    UART1_ITConfig(UART1_IT_RXNE, ENABLE);
    UART1_ITConfig(UART1_IT_IDLE, ENABLE);
}
