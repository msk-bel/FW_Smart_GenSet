/**
  ****************************************************************************************************
  * File:    getADC.c
  * Author:  M.Ahmad Naeem
  * Version: V1.0.0
  * Date:    20-May-2021
  * Brief:   This file contains all the functions for reading temperature, battery voltage and fuel
             level sensor and converting ADC values to  meaningful data.
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
#include "getADC.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

uint32_t batVolt = 0;
@near uint32_t Fuellevel;
@near float Temperature1 = 0;
@near float Temperature2 = 0;

void getbatteryvolt(void)
{
  uint16_t batVolt1;
  ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_6, ADC2_ALIGN_RIGHT);
  ADC2_Cmd(ENABLE);
  delay_ms(20);
  ADC2_StartConversion();

  while (ADC2_GetFlagStatus() == RESET)
  {
  }

  batVolt1 = ADC2_GetConversionValue();
  ADC2_ClearFlag();
  ADC2_Cmd(DISABLE);
  calculateBatVolt(batVolt1);
}

void gettemp1(void)
{
  uint16_t tempADC;
  ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_2, ADC2_ALIGN_RIGHT);
  ADC2_Cmd(ENABLE);
  delay_ms(20);
  ADC2_StartConversion();

  while (ADC2_GetFlagStatus() == RESET)
  {
  }

  tempADC = ADC2_GetConversionValue();
  ADC2_ClearFlag();
  ADC2_Cmd(DISABLE);
  calculateTemp1(tempADC);
}

void gettemp2(void)
{
  uint16_t tempADC;
  ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_1, ADC2_ALIGN_RIGHT);
  ADC2_Cmd(ENABLE);
  delay_ms(20);
  ADC2_StartConversion();

  while (ADC2_GetFlagStatus() == RESET)
  {
  }

  tempADC = ADC2_GetConversionValue();
  ADC2_ClearFlag();
  ADC2_Cmd(DISABLE);
  calculateTemp2(tempADC);
}

void getFuelLevel(void)
{
  uint16_t tempADC;
  ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_7, ADC2_ALIGN_RIGHT);
  ADC2_Cmd(ENABLE);
  delay_ms(20);
  ADC2_StartConversion();

  while (ADC2_GetFlagStatus() == RESET)
  {
  }

  tempADC = ADC2_GetConversionValue();

  ADC2_ClearFlag();
  ADC2_Cmd(DISABLE);
  calculateFuelLevel(tempADC);
}

void calculateBatVolt(uint16_t batVolt2)
{
  batVolt = ((uint32_t)((batVolt2)*ADCvoltmultiplier) * BatVoltDividerFactor)/ADC_RESOLUTION;
}

void calculateTemp1(uint16_t tempADC1)
{
  float ntcR;
  float tKelvin;
  float resRatio;
  float logresRatio;
  float temp;
  float temp1;
  float temp2;
  uint8_t a[5];
  ntcR = adcSeriesResistor * (((float)adcMaxVal / tempADC1) - 1);
  resRatio = ntcR / resistanceRoomTeperature;
  logresRatio = log(resRatio);
  temp = logresRatio / ntcCoefficient;
  temp1 = 1.0 / RoomTeperature;
  temp2 = temp1 + temp;
  tKelvin = 1 / temp2;
  Temperature1 = tKelvin - 273.15;
}

void calculateTemp2(uint16_t tempADC2)
{
  float ntcR;
  float tKelvin;
  float resRatio;
  float logresRatio;
  float temp;
  float temp1;
  float temp2;
  float temp3;
  uint32_t temp4;
  uint8_t a[5];
  ntcR = adcSeriesResistor * (((float)adcMaxVal / tempADC2) - 1);
  resRatio = ntcR / resistanceRoomTeperature;
  logresRatio = log(resRatio);
  temp = logresRatio / ntcCoefficient;
  temp1 = 1.0 / RoomTeperature;
  temp2 = temp1 + temp;
  tKelvin = 1 / temp2;
  Temperature2 = tKelvin - 273.15;
}

void calculateFuelLevel(uint16_t fuelLevel) // calculate fuel level in cubic feet
{
  // uint8_t fuelVoltage1[3]; //-> Commented by Saqib
  // if (fuelLevel > 0)//-> Commented by Saqib
  {
    //-> Changed by Saqib
    Fuellevel = ((uint32_t)(fuelLevel)/**FuelLevelFactor*/) /** (TankLengthinFoot) * (TankBreadthinFoot)*/; // divide FuelLevelFactor by 100,000
  }
  // else if (fuelLevel == 0)//-> Commented by Saqib
  {
    // Fuellevel = /*reserveFuel*/;//-> Commented by Saqib
  }
}
