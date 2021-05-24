/**
  ****************************************************************************************************
  * File:    metering.c
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
#include "metering.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/
uint32_t voltagePeriod1 = 0;
uint32_t voltagePeriod2 = 0;
uint32_t voltagePeriod3 = 0;
uint32_t currentPeriod1 = 0;
uint32_t currentPeriod2 = 0;
uint32_t currentPeriod3 = 0;
uint32_t powerPeriod1 = 0;
uint32_t powerPeriod2 = 0;
uint32_t powerPeriod3 = 0;
uint32_t discardPulseTics = 0;
bool bypassPulseTicsFlag = false;
bool voltCurrentSelectionFlag = false;    // true: measure volt,  false: measure current

void calculateVoltCurrent(uint32_t timeout)
{
  uint8_t tempCount = 0;           //local variable to store overflow count
  FlagStatus timer1Ch4_FlagStatus; // Flag status check timer1 Channel 4
  FlagStatus timer1Ch2_FlagStatus; // Flag status check timer1 Channel 2
  FlagStatus timer2Ch2_FlagStatus; // Flag status check timer2 Channel 2
  uint16_t ICStartTics = 0;
  uint16_t ICEndTics = 0;
  uint32_t presentTics;
  bool FirstCaptureFlag = false;  // Flag for implementing one iteration
  bool SecondCaptureFlag = false; // Flag for implementing one iteration
  bypassPulseTicsFlag = false;    // Flag for implementing one iteration for main while loop

  while (getTics() - discardPulseTics > discardPulseTimeout && !bypassPulseTicsFlag)
  {
    /*
    ============================================================================================================
                              <Start of phase 2 current / voltage period calculation>
    ============================================================================================================
    */
    TIM1_CCxCmd(TIM1_CHANNEL_4, ENABLE); // Enable time 1 channel 4
    presentTics = getTics();             // capture value of current tics from timercounter register
    TIM1_ClearFlag(TIM1_FLAG_CC4);       // Clear status bit

    while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
    {
      timer1Ch4_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC4);

      if (timer1Ch4_FlagStatus == SET)
      {
        ICStartTics = TIM1_GetCapture4();
        TIM1_ClearFlag(TIM1_FLAG_CC4); // Clear status bit
        voltCurrent2OverflowCount = 0;
        FirstCaptureFlag = true; // make it true to let loop iterate one time only
      }
    }

    if (FirstCaptureFlag == true)
    {
      presentTics = getTics();

      while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
      {
        timer1Ch4_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC4);

        if (timer1Ch4_FlagStatus == SET)
        {
          ICEndTics = TIM1_GetCapture4();
          tempCount = voltCurrent2OverflowCount; // Get number of overflows immediately after captruing tics
          TIM1_ClearFlag(TIM1_FLAG_CC4);
          SecondCaptureFlag = true;
          TIM1_CCxCmd(TIM1_CHANNEL_4, DISABLE); // Disable time 1 channel 4

          if (voltCurrentSelectionFlag)
          {
            voltagePeriod2 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
            calcVolt2(voltagePeriod2);
          }

          else
          {
            currentPeriod2 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
            calcAmp2(currentPeriod2);
          }
        }
      }
    }

    else
    {
      if (voltCurrentSelectionFlag)
      {
        voltagePeriod2 = 0;
      }

      else
      {
        currentPeriod2 = 0;
      }
    }

    /*
    ============================================================================================================
                            <Start of phase 1 current / voltage period calculation>
    ============================================================================================================
    */
    TIM1_CCxCmd(TIM1_CHANNEL_2, ENABLE); // Enable time 1 channel 2
    FirstCaptureFlag = false;            // Make false to iterate one time
    SecondCaptureFlag = false;           // Make false to iterate one time
    presentTics = getTics();
    TIM1_ClearFlag(TIM1_FLAG_CC2);

    while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
    {
      timer1Ch2_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC2);

      if (timer1Ch2_FlagStatus == SET)
      {
        voltCurrent1OverflowCount = 0;
        ICStartTics = TIM1_GetCapture2();
        TIM1_ClearFlag(TIM1_FLAG_CC2);
        FirstCaptureFlag = true;
      }
    }

    if (FirstCaptureFlag == true)
    {
      presentTics = getTics();

      while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
      {
        timer1Ch2_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC2);

        if (timer1Ch2_FlagStatus == SET)
        {
          ICEndTics = TIM1_GetCapture2();
          tempCount = voltCurrent1OverflowCount; // Get number of overflows immediately after captruing tics
          TIM1_ClearFlag(TIM1_FLAG_CC2);
          SecondCaptureFlag = true;
          TIM1_CCxCmd(TIM1_CHANNEL_2, DISABLE);

          if (voltCurrentSelectionFlag)
          {
            voltagePeriod1 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
            calcVolt1(voltagePeriod1); //Calculate voltage of phase 1
          }
          else
          {
            currentPeriod1 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
            calcAmp1(currentPeriod1); //Calculate current of phase 1
          }
        }
      }
    }

    else
    {
      if (voltCurrentSelectionFlag)
      {
        voltagePeriod1 = 0;
      }
      else
      {
        currentPeriod1 = 0;
      }
    }

    /*
    ============================================================================================================
                            <Start of phase 3 current / voltage period calculation>
    ============================================================================================================
    */
    TIM2_CCxCmd(TIM2_CHANNEL_2, ENABLE); // Enable time 1 channel 2
    FirstCaptureFlag = false;            // Make false to iterate one time
    SecondCaptureFlag = false;           // Make false to iterate one time
    presentTics = getTics();
    TIM2_ClearFlag(TIM2_FLAG_CC2);

    while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
    {
      timer2Ch2_FlagStatus = TIM2_GetFlagStatus(TIM2_FLAG_CC2);

      if (timer2Ch2_FlagStatus == SET)
      {
        ICStartTics = TIM2_GetCapture2();
        TIM2_ClearFlag(TIM2_FLAG_CC2);
        voltCurrent3OverflowCount = 0;
        FirstCaptureFlag = true;
      }
    }

    if (FirstCaptureFlag == true)
    {
      presentTics = getTics();

      while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
      {
        timer2Ch2_FlagStatus = TIM2_GetFlagStatus(TIM2_FLAG_CC2);

        if (timer2Ch2_FlagStatus == SET)
        {
          ICEndTics = TIM2_GetCapture2();
          tempCount = voltCurrent3OverflowCount;
          TIM2_ClearFlag(TIM2_FLAG_CC2);
          SecondCaptureFlag = true;
          TIM2_CCxCmd(TIM2_CHANNEL_2, DISABLE);

          if (voltCurrentSelectionFlag)
          {
            voltagePeriod3 = timer2MaxCount * tempCount - ICStartTics + ICEndTics;
            calcVolt3(voltagePeriod3); // Calculate voltage of phase 3
          }
          else
          {
            currentPeriod3 = ((timer2MaxCount * tempCount) - ICStartTics) + ICEndTics;
            calcAmp3(currentPeriod3); // Calculate current of phase 3
          }
        }
      }
    }

    else
    {
      if (voltCurrentSelectionFlag)
      {
        voltagePeriod3 = 0;
      }
      else
      {
        currentPeriod3 = 0;
      }
    }

    if (voltCurrentSelectionFlag)
    {
      GPIO_WriteLow(currentVoltSelectionPin);
      voltCurrentSelectionFlag = false;
    }
    else
    {
      GPIO_WriteHigh(currentVoltSelectionPin);
      voltCurrentSelectionFlag = true;
    }

    discardPulseTics = getTics();
    bypassPulseTicsFlag = true;
  }
}
/*============================<End of Phase 3 current / voltage calculation>========================================*/