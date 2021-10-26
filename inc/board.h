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
    // V1CabFab_LSB = 0x4000,//0x4000
    // V1CabFab_MSB = 0x4001,
    V1CabFab = 0x4000,  
    // V2CabFab_LSB = 0x4002,//0x4001
    // V2CabFab_MSB = 0x4003,
    V2CabFab = 0x4004,
    // V3CabFab_LSB = 0x4004,//0x4002
    // V3CabFab_MSB = 0x4005,
    V3CabFab = 0x4008,
    // I1CabFab_LSB = 0x4006,//0x4003
    // I1CabFab_MSB = 0x4007,
    I1CabFab = 0x400C,
    // I2CabFab_LSB = 0x4008,//0x4004
    // I2CabFab_MSB = 0x4009,
    I2CabFab = 0x4010,
    // I3CabFab_LSB = 0x400A,//0x4005
    // I3CabFab_MSB = 0x400B,
    I3CabFab = 0x4014,
    // P1CabFab_LSB = 0x400C,//0x4006
    // P1CabFab_MSB = 0x400D,
    P1CabFab = 0x4018,
    // P2CabFab_LSB = 0x400E,//0x4007
    // P2CabFab_MSB = 0x400F,
    P2CabFab = 0x401C,
    // P3CabFab_LSB = 0x4010,//0x4008
    // P3CabFab_MSB = 0x4011,
    P3CabFab = 0x4020,

    CheckByte = 0x4025//0x4009
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
void WriteFlashWord(uint16_t data, uint32_t address);
extern bool checkit;


// #define MODULE_SIMCOM_SIM868
#define MODULE_QUECTEL_EC200U

#define stm8s
#define timer2MaxCount 65535
#define timer2Prescaler TIM2_PRESCALER_8 //divide the timer 2 fMaster clock by 8
#define timer2Frequency 2000000.0
#define timer1MaxCount 65535
#define timer1Prescaler 7 //divide the timer 1 fMaster clock by 8
#define timer1Repeat 0    //do not repeat the timer1
#define timer1Frequency 2000000.0
#define uartBaudRate 115200
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
#ifdef MODULE_SIMCOM_SIM868

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
#define TCP_SEND_FIXED_LENGTH "AT+CIPSEND=" //AT+CIPSEND= expects 0x1A to know end of data
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

#ifdef MODULE_QUECTEL_EC200U
// Module Configure Related Commands
#define AT                                      "AT"
#define NOECHO                                  "ATE0"
#define SIMCom_OFF                              "AT+QPOWD=1"
#define disable_power_saving                    "AT+QSCLK=0"
#define MODULE_SET_RESPONSE_AS_OK               "ATQ0"
#define MODULE_SET_RESPONSE_FORMAT              "ATV1"  
#define MODULE_SET_URC_FORMAT                   "AT+CMEE=2"
#define MODULE_SET_CHARACTER_FORMAT             "AT+CSCS=\"GSM\""
#define MODULE_SET_URC_PORT                     "AT+QURCCFG=\"URCPORT\",\"uart1\""
#define MODULE_SAVE_CONFIGURATION               "AT&W1" //In Profile 1
#define MODULE_SET_FULL_FUNCTION                "AT+CFUN=1"
#define MODULE_URC_REPORT_MAIN_ON               "AT+QINDCFG=\"all\",1,1"
#define MODULE_URC_REPORT_CSQ_OFF               "AT+QINDCFG=\"csq\",0,1"
#define MODULE_URC_REPORT_SMS_RCV_ON            "AT+QINDCFG=\"smsincoming\",1,1"
#define MODULE_URC_REPORT_SMS_FULL_OFF          "AT+QINDCFG=\"smsfull\",0,1"
#define MODULE_URC_REPORT_RING_OFF              "AT+QINDCFG=\"ring\",0,1"
#define MODULE_URC_REPORT_NETWORK_ON            "AT+QINDCFG=\"act\",1,1"
#define MODULE_RI_OTHERS_OFF                    "AT+QCFG=\"urc/ri/other\",\"off\""
#define MODULE_RI_SMS_ON                        "AT+QCFG=\"urc/ri/smsincoming\",\"pulse\",120,1"
#define MODULE_RI_RING_OFF                      "AT+QCFG=\"urc/ri/ring\",\"off\""
#define IMEI                                    "AT+GSN"
#define IMEIcmnd                                "AT+GSN"

// SIM Related Commands
#define MODULE_SIM_CHECK_STATUS                 "AT+CPIN?"  //Should be "CPIN: Ready"
#define MODULE_SIM_CHECK_INIT_STATUS            "AT+QINISTAT"  //Should Return +QINISTAT: 7
#define MODULE_SIM_DETECT_ON                    "AT+QSIMDET=1,0" 
#define MODULE_SIM_INSERTDELETE_STATUS_OFF      "AT+QSIMSTAT=0"  
#define check_num                               "AT+CNUM"

// SMS Related Commmands
#define MSGFT                                   "AT+CMGF=1"
#define MSGSD                                   "AT+CMGS=\"+923316821907\""
#define TR                                      0x1A
#define MSG_IND                                 "AT+CNMI=2"
#define MS_DELETE_ALL_SMS                       "AT+CMGD=1,4"
#define SMSRead                                 "AT+CMGR=1"
#define SMS_Ack                                 "SMS receive acknowledgment"
#define SMS_CURRENT_ACK                         "CURRENT is"
#define SET_SMS_STORAGE_AS_ME                   "AT+CPMS=\"ME\",\"ME\",\"ME\""
#define DISABLE_SMS_EXTRA_INFO                  "AT+CSDH=0"


// GPS/GNSS Related Commands
// #define GPS_ON "AT+CGNSPWR=1" // power command changed to GNSS pwr =1
// #define rmc "AT+CGNSSEQ=RMC"  //RMC: Time, date, position, course and speed data
// #define GPS_Data "AT+CGNSINF" //<GNSS run status>,<Fix status>,
// #define GPS_ST "AT+CGPSSTATUS?"

// Packet Domain Service Related Commands
#define GPRS_ATT                                "AT+CGATT=1"
#define GPRS_Con                                "AT+QCFG=\"nwscanmode\",0,1"           //Scan Mode is Automatic (GPRS/4G)
#define GPRS_APN                                "AT+CGDCONT=1,\"IP\",\"ZONGWAP\""
#define GPRS_Set                                "AT+CGACT=1,1"
#define GPRS_Set1                               "AT+CGACT=1,1"
#define GPRS_CheckStaus1                        "AT+CGDCONT?"
#define GPRS_CheckStaus2                        "AT+QNWINFO"
#define GPRS_ATT_READ                           "AT+CGATT?"
#define CHECK_REGISTRATION_STATUS               "AT+CGREG?" // Should return +CGREG: 0,1 for registered, +CGREG: 0,3 for denied registration
#define CHECK_REGISTRATION_STATUS_CS            "AT+CREG?"     //For GSM
#define CHECK_REGISTRATION_STATUS_PS            "AT+CGREG?"    //For GPRS
#define CHECK_REGISTRATION_STATUS_EPS           "AT+CEREG?"   //For 4G/E-UTRAN

// TCP Related Commands
#define TCP_SHUTDOWN                            "AT+QICLOSE=1" //	Shut Down All TCP Connections and Have to Restart again while setting context

// #define	TCP_SINGLE_CONN_MODE                    "AT+CIPMUX=0" //For Single Connection to server
#define	TCP_NON_TRANSPARENT_MODE                "AT+QISWTMD=1,1"	//For TCP Non-Transparent Mode (Has to send CIPSEND Command to send data)
#define TCP_MODE_RESPONSE_NORMAL                "AT+QISWTMD=1,1" // Module will respond "SEND OK" for successful TCP Transfer to Remote server
// #define TCP_MODE_SEND_PROMPT_ECHO               "AT+CIPSPRT=1" // Module will echo '>' on CIPSEND and "SEND OK" on Successfull data transfer
// #define TCP_MODE_REMOTE_IP_PORT_ON              "AT+CIPSRIP=1" // MOdule will prompt "RECV FROM:<IP ADDRESS>:<PORT>" on getting data from remote server
// #define TCP_MODE_HEADER_ON_RECV_ON              "AT+CIPHEAD=1" // MOdule will add header "+IPD,<data length>:" on recieving data from server
// #define TCP_SAVE_CONTEXT                        "AT+CIPSCONT" // Module will save TCP/IP Context(configuration)
#define TCP_GET_IP                              "AT+QIACT?"
#define TCP_SET_APN                             "AT+QICSGP=1,1,\"ZONGWAP\","","",1"
#define TCP_START_WIRELESS_CONN	                "AT+QIACT=1" //Module will Start Wireless Connection, responds "OK" if done
#define startTCP_CMD                            "AT+QIOPEN=1,1,\"TCP\",\"mqtt.mevris.io\",3881,0,0" 
#define TCP_SEND_VARIABLE_LENGTH                "AT+QISEND=1" //AT+CIPSEND= expects 0x1A to know end of data
#define TCP_SEND_FIXED_LENGTH                   "AT+QISEND=1," //AT+CIPSEND do not expects 0x1A to know end of data but the number of bytes 
#define TCP_GET_STATUS                          "AT+QISTATE?" //Module will return status of TCP Connection

// HTTP Related Commands
// #define HTTPINIT "AT+HTTPINIT"
// #define HTTP_URL "AT+HTTPPARA=\"URL\",\"http://ptsv2.com/t/d9bxi-1612442037/post\""
// #define HTTP_ACTION "AT+HTTPACTION=1"
// #define HTTP_TERM "AT+HTTPTERM"
// #define HTTP_DATA "AT+HTTPDATA=260,2000"
// #define HTTP_MSG "hello_zeeshan"
// #define HTTP_Read "AT+HTTPREAD=0,20"
// #define HTTP_CID "AT+HTTPPARA=\"CID\",1"
// #define HTTP_REDIR "AT+HTTPPARA=\"REDIR\",1"
// #define HTTP_SSL "AT+HTTPSSL=1"
// #define HTTP_CONTENT "AT+HTTPPARA=\"CONTENT\",\"application/json\""
#define ping                                    "AT+QPING=1,\"www.google.com\""    //Google Server

//MQTT Related Commands
#define MQTT_SET_VERSION                        "AT+QMTCFG=\"version\",1,4"         //Version is 3.1.1
#define MQTT_SET_PDP_CONTEXT                    "AT+QMTCFG=\"pdpcid\",1,1"          //Context ID is 1
#define MQTT_SET_TCP_PROTOCOL                   "AT+QMTCFG=\"ssl\",1,0,0"           //Normal TCP without SSL
#define MQTT_SET_KEEPALIVE_TIME                 "AT+QMTCFG=\"keepalive\",1,120"     
#define MQTT_SET_SESSION_TYPE                   "AT+QMTCFG=\"session\",1,1"         //Clean Session
#define MQTT_SET_URC_RESPONSE_FORMAT            "AT+QMTCFG=\"recv/mode\",1,0,1"     //In URC, and Length is present
#define MQTT_SET_MODE_SEND_RECV                 "AT+QMTCFG=\"dataformat\",1,0,0"    //String
#define MQTT_SET_DATA_VIEW_MODE                 "AT+QMTCFG=\"view/mode\",1,0"       //Non Transparent mode
#define MQTT_DISABLE_EDIT_TIMEOUT               "AT+QMTCFG=\"edit/timeout\",1,0,1"  //Disable
#define MQTT_OPEN_CONNECTION                    "AT+QMTOPEN=1,\"mqtt.mevris.io\",3881"
#define MQTT_CONNECT_TO_BROKER                  "AT+QMTCONN=1,\"gen867400032743266\""
#define MQTT_SUBSCRIBE_TOPIC                    "AT+QMTSUB=1,1,\"sc2/867400032743266/command\",0"
#define MQTT_UNSUBSCRIBE_TOPIC                  "AT+QMTUNS=1,1,\"sc2/867400032743266/command\""
#define MQTT_PUBLISH_MESSAGE                    "AT+QMTPUBEX=1,0,0,0,\"sc2/867400032743266/event\",14"
#define MQTT_CHECK_RECV_BUFFER                  "AT+QMTRECV?"                       // Should give +QMTRECV: 1,0,0,0,0,0, 
                                                                                    //in case no message is stored, 
                                                                                    //can store max 5 messages
                                                                                    // indicates '0' as if its present or not in response
#define MQTT_CHECK_STATUS                       "AT+QMTCONN?"
#define MQTT_READ_STORE_BUFFER                  "AT+QMTRECV=1,1"                    // Second '1' indicates store number of message 
#define MQTT_DISCONNECT_BROKER                  "AT+QMTDISC=1"
#define MQTT_CLOSE_CONNECTION                   "AT+QMTCLOSE=1"




// Bluetooth Related Commands
// #define BT_GET_ON_OFF_STATUS "AT+BTPOWER?"
// #define BT_GET_CONNECT_STATUS "AT+BTSTATUS?"
//#define BT_SET_NAME "AT+BTHOST=" //AT+BTHOST=<name>, <name> max length is 18 characters
// #define BT_TURN_ON "AT+BTPOWER=1"
// #define BT_TURN_OFF "AT+BTPOWER=0"
// #define BT_ACCEPT_PAIR_REQ "AT+BTPAIR=1,1"
// #define BT_REJECT_PAIR_REQ "AT+BTPAIR=1,0"
// #define BT_UNPAIR_ALL "AT+BTUNPAIR=0"    // Unpair all connected devices
// #define BT_ACCEPT_SPP_REQ "AT+BTACPT=1"  // Accept incoming SPP Request
// #define BT_REJECT_SPP_REQ "AT+BTACPT=0"  // Reject incoming SPP Request
// #define BT_GET_SPP_CONFIG "AT+BTSPPCFG?" // Accepted response +BTSPPCFG: S,1,1
// #define BT_SPP_GET_DATA "AT+BTSPPGET="   // AT+BTSPPGET=<command>[,<reqLength>][,<showWithHex>]"
// #define BT_SPP_SEND_IMEI "AT+BTSPPSEND=" //AT+BTSPPSEND=<length>
// #define BT_PAIR_CONFIG "AT+BTPAIRCFG=1," // AT+BTPAIRCFG=1,5555 , here 5555 is a pin
// #define BT_WRONG_DATA "Wrong Data!"
// #define BT_SET_NAME "AT+BTHOST=GENERATOR-555555"
// #define BT_SET_PIN "AT+BTPAIRCFG=1,1234"
#endif

#endif
