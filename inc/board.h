#ifndef __BOARD_H
#define __BOARD_H

#include "stm8s.h"
#include "stm8s_it.h"
#include "stm8s_exti.h"
#include "stm8s_itc.h"
#include "stm8s_flash.h"
#include "stm8s_delay.h"

typedef enum {
	MEVRIS_UART_PARITY_NONE,
	MEVRIS_UART_PARITY_EVEN,
	MEVRIS_UART_PARITY_ODD
}UARTCONFIG;

enum
{
    V1CabFab = 0x4000,
    V2CabFab = 0x4001,
    V3CabFab = 0x4002,
    I1CabFab = 0x4003,
    I2CabFab = 0x4004,
    I3CabFab = 0x4005,
    P1CabFab = 0x4006,
    P2CabFab = 0x4007,
    P3CabFab = 0x4008,
    CheckByte = 0x4009
};

void clockSetup(void);
void gpioSetup(void);
void timer2Setup(void);
void timer1Setup(void);
void EEPROMSetup(void);
void systemInit(void);
void EXTI_setup(void);
void getCalibration(void);
void ADCSetup(void);
void UARTSetup(uint32_t , UARTCONFIG);
extern bool checkit;
#define stm8s
#define timer2MaxCount 65535
#define timer2Prescaler TIM2_PRESCALER_8 //divide the timer 2 fMaster clock by 8
#define timer2Frequency 2000000.0
#define timer1MaxCount 65535
#define timer1Prescaler 7 //divide the timer 1 fMaster clock by 8
#define timer1Repeat 0    //do not repeat the timer1
#define timer1Frequency 2000000.0
#define uartBaudRate 9600
#define adcSeriesResistor 2000
#define adcMaxVal 1023
#define ntcCoefficient 3950
#define resistanceRoomTeperature 10000.0
#define RoomTeperature 298.15
#define txPin GPIOD, GPIO_PIN_5
#define rxPin GPIOD, GPIO_PIN_6
#define powerFrequency1Pin GPIOC, GPIO_PIN_1
#define powerFrequency2Pin GPIOC, GPIO_PIN_3
#define powerFrequency3Pin GPIOD, GPIO_PIN_4
#define currentVoltSelectionPin GPIOD, GPIO_PIN_2
#define currentVoltFrequency1Pin GPIOC, GPIO_PIN_2
#define currentVoltFrequency2Pin GPIOD, GPIO_PIN_7
#define currentVoltFrequency3Pin GPIOD, GPIO_PIN_3
#define PWRKEY GPIOC, GPIO_PIN_5
#define RingIndicatorPin GPIOD, GPIO_PIN_0
#define BatteryVoltagePin GPIOB, GPIO_PIN_6
#define Temp1Pin GPIOB, GPIO_PIN_2
#define Temp2Pin GPIOB, GPIO_PIN_1
#define ADCvoltmultiplier 49
#define BatVoltDividerFactor 41
#define currentVoltFrequencyPin GPIOC, GPIO_PIN_4 //undefine the pin after resolving compilation errors
#define FuelLevelFactor 97
#define ADC_RESOLUTION  1024
#define TankLengthinFoot 2
#define TankBreadthinFoot 1
#define sensorHeadroom 1
#define reserveFuel TankLengthinFoot * TankBreadthinFoot * sensorHeadroom
//SIMCOM module defines
#define IMEI "AT+CGSN"
#define HTTP_SAVE_CONTEXT "AT+HTTPSCONT"
#define AT "AT"
#define NOECHO "ATE0"
#define MSGFT "AT+CMGF=1"
#define MSGSD "AT+CMGS=\"+923133647854\""
#define TR 0x1A
#define MSG_IND "AT+CNMI=2,1"
#define GPS_ON "AT+CGNSPWR=1" // power command changed to GNSS pwr =1
#define rmc "AT+CGNSSEQ=RMC"  //RMC: Time, date, position, course and speed data
#define GPS_Data "AT+CGNSINF" //<GNSS run status>,<Fix status>,
#define GPS_ST "AT+CGPSSTATUS?"
#define MS_DELETE_ALL_SMS "AT+CMGD=1,4"
#define delete_all_sms_waqas "AT+CMGDA=DEL ALL"
#define SMSRead "AT+CMGR=1"
#define SIMCom_OFF "AT+CPOWD=0"
#define Kick_alert "Kick Temper Detected"
#define disable_power_saving "AT+CSCLK=0"
#define SMS_Ack "SMS receive acknowledgment"
#define SMS_CURRENT_ACK "CURRENT is"
#define GPRS_ATT "AT+CGATT=1"
#define GPRS_Con "AT+SAPBR=3,1,\"CONTYPE\",\"GPRS\""
#define GPRS_APN "AT+SAPBR=3,1,\"APN\",\"zongwap\""
#define GPRS_Set "AT+SAPBR=1,1"
#define GPRS_Set1 "AT+SAPBR=0,1"
#define GPRS_ATT_READ "AT+CGATT?"
#define CHECK_REGISTRATION_STATUS "AT+CGREG?" // Should return +CGREG: 0,1 for registered, +CGREG: 0,3 for denied registration
#define GPRS_CheckStaus1 "AT+SAPBR=2,1"
#define GPRS_CheckStaus2 "AT+SAPBR=4,1"
#define TCP_SHUTDOWN "AT+CIPSHUT" //	Shut Down All TCP Connections and Have to Restart again while setting context
#define	TCP_SINGLE_CONN_MODE "AT+CIPMUX=0" //For Single Connection to server
#define	TCP_NON_TRANSPARENT_MODE "AT+CIPMODE=0"	//For TCP Non-Transparent Mode (Has to send CIPSEND Command to send data)
#define TCP_MODE_RESPONSE_NORMAL "AT+CIPQSEND=0" // Module will respond "SEND OK" for successful TCP Transfer to Remote server
#define TCP_MODE_SEND_PROMPT_ECHO "AT+CIPSPRT=1" // Module will echo '>' on CIPSEND and "SEND OK" on Successfull data transfer
#define TCP_MODE_REMOTE_IP_PORT_ON "AT+CIPSRIP=1" // MOdule will prompt "RECV FROM:<IP ADDRESS>:<PORT>" on getting data from remote server
#define TCP_MODE_HEADER_ON_RECV_ON "AT+CIPHEAD=1" // MOdule will add header "+IPD,<data length>:" on recieving data from server
#define TCP_SAVE_CONTEXT "AT+CIPSCONT" // Module will save TCP/IP Context(configuration)
#define TCP_SET_APN "AT+CSTT=\"zongwap\""
#define TCP_START_WIRELESS_CONN	"AT+CIICR" //Module will Start Wireless Connection, responds "OK" if done
#define startTCP_CMD "AT+CIPSTART=\"TCP\",\"mqtt.mevris.io\",\"3881\""
#define TCP_SEND_VARIABLE_LENGTH "AT+CIPSEND" //AT+CIPSEND= expects 0x1A to know end of data
#define TCP_GET_STATUS "AT+CIPSTATUS" //Module will return status of TCP Connection
#define HTTPINIT "AT+HTTPINIT"
#define HTTP_URL "AT+HTTPPARA=\"URL\",\"http://ptsv2.com/t/d9bxi-1612442037/post\""
#define HTTP_ACTION "AT+HTTPACTION=1"
#define HTTP_TERM "AT+HTTPTERM"
#define HTTP_DATA "AT+HTTPDATA=260,2000"
#define HTTP_MSG "hello_zeeshan"
#define HTTP_Read "AT+HTTPREAD=0,20"
#define HTTP_CID "AT+HTTPPARA=\"CID\",1"
#define HTTP_REDIR "AT+HTTPPARA=\"REDIR\",1"
#define HTTP_SSL "AT+HTTPSSL=1"
#define HTTP_CONTENT "AT+HTTPPARA=\"CONTENT\",\"application/json\""
#define ping "AT+CIPPING=\"www.google.com\""
#define check_num "AT+CNUM"
#define BT_GET_ON_OFF_STATUS "AT+BTPOWER?"
#define BT_GET_CONNECT_STATUS "AT+BTSTATUS?"
//#define BT_SET_NAME "AT+BTHOST=" //AT+BTHOST=<name>, <name> max length is 18 characters
#define BT_TURN_ON "AT+BTPOWER=1"
#define BT_TURN_OFF "AT+BTPOWER=0"
#define BT_ACCEPT_PAIR_REQ "AT+BTPAIR=1,1"
#define BT_REJECT_PAIR_REQ "AT+BTPAIR=1,0"
#define BT_UNPAIR_ALL "AT+BTUNPAIR=0"    // Unpair all connected devices
#define BT_ACCEPT_SPP_REQ "AT+BTACPT=1"  // Accept incoming SPP Request
#define BT_REJECT_SPP_REQ "AT+BTACPT=0"  // Reject incoming SPP Request
#define BT_GET_SPP_CONFIG "AT+BTSPPCFG?" // Accepted response +BTSPPCFG: S,1,1
#define BT_SPP_GET_DATA "AT+BTSPPGET="   // AT+BTSPPGET=<command>[,<reqLength>][,<showWithHex>]"
#define BT_SPP_SEND_IMEI "AT+BTSPPSEND=" //AT+BTSPPSEND=<length>
#define BT_PAIR_CONFIG "AT+BTPAIRCFG=1," // AT+BTPAIRCFG=1,5555 , here 5555 is a pin
#define BT_WRONG_DATA "Wrong Data!"
#define BT_SET_NAME "AT+BTHOST=GENERATOR-555555"
#define BT_SET_PIN "AT+BTPAIRCFG=1,1234"
#define IMEIcmnd "AT+GSN"

#endif
