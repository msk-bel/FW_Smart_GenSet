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

/* Public functions ----------------------------------------------------------*/

@near uint8_t aunPushed_Data[MEVRIS_SEND_DATA_MAX_SIZE] = "";
@near uint8_t aunMQTT_ClientID[20] = "gen123456789012345";
@near uint8_t aunMQTT_Subscribe_Topic[24] = "sc1/123456789012345/cmd";
@near uint8_t aunMQTT_Publish_Topic[24] = "sc1/123456789012345/evt";
bool bCONNACK_Recieved = FALSE;
extern @near uint8_t response_buffer[100];

void sendDataToCloud(void)
{
    uint8_t informationString[100];
    uint8_t stringLength;
    static enCOMMAND_TYPE enSendEventCounter;
    enTCP_STATUS eTCP_Status;
    stringLength = createStringToSend(informationString);
    eTCP_Status = enGet_TCP_Status();
    if (eTCP_Status == eTCP_STAT_CONNECT_OK)
    {
        switch (enSendEventCounter)
        {
        case eCommand_Reserved:
            enSendEventCounter++;
            break;
        case eCommand_IMEI:
            //vMevris_Send_sensorData();
            //            enSendEventCounter++;
            break;
        case eCommand_SIM_Number:
            // vMevris_Send_SIM_Number();
            //            enSendEventCounter++;
            break;
        case eCommand_Location:
            // vMevris_Send_Location();
            //            enSendEventCounter++;
            break;
        case eCommand_Bike_State:
            //  vMevris_Send_BikeState();
            //            enSendEventCounter++;
            break;
        default:
            break;
        }

        enSendEventCounter++;
        if (enSendEventCounter >= eCommand_Others)
            enSendEventCounter = eCommand_IMEI;
    }
    else
    {
        enSendEventCounter = eCommand_IMEI;
    }
}

int createStringToSend(uint8_t *informationString)
{
    uint8_t w;
    uint8_t f;
    uint8_t u;
    uint8_t stringLength;
    uint8_t temp1Length = 0;
    uint8_t decPlace;
    uint8_t temp1[6];
    uint8_t temp2[16];

    sprintf(temp1, "%d", 1234);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcpy(informationString, "{");
    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 4567);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 7891);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 1234);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 4657);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 7891);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 1324);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 4567);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, ",");

    sprintf(temp1, "%d", 7891);
    temp1Length = strlen(temp1);
    decPlace = temp1Length - 2;
    temp2[decPlace] = '.';
    for (w = 0; w < decPlace; w++)
    {
        temp2[w] = temp1[w];
    }
    f = decPlace + 1;
    for (w = f; w <= temp1Length; w++)
    {
        u = w - 1;
        temp2[w] = temp1[u];
    }
    temp2[w] = '\0';

    strcat(informationString, temp2);
    strcat(informationString, "}");
    stringLength = strlen(informationString);
    return (stringLength);
}

void vHandleMevris_MQTT_Recv_Data(void)
{
    uint8_t localBuffer[20];
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
                vClearBuffer(localBuffer, 20);
                j = 0;
                while (*(ptr + i) != '\r' && j < 19)
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
    // Example Data[] = "{1,1,RUN}"

    if (Data[0] == '{')
    {
           // ms_send_cmd("inside if for {", strlen((const char *)"inside if for {"))
        //switch (Data[1])
       // {
        //case eCommand_IMEI:
          
          if (Data[1]='1')
              {
                        ms_send_cmd("are you there", strlen((const char *)"are you there"));

            vMevris_Send_IMEI();
            
        }//break;
        //case eCommand_SIM_Number:
            //vMevris_Send_SIM_Number();
        //    break;
        //case eCommand_Location:
            //gps_data(!SEND_GPS_VIA_SMS);
            //vMevris_Send_Location();
          //  break;
        //case eCommand_Bike_State:
            //if(strstr(Data, "RUN"))
            // {
            //    vStartBike();
            //}
            //else if(strstr(Data, "STOP"))
            //{
            //  vStopBike();
            //}
            //vMevris_Send_BikeState();
           // break;
        //default:
          //  break;
       // }
    }
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
    vClearBuffer(aunMQTT_Subscribe_Topic, 24);
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
    vClearBuffer(aunMQTT_Publish_Topic, 24);
    strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
    strcat(aunMQTT_Publish_Topic, "/");
    strcat(aunMQTT_Publish_Topic, aunIMEI);
    strcat(aunMQTT_Publish_Topic, "/");
    strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);

    return aunMQTT_Publish_Topic;
}

void vMevris_Send_IMEI(void)
{
    uint8_t localBuffer[22] = "{1,1,123456789012345}";
    uint8_t unSendDataLength = 0;
    uint8_t aunTemp[2] = "1";
    vClearBuffer(localBuffer, 22);
    strcpy(localBuffer, "{");
    aunTemp[0] = eCommand_IMEI;
    aunTemp[1] = '\0';
    strcat(localBuffer, aunTemp);
    strcat(localBuffer, ",");
    aunTemp[0] = eCommand_Outbound;
    aunTemp[1] = '\0';
    strcat(localBuffer, aunTemp);
    strcat(localBuffer, ",");
    strcat(localBuffer, aunIMEI);
    strcat(localBuffer, "}");
    vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
    unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
                                               punGet_Event_Topic(),
                                               localBuffer /*, eCTRL_PKT_FLAG_PUBLISH_D0_0_R0 */);
    bSendDataOverTCP(aunPushed_Data, unSendDataLength);
}