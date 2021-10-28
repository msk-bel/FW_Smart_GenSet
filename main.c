/**
  ****************************************************************************************************
  * File:    		main.c
  * Author:  		M.Ahmad Naeem
  * Author:	 		Saqib Kamal
  * Version: 		V1.1.0
  * Date:    		20-May-2021
  * Last Modified:	20-Oct-2021
  * Brief:   This file contains all the functions for System Setup, SIMMCOM/Quectel Setup and Reading Sensors.
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
#include "main.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

@near uint8_t response_buffer[100] = "";
uint16_t timeout = 0;
uint8_t OK;
uint8_t cloud_gps_data_flag = 0;
uint8_t flag2 = 0;
uint8_t sms_recev = 0;
uint8_t cloud_connectivity_flag = 0;
uint8_t gprs_post_response_status = 0;
uint8_t gprs_init_flag = 0;
uint8_t noEchoFlag = 0;
bool arm_flag = 0;
volatile bool activation_flag = 0;
uint8_t IMEIRecievedOKFlag = 0;
void systemSetup(void)
{
	systemInit();
	SIMCom_setup();
	//GPRS_reconnect();
	//test_at_ok(); //temp
	clearBuffer();
}

void main(void)
{
	systemSetup();
	while (1)
	{
		calculateVoltCurrent(maxPeriodWidth);
		//	previousTics = getTics();
		getbatteryvolt();
		gettemp1();
		gettemp2();
		getFuelLevel();
		sendDataToCloud(); // Uncommented by Saqib
		vHandle_MQTT();	   //Added By Saqib
						   // while ( getTics() - previousTics < uartTimout)
						   //{
						   //	IWDG_ReloadCounter();
		gps_data();
	}
}

void sms_receive(void)
{
	uint8_t cell_num[14];
	uint8_t uart_buffer[85];
	// uint8_t check_cmnd[10];
	uint8_t temp1[10] = "";
	uint8_t calibrationFactor[4];
	uint16_t value;
	uint8_t i, j, m, n, k = 0, l = 0, t = 0;
	char *ret_pin;
	uint32_t myVar = 0;
	UART1_ITConfig(UART1_IT_RXNE, DISABLE);
	UART1_ITConfig(UART1_IT_IDLE, DISABLE);

	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); //  no echo
	delay_ms(200);
	ms_send_cmd(MSGFT, strlen((const char *)MSGFT));
	delay_ms(200);
	ms_send_cmd(SMSRead, strlen((const char *)SMSRead)); // SMS read

	for (i = 0; i < 85; i++)
	{
		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
			;
		uart_buffer[i] = UART1_ReceiveData8();
		timeout = 0;
	}

	if (strstr(uart_buffer, "+CMGR"))
	{
		k = 0;
		while (uart_buffer[k] != '+')
		{
			k++;
		}
		k++;
		while (uart_buffer[k] != '+')
		{
			k++;
		}
		for (l = 0; l < 13; l++)
		{
			cell_num[l] = uart_buffer[k];
			k++;
		}
	}
	cell_num[l] = '\0';

	ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); // Delete SMS
	delay_ms(200);
	// ms_send_cmd("MSG Recieved: ", strlen((const char *)"MSG Recieved: "));
	// delay_ms(200);
	// ms_send_cmd(uart_buffer, 85);
	if (strstr(uart_buffer, "CALIBRATE"))
	{
		checkByte = 'B';
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(CheckByte, 'A');//Earlier
		FLASH_ProgramByte(CheckByte, 'B'); //Changed by Saqib
		FLASH_Lock(FLASH_MEMTYPE_DATA);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	if (strstr(uart_buffer, "CALIBRATION DONE"))
	{
		checkByte = 'A';
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		FLASH_ProgramByte(CheckByte, 'A');
		FLASH_Lock(FLASH_MEMTYPE_DATA);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	if (strstr(uart_buffer, "V1CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		voltageCalibrationFactor1 = value; //Added By saqib, earlier not present
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(V1CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(V1CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, V1CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "V2CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		voltageCalibrationFactor2 = value; //Added By saqib, earlier not present
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(V2CabFab, value);
		// FLASH_ProgramByte(V2CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(V2CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, V2CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "V3CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		voltageCalibrationFactor3 = value;
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(V3CabFab, value);
		// FLASH_ProgramByte(V3CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(V3CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, V3CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "I1CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		currentCalibrationFactor1 = value; //Added By saqib, earlier not present
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(I1CabFab, value);
		// FLASH_ProgramByte(I1CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(I1CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, I1CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "I2CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		currentCalibrationFactor2 = value; //Added By saqib, earlier not present
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(I2CabFab, value);
		// FLASH_ProgramByte(I2CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(I2CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, I2CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "I3CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		currentCalibrationFactor3 = value;
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(I3CabFab, value);
		// FLASH_ProgramByte(I3CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(I3CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, I3CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "P1CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		powerCalibrationFactor1 = value; //Added By saqib, earlier not present
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(P1CabFab, value);
		// FLASH_ProgramByte(P1CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(P1CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, P1CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "P2CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		powerCalibrationFactor2 = value; //Added By saqib, earlier not present
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(P2CabFab, value);
		// FLASH_ProgramByte(P2CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(P2CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, P2CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}

	else if (strstr(uart_buffer, "P3CalFac = "))
	{
		t = k + 42;
		for (n = 0; n < 4; n++)
		{
			calibrationFactor[n] = uart_buffer[t];
			t++;
		}
		calibrationFactor[n] = '\0';
		value = atoi(calibrationFactor);
		powerCalibrationFactor3 = value;
		// FLASH_Unlock(FLASH_MEMTYPE_DATA);
		// FLASH_ProgramByte(P3CabFab, value);
		// FLASH_ProgramByte(P3CabFab_LSB, (value & 0xFF));
		// FLASH_ProgramByte(P3CabFab_MSB, ((value >> 8) & 0xFF));
		// FLASH_ProgramWord()
		// FLASH_Lock(FLASH_MEMTYPE_DATA);
		WriteFlashWord(value, P3CabFab);
		bSendSMS("OK", strlen((const char *)"OK"), cell_num);
	}
	// bSendSMS("OK",strlen((const char*)"OK"),cell_num);
	if (strstr(uart_buffer, "CURRENT1"))
	{
		sendSMSCurrent(Ampere_Phase1, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "VOLTAGE1")))
	{
		sendSMSVoltage(Voltage_Phase1, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "POWER1")))
	{
		sendSMSPower(Watt_Phase1, cell_num); //Changed by Saqib
	}
	else if (strstr(uart_buffer, "CURRENT2"))
	{
		sendSMSCurrent(Ampere_Phase2, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "VOLTAGE2")))
	{
		sendSMSVoltage(Voltage_Phase2, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "POWER2")))
	{
		sendSMSPower(Watt_Phase2, cell_num); //Changed by Saqib
	}
	else if (strstr(uart_buffer, "CURRENT3"))
	{
		sendSMSCurrent(Ampere_Phase3, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "VOLTAGE3")))
	{
		sendSMSVoltage(Voltage_Phase3, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "POWER3")))
	{
		sendSMSPower(Watt_Phase3, cell_num); //Changed by Saqib
	}
	else if ((strstr(uart_buffer, "RADIATOR-TEMP")))
	{
		myVar = (uint32_t)(Temperature1 * 100);
		if (myVar > 100000)
			myVar = 0;
		vClearBuffer(uart_buffer, 85);
		strcpy(uart_buffer, "Radiator Temperature: ");
		sprintf(temp1, "%ld", myVar / 100);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, ".");
		sprintf(temp1, "%ld", myVar % 100);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, " C");
		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
	}
	else if ((strstr(uart_buffer, "ENGINE-TEMP")))
	{
		myVar = (uint32_t)(Temperature2 * 100);
		if (myVar > 100000)
			myVar = 0;
		vClearBuffer(uart_buffer, 85);
		strcpy(uart_buffer, "Engine Temperature: ");
		sprintf(temp1, "%ld", myVar / 100);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, ".");
		sprintf(temp1, "%ld", myVar % 100);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, " C");
		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
	}
	else if ((strstr(uart_buffer, "BATTERY-VOLT")))
	{
		// myVar = (uint32_t)(Temperature1 * 100);
		vClearBuffer(uart_buffer, 85);
		strcpy(uart_buffer, "Battery: ");
		sprintf(temp1, "%ld", batVolt / 100);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, ".");
		sprintf(temp1, "%ld", batVolt % 100);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, " Volts");
		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
	}
	else if ((strstr(uart_buffer, "FUEL-LEVEL")))
	{
		vClearBuffer(uart_buffer, 85);
		strcpy(uart_buffer, "Fuel: ");
		sprintf(temp1, "%ld", Fuellevel);
		strcat(uart_buffer, temp1);
		strcat(uart_buffer, " Value");
		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
	}

	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
}

bool bSendSMS(char *message, uint8_t messageLength, char *Number)
{
	uint8_t buffer[24] = "AT+CMGS=\"+923316821907\"";
	uint8_t tempBuffer[24];
	uint8_t i;
	uint32_t whileTimeout = 650000;
	delay_ms(2000);
	for (i = 10; i < 22; i++)
	{
		buffer[i] = *(Number + (i - 9));
	}
	i++;
	buffer[i] = '\0';

	ms_send_cmd(buffer, strlen((const char *)buffer));
	delay_ms(20);

	for (i = 0; i < messageLength; i++)
	{
		while (!UART1_GetFlagStatus(UART1_FLAG_TC))
			;
		UART1_SendData8(*(message + i));
	}
	delay_ms(10);
	while (!UART1_GetFlagStatus(UART1_FLAG_TC))
		;
	UART1_SendData8(0x1A);
	delay_ms(200); // Wait for 2 Seconds to check response of Module if SMS has been send or not

	tempBuffer[0] = 0;
	tempBuffer[1] = 0;
	while (tempBuffer[0] != '+' && tempBuffer[1] != 'C' && --whileTimeout > 0)
	{
		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
			;
		tempBuffer[0] = tempBuffer[1];
		tempBuffer[1] = UART1_ReceiveData8();
		timeout = 0;
	}
	for (i = 2; i < 23; i++)
	{
		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
			;
		tempBuffer[i] = UART1_ReceiveData8();
		timeout = 0;
	}
	tempBuffer[i] = '\0';

	if (strstr(tempBuffer, "+CMGS"))
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

// int GSM_DOWNLOAD(void)
// {
// 	uint8_t r1;
// 	char *ret3;
// 	const char STATUS1[] = "DOWNLOAD";
// 	char response_buffer[11];
// 	uint16_t gsm_download_timeout = 10000;

// 	for (r1 = 0; r1 < 11; r1++)
// 	{
// 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_download_timeout > 0))
// 			;
// 		response_buffer[r1] = UART1_ReceiveData8();
// 	}

// 	ret3 = strstr(response_buffer, STATUS1);

// 	if (ret3)
// 	{

// 		return 1;
// 	}

// 	else

// 	{

// 		return 0;
// 	}
// }

// int GSM_OK_FAST(void)
// {
// 	uint8_t p;
// 	uint16_t gsm_ok_timeout = 7000;
// 	const char OK[3] = "OK";
// 	char *ret1;

// 	for (p = 0; p < 30; p++) //8 for error
// 	{
// 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
// 			;
// 		//while (UART1_GetFlagStatus (UART1_FLAG_RXNE) == FALSE);
// 		response_buffer[p] = UART1_ReceiveData8();
// 	}

// 	ret1 = strstr(response_buffer, OK);

// 	if (ret1)
// 	{
// 		return 1;
// 	}

// 	else

// 	{
// 		return 0;
// 	}
// }

int GSM_OK(void)
{
	uint8_t p;
	uint16_t gsm_ok_timeout = 30000;
	const char OK[3] = "OK";
	char *ret1;

	for (p = 0; p < 30; p++) //8 for error
	{
		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
			;
		//while (UART1_GetFlagStatus (UART1_FLAG_RXNE) == FALSE);
		response_buffer[p] = UART1_ReceiveData8();
	}

	ret1 = strstr(response_buffer, OK);

	if (ret1)
	{
		return 1;
	}

	else

	{
		return 0;
	}
}

void clearBuffer()
{
	uint8_t s;
	for (s = 0; s < 100; s++)
	{

		response_buffer[s] = '\0';
		//timeout=0;
	}
}

//Changed by Saqib
void sendSMSCurrent(uint32_t Current, uint8_t *cell_number)
{
	uint8_t u;
	uint8_t f;
	uint8_t w;
	uint8_t current[26] = "Current is ";
	uint8_t currentUnit[6] = " Amps";
	uint8_t templen = 0;
	uint8_t decplace = 0;
	uint8_t tempwho[6];
	uint8_t tempwho2[16];

	sprintf(tempwho, "%lu", Current);
	templen = strlen(tempwho);
	decplace = templen - 2;
	tempwho2[decplace] = '.';
	for (w = 0; w < decplace; w++)
	{
		tempwho2[w] = tempwho[w];
	}
	f = decplace + 1;
	for (w = f; w <= templen; w++)
	{
		u = w - 1;
		tempwho2[w] = tempwho[u];
	}
	tempwho2[w] = '\0';
	strcat(tempwho2, currentUnit);
	strcat(current, tempwho2);
	bSendSMS(current, strlen((const char *)current), cell_number);
}
//Changed by Saqib
void sendSMSVoltage(uint32_t Voltage, uint8_t *cell_number)
{
	uint8_t u;
	uint8_t f;
	uint8_t w;
	uint8_t voltage[29] = "Voltage is ";
	uint8_t voltageUnit[7] = " Volts";
	uint8_t templen = 0;
	uint8_t decplace = 0;
	uint8_t tempwho[6];
	uint8_t tempwho2[16];

	sprintf(tempwho, "%lu", Voltage);
	templen = strlen(tempwho);
	decplace = templen - 2;
	tempwho2[decplace] = '.';
	for (w = 0; w < decplace; w++)
	{
		tempwho2[w] = tempwho[w];
	}
	f = decplace + 1;
	for (w = f; w <= templen; w++)
	{
		u = w - 1;
		tempwho2[w] = tempwho[u];
	}
	tempwho2[w] = '\0';
	strcat(tempwho2, voltageUnit);
	strcat(voltage, tempwho2);
	bSendSMS(voltage, strlen((const char *)voltage), cell_number);
}
//Changed by Saqib
void sendSMSPower(uint32_t Power, uint8_t *cell_number)
{
	uint8_t u;
	uint8_t f;
	uint8_t w;
	uint8_t power[31] = "Power is ";
	uint8_t powerUnit[7] = " Watts";
	uint8_t templen = 0;
	uint8_t decplace = 0;
	uint8_t tempwho[6];
	uint8_t tempwho2[16];

	sprintf(tempwho, "%lu", Power);
	templen = strlen(tempwho);
	decplace = templen - 2;
	tempwho2[decplace] = '.';
	for (w = 0; w < decplace; w++)
	{
		tempwho2[w] = tempwho[w];
	}
	f = decplace + 1;
	for (w = f; w <= templen; w++)
	{
		u = w - 1;
		tempwho2[w] = tempwho[u];
	}
	tempwho2[w] = '\0';
	strcat(tempwho2, powerUnit);
	strcat(power, tempwho2);
	bSendSMS(power, strlen((const char *)power), cell_number);
}