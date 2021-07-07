/**
  ****************************************************************************************************
  * File:    cloudService.c
  * Author:  M.Ahmad Naeem
  * Version: V1.0.0
  * Date:    20-May-2021
  * Brief:   This file contains all the functions for creating information string.
   ***************************************************************************************************
  * Attention:
  *                         COPYRIGHT 2021 BlueEast Pvt Ltd.
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
  ********************************************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "cloudService.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
void vMevris_Send_IMEI(void);       //Added By Saqib
void vMevris_Send_Version(void);    //Added By Saqib
void vMevris_Send_SIM_Number(void); //Added By Saqib
void vMevris_Send_Location(void);   //Added By Saqib
// void vMevris_Send_Phase1(void);//Added By Saqib
// void vMevris_Send_Phase2(void);//Added By Saqib
// void vMevris_Send_Phase3(void);//Added By Saqib
void vMevris_Send_BatteryVolt(void);                                                             //Added By Saqib
void vMevris_Send_RadiatorTemp(void);                                                            //Added By Saqib
void vMevris_Send_EngineTemp(void);                                                              //Added By Saqib
void vMevris_Send_FuelLevel(void);                                                               //Added By Saqib
void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere); //Added By Saqib
/* Public functions ----------------------------------------------------------*/

@near uint8_t aunPushed_Data[MEVRIS_SEND_DATA_MAX_SIZE] = "";
@near uint8_t aunMQTT_ClientID[20] = "gen123456789012345";
@near uint8_t aunMQTT_Subscribe_Topic[30] = "sc2/123456789012345/command";
@near uint8_t aunMQTT_Publish_Topic[30] = "sc2/123456789012345/event";
bool bCONNACK_Recieved = FALSE;
extern @near uint8_t response_buffer[100];
extern uint8_t IMEIRecievedOKFlag;

void sendDataToCloud(void)
{
    // uint8_t informationString[100];
    // uint8_t stringLength;
    static enCOMMAND_TYPE enSendEventCounter;
    static uint8_t tempCounter = 0;
    enTCP_STATUS eTCP_Status;
    //->Commented by Saqib
    // stringLength = createStringToSend(informationString);
    // vMevris_Send_IMEI();
    tempCounter++; //Added by Saqib
    if (tempCounter >= 3)
    {
        eTCP_Status = enGet_TCP_Status();
        if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
        {
            switch (enSendEventCounter)
            {
            case eCommand_Reserved:
                // enSendEventCounter++;
                break;
            case eCommand_IMEI:
                // vMevris_Send_IMEI();
                break;
            case eCommand_SIM_Number:
                // vMevris_Send_SIM_Number();
                break;
            case eCommand_Location:
                // vMevris_Send_Location();
                break;
            case eCommand_Version:
                // vMevris_Send_Version();
                break;
            case eCommand_Phase1:
                // vMevris_Send_Phase1();
                vMevris_Send_Phase(1, Watt_Phase1, Voltage_Phase1, Ampere_Phase1);
                break;
            case eCommand_Phase2:
                // vMevris_Send_Phase2();
                vMevris_Send_Phase(2, Watt_Phase2, Voltage_Phase2, Ampere_Phase2);
                break;
            case eCommand_Phase3:
                // vMevris_Send_Phase3();
                vMevris_Send_Phase(3, Watt_Phase3, Voltage_Phase3, Ampere_Phase3);
                break;
            case eCommand_BatteryVolts:
                vMevris_Send_BatteryVolt();
                break;
            case eCommand_RadiatorTemp:
                vMevris_Send_RadiatorTemp();
                break;
            case eCommand_EngineTemp:
                vMevris_Send_EngineTemp();
                break;
            case eCommand_FuelLevel:
                vMevris_Send_FuelLevel();
                break;
            case eCommand_Others:
                // Do something
                break;
            default:
                break;
            }

            enSendEventCounter++;
            if (enSendEventCounter >= eCommand_Others)
                enSendEventCounter = eCommand_IMEI;
            tempCounter = 0;
        }
        else
        {
            enSendEventCounter = eCommand_IMEI;
        }
    }
}

// void vMevris_Send_sensorData()
// {

//     uint8_t informationString[100];
//     uint8_t stringLength;
//     uint8_t unSendDataLength = 0;
//     stringLength = createStringToSend(informationString);
//     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
//     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
//                                                punGet_Event_Topic(),
//                                                informationString /*, eCTRL_PKT_FLAG_PUBLISH_D0_0_R0 */);
//     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
// }

//-> Commneted by Saqib
// int createStringToSend(uint8_t *informationString)
// {
//     uint8_t w;
//     uint8_t f;
//     uint8_t u;
//     uint8_t stringLength;
//     uint8_t temp1Length = 0;
//     uint8_t decPlace;
//     uint8_t temp1[6];
//     uint8_t temp2[16];

//     sprintf(temp1, "%d", 1234);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcpy(informationString, "{");
//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 4567);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 7891);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 1234);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 4657);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 7891);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 1324);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 4567);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, ",");

//     sprintf(temp1, "%d", 7891);
//     temp1Length = strlen(temp1);
//     decPlace = temp1Length - 2;
//     temp2[decPlace] = '.';
//     for (w = 0; w < decPlace; w++)
//     {
//         temp2[w] = temp1[w];
//     }
//     f = decPlace + 1;
//     for (w = f; w <= temp1Length; w++)
//     {
//         u = w - 1;
//         temp2[w] = temp1[u];
//     }
//     temp2[w] = '\0';

//     strcat(informationString, temp2);
//     strcat(informationString, "}");
//     stringLength = strlen(informationString);
//     return (stringLength);
// }

void vHandleMevris_MQTT_Recv_Data(void)
{
    uint8_t localBuffer[30];
    uint8_t *ptr;
    uint8_t i = 0, j;
    uint8_t unLength = 0;

    // ms_send_cmd("print below response_buffer", strlen((const char *)"print below response_buffer"));
    // ms_send_cmd(response_buffer, strlen((const char *)response_buffer));

    ptr = strstr(response_buffer, "+IPD");
    if (ptr)
    {
        i = 0;
        while (*(ptr + i) != ':')
            i++;
        i++;
        if (*(ptr + i) == 0x20) // Check if CONNACK is Recieved
        {
            if (*(ptr + 3) == 0) // If 0x00 Then it means Successfull
                bCONNACK_Recieved = TRUE;
        }
        else if (*(ptr + i) == 0x30) //Check if Message is a PUBLISH Packet from server
        {
            while (*(ptr + i) != '{' && i < 99)
                i++;
            //            ptr = strstr(response_buffer, MQTT_INBOUND_TOPIC_FOOTER);
            if (*(ptr + i) == '{')
            {
                vClearBuffer(localBuffer, 30);
                j = 0;
                while (*(ptr + i) != '\r' && j < 29)
                {
                    localBuffer[j++] = *(ptr + i);
                    unLength++;
                    i++;
                }
                //  ms_send_cmd("print below local buffer", strlen((const char *)"print below local buffer"));
                //  ms_send_cmd(localBuffer, strlen((const char *)localBuffer));
                vHandleMevrisRecievedData(localBuffer, unLength);
            }
        }
    }
}

void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
{
    uint8_t i, j;
    uint8_t *ret;
    // Example Data[] = "{1,1,RUN}"
    // if (Data[0] == '{')
    // {
    //     if (Data[1] = '1')
    //     {
    //         ms_send_cmd("are you there", strlen((const char *)"are you there"));
    //         vMevris_Send_IMEI();
    //     }
    // }
    if (strstr(Data, "\"info\"")) //Example "{"info":"imei"}"
    {
        if (strstr(Data, "\"imei\""))
        {
            vMevris_Send_IMEI();
        }
    }
    // else if (strstr(Data, "\"key\""))
    // {
    //     i = 0;
    //     ret = strstr(Data, "\"key\":");
    //     while (*(ret + i) != ':' && i < 8)
    //     {
    //         i++;
    //     }
    //     i++;
    //     i++;
    //     vClearBuffer(PASS_KEY, strlen((const char*)PASS_KEY));
    //     for (j = 0; j < 8; j++)
    //     {
    //         PASS_KEY[j] = *(ret + i);
    //         i++;
    //     }
    // }
}

uint8_t *punGet_Client_ID(void)
{
    //  uint8_t i = 0;
    //   for (i = 0; i < 15; i++)
    //  {
    //     aunMQTT_ClientID[i+3] = aunIMEI[i];
    //  }
    //	aunMQTT_ClientID[i+3] = '\0';
    vClearBuffer(aunMQTT_ClientID, 20);
    strcpy(aunMQTT_ClientID, "gen");
    strcat(aunMQTT_ClientID, aunIMEI);

    return aunMQTT_ClientID;
}

uint8_t *punGet_Command_Topic(void)
{
    uint8_t i = 0;
    //    for (i = 0; i < 15; i++)
    //    {
    //        aunMQTT_Subscribe_Topic[i+4] = aunIMEI[i];
    //    }
    //	aunMQTT_Subscribe_Topic[i+4] = '\0';
    vClearBuffer(aunMQTT_Subscribe_Topic, 30);
    strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
    strcat(aunMQTT_Subscribe_Topic, "/");
    strcat(aunMQTT_Subscribe_Topic, aunIMEI);
    strcat(aunMQTT_Subscribe_Topic, "/");
    strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);

    return aunMQTT_Subscribe_Topic;
}

uint8_t *punGet_Event_Topic(void)
{
    uint8_t i = 0;
    //    for (i = 0; i < 15; i++)
    //    {
    //        aunMQTT_Publish_Topic[i+4] = aunIMEI[i];
    //    }
    //	aunMQTT_Publish_Topic[i+4] = '\0';
    vClearBuffer(aunMQTT_Publish_Topic, 30);
    strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
    strcat(aunMQTT_Publish_Topic, "/");
    strcat(aunMQTT_Publish_Topic, aunIMEI);
    strcat(aunMQTT_Publish_Topic, "/");
    strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);

    return aunMQTT_Publish_Topic;
}

//-> Added by Saqib from here to end of file
void vMevris_Send_IMEI(void)
{
    uint8_t localBuffer[30] = "{\"imei\":\"123456789012345\"}";
    uint8_t unSendDataLength = 0;
    vClearBuffer(localBuffer, 30);
    strcpy(localBuffer, "{\"imei\":\"");
    strcat(localBuffer, aunIMEI);
    strcat(localBuffer, "\"}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}

// void vMevris_Send_SIM_Number()
// {
//     uint8_t localBuffer[30] = "{\"SIM\":\"+923316821907\"}";
//     uint8_t unSendDataLength = 0;
//     uint8_t aunTemp[14] = "+923316821907";
//     vClearBuffer(localBuffer, 30);
//     strcpy(localBuffer, "{\"SIM\":\"");
//     strcat(localBuffer, aunTemp); //Concatenate SIM number
//     strcat(localBuffer, "\"}");
//     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
//     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
//                                                punGet_Event_Topic(),
//                                                localBuffer);
//     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
// }

// void vMevris_Send_Location()
// {
//     uint8_t localBuffer[50] = "{\"Lat\":\"12345678901\",\"Long\":\"123456789012\"}";
//     uint8_t unSendDataLength = 0;
//     vClearBuffer(localBuffer, 50);
//     strcpy(localBuffer, "{\"Lat\":\"");
//     strcat(localBuffer, "12345678901" /*getGPS_Latitude()*/);
//     strcat(localBuffer, "\",\"Long\":\"");
//     strcat(localBuffer, "123456789012" /*getGPS_Longitude()*/);
//     strcat(localBuffer, "\"}");
//     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
//     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
//                                                punGet_Event_Topic(),
//                                                localBuffer);
//     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
// }

void vMevris_Send_Version()
{
    uint8_t localBuffer[35] = "{\"fw\":\"2.4.010\",\"hw\":\"0.0.001\"}";
    uint8_t unSendDataLength = 0;
    vClearBuffer(localBuffer, 35);
    strcpy(localBuffer, "{\"fw\":\"");
    strcat(localBuffer, /*"2.4.010"*/ Firmware_Version);
    strcat(localBuffer, "\",\"hw\":\"");
    strcat(localBuffer, /*"0.0.001"*/ Hardware_Version);
    strcat(localBuffer, "\"}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}

void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere)
{
    uint8_t localBuffer[75] = "{\"power1\":\"123456890.23\",\"voltage1\":\"123.56\",\"current1\":\"12345.78\"}";
    uint8_t unSendDataLength = 0;
    uint8_t temp1[12] = "";
    uint8_t phase_num[3] = "";
    vClearBuffer(localBuffer, 55);
    sprintf(phase_num, "%d", (uint16_t)phase_number);
    strcpy(localBuffer, "{\"power");
    strcat(localBuffer, phase_num);
    strcat(localBuffer, "\":\"");
    sprintf(temp1, "%ld", Watt / 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, ".");
    sprintf(temp1, "%ld", Watt % 100);
    strcat(localBuffer, temp1);

    strcat(localBuffer, "\",\"voltage");
    strcat(localBuffer, phase_num);
    strcat(localBuffer, "\":\"");
    sprintf(temp1, "%ld", Voltage / 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, ".");
    sprintf(temp1, "%ld", Voltage % 100);
    strcat(localBuffer, temp1);

    strcat(localBuffer, "\",\"current");
    strcat(localBuffer, phase_num);
    strcat(localBuffer, "\":\"");
    sprintf(temp1, "%ld", Ampere / 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, ".");
    sprintf(temp1, "%ld", Ampere % 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, "\"}");

    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}

// void vMevris_Send_Phase1()
// {
//     uint8_t localBuffer[55] = "{\"P1\":\"123456.89\",\"V1\":\"123\",\"I1\":\"1234.67\"}";
//     uint8_t unSendDataLength = 0;
//     uint8_t temp1[10] = "";
//     vClearBuffer(localBuffer, 55);

//     strcpy(localBuffer, "{\"P1\":\"");
//     sprintf(temp1, "%ld", Watt_Phase1 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Watt_Phase1 % 100);
//     strcat(localBuffer, temp1);

//     strcat(localBuffer, "\",\"V1\":\"");
//     sprintf(temp1, "%ld", Voltage_Phase1 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Voltage_Phase1 % 100);
//     strcat(localBuffer, temp1);

//     strcat(localBuffer, "\",\"I1\":\"");
//     sprintf(temp1, "%ld", Ampere_Phase1 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Ampere_Phase1 % 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, "\"}");

//     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
//     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
//                                                punGet_Event_Topic(),
//                                                localBuffer);
//     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
// }

// void vMevris_Send_Phase2()
// {
//     uint8_t localBuffer[55] = "{\"P2\":\"123456.89\",\"V2\":\"123\",\"I2\":\"1234.67\"}";
//     uint8_t unSendDataLength = 0;
//     uint8_t temp1[10] = "";
//     vClearBuffer(localBuffer, 55);

//     strcpy(localBuffer, "{\"P2\":\"");
//     sprintf(temp1, "%ld", Watt_Phase2 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Watt_Phase2 % 100);
//     strcat(localBuffer, temp1);

//     strcat(localBuffer, "\",\"V2\":\"");
//     sprintf(temp1, "%ld", Voltage_Phase2 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Voltage_Phase2 % 100);
//     strcat(localBuffer, temp1);

//     strcat(localBuffer, "\",\"I2\":\"");
//     sprintf(temp1, "%ld", Ampere_Phase2 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Ampere_Phase2 % 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, "\"}");

//     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
//     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
//                                                punGet_Event_Topic(),
//                                                localBuffer);
//     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
// }

// void vMevris_Send_Phase3()
// {
//     uint8_t localBuffer[55] = "{\"P3\":\"123456.89\",\"V3\":\"123\",\"I3\":\"1234.67\"}";
//     uint8_t unSendDataLength = 0;
//     uint8_t temp1[10] = "";
//     vClearBuffer(localBuffer, 55);

//     strcpy(localBuffer, "{\"P3\":\"");
//     sprintf(temp1, "%ld", Watt_Phase3 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Watt_Phase3 % 100);
//     strcat(localBuffer, temp1);

//     strcat(localBuffer, "\",\"V3\":\"");
//     sprintf(temp1, "%ld", Voltage_Phase3 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Voltage_Phase3 % 100);
//     strcat(localBuffer, temp1);

//     strcat(localBuffer, "\",\"I3\":\"");
//     sprintf(temp1, "%ld", Ampere_Phase3 / 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, ".");
//     sprintf(temp1, "%ld", Ampere_Phase3 % 100);
//     strcat(localBuffer, temp1);
//     strcat(localBuffer, "\"}");

//     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
//     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
//                                                punGet_Event_Topic(),
//                                                localBuffer);
//     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
// }

void vMevris_Send_BatteryVolt()
{
    uint8_t localBuffer[30] = "{\"battery\":\"123456.89\"}";
    uint8_t unSendDataLength = 0;
    uint8_t temp1[10] = "";
    vClearBuffer(localBuffer, 30);
    strcpy(localBuffer, "{\"battery\":\"");
    // sprintf(temp1, "%ld", batVolt);
    sprintf(temp1, "%ld", batVolt / 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, ".");
    sprintf(temp1, "%ld", batVolt % 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, "\"}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}

void vMevris_Send_RadiatorTemp()
{
    uint8_t localBuffer[40] = "{\"RadiatorTemperature\":\"123456.89\"}";
    uint8_t unSendDataLength = 0;
    uint8_t temp1[15] = "";
    uint32_t myVar = 0;
    vClearBuffer(localBuffer, 40);
    strcpy(localBuffer, "{\"RadiatorTemperature\":\"");
    myVar = (uint32_t)(Temperature1 * 100);
    sprintf(temp1, "%ld", myVar / 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, ".");
    sprintf(temp1, "%ld", myVar % 100);
    strcat(localBuffer, temp1);
    // sprintf(temp1, "%f", /*Temperature1*/10.29);
    strcat(localBuffer, "\"}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}

void vMevris_Send_EngineTemp()
{
    uint8_t localBuffer[40] = "{\"EngineTemperature\":\"123456.89\"}";
    uint8_t unSendDataLength = 0;
    uint8_t temp1[15] = "";
    uint32_t myVar = 0;
    vClearBuffer(localBuffer, 40);
    strcpy(localBuffer, "{\"EngineTemperature\":\"");
    myVar = (uint32_t)(Temperature2 * 100);
    sprintf(temp1, "%ld", myVar / 100);
    strcat(localBuffer, temp1);
    strcat(localBuffer, ".");
    sprintf(temp1, "%ld", myVar % 100);
    strcat(localBuffer, temp1);
    // sprintf(temp1, "%f", /*Temperature2*/897.12);
    strcat(localBuffer, "\"}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}

void vMevris_Send_FuelLevel()
{
    uint8_t localBuffer[30] = "{\"fuel\":\"123456.89\"}";
    uint8_t unSendDataLength = 0;
    uint8_t temp1[10] = "";
    vClearBuffer(localBuffer, 30);
    strcpy(localBuffer, "{\"fuel\":\"");
    sprintf(temp1, "%ld", Fuellevel);
    strcat(localBuffer, temp1);
    strcat(localBuffer, "\"}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
                                               localBuffer);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}