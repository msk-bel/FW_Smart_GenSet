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
  ************************************************************************************************************
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

void sendDataToCloud(void)
{
    uint8_t informationString[100];
    uint8_t stringLength;
    stringLength = createStringToSend(informationString);
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