#include "stm8s_it.h"
#include "stm8s.h"
#include "board.h"
#include "metering.h"
#include "uart_service.h"
#include "VIPE_Calculation.h"
void sms_receive(void);
/*
====================================
Voltage Current variables
====================================
*/
uint8_t voltCurrent1OverflowCount = 0;
uint8_t voltCurrent2OverflowCount = 0;
uint8_t voltCurrent3OverflowCount = 0;

/*
====================================
Power variables
====================================
*/
uint8_t power1OverflowCount = 0;
uint8_t power2OverflowCount = 0;
uint8_t power3OverflowCount = 0;
extern uint32_t powerPeriod1; /* defined in metering.c */
extern uint32_t powerPeriod2; /* defined in metering.c */
extern uint32_t powerPeriod3; /* defined in metering.c */
extern @near uint32_t Watt_Phase1;//Added by Saqib
extern @near uint32_t Watt_Phase2;//Added by Saqib
extern @near uint32_t Watt_Phase3;//Added by Saqib
//extern uint8_t powerCalibrationFactor1;
//extern uint8_t powerCalibrationFactor2;
//extern uint8_t powerCalibrationFactor3;
extern char response_buffer[];
bool power1ReadFlag = false;
bool power2ReadFlag = false;
bool power3ReadFlag = false;
//extern bool checkit;
uint16_t timeoutForUART = 0;

/*
====================================
UART1 variables
====================================
*/
extern uint8_t readRxBufferIndx;
extern uint8_t rxBufferIndx;
extern uint8_t rxBuffer[];
extern bool rxBufferReadytoRead;
bool uartDataReadytoRead = false;

/*
====================================
timer tics variable
====================================
*/
extern uint32_t ticsOverflowCounter;

/*
====================================
energy variables
====================================
*/
uint32_t energyPhase1;
uint32_t energyPhase2;
uint32_t energyPhase3;
uint32_t storeEnergyPhase1 = 0;
uint32_t storeEnergyPhase2 = 0;
uint32_t storeEnergyPhase3 = 0;
uint8_t powerAccumulateCount = 0;

#ifdef FREQUENCY_DEBUG_ON
float debugPowerFreq1 = 0, debugPowerFreq2 = 0, debugPowerFreq3 = 0;
#endif

void TIM1_IRQHandler(void) //to measure energy
{
  voltCurrent1OverflowCount++;
  voltCurrent2OverflowCount++;//Added by Saqib
  if (powerAccumulateCount > powerAccumulateCountMax)
  {

    if (powerPeriod1 != 0)
    {
      storeEnergyPhase1 = storeEnergyPhase1 + ((float)(powerMultiplier * powerCalibrationFactor1) / powerPeriod1) * powerAccumulateTime;

      if ((storeEnergyPhase1 >= energyResolution))
      {
        energyPhase1++;
        storeEnergyPhase1 = storeEnergyPhase1 - energyResolution;
      }
    }

    if (powerPeriod2 != 0)
    {
      storeEnergyPhase2 = storeEnergyPhase2 + ((float)(powerMultiplier * powerCalibrationFactor2) / powerPeriod2) * powerAccumulateTime;

      if ((storeEnergyPhase2 >= energyResolution))
      {
        energyPhase2++;
        storeEnergyPhase2 = storeEnergyPhase2 - energyResolution;
      }
    }

    if (powerPeriod3 != 0)
    {
      storeEnergyPhase3 = storeEnergyPhase3 + ((float)(powerMultiplier * powerCalibrationFactor3) / powerPeriod3) * powerAccumulateTime;

      if ((storeEnergyPhase3 >= energyResolution))
      {
        energyPhase3++;
        storeEnergyPhase3 = storeEnergyPhase3 - energyResolution;
      }
    }

    powerAccumulateCount = 0;
  }

  if (power1OverflowCount < powerOverflowCountMax)
  {
    power1OverflowCount++;
  }
  else
  {
    powerPeriod1 = 0;
    Watt_Phase1 = 0; // Added By Saqib
    power1ReadFlag = false;
#ifdef FREQUENCY_DEBUG_ON
    debugPowerFreq1 = 0;
#endif
  }

  if (power2OverflowCount < powerOverflowCountMax)
  {
    power2OverflowCount++;
  }
  else
  {
    powerPeriod2 = 0;
    power2ReadFlag = false;
    Watt_Phase2 = 0; // Added By Saqib
#ifdef FREQUENCY_DEBUG_ON
    debugPowerFreq1 = 0;
#endif
  }

  powerAccumulateCount++;
  // voltCurrent1OverflowCount++;
  // voltCurrent2OverflowCount++; //Commented by Saqib

  TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  TIM1_ClearFlag(TIM1_FLAG_UPDATE);
}

void TIM2_UPD_IRQHandler(void) //to control power,voltage,current overflow counter
{
  ticsOverflowCounter++;

  if (power3OverflowCount < powerOverflowCountMax)
  {
    power3OverflowCount++;
  }
  else
  {
    powerPeriod3 = 0;
    Watt_Phase3 = 0; // Added By Saqib
    power3ReadFlag = false;
#ifdef FREQUENCY_DEBUG_ON
    debugPowerFreq3 = 0;
#endif
  }

  voltCurrent3OverflowCount++;

  TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
  TIM2_ClearFlag(TIM2_FLAG_UPDATE);
}

/*
=========================================================
 * Function: TIM2_CCP_IRQHandler
 * 
 * Measure Power period of Phase 3
=========================================================
*/
void TIM2_CCP_IRQHandler(void)
{
  // uint8_t i;                       /* Test index variable */
  // uint8_t temp[2];                 /* Test buffer */
  static uint16_t powerEndTime;    /* Save end time of CF_L3 pulse */
  ITStatus timer2Ch1_ITStatus;     /* Interrupt status check */
  static uint16_t power3StartTime; /* Save end time of CF_L3 pulse */

  // ms_send_cmd("insideCCPhandler", strlen((const char *)"insideCCPhandler"));
  timer2Ch1_ITStatus = TIM2_GetITStatus(TIM2_IT_CC1);

  if (timer2Ch1_ITStatus == SET)
  {
    powerEndTime = TIM2_GetCapture1(); /* Read Timer value on Input Capture event */

    if (power3ReadFlag == true) /* Avoid Calculation on first capture */
    {
      powerPeriod3 = timer2MaxCount * power3OverflowCount - power3StartTime + powerEndTime;
      calcWatt3(powerPeriod3);

      /* temp[0] = powerPeriod3 >> 8;
      temp[1] = powerPeriod3 & 0x00FF;
      for (i = 0; i < 2; i++)
      {
        while (!UART1_GetFlagStatus(UART1_FLAG_TC))
        {
          ;
        }
        UART1_SendData8(*(temp + i));
      }*/
      // temp[0] = 0;
      // temp[1] = 0;

#ifdef sFREQUENCY_DEBUG_ON
      debugPowerFreq2 = timer2Frequency / powerPeriod2;
#endif
    }

    power3StartTime = powerEndTime;
    power3OverflowCount = 0;
    power3ReadFlag = true;
    TIM2_ClearITPendingBit(TIM2_IT_CC1);
    TIM2_ClearFlag(TIM2_FLAG_CC1);
  }
}

/*
=========================================================
 * Function: TIM1_CCP_IRQHandler
 * 
 * Measure Power period of Phase 1
 * Measure Power period of Phase 2
 =========================================================
*/
void TIM1_CCP_IRQHandler(void)
{
  uint16_t powerEndTime;           /* Save end time of CF_L1 / CF_L2 pulse */
  ITStatus timer1Ch1_ITStatus;     /* Interrupt status check */
  ITStatus timer1Ch3_ITStatus;     /* Interrupt status check */
  static uint16_t power1StartTime; /* Save end time of CF_L1 / CF_L2 pulse */
  static uint16_t power2StartTime; /* Save end time of CF_L1 / CF_L2 pulse */

  timer1Ch1_ITStatus = TIM1_GetITStatus(TIM1_IT_CC1);
  if (timer1Ch1_ITStatus == SET)
  {
    powerEndTime = TIM1_GetCapture1();

    if (power1ReadFlag == true) /* Avoid Calculation on first capture */
    {
      powerPeriod1 = ((timer1MaxCount * power1OverflowCount) - power1StartTime) + powerEndTime;
      calcWatt1(powerPeriod1);//Added by Saqib
#ifdef FREQUENCY_DEBUG_ON
      debugPowerFreq1 = timer1Frequency / powerPeriod1;
#endif
    }

    power1StartTime = powerEndTime;
    power1OverflowCount = 0;
    power1ReadFlag = true;
    TIM1_ClearITPendingBit(TIM1_IT_CC1);
    TIM1_ClearFlag(TIM1_FLAG_CC1);
  }
  // Changed by Saqib
  timer1Ch3_ITStatus = TIM1_GetITStatus(/*TIM1_IT_CC2*/TIM1_IT_CC3); /* Interrupt status check */

  if (timer1Ch3_ITStatus == SET)
  {
    powerEndTime = TIM1_GetCapture3();

    if (power2ReadFlag == true) /* Avoid Calculation on first capture */
    {
      powerPeriod2 = timer1MaxCount * power2OverflowCount - power2StartTime + powerEndTime;
      calcWatt2(powerPeriod2);//Added by Saqib
#ifdef FREQUENCY_DEBUG_ON
      debugPowerFreq1 = timer1Frequency / powerPeriod1;
#endif
    }

    power2StartTime = powerEndTime;
    power2OverflowCount = 0;
    power2ReadFlag = true;
    TIM1_ClearITPendingBit(TIM1_IT_CC3);
    TIM1_ClearFlag(TIM1_FLAG_CC3);
  }
}

@svlreg void UART1_RCV_IRQHandler(void) // recieve data intrrupt
{
  if (UART1_GetFlagStatus(UART1_FLAG_RXNE)) // If Data is Recieved, this clears
  {
    vSerialRecieveISR();
    //ms_send_cmd("I AM IN", strlen((const char *)"I AM IN"));
  }

  if (UART1_GetFlagStatus(UART1_FLAG_IDLE)) // If Data is Recieved, this clears
  {
    uint8_t temp = UART1_ReceiveData8(); // This will clear IDLE Flag
    vHandleDataRecvUARTviaISR();
  }
}

@svlreg void EXTI_PORTD_IRQHandler(void)
{
  //uint8_t uart_buff[85];
  //uint8_t i = 0;
  if (checkit == 1)
  {
    //sms_send_cmd("Message Received", strlen((const char *)"Message Received"));

    //ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); //  no echo
    //delay_ms(200);
    //ms_send_cmd(MSGFT, strlen((const char *)MSGFT));
    //delay_ms(200);
    //ms_send_cmd(SMSRead, strlen((const char *)SMSRead)); // SMS read
    //for (i = 0; i < 85; i++)
    //{
    //while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeoutForUART != 10000))
    //{

    //}
    //uart_buff[i] = UART1_ReceiveData8();
    //timeoutForUART = 0;
    //}
    //ms_send_cmd(uart_buff, 85);
    //-> Commented by Saqib 
    sms_receive();
    checkit = 1;
  }
  // checkit = true;
}

#ifdef _COSMIC_
/**
    @brief Dummy Interrupt routine
    @par Parameters:
    None
    @retval
    None
*/
INTERRUPT_HANDLER(NonHandledInterrupt, 25)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*_COSMIC_*/

/**
    @brief TRAP Interrupt routine
    @param  None
    @retval None
*/
INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Top Level Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TLI_IRQHandler, 0)

{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Auto Wake Up Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(AWU_IRQHandler, 1)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Clock Controller Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(CLK_IRQHandler, 2)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief External Interrupt PORTA Interrupt routine.
    @param  None
    @retval None
*/

//INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
//{
/* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
//ms_send_cmd("Message Received", strlen((const char *)"Message Received")); // Delete SMS
//}

/**
    @brief External Interrupt PORTB Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief External Interrupt PORTC Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief External Interrupt PORTD Interrupt routine.
    @param  None
    @retval None
*/
//INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
//{
/* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
//}

/**
    @brief External Interrupt PORTE Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#if defined(STM8S903) || defined(STM8AF622x)
/**
    @brief External Interrupt PORTF Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(EXTI_PORTF_IRQHandler, 8)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S903) || (STM8AF622x) */

#if defined(STM8S208) || defined(STM8AF52Ax)
/**
    @brief CAN RX Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief CAN TX Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S208) || (STM8AF52Ax) */

/**
    @brief SPI Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(SPI_IRQHandler, 10)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Timer1 Update/Overflow/Trigger/Break Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Timer1 Capture/Compare Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#if defined(STM8S903) || defined(STM8AF622x)
/**
    @brief Timer5 Update/Overflow/Break/Trigger Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM5_UPD_OVF_BRK_TRG_IRQHandler, 13)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Timer5 Capture/Compare Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM5_CAP_COM_IRQHandler, 14)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#else  /* (STM8S208) || (STM8S207) || (STM8S105) || (STM8S103) || (STM8AF62Ax) || (STM8AF52Ax) || (STM8AF626x) */
/**
    @brief Timer2 Update/Overflow/Break Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Timer2 Capture/Compare Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S903) || (STM8AF622x) */

#if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S105) || \
    defined(STM8S005) || defined(STM8AF62Ax) || defined(STM8AF52Ax) || defined(STM8AF626x)
/**
    @brief Timer3 Update/Overflow/Break Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief Timer3 Capture/Compare Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S208) || (STM8S207) || (STM8S105) || (STM8AF62Ax) || (STM8AF52Ax) || (STM8AF626x) */

#if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S103) || \
    defined(STM8S003) || defined(STM8AF62Ax) || defined(STM8AF52Ax) || defined(STM8S903)
/**
    @brief UART1 TX Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief UART1 RX Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S208) || (STM8S207) || (STM8S103) || (STM8S903) || (STM8AF62Ax) || (STM8AF52Ax) */

#if defined(STM8AF622x)
/**
    @brief UART4 TX Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART4_TX_IRQHandler, 17)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief UART4 RX Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART4_RX_IRQHandler, 18)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8AF622x) */

/**
    @brief I2C Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(I2C_IRQHandler, 19)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#if defined(STM8S105) || defined(STM8S005) || defined(STM8AF626x)
/**
    @brief UART2 TX interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief UART2 RX interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S105) || (STM8AF626x) */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined(STM8AF52Ax) || defined(STM8AF62Ax)
/**
    @brief UART3 TX interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @brief UART3 RX interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S208) || (STM8S207) || (STM8AF52Ax) || (STM8AF62Ax) */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined(STM8AF52Ax) || defined(STM8AF62Ax)
/**
    @brief ADC2 interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#else  /* STM8S105 or STM8S103 or STM8S903 or STM8AF626x or STM8AF622x */
/**
    @brief ADC1 interrupt routine.
    @par Parameters:
    None
    @retval
    None
*/
INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S208) || (STM8S207) || (STM8AF52Ax) || (STM8AF62Ax) */

#if defined(STM8S903) || defined(STM8AF622x)
/**
    @brief Timer6 Update/Overflow/Trigger Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM6_UPD_OVF_TRG_IRQHandler, 23)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#else  /* STM8S208 or STM8S207 or STM8S105 or STM8S103 or STM8AF52Ax or STM8AF62Ax or STM8AF626x */
/**
    @brief Timer4 Update/Overflow Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* (STM8S903) || (STM8AF622x)*/

/**
    @brief Eeprom EEC Interrupt routine.
    @param  None
    @retval None
*/
INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
    @}
*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/