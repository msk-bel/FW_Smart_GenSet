/**
  ****************************************************************************************************
  * File:    board.c
  * Author:  M.Ahmad Naeem
  * Version: V1.0.0
  * Date:    20-May-2021
  * Brief:   This file contains all the functions for initializing the controller peripherals.
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
#include "board.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
void SetPortD7AsTim1_Ch4(void);

/* Public functions ----------------------------------------------------------*/

uint8_t checkByte;
uint8_t voltageCalibrationFactor1;
uint8_t voltageCalibrationFactor2;
uint8_t voltageCalibrationFactor3;
uint8_t currentCalibrationFactor1;
uint8_t currentCalibrationFactor2;
uint8_t currentCalibrationFactor3;
uint8_t powerCalibrationFactor1;
uint8_t powerCalibrationFactor2;
uint8_t powerCalibrationFactor3;
bool checkit = 0;
void systemInit(void)
{
	
	clockSetup();
	EEPROMSetup();
	getCalibration();
	// Option Bytes Setup, Set AFR4 bit of OPT2 Byte as 1 to activate TIM1_CH4 & Disable TLI
	SetPortD7AsTim1_Ch4();
	//////////////////////
	gpioSetup();
	timer2Setup();
	timer1Setup();
	ADCSetup();
	UARTSetup(uartBaudRate, MEVRIS_UART_PARITY_NONE);
	EXTI_setup();
	
	//IWDG_Config(); /* Disable Watchdog for testing purpose */
}

/*
================================================================
*Function: clockSetup
*
*	Enable the High Speed Internal RC Oscillator which is 16MHz,
*
*	fHSI = fHSIDIV = fMaster = fCPU = 16MHz
*
*	fHSI-->High Speed Internal Oscillator clock signal.
*	fHSIDIV-->Scaled High Speed Internal Oscillator clock signal.
*	fMaster-->Master Clock Switch clock signal.
*	fCPU-->Scaled fMaster clock signal.
=================================================================
*/
void clockSetup(void)
{
	CLK_DeInit();
	CLK_HSECmd(DISABLE); /* Disable High Speed External clock signal */
	CLK_LSICmd(DISABLE); /* Disable Low Speed Internal clock signal */
	CLK_HSICmd(ENABLE);	 /* Enable high speed internal clock signal  */

	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE)
	{
		; /* Wait until HSI clock signal is stable */
	}

	CLK_ClockSwitchCmd(ENABLE);
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE); /* Select HSI as master clock source */
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
}

/*
===================================================================
*Funtion: gpioSetup 
*   ---> Initiliazes the Port A,C and D.
*
*   Port D
*   ---> GPIO 2 for current and voltage selection pin for HLW8012.
*   ---> GPIO 5 Tx for MAX232.
*   ---> GPIO 6 Rx for MAX232.
*   ---> GPIO 3 Current & Voltage Read pin for Phase 3.
*   ---> GPIO 7 Current & Voltage Read pin for Phase 2.
*   ---> GPIO 4 Power Read phase 3.
*
*   Port C
*   ---> GPIO 5 GSM Power Pin.
*   ---> GPIO 2 Current & Voltage Read pin for Phase 1.
*   ---> GPIO 1 Power Read phase 1.
*   ---> GPIO 3 Power Read phase 2.
=====================================================================
*/
void gpioSetup(void)
{
	GPIO_DeInit(GPIOD);											   // Deinitialize Port D
	GPIO_DeInit(GPIOC);											   // Deinitialize Port C
	GPIO_DeInit(GPIOA);											   // Deinitialize Port A
	GPIO_Init(txPin, GPIO_MODE_OUT_PP_HIGH_FAST);				   // Tx pin MAX232
	GPIO_Init(rxPin, GPIO_MODE_IN_PU_NO_IT);					   // Rx pin MAX232
	GPIO_Init(PWRKEY, GPIO_MODE_OUT_PP_LOW_FAST);				   // SIMCom module power pin
	GPIO_Init(currentVoltSelectionPin, GPIO_MODE_OUT_PP_LOW_FAST); // current and volt selection pin in PUSH-PULL Mode
	GPIO_WriteHigh(currentVoltSelectionPin);					   // initially select voltage 1=Voltage & 0=Current
	GPIO_Init(currentVoltFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 1 pin
	GPIO_Init(currentVoltFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 2 pin
	GPIO_Init(currentVoltFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 3 pin
	GPIO_Init(powerFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 1 pin
	GPIO_Init(powerFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 2 pin
	GPIO_Init(powerFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 3 pin
	GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
	GPIO_Init(RingIndicatorPin, GPIO_MODE_IN_FL_IT);			   //Ring Indicator interrupt
	GPIO_Init(BatteryVoltagePin, GPIO_MODE_IN_FL_NO_IT);		   //Battery Voltage read pin
	GPIO_Init(Temp1Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 1 read pin
	GPIO_Init(Temp2Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 2 read pin
}

/*
=======================================================================================================================
*Function: timer2Setup
*
*	Timer2 timer base unit initialization.
*	Input Capture initialization.
*
*	Timer2 base unit
*	---> Prescalar value 7, it divides the CK_PSC (fMaster = 16MHz) by 8 to give counter clock which drives counter.
*	---> Max count is 65535.
*
*	Input Capture Channel
*	---> Channel 1 input falling.
*	---> Channel 2 input falling.
*	---> Interrupt enabled on channel 1.
*	---> Interrupt enabled on Update/Overeflow.
=========================================================================================================================
*/
void timer2Setup(void)
{
	TIM2_DeInit();																							/* Deinitialize Timer 2 */
	TIM2_TimeBaseInit(timer2Prescaler, timer2MaxCount);														/* Timer2 : time base generation */
	TIM2_ICInit(TIM2_CHANNEL_1, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
	TIM2_ICInit(TIM2_CHANNEL_2, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
	TIM2_CCxCmd(TIM2_CHANNEL_1, ENABLE);																	/* Enable Timer 2 Capture Compare Channel 1 */
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);																	/* Timer 2 overflow interrupt enable */
	TIM2_ITConfig(TIM2_IT_CC1, ENABLE);																		/* Timer 1 input capture channel 3 interrupt enable */
	TIM2_Cmd(ENABLE);
}

/*
====================================================================================================================
*Function: timer1Setup
*
*	Timer1 timer base unit initialization.
*	Input Capture initialization.
*
*	Timer1 base unit
*	---> Prescalar value 7, it divides the CK_PSC (fMaster=16MHz) by 8 to give counter clock which drives counter.
*	---> Counter up mode.
*	---> Max count is 65535.
*	---> Repeater counter is NULL, update event on 1 count.
*
*	Input Capture Channel
*	---> Channel 1 input falling.
*	---> Channel 2 input falling.
*	---> Channel 3 input falling.
*	---> Channel 4 input falling.
*	---> Interrupt enabled on channel 1.
*	---> Interrupt enabled on channel 3.
*	---> Interrupt enabled on Update/Overeflow.
=======================================================================================================================
*/
void timer1Setup(void)
{
	TIM1_DeInit();																							/* Deinitialize Timer 1 */
	TIM1_TimeBaseInit(timer1Prescaler, TIM1_COUNTERMODE_UP, timer1MaxCount, timer1Repeat);					/* Timer1 : time base generation */
	TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
	TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
	TIM1_ICInit(TIM1_CHANNEL_4, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);	/* Initialize Input Capture Channel 3 */
	TIM1_CCxCmd(TIM1_CHANNEL_1, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 1 */
	TIM1_CCxCmd(TIM1_CHANNEL_3, ENABLE);
	// TIM1_CCxCmd(TIM1_CHANNEL_4, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 2 */
	TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE); //Uncommented by Saqib																	/* Timer 1 overflow interrupt enable */
	TIM1_ITConfig(TIM1_IT_CC1, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
	TIM1_ITConfig(TIM1_IT_CC3, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */

	TIM1_Cmd(ENABLE); /* Enable Timer 1 */
}

/*
===============================================================
*Function: IWDG_Config
*
*	Watchdog timer enable.
===============================================================
*/
void IWDG_Config(void)
{
	IWDG_Enable();

	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
	IWDG_SetPrescaler(IWDG_Prescaler_256);
	IWDG_SetReload(0xFF);
	IWDG_ReloadCounter();
}

/*
===============================================================
*Function: EXTI_setup
*
*	
===============================================================
*/
void EXTI_setup(void)
{
	ITC_DeInit();
	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
	EXTI_DeInit();
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
	enableInterrupts();
}

/*
===============================================================
*Function: EEPROMSetup
*
*	
===============================================================
*/
void EEPROMSetup(void)
{
	FLASH_DeInit();
}

void getCalibration()
{
	checkByte = FLASH_ReadByte(CheckByte);
	voltageCalibrationFactor1 = FLASH_ReadByte(V1CabFab);
	voltageCalibrationFactor2 = FLASH_ReadByte(V2CabFab);
	voltageCalibrationFactor3 = FLASH_ReadByte(V3CabFab);
	currentCalibrationFactor1 = FLASH_ReadByte(I1CabFab);
	currentCalibrationFactor2 = FLASH_ReadByte(I2CabFab);
	currentCalibrationFactor3 = FLASH_ReadByte(I3CabFab);
	powerCalibrationFactor1 = FLASH_ReadByte(P1CabFab);
	powerCalibrationFactor3 = FLASH_ReadByte(P3CabFab);
	powerCalibrationFactor2 = FLASH_ReadByte(P2CabFab);
}

/*
===============================================================
*Function: ADCSetup
*
*	
===============================================================
*/
void ADCSetup(void)
{
	ADC2_DeInit();
	ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_0, ADC2_PRESSEL_FCPU_D8, ADC2_EXTTRIG_GPIO, DISABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL0, DISABLE);
	ADC2_SchmittTriggerConfig(ADC2_SCHMITTTRIG_ALL, DISABLE);
	ADC2_ITConfig(DISABLE);
}

/*
==============================================================
*Function: UARTSetup
*
*	Initialize the UART1
*	BaudRate = 9600
*	WordLength = 8
*	Parity = No
*	StopBits = 1
*	TX & RX Enable
*	Interrupt Enable on Receive
===============================================================
*/
void UARTSetup(uint32_t baudRate, UARTCONFIG config)
{
	UART1_DeInit();

	switch (config)
	{
	case MEVRIS_UART_PARITY_NONE:
		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
		break;
	default:
		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
		break;
	}

	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
	UART1_Cmd(ENABLE);
}

/*
==============================================================
*Function: SetPortD7AsTim1_Ch4
*
*	Programs option Byte OPT2 & NOPT2 bit number 4, AFR4 as 1, which by default is 0
===============================================================
*/

#define OP2_Address 0x4803

void SetPortD7AsTim1_Ch4(void)
{
	uint16_t OPT2_status; /*Record the status OPT2 to check whether is it is TLI or Tim1_CH4*/
	OPT2_status = FLASH_ReadOptionByte(OP2_Address);
	if ((OPT2_status & 0x1000) == 0)
	{
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		delay_ms(100);
		/*SetOPT2 to TIM1_CH4, deactivate TLI and restore TIM1_CH4 channel*/
		FLASH_ProgramOptionByte(OP2_Address, (uint8_t)((uint8_t)(OPT2_status >> 8) | 0x10));
		delay_ms(100);
		FLASH_Lock(FLASH_MEMTYPE_DATA);
		
	}
}

/**************************************** (C) COPYRIGHT BlueEast *****END OF FILE*************************************************/