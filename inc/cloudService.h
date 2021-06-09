#ifndef __cloudService_H
#define __cloudService_H

#include "stm8s.h"
#include <string.h>
#include "stdio.h"
#include "uart_service.h"
#include "SIMCom.h"

#define MEVRIS_SEND_DATA_MAX_SIZE 100
#define MEVRIS_RECV_DATA_MAX_SIZE 70
#define MQTT_TOPIC_HEADER			"sc1"
#define MQTT_INBOUND_TOPIC_FOOTER	"cmd"
#define MQTT_OUTBOUND_TOPIC_FOOTER	"evt"

typedef enum COMMAND_TYPE_ENUM
{
	eCommand_Reserved 	= 0,
	eCommand_IMEI 		= 1,
	eCommand_SIM_Number	= 2,
	eCommand_Location	= 3,
	eCommand_Bike_State	= 4,
	eCommand_Version	= 5,
	eCommand_Others		= 6,
	eCommand_Unknown	= 7
}enCOMMAND_TYPE;

typedef enum COMMAND_ID_ENUM
{
	eCommand_Inbound 	= 1,
	eCommand_Outbound 	= 2
}enCOMMAND_ID;

int createStringToSend(uint8_t *);
void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength);
void vHandleMevris_MQTT_Recv_Data (void);
uint8_t *punGet_Event_Topic (void);
uint8_t *punGet_Command_Topic (void);
uint8_t *punGet_Client_ID (void);
void vMevris_Send_sensorData(void);
void vMevris_Send_IMEI(void);
//void sendToHTTP(uint8_t *, uint8_t);
//uint8_t unHTTPACTION_Response(void);
//void vTerminateHTTP( void );

extern @near uint32_t Voltage_Phase1;
extern @near uint32_t Ampere_Phase1;
extern @near uint32_t Watt_Phase1;
extern @near uint32_t Voltage_Phase2;
extern @near uint32_t Ampere_Phase2;
extern @near uint32_t Watt_Phase2;
extern @near uint32_t Voltage_Phase3;
extern @near uint32_t Ampere_Phase3;
extern @near uint32_t Watt_Phase3;
extern uint8_t aunIMEI[20];

#endif