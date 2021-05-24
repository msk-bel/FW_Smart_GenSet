/**
  ****************************************************************************************************
  * File:    VIPE_Calculation.c
  * Author:  M.Ahmad Naeem
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
#include "VIPE_Calculation.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

@near uint32_t Voltage_Phase1 = 0;
@near uint32_t Voltage_Phase2 = 0;
@near uint32_t Voltage_Phase3 = 0;
@near uint32_t Ampere_Phase1 = 0;
@near uint32_t Ampere_Phase2 = 0;
@near uint32_t Ampere_Phase3 = 0;
@near uint32_t Watt_Phase1 = 0;
@near uint32_t Watt_Phase2 = 0;
@near uint32_t Watt_Phase3 = 0;

void calcVolt1(uint32_t voltagePeriod1)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = voltageCalibrationFactor1 / 100.00;
        Voltage_Phase1 = (((float)voltageMultiplier / voltagePeriod1) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Voltage_Phase1 = (((float)voltageMultiplier / voltagePeriod1) * 1) * accuracyFactor;
    }
}

void calcVolt2(uint32_t voltagePeriod2)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = voltageCalibrationFactor2 / 100.00;
        Voltage_Phase2 = (((float)voltageMultiplier / voltagePeriod2) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Voltage_Phase2 = (((float)voltageMultiplier / voltagePeriod2) * 1) * accuracyFactor;
    }
}

void calcVolt3(uint32_t voltagePeriod3)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = voltageCalibrationFactor3 / 100.00;
        Voltage_Phase3 = (((float)voltageMultiplier / voltagePeriod3) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Voltage_Phase3 = (((float)voltageMultiplier / voltagePeriod3) * 1) * accuracyFactor;
    }
}

void calcAmp1(uint32_t ampPeriod1)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = currentCalibrationFactor3 / 100.00;
        Ampere_Phase1 = (((float)currentMultiplier / ampPeriod1) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Ampere_Phase1 = (((float)currentMultiplier / ampPeriod1) * 1) * accuracyFactor;
    }
}

void calcAmp2(uint32_t ampPeriod2)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = currentCalibrationFactor3 / 100.00;
        Ampere_Phase2 = (((float)currentMultiplier / ampPeriod2) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Ampere_Phase2 = (((float)currentMultiplier / ampPeriod2) * 1) * accuracyFactor;
    }
}

void calcAmp3(uint32_t ampPeriod3)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = currentCalibrationFactor3 / 100.00;
        Ampere_Phase3 = (((float)currentMultiplier / ampPeriod3) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Ampere_Phase3 = (((float)currentMultiplier / ampPeriod3) * 1) * accuracyFactor;
    }
}

void calcWatt1(uint32_t wattPeriod1)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = powerCalibrationFactor3 / 100.00;
        Watt_Phase1 = (((float)powerMultiplier / wattPeriod1) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Watt_Phase1 = (((float)powerMultiplier / wattPeriod1) * 1) * accuracyFactor;
    }
}

void calcWatt2(uint32_t wattPeriod2)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = powerCalibrationFactor3 / 100.00;
        Watt_Phase2 = (((float)powerMultiplier / wattPeriod2) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Watt_Phase2 = (((float)powerMultiplier / wattPeriod2) * 1) * accuracyFactor;
    }
}

void calcWatt3(uint32_t wattPeriod3)
{
    float tempcalibfactor;
    if (checkByte == 'A')
    {
        tempcalibfactor = powerCalibrationFactor3 / 100.00;
        Watt_Phase3 = (((float)powerMultiplier / wattPeriod3) * tempcalibfactor) * accuracyFactor;
    }
    else
    {
        Watt_Phase3 = (((float)powerMultiplier / wattPeriod3) * 1) * accuracyFactor;
    }
}
